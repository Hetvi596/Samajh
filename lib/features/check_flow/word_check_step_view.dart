import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/motion.dart';
import '../../app/theme.dart';
import '../../core/analysis/grade_bank.dart';
import '../../core/analysis/self_rating.dart';
import '../../core/analysis/word_check_scoring_engine.dart';
import '../../core/audio/word_speaker.dart';
import '../../core/security/passcode_service.dart';
import 'check_flow_controller.dart';
import 'widgets/notebook_line_word_painter.dart';

/// Item model loaded from assets or dynamic generator.
class WordCheckItem {
  final String id;
  final int level;
  final String type; // 'writing_position', 'spelling', 'sound_recognition', 'fill_blank', 'odd_one_out', 'meaning_inference', 'sentence_match', 'event_sequence'
  final String? targetWord;
  final String promptAudioText;
  final String promptLabel;
  final List<WordCheckOption> options;

  const WordCheckItem({
    required this.id,
    required this.level,
    required this.type,
    this.targetWord,
    required this.promptAudioText,
    required this.promptLabel,
    required this.options,
  });

  factory WordCheckItem.fromJson(Map<String, dynamic> json) {
    final rawOpts = (json['options'] as List<dynamic>? ?? []);
    final options = rawOpts.map((o) => WordCheckOption.fromJson(o as Map<String, dynamic>)).toList();

    return WordCheckItem(
      id: json['id'] as String? ?? 'item_${DateTime.now().millisecondsSinceEpoch}',
      level: (json['level'] as num?)?.toInt() ?? 1,
      type: json['type'] as String? ?? 'spelling',
      targetWord: json['target_word'] as String?,
      promptAudioText: json['prompt_audio_text'] as String? ?? '',
      promptLabel: json['prompt_label'] as String? ?? '',
      options: options,
    );
  }
}

class WordCheckOption {
  final String id;
  final String text;
  final bool isCorrect;
  final String? distractorTag;
  final WritingPositionStyle? positionStyle;

  const WordCheckOption({
    required this.id,
    required this.text,
    required this.isCorrect,
    this.distractorTag,
    this.positionStyle,
  });

  factory WordCheckOption.fromJson(Map<String, dynamic> json) {
    return WordCheckOption(
      id: json['id'] as String? ?? 'opt',
      text: json['text'] as String? ?? '',
      isCorrect: json['is_correct'] as bool? ?? false,
      distractorTag: json['distractor_tag'] as String?,
      positionStyle: parseWritingStyle(json['position_style'] as String?),
    );
  }
}

/// Item types answered by picking one of four drawn notebook pictures.
bool isPictureWritingItem(String type) => type == 'writing_position' || type == 'letter_formation';

/// Picks [count] items for a level, covering as many different item types
/// as possible and always including a picture writing item when the bank
/// has one. Options are shuffled so the correct answer has no fixed place.
List<WordCheckItem> selectWordCheckItems(List<WordCheckItem> available, int count, {math.Random? random}) {
  final rnd = random ?? math.Random();
  final pool = List<WordCheckItem>.from(available)..shuffle(rnd);
  final picked = <WordCheckItem>[];
  final picture = pool.where((i) => isPictureWritingItem(i.type)).firstOrNull;
  if (picture != null && count > 0) picked.add(picture);
  // One of each type first, then fill up with whatever is left.
  for (final item in pool) {
    if (picked.length >= count) break;
    if (!picked.contains(item) && picked.every((p) => p.type != item.type)) picked.add(item);
  }
  for (final item in pool) {
    if (picked.length >= count) break;
    if (!picked.contains(item)) picked.add(item);
  }
  picked.shuffle(rnd);
  return [
    for (final item in picked)
      WordCheckItem(
        id: item.id,
        level: item.level,
        type: item.type,
        targetWord: item.targetWord,
        promptAudioText: item.promptAudioText,
        promptLabel: item.promptLabel,
        options: List<WordCheckOption>.from(item.options)..shuffle(rnd),
      ),
  ];
}

/// Child-facing Word Check Step in Student Mode.
class WordCheckStepView extends ConsumerStatefulWidget {
  final CheckSessionState session;

  const WordCheckStepView({super.key, required this.session});

  @override
  ConsumerState<WordCheckStepView> createState() => _WordCheckStepViewState();
}

class _WordCheckStepViewState extends ConsumerState<WordCheckStepView> {
  bool _isLoading = true;
  Map<int, List<WordCheckItem>> _bankByLevel = {};
  int _currentLevel = 1;
  int _currentItemIndex = 0;
  List<WordCheckItem> _currentLevelItems = [];

  // Per-item response tracking
  String? _firstChoiceId;
  String? _currentSelectedId;
  int _changeCount = 0;
  final Stopwatch _itemStopwatch = Stopwatch();
  int _timeToFirstTapMs = 0;


  // Session-wide accumulated choices
  final List<WordCheckItemChoice> _recordedChoices = [];
  Map<String, dynamic>? _thresholds;

  @override
  void initState() {
    super.initState();
    _bankByLevel = _buildFallbackBank();
    _currentLevelItems = _selectItemsForLevel(1);
    _isLoading = false;
    _startNewItem();
    _loadItemBank();
  }

  @override
  void dispose() {
    _itemStopwatch.stop();
    WordSpeaker.instance.stop();
    super.dispose();
  }

  Future<void> _loadItemBank() async {
    try {
      final isEnglish = !widget.session.isPassageHindi;
      _thresholds = await WordCheckScoringEngine.loadThresholds();

      // Every child starts at Level 1 and moves up only by passing a level.
      const startingLevel = 1;

      // Load items from bundled bank
      final bankJsonStr = await rootBundle.loadString('assets/practice/word_check_bank.json');
      final decoded = jsonDecode(bankJsonStr) as Map<String, dynamic>;
      // Hindi Classes 1-3 have their own items; others use the shared bank.
      final langBank = levelsForGrade(decoded, isHindi: !isEnglish, grade: widget.session.grade);

      final loadedByLevel = <int, List<WordCheckItem>>{};
      for (int lvl = 1; lvl <= 4; lvl++) {
        final rawList = langBank['level_$lvl'] as List<dynamic>? ?? [];
        loadedByLevel[lvl] = rawList.map((e) => WordCheckItem.fromJson(e as Map<String, dynamic>)).toList();
      }

      if (!mounted) return;
      setState(() {
        _bankByLevel = loadedByLevel;
        _currentLevel = startingLevel;
        _currentLevelItems = _selectItemsForLevel(startingLevel);
        _currentItemIndex = 0;
        _isLoading = false;
        _bankReady = true;
      });

      _startNewItem();
    } catch (e) {
      // Fallback: graceful items
      if (!mounted) return;
      setState(() {
        _bankByLevel = _buildFallbackBank();
        _currentLevel = 1;
        _currentLevelItems = _bankByLevel[1] ?? [];
        _currentItemIndex = 0;
        _isLoading = false;
        _bankReady = true;
      });
      _startNewItem();
    }
  }

  List<WordCheckItem> _selectItemsForLevel(int level) {
    final cfg = (_thresholds?['word_check_levels'] as Map<String, dynamic>?)?['$level'] as Map<String, dynamic>?;
    final count = (cfg?['items'] as num?)?.toInt() ?? 3;
    return selectWordCheckItems(_bankByLevel[level] ?? const [], count);
  }

  void _startNewItem() {
    _itemStopwatch.reset();
    _itemStopwatch.start();
    _firstChoiceId = null;
    _currentSelectedId = null;
    _changeCount = 0;
    _timeToFirstTapMs = 0;
    // Say each new word once it is on screen (not the stand-in items shown
    // for a moment while the bank loads).
    if (_bankReady) WidgetsBinding.instance.addPostFrameCallback((_) => _playPrompt());
  }

  /// True once the real item bank has loaded.
  bool _bankReady = false;

  /// Says the word (or sentence) with the phone's voice. Only when the phone
  /// cannot speak does the teacher get a note to say it aloud.
  Future<void> _playPrompt() async {
    if (!mounted || _currentLevelItems.isEmpty) return;
    final item = _currentLevelItems[_currentItemIndex];
    final isHindi = widget.session.isPassageHindi;
    final ok = await WordSpeaker.instance.speak(item.promptAudioText, isHindi: isHindi);
    if (ok || !mounted) return;
    // Usually the phone lacks the voice data for this language: say how to add it once.
    final missingVoice = WordSpeaker.instance.lastProblem != SpeechProblem.failed;
    final word = item.promptAudioText;
    final String text;
    if (isHindi) {
      text = missingVoice
          ? "फ़ोन में हिंदी आवाज़ नहीं है। कृपया बोलें: $word\n"
              "एक बार इंटरनेट पर: सेटिंग्स > टेक्स्ट-टू-स्पीच > Google > आवाज़ डेटा इंस्टॉल करें > हिंदी।"
          : "फ़ोन यह शब्द बोल नहीं पाया। कृपया बोलें: $word";
    } else {
      text = missingVoice
          ? "This phone has no English voice installed. Please say aloud: $word\n"
              "Once, with internet: Settings > Text-to-speech > Google > Install voice data > English (India)."
          : "The phone could not say this. Please say aloud: $word";
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text), duration: const Duration(seconds: 6)));
  }

  void _onOptionTapped(WordCheckOption option) {
    if (_firstChoiceId == null) {
      _firstChoiceId = option.id;
      _timeToFirstTapMs = _itemStopwatch.elapsedMilliseconds;
    } else if (_currentSelectedId != option.id) {
      _changeCount++;
    }

    setState(() {
      _currentSelectedId = option.id;
    });
  }

  void _onNextItem({bool isSkip = false}) {
    if (_currentLevelItems.isEmpty) return;
    final currentItem = _currentLevelItems[_currentItemIndex];
    final selectedOpt = currentItem.options.where((o) => o.id == _currentSelectedId).firstOrNull;
    final firstOpt = currentItem.options.where((o) => o.id == _firstChoiceId).firstOrNull;

    final choice = WordCheckItemChoice(
      itemId: currentItem.id,
      level: currentItem.level,
      type: currentItem.type,
      firstChoice: firstOpt?.text,
      finalChoice: isSkip ? null : selectedOpt?.text,
      timeToFirstTapMs: _timeToFirstTapMs == 0 ? _itemStopwatch.elapsedMilliseconds : _timeToFirstTapMs,
      expectedTimeMs: WordCheckScoringEngine.expectedTimeMs(currentItem.level, _thresholds),
      changeCount: _changeCount,
      isCorrectFirstTry: firstOpt?.isCorrect ?? false,
      isCorrectFinal: isSkip ? false : (selectedOpt?.isCorrect ?? false),
      isSkipped: isSkip,
      chosenDistractorTag: (selectedOpt != null && !selectedOpt.isCorrect) ? selectedOpt.distractorTag : null,
      selfRating: SelfRating.notGiven, // the child rates once, at the end
    );

    _recordedChoices.add(choice);

    if (_currentItemIndex + 1 < _currentLevelItems.length) {
      // Advance to next item in current level
      setState(() {
        _currentItemIndex++;
      });
      _startNewItem();
    } else {
      // Completed all items in current level: evaluate level result
      _evaluateAndAdvanceLevel();
    }
  }

  void _evaluateAndAdvanceLevel() {
    final levelChoices = _recordedChoices.where((c) => c.level == _currentLevel).toList();
    final levelResult = WordCheckScoringEngine.evaluateLevel(
      level: _currentLevel,
      items: levelChoices,
      thresholds: _thresholds,
    );

    // A level not passed ends the check quietly; the child never sees "failed".
    if (levelResult.passedPromotion && _currentLevel < 4) {
      // Child moves up!
      final nextLevel = _currentLevel + 1;
      final nextItems = _selectItemsForLevel(nextLevel);
      if (nextItems.isNotEmpty) {
        setState(() {
          _currentLevel = nextLevel;
          _currentLevelItems = nextItems;
          _currentItemIndex = 0;
        });
        _startNewItem();
        return;
      }
    }

    // Done all levels or cannot advance further
    _finishWordCheckSession();
  }

  void _finishWordCheckSession() {
    _itemStopwatch.stop();
    // Complete word check and move to shabaash screen in controller
    ref.read(checkFlowControllerProvider.notifier).completeWordCheck(_recordedChoices);
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

  Map<int, List<WordCheckItem>> _buildFallbackBank() {
    return {
      1: [
        const WordCheckItem(
          id: 'fb_1',
          level: 1,
          type: 'sound_recognition',
          promptAudioText: 'सेब',
          promptLabel: 'सुने गए शब्द का सही चित्र चुनें',
          options: [
            WordCheckOption(id: '1', text: '🍎 सेब', isCorrect: true),
            WordCheckOption(id: '2', text: '🍌 केला', isCorrect: false, distractorTag: 'different_fruit'),
            WordCheckOption(id: '3', text: '🥭 आम', isCorrect: false, distractorTag: 'different_fruit'),
            WordCheckOption(id: '4', text: '🍇 अंगूर', isCorrect: false, distractorTag: 'different_fruit'),
          ],
        ),
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentLevelItems.isEmpty || _currentItemIndex >= _currentLevelItems.length) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isHindi = widget.session.isPassageHindi;
    final currentItem = _currentLevelItems[_currentItemIndex];
    final hasSelection = _currentSelectedId != null;
    final canGoNext = hasSelection;

    final teacherUnlockText = isHindi ? 'शिक्षक' : 'Teacher';
    final playCueText = isHindi ? 'सुनें' : 'Play cue';
    final notSureText = isHindi ? 'पता नहीं' : 'Not sure';
    final nextText = isHindi ? 'आगे बढ़ें' : 'Next';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showTeacherExitSheet();
        }
      },
      child: Scaffold(
        backgroundColor: SamajhColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Header: one pebble per question in this level, and the
              // locked teacher button. No score or rank is ever shown.
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 12, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          for (var i = 0; i < _currentLevelItems.length; i++) ...[
                            if (i > 0) const SizedBox(width: 6),
                            Expanded(
                              child: AnimatedContainer(
                                duration: SamajhMotion.base,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: i <= _currentItemIndex ? SamajhColors.forestGreen : SamajhColors.creamTrack,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        key: const Key('word_check_teacher_unlock_button'),
                        tooltip: teacherUnlockText,
                        onPressed: _showTeacherExitSheet,
                        constraints: const BoxConstraints.tightFor(width: 48, height: 48),
                        icon: const Icon(Icons.lock_outline_rounded, size: 20, color: SamajhColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),

              // Level, a big listen button and the question (never the answer).
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: SamajhColors.creamSoft,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        isHindi ? 'स्तर $_currentLevel' : 'Level $_currentLevel',
                        style: TextStyle(
                          fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: SamajhColors.warning,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Semantics(
                      button: true,
                      label: playCueText,
                      excludeSemantics: true,
                      child: Pressable(
                        pressedScale: 0.92,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Color(0xFFE2F0E6), shape: BoxShape.circle),
                          child: Material(
                            color: SamajhColors.forestGreen,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: _playPrompt,
                              child: const SizedBox(
                                width: 68,
                                height: 68,
                                child: Icon(Icons.volume_up_rounded, size: 32, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      currentItem.promptLabel,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: SamajhColors.textNavy,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // 4 Large Options (No position bias)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: isPictureWritingItem(currentItem.type)
                      ? _buildWritingPositionOptions(currentItem)
                      : (currentItem.options.length == 4 && currentItem.options.every((o) => o.text.characters.length <= 8))
                          ? _buildTileOptions(currentItem, isHindi: isHindi)
                          : _buildTextChoiceOptions(currentItem, isHindi: isHindi),
                ),
              ),

              // Bottom: "Not sure" and "Next", both pills.
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 16.0),
                child: Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: SamajhColors.textMuted,
                        minimumSize: const Size(0, 56),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        side: const BorderSide(color: SamajhColors.creamLine, width: 2),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => _onNextItem(isSkip: true),
                      child: Text(
                        notSureText,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SamajhColors.textNavy,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: SamajhColors.creamTrack,
                          disabledForegroundColor: SamajhColors.textMuted,
                          minimumSize: const Size(0, 56),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: canGoNext ? () => _onNextItem(isSkip: false) : null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                nextText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds 4 writing position options drawn on ruled notebook lines with CustomPainter.
  Widget _buildWritingPositionOptions(WordCheckItem item) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: item.options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final option = item.options[index];
        final isSelected = _currentSelectedId == option.id;
        final posStyle = option.positionStyle ?? WritingPositionStyle.correctHanging;
        final target = item.targetWord ?? option.text;

        return EntranceFade(
          key: ValueKey('${item.id}_${option.id}'),
          index: index,
          child: RuledNotebookChoiceCard(
            word: target,
            positionStyle: posStyle,
            isSelected: isSelected,
            onTap: () => _onOptionTapped(option),
          ),
        );
      },
    );
  }

  /// Four short words as big round tiles in a 2 x 2 grid. The chosen tile
  /// turns green with a gold tick.
  Widget _buildTileOptions(WordCheckItem item, {required bool isHindi}) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 1.3,
      physics: const BouncingScrollPhysics(),
      children: [
        for (final (index, option) in item.options.indexed)
          EntranceFade(
            key: ValueKey('${item.id}_${option.id}'),
            index: index,
            child: _WordTile(
              text: option.text,
              isHindi: isHindi,
              selected: _currentSelectedId == option.id,
              onTap: () => _onOptionTapped(option),
            ),
          ),
      ],
    );
  }


  /// Builds standard large text / picture choice options.
  Widget _buildTextChoiceOptions(WordCheckItem item, {required bool isHindi}) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: item.options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final option = item.options[index];
        final isSelected = _currentSelectedId == option.id;

        return EntranceFade(
          key: ValueKey('${item.id}_${option.id}'),
          index: index,
          child: Pressable(
            child: AnimatedScale(
              scale: isSelected ? 1.02 : 1,
              duration: SamajhMotion.base,
              curve: SamajhMotion.spring,
              child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onOptionTapped(option),
            borderRadius: BorderRadius.circular(18),
            child: AnimatedContainer(
              duration: SamajhMotion.base,
              curve: SamajhMotion.enter,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected ? const Color(0xFF15803D) : const Color(0xFFE2E8F0),
                  width: isSelected ? 2.5 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isSelected ? 0.06 : 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Radio-like selection indicator
                  AnimatedContainer(
                    duration: SamajhMotion.fast,
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? const Color(0xFF15803D) : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? const Color(0xFF15803D) : const Color(0xFF94A3B8),
                        width: 2,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: SamajhMotion.base,
                      switchInCurve: SamajhMotion.spring,
                      transitionBuilder: (child, a) => ScaleTransition(scale: a, child: child),
                      child: isSelected
                          ? const Icon(Icons.check, key: ValueKey('on'), size: 16, color: Colors.white)
                          : const SizedBox.shrink(key: ValueKey('off')),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      option.text,
                      style: TextStyle(
                        fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                        fontSize: 20,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected ? const Color(0xFF15803D) : SamajhColors.textNavy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Sheet for teacher passcode exit.
class StudentPasscodeSheet extends ConsumerStatefulWidget {
  final VoidCallback onSuccess;

  const StudentPasscodeSheet({super.key, required this.onSuccess});

  @override
  ConsumerState<StudentPasscodeSheet> createState() => StudentPasscodeSheetState();
}

class StudentPasscodeSheetState extends ConsumerState<StudentPasscodeSheet> {
  final TextEditingController _passcodeController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _passcodeController.dispose();
    super.dispose();
  }

  void _verifyPasscode() {
    final entered = _passcodeController.text.trim();
    final ok = ref.read(passcodeProvider.notifier).verifyPasscode(entered);
    if (ok) {
      widget.onSuccess();
    } else {
      setState(() {
        _errorMessage = "गलत पासकोड / Incorrect passcode";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "शिक्षक पासकोड / Teacher Exit",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "विद्यार्थी मोड से बाहर जाने के लिए 6-अंकीय शिक्षक पासकोड दर्ज करें:",
            style: TextStyle(fontSize: 13, color: SamajhColors.textMuted),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passcodeController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 6,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "••••••",
              border: const OutlineInputBorder(),
              errorText: _errorMessage,
            ),
            onSubmitted: (_) => _verifyPasscode(),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SamajhColors.forestGreen,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: _verifyPasscode,
            child: const Text("सत्यापित करें / Unlock"),
          ),
        ],
      ),
    );
  }
}

class _WordTile extends StatelessWidget {
  final String text;
  final bool isHindi;
  final bool selected;
  final VoidCallback onTap;

  const _WordTile({required this.text, required this.isHindi, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Pressable(
        pressedScale: 0.95,
        child: AnimatedScale(
          scale: selected ? 1.03 : 1,
          duration: SamajhMotion.base,
          curve: SamajhMotion.spring,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(34),
              child: AnimatedContainer(
                duration: SamajhMotion.base,
                curve: SamajhMotion.enter,
                decoration: BoxDecoration(
                  color: selected ? SamajhColors.forestGreen : Colors.white,
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: selected
                      ? SamajhShadow.raised(SamajhColors.forestGreen)
                      : [BoxShadow(color: SamajhColors.warning.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 6))],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                            fontSize: 32,
                            fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
                            color: selected ? Colors.white : SamajhColors.textNavy,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 14,
                      child: AnimatedSwitcher(
                        duration: SamajhMotion.base,
                        switchInCurve: SamajhMotion.spring,
                        transitionBuilder: (child, a) => ScaleTransition(scale: a, child: child),
                        child: selected
                            ? Container(
                                key: const ValueKey('tick'),
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(color: SamajhColors.kiranGold, shape: BoxShape.circle),
                                child: const Icon(Icons.check_rounded, size: 18, color: SamajhColors.textNavy),
                              )
                            : const SizedBox.shrink(key: ValueKey('none')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
