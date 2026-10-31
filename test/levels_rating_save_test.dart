import 'dart:convert';

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

/// The finished check saves the child's ratings, the typed words, and the
/// level, time and marks of each teacher question.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('final save stores levels, weighted marks, typed words and self-ratings', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final container = ProviderContainer(overrides: [
      appDatabaseProvider.overrideWithValue(db),
      cloudSyncProvider.overrideWithValue(NoopCloudSync()),
    ]);
    addTearDown(() async {
      container.dispose();
      await db.close();
    });

    const words = ['राम', 'मेले', 'गया', 'और', 'खुश', 'हुआ'];
    final notifier = container.read(checkFlowControllerProvider.notifier);
    notifier.state = CheckSessionState(
      checkId: 'check_save_levels',
      childId: 'child_save_levels',
      childName: 'Asha K.',
      currentStep: CheckStep.questions,
      passage: const {
        'id': 'p_save',
        'questions': [
          {'id': 'q1', 'type': 'fact'},
          {'id': 'q2', 'type': 'word_meaning'},
          {'id': 'q3', 'type': 'why_how'},
        ],
      },
      passageWords: words,
      wordMarks: {for (var i = 0; i < words.length; i++) i: WordMark.correct},
      wordObservations: const {},
      retellPointsTicked: const {},
      questionAnswers: const {'q1': 'correct', 'q2': 'not_correct'},
      questionTimesMs: const {'q1': 10000, 'q2': 20000},
      questionRatings: const {'q1': SelfRating.thumbsUp, 'q2': SelfRating.thumbsUp},
      dictationMarks: const {},
      readingDurationSeconds: 30,
      readingSelfRating: SelfRating.thumbsUp,
      typingChoices: const [
        WordCheckItemChoice(
          itemId: 'typing_l1_1',
          level: 1,
          type: 'typed_spelling',
          firstChoice: 'घर',
          finalChoice: 'घर',
          timeToFirstTapMs: 8000,
          expectedTimeMs: 20000,
          isCorrectFirstTry: true,
          isCorrectFinal: true,
          selfRating: SelfRating.thumbsDown,
        ),
      ],
      typingSummary: WordCheckScoringEngine.evaluateSession(choices: const [
        WordCheckItemChoice(
          itemId: 'typing_l1_1',
          level: 1,
          type: 'typed_spelling',
          firstChoice: 'घर',
          finalChoice: 'घर',
          timeToFirstTapMs: 8000,
          expectedTimeMs: 20000,
          isCorrectFirstTry: true,
          isCorrectFinal: true,
          selfRating: SelfRating.thumbsDown,
        ),
      ], levelsKey: 'typing_levels'),
    );

    await notifier.computeFinalResultAndSave();

    final check = await (db.select(db.checksTable)..where((t) => t.id.equals('check_save_levels'))).getSingle();
    expect(check.readingSelfRating, 'thumbs_up');

    final qa = await (db.select(db.questionAnswersTable)..where((t) => t.checkId.equals('check_save_levels'))).get();
    final byId = {for (final q in qa) q.questionId: q};
    expect(byId['q1']!.level, 1);
    expect((byId['q1']!.marks, byId['q1']!.maxMarks), (1.0, 1.0));
    expect(byId['q1']!.selfRating, 'thumbs_up');
    expect(byId['q2']!.level, 2);
    expect((byId['q2']!.marks, byId['q2']!.maxMarks, byId['q2']!.timeMs), (0.0, 2.0, 20000));
    expect(byId['q3']!.answerStatus, 'not_asked', reason: 'Level 3 never opened after Level 2 was not passed');
    expect(byId['q3']!.marks, isNull);

    final typed = await (db.select(db.choiceResponsesTable)..where((t) => t.type.equals('typed_spelling'))).get();
    expect(typed.single.firstChoice, 'घर');
    expect(typed.single.selfRating, 'thumbs_down');

    final result = await (db.select(db.resultsTable)..where((t) => t.checkId.equals('check_save_levels'))).getSingle();
    expect(result.typingScore, contains('1 of 1 words'));
    final ratings = SelfRatingSummary.fromJson(jsonDecode(result.selfRatingSummaryJson!) as Map<String, dynamic>);
    // End-of-check 👍, but typing Level 1 was not passed (one word only), so
    // the check counts as not gone well. Older per-item ratings still count:
    // typed 👎 but right, q1 👍 right, q2 👍 but wrong.
    expect((ratings.thumbsUp, ratings.thumbsDown), (3, 1));
    expect(ratings.upButWrong, 2);
    expect(ratings.downButCorrect, 1);
    // Comprehension counts only asked questions: 1 of 3 marks.
    expect(result.comprehensionFactScore, '2 comprehension points');
  });
}
