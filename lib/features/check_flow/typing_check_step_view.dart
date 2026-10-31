import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../core/analysis/grade_bank.dart';
import '../../core/analysis/self_rating.dart';
import '../../core/analysis/typed_spelling_checker.dart';
import '../../core/analysis/word_check_scoring_engine.dart';
import '../../core/audio/word_speaker.dart';
import 'check_flow_controller.dart';
import 'word_check_step_view.dart';

/// Levelled words for the typing check, from assets/practice/typing_bank.json.
class TypingBank {
  final Map<int, List<String>> byLevel;
  const TypingBank(this.byLevel);

  static const fallbackHindi = TypingBank({
    1: ['घर', 'जल', 'नल'],
    2: ['पानी', 'सूरज', 'रोटी'],
    3: ['स्कूल', 'चाँद', 'बंदर'],
  });
  static const fallbackEnglish = TypingBank({
    1: ['cat', 'sun', 'pen'],
    2: ['fish', 'tree', 'book'],
    3: ['school', 'water', 'flower'],
  });

  factory TypingBank.fromJson(Map<String, dynamic> json, {required bool isHindi, int grade = 1}) {
    final lang = levelsForGrade(json, isHindi: isHindi, grade: grade);
    final out = <int, List<String>>{};
    for (final e in lang.entries) {
      final lvl = int.tryParse(e.key.replaceFirst('level_', ''));
      if (lvl != null) out[lvl] = (e.value as List<dynamic>).map((w) => w.toString()).toList();
    }
    return TypingBank(out);
  }

  List<int> get levels => byLevel.keys.toList()..sort();
}

/// Child-facing: the phone (or the teacher) says a word, the child types it
/// on a big on-screen keypad, then gives a thumbs up or down. Everyone starts
/// at Level 1 and moves up only after passing the level.
class TypingCheckStepView extends ConsumerStatefulWidget {
  final CheckSessionState session;

  /// For tests: skip asset loading.
  final TypingBank? bank;
  final Map<String, dynamic>? thresholds;

  const TypingCheckStepView({super.key, required this.session, this.bank, this.thresholds});

  @override
  ConsumerState<TypingCheckStepView> createState() => _TypingCheckStepViewState();
}

class _TypingCheckStepViewState extends ConsumerState<TypingCheckStepView> {
  TypingBank? _bank;
  Map<String, dynamic>? _thresholds;
  int _level = 1;
  List<String> _words = [];
  int _index = 0;

  String _typed = '';
  bool _done = false; // typing finished, waiting for Next
  int _answerTimeMs = 0;
  bool _speechMissing = false;
  final Stopwatch _watch = Stopwatch();
  final List<WordCheckItemChoice> _choices = [];

  bool get _isHindi => widget.session.isPassageHindi;
  String get _font => _isHindi ? 'NotoSansDevanagari' : 'Inter';
  String get _word => _words[_index];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    WordSpeaker.instance.stop();
    super.dispose();
  }

  Future<void> _load() async {
    var bank = widget.bank;
    var thresholds = widget.thresholds;
    if (bank == null) {
      try {
        final raw = await rootBundle.loadString('assets/practice/typing_bank.json');
        bank = TypingBank.fromJson(
          jsonDecode(raw) as Map<String, dynamic>,
          isHindi: _isHindi,
          grade: widget.session.grade,
        );
      } catch (_) {}
      if (bank == null || bank.byLevel.isEmpty) {
        bank = _isHindi ? TypingBank.fallbackHindi : TypingBank.fallbackEnglish;
      }
    }
    thresholds ??= await WordCheckScoringEngine.loadThresholds();
    if (!mounted) return;
    setState(() {
      _bank = bank;
      _thresholds = thresholds;
      _level = bank!.levels.first;
      _words = _pick(_level);
      _index = 0;
    });
    _startItem();
  }

  Map<String, dynamic>? _levelCfg(int level) =>
      (_thresholds?['typing_levels'] as Map<String, dynamic>?)?['$level'] as Map<String, dynamic>?;

  List<String> _pick(int level) {
    final count = (_levelCfg(level)?['items'] as num?)?.toInt() ?? 2;
    final pool = List<String>.from(_bank?.byLevel[level] ?? const [])..shuffle(math.Random());
    return pool.take(count).toList();
  }

  void _startItem() {
    _typed = '';
    _done = false;
    _answerTimeMs = 0;
    _watch
      ..reset()
      ..start();
    _play();
  }

  Future<void> _play() async {
    if (_words.isEmpty) return;
    final ok = await WordSpeaker.instance.speak(_word, isHindi: _isHindi);
    if (mounted && !ok && !_speechMissing) setState(() => _speechMissing = true);
  }

  void _key(String k) {
    if (_done) return;
    setState(() => _typed += k);
  }

  void _backspace() {
    if (_done || _typed.isEmpty) return;
    final runes = _typed.runes.toList()..removeLast();
    setState(() => _typed = String.fromCharCodes(runes));
  }

  void _finishTyping() {
    _answerTimeMs = _watch.elapsedMilliseconds;
    setState(() => _done = true);
  }

  void _record({required bool skipped}) {
    final res = TypedSpellingChecker.check(_word, skipped ? '' : _typed);
    _choices.add(
      WordCheckItemChoice(
        itemId: 'typing_l${_level}_${_index + 1}',
        level: _level,
        type: 'typed_spelling',
        firstChoice: _word, // the word asked
        finalChoice: skipped ? null : _typed, // what the child typed
        timeToFirstTapMs: skipped ? _watch.elapsedMilliseconds : _answerTimeMs,
        expectedTimeMs: WordCheckScoringEngine.expectedTimeMs(_level, _thresholds, levelsKey: 'typing_levels'),
        isCorrectFirstTry: !skipped && res.isCorrect,
        isCorrectFinal: !skipped && res.isCorrect,
        isSkipped: skipped,
        chosenDistractorTag: skipped ? null : res.primaryTag,
        selfRating: SelfRating.notGiven, // the child rates once, at the end
      ),
    );

    if (_index + 1 < _words.length) {
      setState(() => _index++);
      _startItem();
      return;
    }
    // End of level: move up only if this level is passed.
    final result = WordCheckScoringEngine.evaluateLevel(
      level: _level,
      items: _choices.where((c) => c.level == _level).toList(),
      thresholds: _thresholds,
      levelsKey: 'typing_levels',
    );
    final next = _bank!.levels.where((l) => l > _level).firstOrNull;
    if (result.passedPromotion && next != null) {
      final words = _pick(next);
      if (words.isNotEmpty) {
        setState(() {
          _level = next;
          _words = words;
          _index = 0;
        });
        _startItem();
        return;
      }
    }
    _watch.stop();
    ref.read(checkFlowControllerProvider.notifier).completeTypingCheck(List.of(_choices));
  }

  void _showTeacherExitSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StudentPasscodeSheet(
        onSuccess: () {
          Navigator.pop(ctx);
          context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_bank == null || _words.isEmpty) {
      return const Scaffold(
        backgroundColor: SamajhColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final isHindi = _isHindi;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _showTeacherExitSheet();
      },
      child: Scaffold(
        backgroundColor: SamajhColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: SamajhColors.paleMint,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.keyboard_alt_outlined, color: SamajhColors.forestGreen, size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                isHindi ? 'स्तर $_level' : 'Level $_level',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: _font,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: SamajhColors.forestGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      key: const Key('typing_teacher_unlock_button'),
                      onPressed: _showTeacherExitSheet,
                      icon: const Icon(Icons.lock_outline_rounded, size: 16, color: SamajhColors.textMuted),
                      label: Text(
                        isHindi ? 'शिक्षक' : 'Teacher',
                        style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),
              _promptCard(),
              _typedBox(),
              Expanded(child: _done ? _donePanel() : _keypad()),
              _bottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _promptCard() {
    final isHindi = _isHindi;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: SamajhColors.paleMintDark, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  key: const Key('typing_play_word'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SamajhColors.paleMint,
                    foregroundColor: SamajhColors.forestGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _play,
                  icon: const Icon(Icons.volume_up_rounded, size: 22),
                  label: Text(
                    isHindi ? 'सुनो' : 'Listen',
                    style: TextStyle(fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isHindi ? 'जो शब्द सुना, वह लिखो।' : 'Type the word you hear.',
                    style: TextStyle(
                      fontFamily: _font,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: SamajhColors.textNavy,
                    ),
                  ),
                ),
              ],
            ),
            if (_speechMissing) ...[
              const SizedBox(height: 8),
              // No voice on this phone: the teacher holds to see the word and says it.
              GestureDetector(
                key: const Key('typing_teacher_hold_reveal'),
                onLongPress: () => _showWordToTeacher(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SamajhColors.creamSoft,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    _speechHelp(isHindi),
                    style: TextStyle(fontFamily: _font, fontSize: 12.5, color: SamajhColors.textNavy, height: 1.4),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Tells the teacher why the phone is silent and how to fix it for good.
  String _speechHelp(bool isHindi) {
    const hold = (
      'शिक्षक जी: शब्द देखने के लिए यहाँ दबाकर रखें और बच्चे को बोलकर सुनाएँ।',
      'Teacher: press and hold here to see the word, then say it aloud.',
    );
    final fix = switch (WordSpeaker.instance.lastProblem) {
      SpeechProblem.needsDownload || SpeechProblem.noVoice => (
          'इस फ़ोन में बिना इंटरनेट वाली ${isHindi ? 'हिंदी' : 'अंग्रेज़ी'} आवाज़ नहीं है। एक बार लगा लें: '
              'सेटिंग्स › टेक्स्ट-टू-स्पीच › Google › आवाज़ डेटा इंस्टॉल करें › ${isHindi ? 'हिंदी' : 'English (India)'}।',
          'This phone has no ${isHindi ? 'Hindi' : 'English'} voice that works offline. Install it once: '
              'Settings › Text-to-speech › Google › Install voice data › ${isHindi ? 'Hindi' : 'English (India)'}.',
        ),
      _ => null,
    };
    return isHindi ? [if (fix != null) fix.$1, hold.$1].join('\n') : [if (fix != null) fix.$2, hold.$2].join('\n');
  }

  void _showWordToTeacher() {
    showDialog<void>(
      context: context,
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.pop(ctx),
        child: AlertDialog(
          content: Text(
            _word,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _font,
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: SamajhColors.textNavy,
            ),
          ),
        ),
      ),
    );
  }

  Widget _typedBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        key: const Key('typing_typed_box'),
        height: 72,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _done ? SamajhColors.forestGreen : const Color(0xFFCBD5E1), width: 2),
        ),
        // Erase sits inside the answer box so it is always on screen,
        // however tall the keypad gets.
        child: Row(
          children: [
            const SizedBox(width: 48),
            Expanded(
              child: Text(
                _typed.isEmpty ? '...' : _typed,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: _font,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: _typed.isEmpty ? const Color(0xFFCBD5E1) : SamajhColors.textNavy,
                ),
              ),
            ),
            SizedBox(
              width: 48,
              child: _done
                  ? null
                  : IconButton(
                      key: const Key('typing_backspace'),
                      tooltip: _isHindi ? 'मिटाओ' : 'Delete',
                      onPressed: _typed.isEmpty ? null : _backspace,
                      icon: const Icon(Icons.backspace_outlined, color: SamajhColors.textNavy),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _donePanel() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.check_circle_rounded, size: 56, color: SamajhColors.forestGreen),
            const SizedBox(height: 8),
            Text(
              _isHindi ? 'आगे बढ़ने के लिए नीचे दबाओ।' : 'Press the button below to go on.',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
            ),
            const SizedBox(height: 8),
            TextButton(
              key: const Key('typing_change_word'),
              onPressed: () => setState(() {
                _done = false;
              }),
              child: Text(
                _isHindi ? 'शब्द बदलना है' : 'Change my word',
                style: TextStyle(fontFamily: _font, fontSize: 14, color: SamajhColors.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _hindiVowels = ['अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ए', 'ऐ', 'ओ', 'औ'];
  static const _hindiConsonants = [
    'क', 'ख', 'ग', 'घ', 'च', 'छ', 'ज', 'झ', 'ट', 'ठ', 'ड', 'ढ', 'ण', 'त', 'थ', 'द', 'ध', 'न', //
    'प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'व', 'श', 'ष', 'स', 'ह',
  ];
  static const _hindiSigns = ['ा', 'ि', 'ी', 'ु', 'ू', 'ृ', 'े', 'ै', 'ो', 'ौ', 'ं', 'ँ', '्', '़'];
  static const _latinRows = ['qwertyuiop', 'asdfghjkl', 'zxcvbnm'];

  Widget _keypad() {
    final rows = _isHindi ? [_hindiVowels, _hindiConsonants, _hindiSigns] : [for (final r in _latinRows) r.split('')];
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Column(
        children: [
          for (final row in rows) ...[
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: [for (final k in row) _keyButton(k)],
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _keyButton(String k) {
    // Matras and signs are shown on a dotted circle so they are easy to see.
    final isSign = _hindiSigns.contains(k);
    return SizedBox(
      width: _isHindi ? 40 : 32,
      height: 46,
      child: Material(
        color: isSign ? const Color(0xFFFFF7ED) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          key: Key('typing_key_$k'),
          borderRadius: BorderRadius.circular(10),
          onTap: () => _key(k),
          child: Center(
            child: Text(
              isSign ? '◌$k' : k,
              style: TextStyle(
                fontFamily: _font,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: SamajhColors.textNavy,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomBar() {
    final isHindi = _isHindi;
    final canFinish = !_done && _typed.trim().isNotEmpty;
    final canNext = _done;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
      child: Row(
        children: [
          Flexible(
            child: TextButton(
              key: const Key('typing_not_sure'),
              onPressed: () => _record(skipped: true),
              child: Text(
                isHindi ? 'पता नहीं' : 'Not sure',
                style: TextStyle(
                  fontFamily: _font,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: SamajhColors.textMuted,
                ),
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            key: const Key('typing_next'),
            style: ElevatedButton.styleFrom(
              backgroundColor: (canFinish || canNext) ? SamajhColors.forestGreen : Colors.grey.shade400,
              foregroundColor: Colors.white,
              minimumSize: const Size(128, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: canFinish ? _finishTyping : (canNext ? () => _record(skipped: false) : null),
            child: Text(
              _done ? (isHindi ? 'आगे बढ़ें' : 'Next') : (isHindi ? 'हो गया' : 'Done'),
              style: TextStyle(fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
