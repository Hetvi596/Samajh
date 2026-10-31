import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/analysis/devanagari_engine.dart';
import '../../core/analysis/question_levels.dart';
import '../../core/analysis/self_rating.dart';
import '../../core/analysis/word_check_scoring_engine.dart';
import '../../core/database/app_database.dart';
import '../../core/providers/database_provider.dart';
import '../../core/speech/reading_alignment.dart';
import '../../core/speech/reading_recognizer.dart';
import '../../core/sync/auto_sync_manager.dart';

enum CheckStep {
  handover,
  studentReading,
  readingSelfRating, // child: thumbs up / down about their reading
  wordCheck,
  typingCheck, // child types words they hear
  shabaash,
  markReading,
  retell,
  questions,
  dictation,
  listeningCheck,
  result,
}

/// Where the phone is with marking the reading by itself.
enum AutoMarkStatus { idle, listening, done, failed, unsupported, noRecording }

enum WordMark {
  unmarked,
  correct,
  readAsAnotherWord,
  skipped,
  correctedSelf,
  repeated,
  notSure,
  notReached,
}

class CheckSessionState {
  final String checkId;
  final String childId;
  final String childName;
  final CheckStep currentStep;
  final Map<String, dynamic> passage;
  final List<String> passageWords;
  final bool noiseTested;
  final bool isNoiseTooHigh;
  final bool lowConfidence;
  final bool markWithoutRecording;
  final double readingDurationSeconds;
  final Map<int, WordMark> wordMarks;
  final Map<int, String> wordObservations;
  final Set<int> retellPointsTicked;
  final Map<String, String> questionAnswers; // questionId -> 'correct'|'partly'|'not_correct'|'no_answer'|'not_asked'
  final Map<String, bool?> dictationMarks; // word -> isCorrect (null = not marked yet)
  final bool dictationSkipped;
  final bool retellSkipped;
  final String? groupAssigned;
  final String? nextTeachingStep;
  final double accuracy;
  final int wordsPerMinute;
  final List<String> stuckOnAksharas;
  final bool notEnoughEvidence;

  final String? audioPath;
  final bool micPermissionGranted;
  final Set<int> regionalAcceptedWords;
  final Map<int, String> wordErrorSubtypes;
  final List<WordCheckItemChoice> wordCheckChoices;
  final WordCheckSessionSummary? wordCheckSummary;
  final String passageLanguage;

  /// The child's class (1-5). Picks the class-wise word check and typing banks.
  final int grade;

  /// Automatic marking of the reading, started as soon as the child stops
  /// reading so the marks are ready before the teacher looks.
  final AutoMarkStatus autoMarkStatus;

  /// Words the teacher may want to listen to again (marked by the app).
  final Set<int> autoNeedsCheck;
  final int autoWrong;

  /// Words the child got to, by the app's ear.
  final int autoReached;

  /// Child's own feeling after reading aloud.
  final SelfRating readingSelfRating;

  /// Typed words, stored as choice items of type 'typed_spelling':
  /// firstChoice holds the word asked, finalChoice what the child typed.
  final List<WordCheckItemChoice> typingChoices;
  final WordCheckSessionSummary? typingSummary;

  /// Teacher questions: time from opening to marking, and the child's rating.
  final Map<String, int> questionTimesMs;
  final Map<String, SelfRating> questionRatings;

  const CheckSessionState({
    required this.checkId,
    required this.childId,
    required this.childName,
    required this.currentStep,
    required this.passage,
    required this.passageWords,
    this.passageLanguage = 'hi',
    this.grade = 1,
    this.autoMarkStatus = AutoMarkStatus.idle,
    this.autoNeedsCheck = const {},
    this.autoWrong = 0,
    this.autoReached = 0,
    this.noiseTested = false,
    this.isNoiseTooHigh = false,
    this.lowConfidence = false,
    this.markWithoutRecording = false,
    this.readingDurationSeconds = 0.0,
    this.audioPath,
    this.micPermissionGranted = false,
    this.regionalAcceptedWords = const {},
    this.wordErrorSubtypes = const {},
    this.wordCheckChoices = const [],
    this.wordCheckSummary,
    this.readingSelfRating = SelfRating.notGiven,
    this.typingChoices = const [],
    this.typingSummary,
    this.questionTimesMs = const {},
    this.questionRatings = const {},
    required this.wordMarks,
    required this.wordObservations,
    required this.retellPointsTicked,
    required this.questionAnswers,
    required this.dictationMarks,
    this.dictationSkipped = false,
    this.retellSkipped = false,
    this.groupAssigned,
    this.nextTeachingStep,
    this.accuracy = 0.0,
    this.wordsPerMinute = 0,
    this.stuckOnAksharas = const [],
    this.notEnoughEvidence = false,
  });

  /// True if the passage is in Hindi (either passageWords contain Devanagari script,
  /// or passageLanguage is 'hi').
  bool get isPassageHindi {
    if (passageWords.any((w) => RegExp(r'[\u0900-\u097F]').hasMatch(w))) {
      return true;
    }
    if (passageWords.any((w) => RegExp(r'[a-zA-Z]').hasMatch(w))) {
      return false;
    }
    if (passageLanguage == 'en') return false;
    return true;
  }

  bool get isPassageEnglish => !isPassageHindi;

  /// The passage's comprehension questions with their levels.
  List<LevelledQuestion> get levelledQuestions {
    final raw = (passage['questions'] as List<dynamic>?) ?? const [];
    return [
      for (var i = 0; i < raw.length; i++) LevelledQuestion.fromJson(raw[i] as Map<String, dynamic>, i),
    ];
  }

  CheckSessionState copyWith({
    CheckStep? currentStep,
    String? passageLanguage,
    AutoMarkStatus? autoMarkStatus,
    Set<int>? autoNeedsCheck,
    int? autoWrong,
    int? autoReached,
    bool? noiseTested,
    bool? isNoiseTooHigh,
    bool? lowConfidence,
    bool? markWithoutRecording,
    double? readingDurationSeconds,
    String? audioPath,
    bool? micPermissionGranted,
    Set<int>? regionalAcceptedWords,
    Map<int, String>? wordErrorSubtypes,
    List<WordCheckItemChoice>? wordCheckChoices,
    WordCheckSessionSummary? wordCheckSummary,
    SelfRating? readingSelfRating,
    List<WordCheckItemChoice>? typingChoices,
    WordCheckSessionSummary? typingSummary,
    Map<String, int>? questionTimesMs,
    Map<String, SelfRating>? questionRatings,
    Map<int, WordMark>? wordMarks,
    Map<int, String>? wordObservations,
    Set<int>? retellPointsTicked,
    Map<String, String>? questionAnswers,
    Map<String, bool?>? dictationMarks,
    bool? dictationSkipped,
    bool? retellSkipped,
    String? groupAssigned,
    String? nextTeachingStep,
    double? accuracy,
    int? wordsPerMinute,
    List<String>? stuckOnAksharas,
    bool? notEnoughEvidence,
  }) {
    return CheckSessionState(
      checkId: checkId,
      childId: childId,
      childName: childName,
      currentStep: currentStep ?? this.currentStep,
      passage: passage,
      passageWords: passageWords,
      passageLanguage: passageLanguage ?? this.passageLanguage,
      grade: grade,
      autoMarkStatus: autoMarkStatus ?? this.autoMarkStatus,
      autoNeedsCheck: autoNeedsCheck ?? this.autoNeedsCheck,
      autoWrong: autoWrong ?? this.autoWrong,
      autoReached: autoReached ?? this.autoReached,
      noiseTested: noiseTested ?? this.noiseTested,
      isNoiseTooHigh: isNoiseTooHigh ?? this.isNoiseTooHigh,
      lowConfidence: lowConfidence ?? this.lowConfidence,
      markWithoutRecording: markWithoutRecording ?? this.markWithoutRecording,
      readingDurationSeconds: readingDurationSeconds ?? this.readingDurationSeconds,
      audioPath: audioPath ?? this.audioPath,
      micPermissionGranted: micPermissionGranted ?? this.micPermissionGranted,
      regionalAcceptedWords: regionalAcceptedWords ?? this.regionalAcceptedWords,
      wordErrorSubtypes: wordErrorSubtypes ?? this.wordErrorSubtypes,
      wordCheckChoices: wordCheckChoices ?? this.wordCheckChoices,
      wordCheckSummary: wordCheckSummary ?? this.wordCheckSummary,
      readingSelfRating: readingSelfRating ?? this.readingSelfRating,
      typingChoices: typingChoices ?? this.typingChoices,
      typingSummary: typingSummary ?? this.typingSummary,
      questionTimesMs: questionTimesMs ?? this.questionTimesMs,
      questionRatings: questionRatings ?? this.questionRatings,
      wordMarks: wordMarks ?? this.wordMarks,
      wordObservations: wordObservations ?? this.wordObservations,
      retellPointsTicked: retellPointsTicked ?? this.retellPointsTicked,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      dictationMarks: dictationMarks ?? this.dictationMarks,
      dictationSkipped: dictationSkipped ?? this.dictationSkipped,
      retellSkipped: retellSkipped ?? this.retellSkipped,
      groupAssigned: groupAssigned ?? this.groupAssigned,
      nextTeachingStep: nextTeachingStep ?? this.nextTeachingStep,
      accuracy: accuracy ?? this.accuracy,
      wordsPerMinute: wordsPerMinute ?? this.wordsPerMinute,
      stuckOnAksharas: stuckOnAksharas ?? this.stuckOnAksharas,
      notEnoughEvidence: notEnoughEvidence ?? this.notEnoughEvidence,
    );
  }
}

/// Reading counts as "went well" for comparing with the child's own rating
/// at this accuracy (the same 85% used for the decoding group).
const double kReadingWentWellAccuracy = 0.85;

/// Whether the child's part of the check went well overall: reading at the
/// accuracy bar, and Level 1 passed in the word check and typing (when done).
bool checkWentWell(CheckSessionState s, {required bool readingWentWell}) {
  bool passed(WordCheckSessionSummary? summary) => summary == null || summary.highestLevelReached >= 1;
  return readingWentWell && passed(s.wordCheckSummary) && passed(s.typingSummary);
}

/// The child gives one thumbs up / down at the end of Student Mode; it is set
/// against how the check went overall. Older checks may also hold per-item
/// ratings, which are still counted.
SelfRatingSummary buildSelfRatingSummary(
  CheckSessionState s,
  QuestionGateResult gate, {
  required bool readingWentWell,
}) {
  return SelfRatingSummary.from([
    if (s.readingSelfRating != SelfRating.notGiven)
      (s.readingSelfRating, checkWentWell(s, readingWentWell: readingWentWell)),
    for (final c in [...s.wordCheckChoices, ...s.typingChoices])
      if (!c.isSkipped && c.selfRating != SelfRating.notGiven) (c.selfRating, c.isCorrectFinal),
    for (final m in gate.marks)
      if ((s.questionRatings[m.questionId] ?? SelfRating.notGiven) != SelfRating.notGiven)
        (s.questionRatings[m.questionId]!, m.credit >= 1.0),
  ]);
}

class CheckFlowNotifier extends StateNotifier<CheckSessionState?> {
  final Ref ref;

  CheckFlowNotifier(this.ref) : super(null);

  Future<void> startSession({
    required String childId,
    required String childName,
    required int grade,
    String? language,
  }) async {
    // 1. Load passages from bank
    final jsonStr = await rootBundle.loadString('assets/passages/bank.json');
    final bankData = jsonDecode(jsonStr);
    final passages = (bankData['passages'] as List<dynamic>?) ?? [];

    // Rule: First check starts one band below grade; if grade 1, starts at grade 1
    final targetGrade = grade > 1 ? grade - 1 : 1;
    Map<String, dynamic>? selectedPassage;

    for (final p in passages) {
      if (p['grade'] == targetGrade) {
        selectedPassage = p as Map<String, dynamic>;
        break;
      }
    }
    selectedPassage ??= (passages.first as Map<String, dynamic>);

    // Resolve reading/passage language:
    String? readingLang = language;
    if (readingLang == null || readingLang.isEmpty) {
      final db = ref.read(appDatabaseProvider);
      final child = await (db.select(db.childrenTable)..where((t) => t.id.equals(childId))).getSingleOrNull();
      if (child != null) {
        final cls = await (db.select(db.classesTable)..where((t) => t.id.equals(child.classId))).getSingleOrNull();
        if (cls != null && cls.checkLanguage.isNotEmpty) {
          readingLang = cls.checkLanguage;
        }
      }
    }
    final activeClass = ref.read(activeClassStreamProvider).value;
    readingLang ??= activeClass?.checkLanguage;
    readingLang ??= ref.read(readingLanguageProvider);
    if (readingLang == null || readingLang.isEmpty) readingLang = 'hi';

    final isEnglish = readingLang == 'en';
    final rawText = isEnglish
        ? ((selectedPassage['text_en'] as String?) ?? (selectedPassage['text_hi'] as String?) ?? '')
        : ((selectedPassage['text_hi'] as String?) ?? (selectedPassage['text_en'] as String?) ?? '');
    final words = rawText.split(RegExp(r'\s+')).where((w) => w.trim().isNotEmpty).toList();

    // Initialise all words to unmarked (teacher marks explicitly or uses mark remaining)
    final initialMarks = <int, WordMark>{};
    for (int i = 0; i < words.length; i++) {
      initialMarks[i] = WordMark.unmarked;
    }

    final checkId = 'check_${DateTime.now().millisecondsSinceEpoch}';

    state = CheckSessionState(
      checkId: checkId,
      childId: childId,
      childName: childName,
      currentStep: CheckStep.handover,
      passage: selectedPassage,
      passageWords: words,
      passageLanguage: isEnglish ? 'en' : 'hi',
      grade: grade,
      wordMarks: initialMarks,
      wordObservations: {},
      retellPointsTicked: {},
      questionAnswers: {},
      dictationMarks: {},
    );
  }

  void setMicPermission(bool granted) {
    if (state == null) return;
    state = state!.copyWith(micPermissionGranted: granted);
  }

  void setNoiseResult({required bool isNoisy, required bool markWithoutRecording}) {
    if (state == null) return;
    state = state!.copyWith(
      noiseTested: true,
      isNoiseTooHigh: isNoisy,
      lowConfidence: isNoisy,
      markWithoutRecording: markWithoutRecording,
    );
  }

  void startStudentMode() {
    if (state == null) return;
    state = state!.copyWith(currentStep: CheckStep.studentReading);
  }

  void finishReading({required double readingDuration, String? audioPath}) {
    if (state == null) return;
    state = state!.copyWith(
      currentStep: CheckStep.wordCheck,
      readingDurationSeconds: readingDuration,
      audioPath: audioPath ?? state!.audioPath,
    );
    // Mark the reading while the child goes on with the word questions.
    autoMarkReading();
  }

  /// Listens to the reading recording on the phone and marks every word.
  /// Never overwrites marks the teacher has already made.
  Future<void> autoMarkReading() async {
    final s = state;
    if (s == null || s.autoMarkStatus != AutoMarkStatus.idle) return;
    if (!s.wordMarks.values.every((m) => m == WordMark.unmarked)) return;
    final path = s.audioPath;
    if (path == null || path.isEmpty) {
      state = s.copyWith(autoMarkStatus: AutoMarkStatus.noRecording);
      return;
    }
    if (!ReadingRecognizer.instance.supports(isHindi: s.isPassageHindi)) {
      state = s.copyWith(autoMarkStatus: AutoMarkStatus.unsupported);
      return;
    }
    state = s.copyWith(autoMarkStatus: AutoMarkStatus.listening);
    final heard = await ReadingRecognizer.instance.transcribe(path, s.passageWords, isHindi: s.isPassageHindi);
    final now = state;
    if (now == null || now.checkId != s.checkId) return; // a new check started meanwhile
    if (heard == null) {
      state = now.copyWith(autoMarkStatus: AutoMarkStatus.failed);
      return;
    }
    if (!now.wordMarks.values.every((m) => m == WordMark.unmarked)) {
      state = now.copyWith(autoMarkStatus: AutoMarkStatus.failed); // the teacher began marking first
      return;
    }
    final result = alignReading(now.passageWords, heard);
    final marks = Map<int, WordMark>.from(now.wordMarks)..addAll(result.marks);
    final observations = Map<int, String>.from(now.wordObservations)..addAll(result.heardAs);
    state = now.copyWith(
      wordMarks: marks,
      wordObservations: observations,
      autoMarkStatus: AutoMarkStatus.done,
      autoNeedsCheck: result.needsCheck,
      autoWrong: result.markedWrong,
      autoReached: result.marks.values.where((m) => m != WordMark.notReached).length,
    );
  }

  /// The teacher has listened to a word the app flagged.
  void clearNeedsCheck(int index) {
    final s = state;
    if (s == null || !s.autoNeedsCheck.contains(index)) return;
    state = s.copyWith(autoNeedsCheck: {...s.autoNeedsCheck}..remove(index));
  }

  /// Child's one thumbs up / down for the whole check, given at the very end
  /// of Student Mode (stored in readingSelfRating), then the well-done screen.
  void setReadingSelfRating(SelfRating rating) {
    if (state == null) return;
    state = state!.copyWith(currentStep: CheckStep.shabaash, readingSelfRating: rating);
  }

  Future<void> completeWordCheck(List<WordCheckItemChoice> choices) async {
    if (state == null) return;
    final thresholds = await WordCheckScoringEngine.loadThresholds();
    final summary = WordCheckScoringEngine.evaluateSession(
      choices: choices,
      thresholds: thresholds,
    );
    state = state!.copyWith(
      currentStep: CheckStep.typingCheck,
      wordCheckChoices: choices,
      wordCheckSummary: summary,
    );
  }

  void skipWordCheck() {
    if (state == null) return;
    state = state!.copyWith(
      currentStep: CheckStep.typingCheck,
      wordCheckChoices: const [],
    );
  }

  /// Typed words are scored level by level with the typing levels.
  Future<void> completeTypingCheck(List<WordCheckItemChoice> choices) async {
    if (state == null) return;
    final thresholds = await WordCheckScoringEngine.loadThresholds();
    final summary = choices.isEmpty
        ? null
        : WordCheckScoringEngine.evaluateSession(choices: choices, thresholds: thresholds, levelsKey: 'typing_levels');
    state = state!.copyWith(
      currentStep: CheckStep.readingSelfRating,
      typingChoices: choices,
      typingSummary: summary,
    );
  }

  void proceedToMarking() {
    if (state == null) return;
    state = state!.copyWith(currentStep: CheckStep.markReading);
  }

  void setWordMark(int index, WordMark mark, {String? observation, String? errorSubtype}) {
    if (state == null) return;
    final updatedMarks = Map<int, WordMark>.from(state!.wordMarks);
    updatedMarks[index] = mark;

    final updatedObs = Map<int, String>.from(state!.wordObservations);
    if (observation != null && observation.isNotEmpty) {
      updatedObs[index] = observation;
    } else if (mark == WordMark.correct) {
      updatedObs.remove(index);
    }

    final updatedSubtypes = Map<int, String>.from(state!.wordErrorSubtypes);
    if (errorSubtype != null && errorSubtype.isNotEmpty) {
      updatedSubtypes[index] = errorSubtype;
    } else if (mark == WordMark.correct) {
      updatedSubtypes.remove(index);
    }

    final updatedRegional = Set<int>.from(state!.regionalAcceptedWords);
    if (mark != WordMark.correct) {
      updatedRegional.remove(index);
    }

    state = state!.copyWith(
      wordMarks: updatedMarks,
      wordObservations: updatedObs,
      wordErrorSubtypes: updatedSubtypes,
      regionalAcceptedWords: updatedRegional,
    );
  }

  Future<void> acceptRegionalPronunciation(int index, String regionalVariant) async {
    if (state == null) return;
    final updatedRegional = Set<int>.from(state!.regionalAcceptedWords);
    updatedRegional.add(index);

    final updatedMarks = Map<int, WordMark>.from(state!.wordMarks);
    updatedMarks[index] = WordMark.correct; // Regional accent is marked correct without penalty

    final updatedObs = Map<int, String>.from(state!.wordObservations);
    updatedObs[index] = 'Regional: $regionalVariant';

    final updatedSubtypes = Map<int, String>.from(state!.wordErrorSubtypes);
    updatedSubtypes.remove(index);

    state = state!.copyWith(
      wordMarks: updatedMarks,
      wordObservations: updatedObs,
      wordErrorSubtypes: updatedSubtypes,
      regionalAcceptedWords: updatedRegional,
    );

    // Persist into database AcceptedPronunciationsTable
    try {
      final db = ref.read(appDatabaseProvider);
      final activeClass = ref.read(activeClassStreamProvider).value;
      final expectedWord = DevanagariAksharaEngine.cleanWord(state!.passageWords[index]);
      final id = 'pron_${DateTime.now().millisecondsSinceEpoch}_$index';

      await db.into(db.acceptedPronunciationsTable).insert(
        AcceptedPronunciationsTableCompanion.insert(
          id: id,
          standardWord: expectedWord,
          regionalVariant: regionalVariant,
          scope: activeClass?.scope ?? 'demo',
          acceptedAt: DateTime.now(),
        ),
      );
    } catch (_) {}
  }

  int getUnmarkedWordsCount() {
    if (state == null) return 0;
    final marks = state!.wordMarks;
    final words = state!.passageWords;
    if (words.isEmpty) return 0;

    int lastReadIndex = -1;
    for (int i = words.length - 1; i >= 0; i--) {
      if (marks[i] != WordMark.notReached) {
        lastReadIndex = i;
        break;
      }
    }
    if (lastReadIndex < 0) return 0;

    int count = 0;
    for (int i = 0; i <= lastReadIndex; i++) {
      if ((marks[i] ?? WordMark.unmarked) == WordMark.unmarked) {
        count++;
      }
    }
    return count;
  }

  bool get hasUnmarkedBeforeLastRead {
    return getUnmarkedWordsCount() > 0;
  }

  bool canSaveMarking() {
    return !hasUnmarkedBeforeLastRead;
  }

  void markAllRemainingAsCorrect() {
    if (state == null) return;
    final updatedMarks = Map<int, WordMark>.from(state!.wordMarks);
    final words = state!.passageWords;

    int lastReadIndex = -1;
    for (int i = words.length - 1; i >= 0; i--) {
      if (updatedMarks[i] != WordMark.notReached) {
        lastReadIndex = i;
        break;
      }
    }
    if (lastReadIndex < 0) {
      lastReadIndex = words.length - 1;
    }

    for (int i = 0; i <= lastReadIndex; i++) {
      if ((updatedMarks[i] ?? WordMark.unmarked) == WordMark.unmarked) {
        updatedMarks[i] = WordMark.correct;
      }
    }

    state = state!.copyWith(wordMarks: updatedMarks);
  }

  void setRemainingNotReached(int fromIndex) {
    if (state == null) return;
    final updatedMarks = Map<int, WordMark>.from(state!.wordMarks);
    for (int i = fromIndex; i < state!.passageWords.length; i++) {
      updatedMarks[i] = WordMark.notReached;
    }
    state = state!.copyWith(wordMarks: updatedMarks);
  }

  Future<bool> saveMarkingAndContinue() async {
    if (state == null) return false;
    if (!canSaveMarking()) {
      return false;
    }

    // Persist word marks into WordMarksTable in DB
    try {
      final db = ref.read(appDatabaseProvider);
      for (int i = 0; i < state!.passageWords.length; i++) {
        final expected = state!.passageWords[i];
        final mark = state!.wordMarks[i] ?? WordMark.unmarked;
        final markStr = mark.name;
        final errorSubtype = state!.wordErrorSubtypes[i] ??
            ((mark == WordMark.readAsAnotherWord || mark == WordMark.skipped)
                ? DevanagariAksharaEngine.classifyPrimaryMistake(expected)
                : null);
        final observed = state!.wordObservations[i];

        await db.into(db.wordMarksTable).insertOnConflictUpdate(
          WordMarksTableCompanion.insert(
            id: 'wm_${state!.checkId}_$i',
            checkId: state!.checkId,
            wordIndex: i,
            expectedWord: expected,
            actualWord: drift.Value(observed),
            mark: markStr,
            errorSubtype: drift.Value(errorSubtype),
          ),
        );
      }
    } catch (_) {}

    state = state!.copyWith(currentStep: CheckStep.retell);
    return true;
  }

  void toggleRetellPoint(int index) {
    if (state == null) return;
    final current = Set<int>.from(state!.retellPointsTicked);
    if (current.contains(index)) {
      current.remove(index);
    } else {
      current.add(index);
    }
    state = state!.copyWith(retellPointsTicked: current);
  }

  void skipRetell() {
    if (state == null) return;
    state = state!.copyWith(
      currentStep: CheckStep.questions,
      retellSkipped: true,
    );
  }

  void continueToQuestions() {
    if (state == null) return;
    state = state!.copyWith(currentStep: CheckStep.questions);
  }

  /// [timeMs]: time from the question opening to this mark. The first mark's
  /// time is kept, so changing a mark later does not cost the child marks.
  void setQuestionAnswer(String questionId, String answerRating, {int? timeMs}) {
    if (state == null) return;
    final updated = Map<String, String>.from(state!.questionAnswers);
    updated[questionId] = answerRating;
    final times = Map<String, int>.from(state!.questionTimesMs);
    if (timeMs != null) times.putIfAbsent(questionId, () => timeMs);
    state = state!.copyWith(questionAnswers: updated, questionTimesMs: times);
  }

  void setQuestionRating(String questionId, SelfRating rating) {
    if (state == null) return;
    final updated = Map<String, SelfRating>.from(state!.questionRatings);
    updated[questionId] = rating;
    state = state!.copyWith(questionRatings: updated);
  }

  /// Level-wise view of the questions answered so far.
  Future<QuestionGateResult?> evaluateQuestions() async {
    if (state == null) return null;
    return QuestionLevels.evaluate(
      questions: state!.levelledQuestions,
      answers: state!.questionAnswers,
      timesMs: state!.questionTimesMs,
      ratings: state!.questionRatings,
      thresholds: await WordCheckScoringEngine.loadThresholds(),
    );
  }

  void continueToDictation() {
    if (state == null) return;

    // Pick 5 dictation words:
    // 1. From child's misread words (prioritize different error kinds)
    // 2. Fill from fallback words if fewer than 5
    final misreadWords = <String>[];
    for (int i = 0; i < state!.passageWords.length; i++) {
      final mark = state!.wordMarks[i];
      if (mark == WordMark.readAsAnotherWord || mark == WordMark.skipped) {
        final cleanWord = state!.passageWords[i].replaceAll(RegExp(r'[।,.?!]'), '').trim();
        if (cleanWord.isNotEmpty && !misreadWords.contains(cleanWord)) {
          misreadWords.add(cleanWord);
        }
      }
    }

    final isEnglish = !state!.isPassageHindi;
    final fallbackKey = isEnglish ? 'dictation_fallback_words_en' : 'dictation_fallback_words';
    final passageFallback = (state!.passage[fallbackKey] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        (state!.passage['dictation_fallback_words'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final fallbackWords = [
      ...passageFallback,
      if (isEnglish) ...['water', 'school', 'friend', 'garden', 'summer']
      else ...['मुस्कुराने', 'गुब्बारे', 'गुब्बारा', 'रविवार', 'सुंदर'],
    ];

    final selectedDictation = <String>[];
    selectedDictation.addAll(misreadWords.take(5));
    for (final fb in fallbackWords) {
      if (selectedDictation.length >= 5) break;
      if (!selectedDictation.contains(fb)) {
        selectedDictation.add(fb);
      }
    }

    final initialDictationMarks = <String, bool?>{};
    for (final w in selectedDictation) {
      initialDictationMarks[w] = null;
    }

    state = state!.copyWith(
      currentStep: CheckStep.dictation,
      dictationMarks: initialDictationMarks,
    );
  }

  void setDictationMark(String word, bool isCorrect) {
    if (state == null) return;
    final updated = Map<String, bool?>.from(state!.dictationMarks);
    updated[word] = isCorrect;
    state = state!.copyWith(dictationMarks: updated);
  }

  void skipDictation() {
    if (state == null) return;
    state = state!.copyWith(
      dictationSkipped: true,
    );
    computeFinalResultAndSave();
  }

  Future<void> computeFinalResultAndSave() async {
    if (state == null) return;

    // Section 8.9 Scoring Guardrails:
    // - Correct words = Correct + Corrected self; Repeated is neutral;
    //   Not sure and Not reached are excluded from errors and from attempted words.
    // - Accuracy = correct words ÷ attempted words.
    int correctCount = 0;
    int attemptedCount = 0;
    final stuckAksharasSet = <String>{};

    for (int i = 0; i < state!.passageWords.length; i++) {
      final mark = state!.wordMarks[i] ?? WordMark.unmarked;
      final word = state!.passageWords[i];

      if (mark == WordMark.notReached || mark == WordMark.notSure || mark == WordMark.unmarked) {
        continue; // Excluded from attempted and errors (unmarked is never counted as correct)
      }

      attemptedCount++;

      final isRegional = state!.regionalAcceptedWords.contains(i);
      if (mark == WordMark.correct || mark == WordMark.correctedSelf || isRegional) {
        correctCount++;
      } else if (mark == WordMark.readAsAnotherWord || mark == WordMark.skipped) {
        final feature = state!.wordErrorSubtypes[i] ?? DevanagariAksharaEngine.classifyPrimaryMistake(word);
        stuckAksharasSet.add(DevanagariAksharaEngine.formatFeatureLabel(feature));
      }
    }

    final accuracy = attemptedCount > 0 ? (correctCount / attemptedCount) : 0.0;

    // Speed uses the time the child actually read. Only a check with no
    // reading to judge is "not enough evidence". A short reading, an
    // impossible speed or a noisy room only lowers confidence: the result is
    // still worked out from the evidence, and speed is left out when it
    // cannot be trusted.
    final durationSeconds = state!.readingDurationSeconds;
    final notEnoughEvidence = durationSeconds < 5.0 || attemptedCount == 0;
    int wpm = 0;
    var speedReliable = false;
    var lowConfidence = state!.lowConfidence || state!.isNoiseTooHigh;

    if (!notEnoughEvidence) {
      wpm = ((correctCount / durationSeconds) * 60).round();
      speedReliable = durationSeconds >= 15.0 && wpm <= 250;
      if (!speedReliable) lowConfidence = true;
    }

    // Comprehension: level-wise, weighted and time-adjusted. Questions above
    // the level where the child stopped, and "not asked" ones, do not count.
    final thresholds = await WordCheckScoringEngine.loadThresholds();
    final gate = QuestionLevels.evaluate(
      questions: state!.levelledQuestions,
      answers: state!.questionAnswers,
      timesMs: state!.questionTimesMs,
      ratings: state!.questionRatings,
      thresholds: thresholds,
    );
    final countedMarks = {for (final m in gate.marks) m.questionId: m};
    int correctQuestions = 0;
    for (final m in gate.marks) {
      correctQuestions += (m.credit * 2).round();
    }
    final compRatio = gate.possible > 0 ? gate.earned / gate.possible : 0.0;

    // Understanding evidence: the teacher's story questions or retell when
    // they were used, otherwise the child's own meaning questions (Level 4 of
    // the word check), answered and marked by the app.
    final meaningItems = state!.wordCheckChoices.where((c) => c.level == 4 && !c.isSkipped).toList();
    final hasTeacherEvidence = gate.possible > 0 || state!.retellPointsTicked.isNotEmpty;
    final meaningRatio =
        meaningItems.isEmpty ? null : meaningItems.where((c) => c.isCorrectFinal).length / meaningItems.length;

    // Determine Group & Next Step:
    String group;
    String nextStep;

    if (notEnoughEvidence) {
      group = "Not enough evidence: no reading could be heard or marked";
      nextStep = "Run the check again in a quieter place, with the phone close to the child";
    } else {
      final meetsDecoding = accuracy >= 0.85 && (!speedReliable || wpm >= 40);
      final meetsUnderstanding = hasTeacherEvidence
          ? compRatio >= 0.6 || state!.retellPointsTicked.length >= 2
          : (meaningRatio ?? 0) >= 0.6;

      if (meetsDecoding && meetsUnderstanding) {
        group = "On track";
        nextStep = "Fluency practice, 10 minutes a day with grade-level storybooks";
      } else if (!meetsDecoding && meetsUnderstanding) {
        group = "Understands, needs help reading words";
        nextStep = "Decoding practice, 10 minutes a day focusing on aksharas and matras";
      } else if (meetsDecoding && !meetsUnderstanding) {
        group = "Reads words, needs help understanding";
        nextStep = "Comprehension conversations: pause after each paragraph and ask 'why' and 'how'";
      } else {
        group = "Needs help with both";
        nextStep = "Paired reading and decodable word practice, 10 minutes daily";
      }
    }

    // Word Check scoring & error aggregation
    final summary = state!.wordCheckSummary ??
        (state!.wordCheckChoices.isNotEmpty
            ? WordCheckScoringEngine.evaluateSession(
                choices: state!.wordCheckChoices,
                thresholds: thresholds,
              )
            : null);

    if (summary != null) {
      stuckAksharasSet.addAll(summary.topMistakeTags);
    }
    final typing = state!.typingSummary;
    if (typing != null) {
      stuckAksharasSet.addAll(typing.topMistakeTags);
    }

    final ratingSummary = buildSelfRatingSummary(
      state!,
      gate,
      readingWentWell: !notEnoughEvidence && accuracy >= kReadingWentWellAccuracy,
    );

    // Dictation errors added to stuck on aksharas
    if (!state!.dictationSkipped && state!.dictationMarks.isNotEmpty) {
      for (final entry in state!.dictationMarks.entries) {
        if (entry.value == false) {
          final feature = DevanagariAksharaEngine.classifyPrimaryMistake(entry.key);
          stuckAksharasSet.add(DevanagariAksharaEngine.formatFeatureLabel(feature));
        }
      }
    }

    final stuckList = stuckAksharasSet.toList();

    // Persist to Database
    final db = ref.read(appDatabaseProvider);
    final activeClass = ref.read(activeClassStreamProvider).value;
    final now = DateTime.now();

    await db.into(db.checksTable).insertOnConflictUpdate(
      ChecksTableCompanion.insert(
        id: state!.checkId,
        childId: state!.childId,
        classId: activeClass?.id ?? 'class_demo_3b',
        scope: activeClass?.scope ?? 'demo',
        status: 'completed',
        currentStep: 'result',
        passageId: state!.passage['id'] ?? 'p_g1_01',
        passageTitle: (state!.isPassageHindi ? state!.passage['title_hi'] : state!.passage['title_en']) ??
            state!.passage['title'] ??
            (state!.isPassageHindi ? 'कहानी' : 'Story'),
        passageLevel: (state!.passage['level'] as num?)?.toInt() ?? 1,
        noiseLevel: drift.Value(state!.isNoiseTooHigh ? 0.45 : 0.12),
        isLowConfidence: drift.Value(lowConfidence || notEnoughEvidence),
        audioPath: drift.Value(state!.audioPath),
        markedWithoutRecording: drift.Value(state!.markWithoutRecording),
        benchmarkUsedJson: const drift.Value('NIPUN Lakshya & FLS 2022'),
        rubricVersion: const drift.Value('v0.1 (provisional)'),
        readingDurationSeconds: drift.Value(durationSeconds),
        readingSelfRating: drift.Value(state!.readingSelfRating.code),
        startedAt: now,
        completedAt: drift.Value(now),
      ),
    );

    // Save Word Marks
    for (int i = 0; i < state!.passageWords.length; i++) {
      final mark = state!.wordMarks[i] ?? WordMark.unmarked;
      final word = state!.passageWords[i];
      final subtype = state!.wordErrorSubtypes[i];
      await db.into(db.wordMarksTable).insertOnConflictUpdate(
        WordMarksTableCompanion.insert(
          id: 'wm_${state!.checkId}_$i',
          checkId: state!.checkId,
          wordIndex: i,
          expectedWord: word,
          actualWord: drift.Value(state!.wordObservations[i]),
          mark: mark.name,
          errorSubtype: drift.Value(subtype),
        ),
      );
    }

    // Save Retell Points
    final retellKey = state!.isPassageHindi ? 'retell_points' : 'retell_points_en';
    final retellPoints = (state!.passage[retellKey] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        (state!.passage['retell_points'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    for (int i = 0; i < retellPoints.length; i++) {
      await db.into(db.retellPointsTable).insertOnConflictUpdate(
        RetellPointsTableCompanion.insert(
          id: 'retell_${state!.checkId}_$i',
          checkId: state!.checkId,
          pointIndex: i,
          pointText: retellPoints[i],
          isMentioned: state!.retellPointsTicked.contains(i),
        ),
      );
    }

    // Save Question Answers with their level, time, marks and child rating.
    // Questions never reached (above the stopping level) are saved as not asked.
    final questionsById = {for (final q in state!.levelledQuestions) q.id: q};
    int qIdx = 0;
    for (final q in state!.levelledQuestions) {
      final mark = countedMarks[q.id];
      final status = state!.questionAnswers[q.id] ?? 'not_asked';
      await db.into(db.questionAnswersTable).insertOnConflictUpdate(
        QuestionAnswersTableCompanion.insert(
          id: 'qa_${state!.checkId}_$qIdx',
          checkId: state!.checkId,
          questionId: q.id,
          questionType: q.type ?? 'fact',
          answerStatus: gate.openLevels.contains(q.level) ? status : 'not_asked',
          level: drift.Value(questionsById[q.id]?.level ?? 1),
          timeMs: drift.Value(state!.questionTimesMs[q.id]),
          marks: drift.Value(mark?.marks),
          maxMarks: drift.Value(mark?.maxMarks),
          selfRating: drift.Value((state!.questionRatings[q.id] ?? SelfRating.notGiven).code),
        ),
      );
      qIdx++;
    }

    // Save Choice Responses (Word Check items and typed words)
    final typedChoices = state!.typingChoices;
    for (final c in [...state!.wordCheckChoices, ...typedChoices]) {
      {
        final itemScore = WordCheckScoringEngine.scoreItem(c, thresholds);
        await db.into(db.choiceResponsesTable).insertOnConflictUpdate(
          ChoiceResponsesTableCompanion.insert(
            id: 'cr_${state!.checkId}_${c.itemId}',
            checkId: state!.checkId,
            itemId: c.itemId,
            level: c.level,
            type: c.type,
            firstChoice: drift.Value(c.firstChoice),
            finalChoice: drift.Value(c.finalChoice),
            timeMs: c.timeToFirstTapMs,
            changeCount: drift.Value(c.changeCount),
            distractorTag: drift.Value(c.chosenDistractorTag),
            weight: drift.Value(itemScore.weightedScore),
            reason: drift.Value(itemScore.reasons.join('; ')),
            createdAt: now,
            maxMarks: drift.Value(itemScore.maxMarks),
            selfRating: drift.Value(c.selfRating.code),
          ),
        );
      }
    }

    // Save Practice Needs from top word check and typing mistakes
    if (summary != null || typing != null) {
      int needIdx = 0;
      for (final tag in {...?summary?.topMistakeTags, ...?typing?.topMistakeTags}) {
        await db.into(db.practiceNeedsTable).insertOnConflictUpdate(
          PracticeNeedsTableCompanion.insert(
            id: 'pn_${state!.checkId}_$needIdx',
            childId: state!.childId,
            scope: activeClass?.scope ?? 'demo',
            gapType: 'word_check_mistake',
            gapDetail: tag,
            activityId: 'act_word_check_${tag.replaceAll(' ', '_').toLowerCase()}',
          ),
        );
        needIdx++;
      }
    }

    // Save legacy Dictation Items if present
    int dictationIdx = 0;
    for (final entry in state!.dictationMarks.entries) {
      final isCorrect = entry.value == true;
      await db.into(db.dictationItemsTable).insertOnConflictUpdate(
        DictationItemsTableCompanion.insert(
          id: 'dict_${state!.checkId}_$dictationIdx',
          checkId: state!.checkId,
          itemIndex: dictationIdx,
          word: entry.key,
          isCorrect: isCorrect,
          isSkipped: drift.Value(state!.dictationSkipped),
          errorType: isCorrect ? const drift.Value(null) : drift.Value(DevanagariAksharaEngine.classifyPrimaryMistake(entry.key)),
        ),
      );
      dictationIdx++;
    }

    final dictationScoreStr = (summary != null && summary.totalItemsAttempted > 0)
        ? "${summary.totalRawCorrect} of ${summary.totalItemsAttempted} (${summary.totalWeightedScore.toStringAsFixed(2)} weighted)"
        : (state!.dictationMarks.isNotEmpty
            ? "${state!.dictationMarks.values.where((v) => v == true).length} of ${state!.dictationMarks.length} words correct"
            : (state!.wordCheckChoices.isEmpty ? "Skipped" : "0 of 0"));

    await db.into(db.resultsTable).insertOnConflictUpdate(
      ResultsTableCompanion.insert(
        id: 'result_${state!.checkId}',
        checkId: state!.checkId,
        childId: state!.childId,
        scope: activeClass?.scope ?? 'demo',
        groupAssigned: group,
        groupReason: notEnoughEvidence
            ? "Not enough evidence: no reading could be heard or marked"
            : (group == "On track" ? "On track: reads with fluency and understanding" : group),
        nextStepRecommendation: nextStep,
        totalWords: state!.passageWords.length,
        attemptedWords: attemptedCount,
        correctWords: correctCount,
        accuracyPercentage: accuracy,
        readingSpeedWpm: drift.Value(wpm.toDouble()),
        speedHasEvidence: speedReliable,
        comprehensionFactScore: "$correctQuestions comprehension points",
        retellScore: "${state!.retellPointsTicked.length} story points",
        dictationScore: dictationScoreStr,
        stuckOnAksharasJson: drift.Value(jsonEncode(stuckList)),
        typingScore: drift.Value(typing == null
            ? null
            : '${typing.totalRawCorrect} of ${typing.totalItemsAttempted} words '
                '(${typing.totalWeightedScore.toStringAsFixed(2)} of ${typing.maxPossibleScore.toStringAsFixed(2)} marks, '
                'level ${typing.highestLevelReached})'),
        selfRatingSummaryJson: drift.Value(jsonEncode(ratingSummary.toJson())),
        isLowConfidence: lowConfidence || notEnoughEvidence,
        createdAt: now,
      ),
    );

    if (!notEnoughEvidence) {
      await db.into(db.groupAssignmentsTable).insert(
        GroupAssignmentsTableCompanion.insert(
          id: 'group_${state!.checkId}',
          childId: state!.childId,
          scope: activeClass?.scope ?? 'demo',
          fromGroup: 'not_grouped',
          toGroup: group,
          reason: drift.Value('Calculated from check on ${now.day}/${now.month}'),
          movedAt: now,
        ),
      );
    }

    state = state!.copyWith(
      currentStep: CheckStep.result,
      groupAssigned: group,
      nextTeachingStep: nextStep,
      accuracy: accuracy,
      wordsPerMinute: wpm,
      stuckOnAksharas: stuckList,
      notEnoughEvidence: notEnoughEvidence,
    );

    // Trigger direct background sync to Supabase if connected
    ref.read(autoSyncManagerProvider).triggerSync();
  }

  /// Resets the current check flow session so the next check starts fresh.
  void reset() {
    state = null;
  }
}

final checkFlowControllerProvider =
    StateNotifierProvider<CheckFlowNotifier, CheckSessionState?>((ref) {
  return CheckFlowNotifier(ref);
});
