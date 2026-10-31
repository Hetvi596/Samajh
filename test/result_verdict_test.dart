import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/analysis/self_rating.dart';
import 'package:samajh/core/analysis/word_check_scoring_engine.dart';
import 'package:samajh/core/database/app_database.dart';
import 'package:samajh/core/providers/database_provider.dart';
import 'package:samajh/core/sync/noop_cloud_sync.dart';
import 'package:samajh/core/sync/sync_providers.dart';
import 'package:samajh/features/check_flow/check_flow_controller.dart';

/// The result comes from the evidence; a noisy room or a short reading only
/// lowers confidence, and the child's own meaning answers count for
/// understanding when the teacher asked no story questions.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // 12 words: read in 15 seconds that is 48 words a minute.
  const words = ['राम', 'मेले', 'गया', 'और', 'खुश', 'हुआ', 'वह', 'घर', 'आया', 'माँ', 'भी', 'हँसी'];

  WordCheckItemChoice meaning(String id, bool right) => WordCheckItemChoice(
        itemId: id,
        level: 4,
        type: 'meaning_inference',
        finalChoice: right ? 'a' : 'b',
        timeToFirstTapMs: 5000,
        expectedTimeMs: 20000,
        isCorrectFirstTry: right,
        isCorrectFinal: right,
        selfRating: SelfRating.notGiven,
      );

  Future<CheckSessionState> finish({
    required double seconds,
    bool noisy = false,
    List<WordCheckItemChoice> wordCheck = const [],
    Map<int, WordMark>? marks,
  }) async {
    final db = AppDatabase(NativeDatabase.memory());
    final container = ProviderContainer(overrides: [
      appDatabaseProvider.overrideWithValue(db),
      cloudSyncProvider.overrideWithValue(NoopCloudSync()),
    ]);
    addTearDown(() async {
      container.dispose();
      await db.close();
    });
    final notifier = container.read(checkFlowControllerProvider.notifier);
    notifier.state = CheckSessionState(
      checkId: 'check_verdict_${seconds}_$noisy',
      childId: 'child_verdict',
      childName: 'Mehul J.',
      currentStep: CheckStep.dictation,
      passage: const {'id': 'p_v', 'questions': []},
      passageWords: words,
      wordMarks: marks ?? {for (var i = 0; i < words.length; i++) i: WordMark.correct},
      wordObservations: const {},
      retellPointsTicked: const {},
      questionAnswers: const {},
      dictationMarks: const {},
      readingDurationSeconds: seconds,
      isNoiseTooHigh: noisy,
      lowConfidence: noisy,
      wordCheckChoices: wordCheck,
    );
    await notifier.computeFinalResultAndSave();
    return notifier.state!;
  }

  test('a noisy room still gives a real group, not "not enough evidence"', () async {
    final s = await finish(seconds: 15, noisy: true, wordCheck: [meaning('m1', true), meaning('m2', true)]);
    expect(s.notEnoughEvidence, isFalse);
    expect(s.groupAssigned, 'On track');
  });

  test('a very short reading leaves speed out but keeps the result', () async {
    final s = await finish(seconds: 8, wordCheck: [meaning('m1', true), meaning('m2', true)]);
    expect(s.notEnoughEvidence, isFalse);
    expect(s.groupAssigned, 'On track');
  });

  test('without story questions, wrong meaning answers mean help with understanding', () async {
    final s = await finish(seconds: 15, wordCheck: [meaning('m1', false), meaning('m2', false)]);
    expect(s.groupAssigned, 'Reads words, needs help understanding');
  });

  test('only a check with no reading heard is "not enough evidence"', () async {
    final s = await finish(seconds: 30, marks: {for (var i = 0; i < words.length; i++) i: WordMark.notReached});
    expect(s.notEnoughEvidence, isTrue);
  });

  test('automatic marking off Android says so instead of waiting', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(checkFlowControllerProvider.notifier);
    notifier.state = const CheckSessionState(
      checkId: 'c',
      childId: 'k',
      childName: 'A',
      currentStep: CheckStep.wordCheck,
      passage: {'id': 'p'},
      passageWords: words,
      wordMarks: {0: WordMark.unmarked},
      wordObservations: {},
      retellPointsTicked: {},
      questionAnswers: {},
      dictationMarks: {},
      audioPath: '/nowhere.wav',
    );
    await notifier.autoMarkReading();
    expect(notifier.state!.autoMarkStatus, AutoMarkStatus.unsupported);
  });
}
