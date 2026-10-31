import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import '../../app/motion.dart';
import '../../app/theme.dart';
import '../../core/analysis/devanagari_engine.dart';
import '../../core/analysis/question_levels.dart';
import '../../core/analysis/word_check_scoring_engine.dart';
import '../../core/audio/audio_service.dart';
import '../../core/database/app_database.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../../core/providers/database_provider.dart';
import '../../core/security/passcode_service.dart';
import '../student_mode/kiran_mascot.dart';
import 'check_flow_controller.dart';
import 'reading_self_rating_step_view.dart';
import 'typing_check_step_view.dart';
import 'widgets/result_level_sections.dart';
import 'word_check_step_view.dart';

class CheckFlowPage extends ConsumerStatefulWidget {
  final String childId;

  const CheckFlowPage({super.key, required this.childId});

  @override
  ConsumerState<CheckFlowPage> createState() => _CheckFlowPageState();
}

class _CheckFlowPageState extends ConsumerState<CheckFlowPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initSession();
    });
  }

  Future<void> _initSession() async {
    final current = ref.read(checkFlowControllerProvider);
    if (current != null && current.childId == widget.childId && current.currentStep != CheckStep.result) {
      return;
    }

    final db = ref.read(appDatabaseProvider);
    final child = await (db.select(db.childrenTable)..where((t) => t.id.equals(widget.childId))).getSingleOrNull();
    ClassesTableData? childClass;
    if (child != null) {
      childClass = await (db.select(db.classesTable)..where((t) => t.id.equals(child.classId))).getSingleOrNull();
    }
    childClass ??= ref.read(activeClassStreamProvider).value;
    if (childClass == null) {
      final scope = ref.read(activeScopeProvider);
      childClass = await (db.select(db.classesTable)..where((t) => t.scope.equals(scope))).getSingleOrNull();
    }

    final childName = child != null ? '${child.firstName} ${child.lastInitial}' : 'Learner';
    final grade = childClass?.grade ?? 3;
    final classLang = (childClass != null && childClass.checkLanguage.isNotEmpty)
        ? childClass.checkLanguage
        : ref.read(readingLanguageProvider);

    // Keep readingLanguageProvider in sync with active class language
    ref.read(readingLanguageProvider.notifier).state = classLang;

    await ref.read(checkFlowControllerProvider.notifier).startSession(
          childId: widget.childId,
          childName: childName,
          grade: grade,
          language: classLang,
        );
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(checkFlowControllerProvider);

    if (session == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Each new step slides in from the right. The old step leaves at once,
    // so there is never a moment with two steps on screen.
    return StepEnter(key: ValueKey(session.currentStep), child: _stepView(session));
  }

  Widget _stepView(CheckSessionState session) {
    switch (session.currentStep) {
      case CheckStep.handover:
        return _HandoverStepView(session: session);
      case CheckStep.studentReading:
        return _StudentReadingStepView(session: session);
      case CheckStep.readingSelfRating:
        return ReadingSelfRatingStepView(session: session);
      case CheckStep.wordCheck:
        return WordCheckStepView(session: session);
      case CheckStep.typingCheck:
        return TypingCheckStepView(session: session);
      case CheckStep.shabaash:
        return _ShabaashStepView(session: session);
      case CheckStep.markReading:
        return _MarkReadingStepView(session: session);
      case CheckStep.retell:
        return _RetellStepView(session: session);
      case CheckStep.questions:
        return _QuestionsStepView(session: session);
      case CheckStep.dictation:
      case CheckStep.listeningCheck:
      case CheckStep.result:
        return _ResultStepView(session: session);
    }
  }
}

// ---------------------------------------------------------------------------
// 8.1 Hand-over Screen
// ---------------------------------------------------------------------------
class _HandoverStepView extends ConsumerStatefulWidget {
  final CheckSessionState session;

  const _HandoverStepView({required this.session});

  @override
  ConsumerState<_HandoverStepView> createState() => _HandoverStepViewState();
}

class _HandoverStepViewState extends ConsumerState<_HandoverStepView> {
  final SamajhAudioService _audioService = SamajhAudioService();
  bool _listening = false;
  bool _noiseChecked = false;
  bool _isNoisy = false;
  bool _micGranted = false;

  @override
  void initState() {
    super.initState();
    _checkInitialPermission();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  Future<void> _checkInitialPermission() async {
    final granted = await _audioService.hasPermission();
    if (mounted) {
      setState(() {
        _micGranted = granted;
      });
      ref.read(checkFlowControllerProvider.notifier).setMicPermission(granted);
    }
  }

  Future<void> _requestMicPermission() async {
    final granted = await _audioService.hasPermission();
    if (mounted) {
      setState(() {
        _micGranted = granted;
      });
      ref.read(checkFlowControllerProvider.notifier).setMicPermission(granted);
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('कृपया ऐप सेटिंग्स में जाकर ऑडियो रिकॉर्डिंग की अनुमति दें।'),
          ),
        );
      }
    }
  }

  Future<void> _listenFor3Seconds() async {
    if (!_micGranted && !widget.session.markWithoutRecording) {
      await _requestMicPermission();
      if (!_micGranted) return;
    }

    setState(() => _listening = true);
    final isLoud = await _audioService.checkAmbientNoise(duration: const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _listening = false;
        _noiseChecked = true;
        _isNoisy = isLoud;
      });
      ref.read(checkFlowControllerProvider.notifier).setNoiseResult(
            isNoisy: isLoud,
            markWithoutRecording: widget.session.markWithoutRecording,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final consentsMap = ref.watch(consentsStreamProvider).value ?? {};
    final appSettings = ref.watch(appSettingsStreamProvider).value;
    final audioConsentGiven = appSettings?.audioRecordingConsentGiven ?? true;
    final hasConsent = widget.session.markWithoutRecording || (consentsMap[widget.session.childId] ?? false);
    final isHindi = widget.session.isPassageHindi;
    final passageTitle = (isHindi ? widget.session.passage['title_hi'] : widget.session.passage['title_en']) ??
        widget.session.passage['title_hi'] ??
        widget.session.passage['title_en'] ??
        (isHindi ? 'कहानी' : 'Story');

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: const SizedBox.shrink(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          children: [
            // Kiran Mascot (speaks in child content language)
            Center(
              child: KiranMascot(
                size: 96,
                spokenText: isHindi ? "नमस्ते! मैं किरण हूँ।" : "Hello! I am Kiran.",
                animated: false,
              ),
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              l10n.givePhoneToTitle(widget.session.childName),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: SamajhColors.textNavy,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            Text(
              l10n.givePhoneToSubtitle(widget.session.childName.split(' ').first),
              style: const TextStyle(
                fontSize: 14,
                color: SamajhColors.textNavy,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            // Passage Card with review tag
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.passageLabel(passageTitle),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: SamajhColors.textNavy,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Color(0xFFB45309),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.originalPassageReviewNote,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF92400E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Audio Permission Status / Request Card (if not yet granted)
            if (!audioConsentGiven) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFCA5A5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.mic_off_rounded, color: SamajhColors.recordingRed, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.audioConsentWithdrawnMessage,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF991B1B),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ] else if (!_micGranted && !widget.session.markWithoutRecording) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFFDE68A), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.mic_none_rounded, color: Color(0xFFD97706), size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.micPermissionTitle,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: SamajhColors.textNavy),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.micPermissionDesc,
                      style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _requestMicPermission,
                            icon: const Icon(Icons.check_circle_outline, size: 18),
                            label: Text(l10n.grantMicPermission),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SamajhColors.forestGreen,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(0, 48),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            ref.read(checkFlowControllerProvider.notifier).setNoiseResult(
                                  isNoisy: false,
                                  markWithoutRecording: true,
                                );
                          },
                          child: Text(l10n.markWithoutRecording),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Check the room section
            Text(
              l10n.checkTheRoom,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: SamajhColors.textNavy,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _listening ? null : _listenFor3Seconds,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_listening) ...[
                          const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n.noiseCheckTitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: SamajhColors.textNavy,
                            ),
                          ),
                        ] else ...[
                          const Icon(Icons.graphic_eq_rounded, color: SamajhColors.textNavy, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            l10n.listenFor3Seconds,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: SamajhColors.textNavy,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_noiseChecked || widget.session.noiseTested) ...[
              const SizedBox(height: 8),
              Text(
                (_isNoisy || widget.session.isNoiseTooHigh)
                    ? l10n.roomTooNoisyWarning
                    : l10n.roomQuietNotice,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: (_isNoisy || widget.session.isNoiseTooHigh)
                      ? const Color(0xFF92400E)
                      : SamajhColors.forestGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            const SizedBox(height: 16),

            // Screen Pinning Tip
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.push_pin_outlined, size: 18, color: SamajhColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.screenPinningTip,
                    style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Primary Button: Start Student Mode
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: hasConsent ? SamajhColors.forestGreen : Colors.grey.shade400,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: hasConsent
                  ? () async {
                      if (!audioConsentGiven) {
                        ref.read(checkFlowControllerProvider.notifier).setNoiseResult(
                              isNoisy: false,
                              markWithoutRecording: true,
                            );
                      } else if (!_micGranted && !widget.session.markWithoutRecording) {
                        await _requestMicPermission();
                        if (!_micGranted) return;
                      }
                      ref.read(checkFlowControllerProvider.notifier).startStudentMode();
                    }
                  : null,
              child: Text(
                l10n.startStudentMode,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            if (!hasConsent) ...[
              const SizedBox(height: 8),
              Text(
                l10n.consentRequiredBeforeCheck(widget.session.childName),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: SamajhColors.recordingRed),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8.2 Student Mode Screen (Child-facing, Locked)
// ---------------------------------------------------------------------------
class _StudentReadingStepView extends ConsumerStatefulWidget {
  final CheckSessionState session;

  const _StudentReadingStepView({required this.session});

  @override
  ConsumerState<_StudentReadingStepView> createState() => _StudentReadingStepViewState();
}

class _StudentReadingStepViewState extends ConsumerState<_StudentReadingStepView> {
  final Stopwatch _stopwatch = Stopwatch();
  final SamajhAudioService _audioService = SamajhAudioService();
  final ScrollController _studentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    final audioConsent = ref.read(appSettingsStreamProvider).value?.audioRecordingConsentGiven ?? true;
    if (!widget.session.markWithoutRecording && audioConsent) {
      _audioService.startReadingRecording(widget.session.checkId);
    }
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _audioService.dispose();
    _studentScrollController.dispose();
    super.dispose();
  }

  Future<void> _onDoneReading() async {
    _stopwatch.stop();
    final elapsedSec = _stopwatch.elapsedMilliseconds / 1000.0;
    String? audioPath;
    if (!widget.session.markWithoutRecording) {
      audioPath = await _audioService.stopReadingRecording();
    }
    ref.read(checkFlowControllerProvider.notifier).finishReading(
          readingDuration: elapsedSec,
          audioPath: audioPath,
        );
  }

  void _showTeacherExitSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => _PasscodeExitSheet(
        onSuccess: () {
          Navigator.pop(ctx);
          context.pop(); // Leave check flow safely
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = widget.session.isPassageHindi;
    final passageText = (isHindi
            ? (widget.session.passage['text_hi'] ?? widget.session.passage['text_en'])
            : (widget.session.passage['text_en'] ?? widget.session.passage['text_hi'])) ??
        '';

    final recordingText = isHindi ? 'रिकॉर्ड हो रहा है' : 'Recording';
    final teacherUnlockText = isHindi ? 'शिक्षक' : 'Teacher';
    final kiranInstructionText = isHindi ? 'कहानी बोलकर पढ़ो। आराम से।' : 'Read this story aloud. Take your time.';
    final studentDoneText = isHindi ? 'मैंने पढ़ लिया' : 'I have finished';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showTeacherExitSheet();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Locked Header with Teacher exit button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Soft recording dot
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: SamajhColors.recordingRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          recordingText,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.recordingRed),
                        ),
                      ],
                    ),
                    // Teacher Unlock
                    TextButton.icon(
                      onPressed: _showTeacherExitSheet,
                      icon: const Icon(Icons.lock_outline_rounded, size: 16, color: SamajhColors.textMuted),
                      label: Text(
                        teacherUnlockText,
                        style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),
              // Spoken & written Kiran prompt
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.wb_sunny_rounded, color: Color(0xFFF59E0B), size: 36),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        kiranInstructionText,
                        style: TextStyle(
                          fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: SamajhColors.textNavy,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Large Devanagari Passage Card
              Expanded(
                child: Scrollbar(
                  controller: _studentScrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _studentScrollController,
                    padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 48.0),
                    child: Text(
                      passageText,
                      style: TextStyle(
                        fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: SamajhColors.textNavy,
                        height: 1.75,
                      ),
                    ),
                  ),
                ),
              ),
              // Large "मैंने पढ़ लिया" Button pinned below
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  key: const Key('done_reading_student_button'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    backgroundColor: SamajhColors.forestGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: _onDoneReading,
                  child: Text(
                    studentDoneText,
                    style: TextStyle(
                      fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8.2 Shabaash screen (friendly transition back to teacher)
// ---------------------------------------------------------------------------
class _ShabaashStepView extends ConsumerWidget {
  final CheckSessionState session;

  const _ShabaashStepView({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHindi = session.isPassageHindi;

    final title = isHindi ? 'शाबाश!' : 'Well done!';
    final subtitle = isHindi ? 'अब यह फोन शिक्षक जी को वापस दे दीजिए।' : 'Now hand the phone back to the teacher.';
    final buttonText = isHindi ? 'शिक्षक मोड पर जाएं' : 'Switch to Teacher Mode';

    return Scaffold(
      backgroundColor: Colors.white,
      body: ConfettiBurst(
        child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // The heading below already says it, so no speech bubble.
                const KiranMascot(
                  size: 140,
                  animated: true,
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: SamajhColors.forestGreen,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: isHindi ? 'NotoSansDevanagari' : 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: SamajhColors.textNavy,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(220, 52),
                    backgroundColor: SamajhColors.forestGreen,
                  ),
                  onPressed: () {
                    ref.read(checkFlowControllerProvider.notifier).proceedToMarking();
                  },
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8.3 Mark Reading Screen (Teacher)
// ---------------------------------------------------------------------------
class _MarkReadingStepView extends ConsumerStatefulWidget {
  final CheckSessionState session;

  const _MarkReadingStepView({required this.session});

  @override
  ConsumerState<_MarkReadingStepView> createState() => _MarkReadingStepViewState();
}

class _MarkReadingStepViewState extends ConsumerState<_MarkReadingStepView> {
  final SamajhAudioService _audioService = SamajhAudioService();
  final ScrollController _chipsScrollController = ScrollController();
  AudioPlayer? _player;
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  StreamSubscription? _posSub;
  StreamSubscription? _durSub;
  StreamSubscription? _stateSub;

  // Automatic marking runs in the controller from the moment the child stops
  // reading; the teacher only rechecks the words outlined in orange.
  AutoMarkStatus get _auto => widget.session.autoMarkStatus;
  Set<int> get _needsCheck => widget.session.autoNeedsCheck;
  int get _autoWrong => widget.session.autoWrong;
  int get _autoReached => widget.session.autoReached;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_chipsScrollController.hasClients) {
        _chipsScrollController.jumpTo(0.0);
      }
      // Started when the reading ended; this only covers checks that skipped that.
      ref.read(checkFlowControllerProvider.notifier).autoMarkReading();
    });
  }

  Widget _autoMarkBanner(AppLocalizations l10n) {
    if (_auto == AutoMarkStatus.idle) return const SizedBox.shrink();
    final (IconData icon, String text, Color bg) = switch (_auto) {
      AutoMarkStatus.listening => (Icons.hearing_rounded, l10n.autoMarkListening, SamajhColors.paleMint),
      AutoMarkStatus.done when _autoReached == 0 =>
        (Icons.hearing_disabled_rounded, l10n.autoMarkNothingHeard, SamajhColors.creamSoft),
      AutoMarkStatus.done when _needsCheck.isNotEmpty =>
        (Icons.fact_check_rounded, l10n.autoMarkDone(_autoWrong, _needsCheck.length), SamajhColors.creamSoft),
      AutoMarkStatus.done when _autoReached < widget.session.passageWords.length =>
        (Icons.check_circle_rounded, l10n.autoMarkStopped(_autoReached), SamajhColors.paleMint),
      AutoMarkStatus.done => (Icons.check_circle_rounded, l10n.autoMarkAllHeard, SamajhColors.paleMint),
      AutoMarkStatus.failed => (Icons.info_outline_rounded, l10n.autoMarkFailed, SamajhColors.creamSoft),
      AutoMarkStatus.unsupported => (Icons.info_outline_rounded, l10n.autoMarkUnsupported, SamajhColors.creamSoft),
      AutoMarkStatus.noRecording => (Icons.info_outline_rounded, l10n.autoMarkNoRecording, SamajhColors.creamSoft),
      AutoMarkStatus.idle => (Icons.info_outline_rounded, '', SamajhColors.creamSoft),
    };
    return Container(
      key: const Key('auto_mark_banner'),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _auto == AutoMarkStatus.listening
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5))
              : Icon(icon, size: 20, color: SamajhColors.textNavy),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textNavy, height: 1.4)),
                if (_auto == AutoMarkStatus.done) ...[
                  const SizedBox(height: 4),
                  Text(l10n.autoMarkNote, style: const TextStyle(fontSize: 11.5, color: SamajhColors.textMuted, height: 1.35)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initAudioPlayer() async {
    final audioPath = widget.session.audioPath;
    if (audioPath != null && audioPath.isNotEmpty) {
      try {
        final file = File(audioPath);
        if (await file.exists()) {
          _player = AudioPlayer();
          _posSub = _player!.positionStream.listen((pos) {
            if (mounted) setState(() => _position = pos);
          });
          _durSub = _player!.durationStream.listen((dur) {
            if (mounted && dur != null) setState(() => _duration = dur);
          });
          _stateSub = _player!.playerStateStream.listen((st) {
            if (mounted) setState(() => _isPlaying = st.playing);
          });
          await _player!.setFilePath(audioPath);
        }
      } catch (e) {
        debugPrint('Samajh: Audio playback init exception: $e');
      }
    }
  }

  @override
  void dispose() {
    _posSub?.cancel();
    _durSub?.cancel();
    _stateSub?.cancel();
    _player?.dispose();
    _audioService.dispose();
    _chipsScrollController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_player == null) return;
    if (_isPlaying) {
      _player!.pause();
    } else {
      _player!.play();
    }
  }

  void _cycleSpeed() {
    if (_player == null) return;
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 0.75;
      } else if (_playbackSpeed == 0.75) {
        _playbackSpeed = 1.25;
      } else {
        _playbackSpeed = 1.0;
      }
      _player!.setSpeed(_playbackSpeed);
    });
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _showPassagePronunciationGuide() {
    final l10n = AppLocalizations.of(context)!;
    final words = widget.session.passageWords;
    final conjunctWords = <String>[];
    final nuktaWords = <String>[];
    final longMatraWords = <String>[];

    for (final w in words) {
      final clean = DevanagariAksharaEngine.cleanWord(w);
      final feat = DevanagariAksharaEngine.analyzeFeatures(clean);
      if (feat.contains('conjunct') && !conjunctWords.contains(clean)) {
        conjunctWords.add(clean);
      }
      if (feat.contains('nukta') && !nuktaWords.contains(clean)) {
        nuktaWords.add(clean);
      }
      if (feat.contains('long matra') && !longMatraWords.contains(clean)) {
        longMatraWords.add(clean);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.pronunciationCheckGuide,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(height: 20),
              const Text(
                "Key phonetic features in this story to check during playback:",
                style: TextStyle(fontSize: 13, color: SamajhColors.textMuted),
              ),
              const SizedBox(height: 12),
              if (conjunctWords.isNotEmpty) ...[
                const Text("संयुक्त अक्षर (Conjuncts):", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: conjunctWords.take(6).map((w) => Chip(label: Text(w), backgroundColor: SamajhColors.paleMint)).toList(),
                ),
                const SizedBox(height: 10),
              ],
              if (nuktaWords.isNotEmpty) ...[
                const Text("नुक्ता ध्वनियाँ (Nukta sounds):", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: nuktaWords.map((w) => Chip(label: Text(w), backgroundColor: Colors.amber.shade50)).toList(),
                ),
                const SizedBox(height: 10),
              ],
              if (longMatraWords.isNotEmpty) ...[
                const Text("दीर्घ मात्रा (Long vowel signs):", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: longMatraWords.take(8).map((w) => Chip(label: Text(w), backgroundColor: const Color(0xFFEFF6FF))).toList(),
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Got it"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openPronunciationSheet(int wordIndex) {
    final words = widget.session.passageWords;
    if (wordIndex < 0 || wordIndex >= words.length) return;
    final word = words[wordIndex];
    final currentMark = widget.session.wordMarks[wordIndex] ?? WordMark.unmarked;
    final isRegional = widget.session.regionalAcceptedWords.contains(wordIndex);
    final errorSubtype = widget.session.wordErrorSubtypes[wordIndex];

    final segments = DevanagariAksharaEngine.segmentWord(word);
    final regionalVariants = DevanagariAksharaEngine.getRegionalVariants(word);
    final guide = DevanagariAksharaEngine.generatePronunciationGuide(word);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            final l10n = AppLocalizations.of(context)!;
            final isHi = Localizations.localeOf(context).languageCode == 'hi';

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sheet Header with word index
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.pronunciationCheckTitle,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Word ${wordIndex + 1} of ${words.length}",
                              style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const Divider(height: 20),

                    // Target Word Highlight Box
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: SamajhColors.paleMint,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: Text(
                          word,
                          style: const TextStyle(
                            fontFamily: 'NotoSansDevanagari',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: SamajhColors.forestGreen,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Syllable / Phonetic Breakdown Section
                    Text(
                      l10n.phoneticBreakdownTitle,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: segments.map((seg) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: SamajhColors.dividerColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                seg.text,
                                style: const TextStyle(
                                  fontFamily: 'NotoSansDevanagari',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: SamajhColors.textNavy,
                                ),
                              ),
                              Text(
                                isHi ? seg.categoryLabelHi : seg.categoryLabelEn,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: SamajhColors.forestGreen),
                              ),
                              Text(
                                isHi ? seg.phoneticNoteHi : seg.phoneticNoteEn,
                                style: const TextStyle(fontSize: 9, color: SamajhColors.textMuted),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),

                    // Standard Pronunciation Guide Text
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: SamajhColors.dividerColor),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.volume_up_rounded, size: 18, color: SamajhColors.forestGreen),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.standardPronunciation(guide),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Regional Variants (if available)
                    if (regionalVariants.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.commonRegionalVariants(regionalVariants.join(', ')),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF92400E)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.regionalAccentExplanation,
                              style: const TextStyle(fontSize: 11, color: Color(0xFFB45309)),
                            ),
                            const SizedBox(height: 8),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF92400E),
                                side: const BorderSide(color: Color(0xFFF59E0B)),
                              ),
                              onPressed: () {
                                ref.read(checkFlowControllerProvider.notifier).acceptRegionalPronunciation(wordIndex, regionalVariants.first);
                                Navigator.pop(ctx);
                              },
                              icon: const Icon(Icons.thumb_up_alt_outlined, size: 16),
                              label: Text(l10n.acceptRegionalPronunciation),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),
                    const Text(
                      "Mark Pronunciation Result:",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                    ),
                    const SizedBox(height: 10),

                    // 1. Correct Pronunciation Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentMark == WordMark.correct && !isRegional ? SamajhColors.forestGreen : Colors.white,
                        foregroundColor: currentMark == WordMark.correct && !isRegional ? Colors.white : SamajhColors.forestGreen,
                        side: const BorderSide(color: SamajhColors.forestGreen, width: 1.5),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: () {
                        ref.read(checkFlowControllerProvider.notifier).setWordMark(wordIndex, WordMark.correct);
                        Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.check_circle_rounded, size: 20),
                      label: Text(l10n.markPronouncedCorrect, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),

                    // 2. Mispronounced / Read Differently Button
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: currentMark == WordMark.readAsAnotherWord ? Colors.red.shade50 : Colors.white,
                        foregroundColor: SamajhColors.recordingRed,
                        side: const BorderSide(color: SamajhColors.recordingRed, width: 1.5),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showErrorCategorySelector(wordIndex, word);
                      },
                      icon: const Icon(Icons.cancel_rounded, size: 20),
                      label: Text(
                        errorSubtype != null
                            ? "${l10n.markMispronounced} (${DevanagariAksharaEngine.formatFeatureLabel(errorSubtype, inHindi: isHi)})"
                            : l10n.markMispronounced,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Row of secondary marks: Self-Corrected, Repeated, Skipped, Not Sure
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: currentMark == WordMark.correctedSelf ? SamajhColors.paleMint : null,
                            minimumSize: const Size(60, 40),
                          ),
                          onPressed: () {
                            ref.read(checkFlowControllerProvider.notifier).setWordMark(wordIndex, WordMark.correctedSelf);
                            Navigator.pop(ctx);
                          },
                          child: Text(l10n.markSelfCorrected),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: currentMark == WordMark.repeated ? Colors.purple.shade50 : null,
                            minimumSize: const Size(60, 40),
                          ),
                          onPressed: () {
                            ref.read(checkFlowControllerProvider.notifier).setWordMark(wordIndex, WordMark.repeated);
                            Navigator.pop(ctx);
                          },
                          child: Text(l10n.markRepeated),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: currentMark == WordMark.skipped ? Colors.orange.shade50 : null,
                            minimumSize: const Size(60, 40),
                          ),
                          onPressed: () {
                            ref.read(checkFlowControllerProvider.notifier).setWordMark(wordIndex, WordMark.skipped);
                            Navigator.pop(ctx);
                          },
                          child: Text(l10n.markSkipped),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: currentMark == WordMark.notSure ? Colors.amber.shade50 : null,
                            minimumSize: const Size(60, 40),
                          ),
                          onPressed: () {
                            ref.read(checkFlowControllerProvider.notifier).setWordMark(wordIndex, WordMark.notSure);
                            Navigator.pop(ctx);
                          },
                          child: Text(l10n.markNotSure),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: currentMark == WordMark.notReached ? Colors.grey.shade100 : null,
                            minimumSize: const Size(60, 40),
                          ),
                          onPressed: () {
                            ref.read(checkFlowControllerProvider.notifier).setWordMark(wordIndex, WordMark.notReached);
                            Navigator.pop(ctx);
                          },
                          child: Text(l10n.markNotReached),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(color: Colors.grey.shade400),
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: () {
                        ref.read(checkFlowControllerProvider.notifier).setRemainingNotReached(wordIndex + 1);
                        Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.stop_circle_outlined, size: 18),
                      label: Text(l10n.markChildStoppedHere),
                    ),
                    const SizedBox(height: 16),

                    // Sequential Navigation Buttons (Prev / Next Word)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (wordIndex > 0)
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _openPronunciationSheet(wordIndex - 1);
                            },
                            icon: const Icon(Icons.arrow_back_rounded, size: 16),
                            label: Text(l10n.prevWord),
                          )
                        else
                          const SizedBox.shrink(),
                        if (wordIndex < words.length - 1)
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _openPronunciationSheet(wordIndex + 1);
                            },
                            icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                            label: Text(l10n.nextWord),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showErrorCategorySelector(int wordIndex, String word) {
    final l10n = AppLocalizations.of(context)!;
    final primaryMistake = DevanagariAksharaEngine.classifyPrimaryMistake(word);
    final textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${l10n.soundErrorType}: $word",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _errorCategoryChoice(ctx, wordIndex, 'long matra', l10n.errorKindLongMatra, primaryMistake == 'long matra' || primaryMistake == 'long ee matra' || primaryMistake == 'long oo matra', textController),
                  _errorCategoryChoice(ctx, wordIndex, 'short matra', l10n.errorKindShortMatra, primaryMistake == 'short matra' || primaryMistake == 'short i matra', textController),
                  _errorCategoryChoice(ctx, wordIndex, 'conjunct', l10n.errorKindConjunct, primaryMistake == 'conjunct', textController),
                  _errorCategoryChoice(ctx, wordIndex, 'consonant', l10n.errorKindConsonant, primaryMistake == 'consonant', textController),
                  _errorCategoryChoice(ctx, wordIndex, 'nukta', l10n.errorKindNukta, primaryMistake == 'nukta', textController),
                  _errorCategoryChoice(ctx, wordIndex, 'bindu', l10n.errorKindBindu, primaryMistake == 'bindu' || primaryMistake == 'chandrabindu', textController),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: l10n.observedWordPrompt,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: () {
                  final obs = textController.text.trim();
                  ref.read(checkFlowControllerProvider.notifier).setWordMark(
                        wordIndex,
                        WordMark.readAsAnotherWord,
                        observation: obs.isNotEmpty ? obs : null,
                        errorSubtype: primaryMistake,
                      );
                  Navigator.pop(ctx);
                },
                child: Text(l10n.saveButton),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _errorCategoryChoice(BuildContext ctx, int wordIndex, String subtype, String label, bool isSuggested, TextEditingController textCtrl) {
    return ActionChip(
      avatar: isSuggested ? const Icon(Icons.star, size: 14, color: Color(0xFFD97706)) : null,
      backgroundColor: isSuggested ? const Color(0xFFFEF3C7) : Colors.white,
      side: BorderSide(color: isSuggested ? const Color(0xFFF59E0B) : SamajhColors.dividerColor),
      label: Text(label, style: TextStyle(fontSize: 12, fontWeight: isSuggested ? FontWeight.bold : FontWeight.normal)),
      onPressed: () {
        final obs = textCtrl.text.trim();
        ref.read(checkFlowControllerProvider.notifier).setWordMark(
              wordIndex,
              WordMark.readAsAnotherWord,
              observation: obs.isNotEmpty ? obs : null,
              errorSubtype: subtype,
            );
        Navigator.pop(ctx);
      },
    );
  }

  void _confirmMarkRemainingAsCorrect() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n.confirmMarkRemainingTitle),
        content: Text(l10n.confirmMarkRemainingBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(l10n.cancelButton),
          ),
          ElevatedButton(
            key: const Key('confirm_mark_remaining_dialog_confirm'),
            style: ElevatedButton.styleFrom(backgroundColor: SamajhColors.forestGreen),
            onPressed: () {
              ref.read(checkFlowControllerProvider.notifier).markAllRemainingAsCorrect();
              Navigator.pop(dialogCtx);
            },
            child: Text(l10n.markRemainingCorrect),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSaveAndContinue() async {
    final l10n = AppLocalizations.of(context)!;
    final hasUnmarked = ref.read(checkFlowControllerProvider.notifier).hasUnmarkedBeforeLastRead;
    if (hasUnmarked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.unmarkedWordsWarning),
          backgroundColor: SamajhColors.recordingRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    _player?.pause();
    _player?.dispose();
    _player = null;
    final audioPath = widget.session.audioPath;
    if (audioPath != null) {
      await _audioService.deleteAudioFile(audioPath);
    }
    await ref.read(checkFlowControllerProvider.notifier).saveMarkingAndContinue();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final words = widget.session.passageWords;
    final marks = widget.session.wordMarks;
    final regionalSet = widget.session.regionalAcceptedWords;
    final subtypes = widget.session.wordErrorSubtypes;

    // Compute live error, not sure, words read count
    int errors = 0;
    int notSure = 0;
    int wordsRead = 0;

    for (int i = 0; i < words.length; i++) {
      final m = marks[i] ?? WordMark.unmarked;
      if (m == WordMark.notReached || m == WordMark.unmarked) continue;
      wordsRead++;
      if (m == WordMark.readAsAnotherWord || m == WordMark.skipped) {
        errors++;
      } else if (m == WordMark.notSure) {
        notSure++;
      }
    }

    final attempted = wordsRead - notSure;
    final correct = wordsRead - errors - notSure;
    final accuracyPct = attempted > 0 ? ((correct / attempted) * 100).round() : 0;
    final unmarkedCount = ref.read(checkFlowControllerProvider.notifier).getUnmarkedWordsCount();
    final canSave = !ref.read(checkFlowControllerProvider.notifier).hasUnmarkedBeforeLastRead;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(l10n.markingTitle),
        actions: [
          IconButton(
            tooltip: l10n.pronunciationCheckGuide,
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: _showPassagePronunciationGuide,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _autoMarkBanner(l10n),
            // Audio Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: _player != null
                  ? Row(
                      children: [
                        IconButton(
                          icon: Icon(_isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded),
                          iconSize: 38,
                          color: SamajhColors.forestGreen,
                          onPressed: _togglePlayPause,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                                ),
                                child: Slider(
                                  value: _position.inMilliseconds.clamp(0, _duration.inMilliseconds > 0 ? _duration.inMilliseconds : 1).toDouble(),
                                  max: (_duration.inMilliseconds > 0 ? _duration.inMilliseconds : 1).toDouble(),
                                  onChanged: (val) {
                                    _player?.seek(Duration(milliseconds: val.toInt()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_formatDuration(_position), style: const TextStyle(fontSize: 10, color: SamajhColors.textMuted)),
                                    Text(_formatDuration(_duration), style: const TextStyle(fontSize: 10, color: SamajhColors.textMuted)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _cycleSpeed,
                          child: Text('${_playbackSpeed}x', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const Icon(Icons.mic_off_rounded, color: SamajhColors.textMuted, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.markWithoutRecording,
                            style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _showPassagePronunciationGuide,
                          icon: const Icon(Icons.menu_book_rounded, size: 16),
                          label: Text(l10n.pronunciationCheckGuide),
                        ),
                      ],
                    ),
            ),
            // Live counts line with pronunciation accuracy
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: SamajhColors.paleMint,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${l10n.liveMarkingCount(errors, notSure, wordsRead)} · ${l10n.livePronunciationAccuracy(accuracyPct)}",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: SamajhColors.forestGreen),
                    ),
                  ),
                  InkWell(
                    onTap: _showPassagePronunciationGuide,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.info_outline, size: 14, color: SamajhColors.forestGreen),
                        const SizedBox(width: 4),
                        Text(
                          Localizations.localeOf(context).languageCode == 'hi' ? "गाइड" : "Guide",
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: SamajhColors.forestGreen),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Note: recording is deleted on save
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              child: Row(
                children: [
                  const Icon(Icons.touch_app_outlined, size: 13, color: SamajhColors.textMuted),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "${l10n.markingGuide} ${Localizations.localeOf(context).languageCode == 'hi' ? 'शब्द पर टैप करके उच्चारण की गहराई से जांच करें।' : 'Tap any word to inspect pronunciation.'}",
                      style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                    ),
                  ),
                ],
              ),
            ),
            // Unmarked Words Banner & "Mark remaining as correct" Button
            if (unmarkedCount > 0)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, size: 18, color: Color(0xFFB45309)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.unmarkedWordsCounter(unmarkedCount),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF92400E),
                        ),
                      ),
                    ),
                    TextButton(
                      key: const Key('mark_remaining_correct_button'),
                      onPressed: _confirmMarkRemainingAsCorrect,
                      style: TextButton.styleFrom(
                        foregroundColor: SamajhColors.forestGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: Text(
                        l10n.markRemainingCorrect,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            // Words chip list with explicit scroll controller starting at top
            Expanded(
              child: Scrollbar(
                controller: _chipsScrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _chipsScrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: List.generate(words.length, (index) {
                      final word = words[index];
                      final mark = marks[index] ?? WordMark.unmarked;
                      final isReg = regionalSet.contains(index);
                      final sub = subtypes[index];

                      return _WordMarkChip(
                        word: word,
                        mark: mark,
                        isRegional: isReg,
                        errorSubtype: sub,
                        needsCheck: _needsCheck.contains(index),
                        onTap: () {
                          ref.read(checkFlowControllerProvider.notifier).clearNeedsCheck(index);
                          _openPronunciationSheet(index);
                        },
                        onLongPress: () {
                          ref.read(checkFlowControllerProvider.notifier).clearNeedsCheck(index);
                          _cycleMark(index, mark);
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
            // Marking Legend & Safety notice (Screenshot 3)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: SamajhColors.dividerColor)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      _legendItem(const Color(0xFFF1F5F9), const Color(0xFFCBD5E1), Localizations.localeOf(context).languageCode == 'hi' ? 'अचिन्हित' : 'Unmarked'),
                      _legendItem(const Color(0xFFECFDF5), SamajhColors.forestGreen, l10n.markCorrect),
                      _legendItem(Colors.red.shade50, SamajhColors.recordingRed, l10n.markReadAsAnotherWord),
                      _legendItem(Colors.orange.shade50, Colors.orange, l10n.markSkipped),
                      _legendItem(SamajhColors.paleMint, SamajhColors.forestGreen, l10n.markSelfCorrected),
                      _legendItem(Colors.purple.shade50, Colors.purple, l10n.markRepeated),
                      _legendItem(Colors.amber.shade50, Colors.amber.shade700, l10n.markNotSure),
                      _legendItem(Colors.grey.shade100, Colors.grey.shade400, l10n.markNotReached),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.markingGuide,
                    style: const TextStyle(fontSize: 11, color: SamajhColors.textMuted),
                  ),
                ],
              ),
            ),
            // Save and continue button
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: ElevatedButton(
                key: const Key('save_and_continue_reading_button'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: canSave ? SamajhColors.forestGreen : Colors.grey.shade400,
                ),
                onPressed: _handleSaveAndContinue,
                child: Text(l10n.saveAndContinue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cycleMark(int index, WordMark current) {
    // Quick cycling shortcut
    const order = [
      WordMark.unmarked,
      WordMark.correct,
      WordMark.readAsAnotherWord,
      WordMark.skipped,
      WordMark.correctedSelf,
      WordMark.repeated,
      WordMark.notSure,
      WordMark.notReached,
    ];
    final nextIndex = (order.indexOf(current) + 1) % order.length;
    ref.read(checkFlowControllerProvider.notifier).setWordMark(index, order[nextIndex]);
  }

  Widget _legendItem(Color bg, Color border, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: border, width: 1.2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: SamajhColors.textNavy)),
      ],
    );
  }
}

class _WordMarkChip extends StatelessWidget {
  final String word;
  final WordMark mark;
  final bool isRegional;
  final String? errorSubtype;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  /// Marked by the app and worth a listen: drawn with a thick orange ring.
  final bool needsCheck;

  const _WordMarkChip({
    required this.word,
    required this.mark,
    this.isRegional = false,
    this.errorSubtype,
    this.needsCheck = false,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isHi = Localizations.localeOf(context).languageCode == 'hi';
    final isDevanagari = RegExp(r'[\u0900-\u097F]').hasMatch(word);

    Color bg = Colors.white;
    Color border = SamajhColors.dividerColor;
    Color text = SamajhColors.textNavy;
    String label = '';

    if (isRegional) {
      bg = const Color(0xFFFEF3C7);
      border = const Color(0xFFF59E0B);
      text = const Color(0xFF92400E);
      label = isHi ? 'क्षेत्रीय ✓' : 'Regional ✓';
    } else {
      switch (mark) {
        case WordMark.unmarked:
          bg = const Color(0xFFF1F5F9);
          border = const Color(0xFFCBD5E1);
          text = const Color(0xFF64748B);
          label = '';
          break;
        case WordMark.correct:
          bg = const Color(0xFFECFDF5);
          border = SamajhColors.forestGreen;
          text = SamajhColors.forestGreen;
          label = '✓';
          break;
        case WordMark.readAsAnotherWord:
          bg = Colors.red.shade50;
          border = SamajhColors.recordingRed;
          text = SamajhColors.recordingRed;
          label = errorSubtype != null
              ? DevanagariAksharaEngine.formatFeatureLabel(errorSubtype!, inHindi: isHi)
              : (isHi ? 'गलत ✗' : 'Wrong ✗');
          break;
        case WordMark.skipped:
          bg = Colors.orange.shade50;
          border = Colors.orange;
          text = Colors.orange.shade900;
          label = isHi ? 'छोड़ा' : 'Skipped';
          break;
        case WordMark.correctedSelf:
          bg = SamajhColors.paleMint;
          border = SamajhColors.forestGreen;
          text = SamajhColors.forestGreen;
          label = isHi ? 'सुधारा' : 'Corrected';
          break;
        case WordMark.repeated:
          bg = Colors.purple.shade50;
          border = Colors.purple;
          text = Colors.purple.shade800;
          label = isHi ? 'दोहराया' : 'Repeated';
          break;
        case WordMark.notSure:
          bg = Colors.amber.shade50;
          border = Colors.amber.shade700;
          text = Colors.amber.shade900;
          label = '?';
          break;
        case WordMark.notReached:
          bg = Colors.grey.shade100;
          border = Colors.grey.shade400;
          text = Colors.grey.shade600;
          label = 'NR';
          break;
      }
    }

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: needsCheck ? const Color(0xFFF97316) : border, width: needsCheck ? 3 : 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              word,
              style: TextStyle(
                fontFamily: isDevanagari ? 'NotoSansDevanagari' : 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: text,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: text),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8.4 Retell Step Screen
// ---------------------------------------------------------------------------
class _RetellStepView extends ConsumerWidget {
  final CheckSessionState session;

  const _RetellStepView({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isHindi = session.isPassageHindi;
    final retellPoints = ((isHindi ? session.passage['retell_points'] : session.passage['retell_points_en']) as List<dynamic>?) ??
        (session.passage['retell_points'] as List<dynamic>?) ??
        (session.passage['retell_points_en'] as List<dynamic>?) ??
        [];

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(title: Text(l10n.retellTitle)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                l10n.retellSubtitle,
                style: const TextStyle(fontSize: 14, color: SamajhColors.textMuted, height: 1.4),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: retellPoints.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final isChecked = session.retellPointsTicked.contains(index);
                  return CheckboxListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: SamajhColors.dividerColor),
                    ),
                    value: isChecked,
                    activeColor: SamajhColors.forestGreen,
                    onChanged: (val) {
                      ref.read(checkFlowControllerProvider.notifier).toggleRetellPoint(index);
                    },
                    title: Text(
                      retellPoints[index].toString(),
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.4),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => ref.read(checkFlowControllerProvider.notifier).skipRetell(),
                      child: Text(l10n.skipRetelling),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => ref.read(checkFlowControllerProvider.notifier).continueToQuestions(),
                      child: Text(l10n.continueToQuestions),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8.5 Questions Step Screen
// ---------------------------------------------------------------------------
class _QuestionsStepView extends ConsumerStatefulWidget {
  final CheckSessionState session;

  const _QuestionsStepView({required this.session});

  @override
  ConsumerState<_QuestionsStepView> createState() => _QuestionsStepViewState();
}

/// Teacher asks level by level, top to bottom. A question's time runs from
/// when the one before it was marked (or its level opened) to its own first
/// mark; slower answers earn fewer marks.
class _QuestionsStepViewState extends ConsumerState<_QuestionsStepView> {
  final Map<int, DateTime> _levelOpenedAt = {};
  final Map<String, DateTime> _markedAt = {};
  Map<String, dynamic>? _thresholds;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    WordCheckScoringEngine.loadThresholds().then((t) {
      if (mounted) setState(() => _thresholds = t);
    });
    // Repaint once a second so the teacher sees the running time.
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.watch(checkFlowControllerProvider) ?? widget.session;
    final isHindi = session.isPassageHindi;
    final rawQuestions = (session.passage['questions'] as List<dynamic>?) ?? [];
    final levelled = session.levelledQuestions;
    final gate = QuestionLevels.evaluate(
      questions: levelled,
      answers: session.questionAnswers,
      timesMs: session.questionTimesMs,
      ratings: session.questionRatings,
      thresholds: _thresholds,
    );
    final now = DateTime.now();
    for (final lvl in gate.openLevels) {
      _levelOpenedAt.putIfAbsent(lvl, () => now);
    }
    final nextLocked = gate.levels.where((l) => !gate.openLevels.contains(l)).firstOrNull;
    final allOpenMarked = levelled
        .where((q) => gate.openLevels.contains(q.level))
        .every((q) => session.questionAnswers.containsKey(q.id));

    final visible = <int>[
      for (var i = 0; i < levelled.length; i++)
        if (gate.openLevels.contains(levelled[i].level)) i,
    ]..sort((a, b) => levelled[a].level.compareTo(levelled[b].level));

    final startedAt = <String, DateTime>{};
    DateTime? previousMark;
    int? previousLevel;
    for (final i in visible) {
      final q = levelled[i];
      final opened = _levelOpenedAt[q.level]!;
      if (q.level != previousLevel) previousMark = null;
      startedAt[q.id] = previousMark != null && previousMark.isAfter(opened) ? previousMark : opened;
      previousMark = _markedAt[q.id] ?? previousMark;
      previousLevel = q.level;
    }

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(title: Text(l10n.questionsTitle)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${l10n.questionsSubtitle}\n${l10n.questionsLevelHint}',
                style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted, height: 1.4),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  for (final index in visible) ...[
                    _questionCard(session, rawQuestions[index] as Map<String, dynamic>, levelled[index], startedAt[levelled[index].id]!, l10n, isHindi),
                    const SizedBox(height: 12),
                  ],
                  if (gate.stoppedAtLevel != null)
                    _note(l10n.questionsStoppedAt(gate.stoppedAtLevel!), const Color(0xFFFEF3C7), const Color(0xFF92400E))
                  else if (nextLocked != null)
                    _note(l10n.questionsNextLocked(nextLocked), const Color(0xFFF1F5F9), SamajhColors.textMuted),
                  if (gate.possible > 0) ...[
                    const SizedBox(height: 8),
                    Text(
                      l10n.marksLine(gate.earned.toStringAsFixed(1), gate.possible.toStringAsFixed(1)),
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!allOpenMarked)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(l10n.questionMarkFirst,
                          style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted)),
                    ),
                  ElevatedButton(
                    key: const Key('questions_see_result'),
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                    onPressed: allOpenMarked
                        ? () => ref.read(checkFlowControllerProvider.notifier).computeFinalResultAndSave()
                        : null,
                    child: Text(l10n.seeTheResult),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _note(String text, Color bg, Color fg) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(text, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: fg, height: 1.35)),
      );

  Widget _questionCard(
    CheckSessionState session,
    Map<String, dynamic> q,
    LevelledQuestion lq,
    DateTime startedAt,
    AppLocalizations l10n,
    bool isHindi,
  ) {
    final qId = lq.id;
    final currentAnswer = session.questionAnswers[qId];
    final questionText = (isHindi ? q['question_hi'] : q['question_en']) ?? q['question_hi'] ?? q['question_en'] ?? '';
    final expectedAns =
        (isHindi ? q['expected_answer_hi'] : q['expected_answer_en']) ?? q['expected_answer_hi'] ?? q['expected_answer_en'] ?? '';
    final frozenMs = session.questionTimesMs[qId];
    final elapsedMs = frozenMs ?? DateTime.now().difference(startedAt).inMilliseconds;
    final notifier = ref.read(checkFlowControllerProvider.notifier);
    void mark(String status) {
      _markedAt.putIfAbsent(qId, DateTime.now);
      notifier.setQuestionAnswer(qId, status, timeMs: elapsedMs);
    }

    return Container(
      key: Key('question_card_$qId'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SamajhColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    _pill(l10n.questionLevelLabel(lq.level), const Color(0xFFDCFCE7), SamajhColors.forestGreen),
                    _pill(_formatQuestionType(lq.type, l10n), const Color(0xFFEFF6FF), const Color(0xFF1D4ED8)),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.timer_outlined, size: 14, color: frozenMs != null ? SamajhColors.forestGreen : SamajhColors.textMuted),
              const SizedBox(width: 2),
              Text(l10n.questionTimeSeconds(elapsedMs ~/ 1000),
                  style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            questionText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: SamajhColors.textNavy, height: 1.4),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.expectedAnswerPrefix(expectedAns),
            style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ChoiceChip(label: l10n.answerCorrect, isSelected: currentAnswer == 'correct', onTap: () => mark('correct')),
              _ChoiceChip(label: l10n.answerPartly, isSelected: currentAnswer == 'partly', onTap: () => mark('partly')),
              _ChoiceChip(label: l10n.answerNotCorrect, isSelected: currentAnswer == 'not_correct', onTap: () => mark('not_correct')),
              _ChoiceChip(label: l10n.answerNoAnswer, isSelected: currentAnswer == 'no_answer', onTap: () => mark('no_answer')),
              _ChoiceChip(label: l10n.answerNotAsked, isSelected: currentAnswer == 'not_asked', onTap: () => mark('not_asked')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color bg, Color fg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
        child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg)),
      );

  String _formatQuestionType(String? type, AppLocalizations l10n) {
    switch (type) {
      case 'fact':
        return l10n.questionTypeFact;
      case 'why_how':
        return l10n.questionTypeWhyHow;
      case 'main_idea':
        return l10n.questionTypeMainIdea;
      case 'word_meaning':
        return l10n.questionTypeWordMeaning;
      case 'cause_effect':
        return l10n.questionTypeCauseEffect;
      default:
        return l10n.questionTypeFact;
    }
  }
}

class _ChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: SamajhColors.paleMint,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? SamajhColors.forestGreen : SamajhColors.textNavy,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8.6 Word check (child-facing visual choice replaces legacy dictation)
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// 8.8 Result in Plain Words Screen
// ---------------------------------------------------------------------------
class _ResultStepView extends ConsumerWidget {
  final CheckSessionState session;

  const _ResultStepView({required this.session});

  String _getFlsBenchmark(int grade, int wpm, AppLocalizations l10n) {
    int minMeets = 35;
    int minAbove = 54;
    if (grade == 1) {
      minMeets = 15;
      minAbove = 25;
    } else if (grade == 2) {
      minMeets = 25;
      minAbove = 35;
    } else if (grade == 3) {
      minMeets = 35;
      minAbove = 54;
    } else if (grade == 4) {
      minMeets = 45;
      minAbove = 65;
    } else if (grade >= 5) {
      minMeets = 55;
      minAbove = 75;
    }

    if (wpm >= minAbove) {
      return l10n.flsBenchmarkAbove(grade);
    } else if (wpm >= minMeets) {
      return l10n.flsBenchmarkMeets(grade);
    } else {
      return l10n.flsBenchmarkBelow(grade);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final activeClass = ref.watch(activeClassStreamProvider).value;
    final isDemoMode = activeClass?.scope != 'real';
    final grade = activeClass?.grade ?? 3;

    int skippedCount = 0;
    int misreadCount = 0;
    int selfCorrectedCount = 0;
    for (final mark in session.wordMarks.values) {
      if (mark == WordMark.skipped) skippedCount++;
      if (mark == WordMark.readAsAnotherWord) misreadCount++;
      if (mark == WordMark.correctedSelf) selfCorrectedCount++;
    }

    final isHindi = session.isPassageHindi;
    final summary = session.wordCheckSummary;
    final topMistakes = summary?.topMistakeTags ?? session.stuckOnAksharas.take(3).toList();
    final totalRetellPoints = ((isHindi ? session.passage['retell_points'] : session.passage['retell_points_en']) as List?)?.length ??
        (session.passage['retell_points'] as List?)?.length ?? 6;
    final correctDictation = session.dictationMarks.values.where((v) => v == true).length;
    final totalDictation = session.dictationMarks.length;

    final isLowConfidence = session.notEnoughEvidence || session.lowConfidence || session.isNoiseTooHigh;

    return Scaffold(
      backgroundColor: SamajhColors.background,
      appBar: AppBar(
        title: Text(
          session.childName,
          style: const TextStyle(fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/app/class'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Demo mode banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8EEF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.science_outlined, color: SamajhColors.textNavy, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isDemoMode ? l10n.demoModeBanner : l10n.realModeBannerApproved,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: SamajhColors.textNavy),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Warning card: no reading to judge, or a result with low confidence.
            if (isLowConfidence) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF7E6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  session.notEnoughEvidence ? l10n.notEnoughEvidenceTitle : l10n.lowConfidenceTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: SamajhColors.textNavy,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                session.notEnoughEvidence ? l10n.lowConfidenceExplanation : l10n.lowConfidenceNote,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8D5B00),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Section 1: Reading
            Text(
              l10n.readingSection,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.accuracyPercent((session.accuracy * 100).toInt()),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.correctWordsPerMinute(session.wordsPerMinute),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.readingBreakdown(skippedCount, misreadCount, selfCorrectedCount),
                    style: const TextStyle(fontSize: 13, color: SamajhColors.textMuted),
                  ),
                  const SizedBox(height: 12),
                  // Badge 1: FLS 2022
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getFlsBenchmark(grade, session.wordsPerMinute, l10n),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0D652D)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Badge 2: UP NIPUN
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      session.wordsPerMinute >= 60 ? l10n.nipunReached : l10n.nipunNotReached,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0D652D)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.accuracyGuideNote,
                    style: const TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.35),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section 2: Understanding
            Text(
              l10n.understandingSection,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Text(
                l10n.storyRetoldScore(session.retellPointsTicked.length, totalRetellPoints),
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
              ),
            ),
            const SizedBox(height: 20),

            // Section 3: Word check (visual choice, teacher-only view)
            Text(
              isHindi ? "शब्द जाँच (दृश्य विकल्प)" : "Word check (Visual choices)",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: SamajhColors.textNavy),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SamajhColors.dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        summary != null && summary.totalItemsAttempted > 0
                            ? "${summary.totalRawCorrect} of ${summary.totalItemsAttempted} correct"
                            : (session.dictationSkipped
                                ? l10n.dictationSkippedSummary
                                : l10n.dictationScoreSummary(correctDictation, totalDictation)),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: SamajhColors.textNavy),
                      ),
                      if (summary != null && summary.totalItemsAttempted > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: SamajhColors.paleMint,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            l10n.marksLine(summary.totalWeightedScore.toStringAsFixed(1), summary.maxPossibleScore.toStringAsFixed(1)),
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: SamajhColors.forestGreen),
                          ),
                        ),
                    ],
                  ),
                  if (summary != null && summary.totalItemsAttempted > 0) ...[
                    const SizedBox(height: 10),
                    Text(
                      summary.highestLevelReached > 0
                          ? l10n.highestLevelPassed(summary.highestLevelReached)
                          : l10n.levelOneNotPassed,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: SamajhColors.textNavy),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: summary.perLevelResults.entries.map((e) {
                        final lvl = e.key;
                        final res = e.value;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "L$lvl: ${res.rawCorrect}/${res.totalItems} (${res.weightedScore.toStringAsFixed(1)}/${res.maxPossibleWeightedScore.toStringAsFixed(1)})",
                            style: const TextStyle(fontSize: 12, color: SamajhColors.textNavy),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  if (summary != null && summary.overallReasons.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      isHindi ? "विस्तृत टिप्पणियाँ (शिक्षक दृश्य):" : "Scoring reasons (Teacher view):",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: SamajhColors.textMuted),
                    ),
                    const SizedBox(height: 4),
                    ...summary.overallReasons.take(3).map((r) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("• ", style: TextStyle(color: SamajhColors.textMuted)),
                              Expanded(
                                child: Text(
                                  r,
                                  style: const TextStyle(fontSize: 12, color: SamajhColors.textNavy),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                  if (topMistakes.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      isHindi ? "सामान्य त्रुटियाँ (शीर्ष 3):" : "Top 3 common mistakes:",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF92400E)),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: topMistakes.map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFFCD34D)),
                            ),
                            child: Text(
                              WordCheckScoringEngine.formatDistractorTag(
                                tag,
                                isHindi: Localizations.localeOf(context).languageCode == 'hi',
                              ),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF92400E)),
                            ),
                          )).toList(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Questions by level, typing check, and the child's own ratings
            LevelResultSections(session: session),

            // Bottom Action: Back to class
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                backgroundColor: SamajhColors.forestGreen,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ref.read(checkFlowControllerProvider.notifier).reset();
                context.go('/app/class');
              },
              child: Text(
                l10n.backToClass,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                ref.read(checkFlowControllerProvider.notifier).reset();
                context.go('/app/today');
              },
              child: Text(l10n.checkNextStudent),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Passcode Exit Bottom Sheet for Student Mode
// ---------------------------------------------------------------------------
class _PasscodeExitSheet extends ConsumerStatefulWidget {
  final VoidCallback onSuccess;

  const _PasscodeExitSheet({required this.onSuccess});

  @override
  ConsumerState<_PasscodeExitSheet> createState() => _PasscodeExitSheetState();
}

class _PasscodeExitSheetState extends ConsumerState<_PasscodeExitSheet> {
  String _pin = '';
  String? _error;

  void _onDigit(String d) {
    if (_pin.length < 6) {
      setState(() {
        _pin += d;
        _error = null;
      });
      if (_pin.length == 6) {
        _verifyPin();
      }
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _error = null;
      });
    }
  }

  void _verifyPin() {
    final ok = ref.read(passcodeProvider.notifier).verifyPasscode(_pin);
    if (ok) {
      widget.onSuccess();
    } else {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _error = l10n.incorrectPasscode;
        _pin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.enterPasscodeToExitStudent,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (i) {
              final filled = i < _pin.length;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? SamajhColors.forestGreen : Colors.grey.shade300,
                ),
              );
            }),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: const TextStyle(color: SamajhColors.recordingRed, fontSize: 13)),
          ],
          const SizedBox(height: 20),
          // Simple keypad
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              ...['1', '2', '3', '4', '5', '6', '7', '8', '9'].map(
                (d) => SizedBox(
                  width: 56,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () => _onDigit(d),
                    child: Text(d, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 56, height: 56),
              SizedBox(
                width: 56,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => _onDigit('0'),
                  child: const Text('0', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                width: 56,
                height: 56,
                child: IconButton(
                  icon: const Icon(Icons.backspace_outlined),
                  onPressed: _onDelete,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancelButton),
          ),
        ],
      ),
    );
  }
}

