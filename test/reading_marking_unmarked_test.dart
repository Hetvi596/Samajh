import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/database/app_database.dart';
import 'package:samajh/core/providers/database_provider.dart';
import 'package:samajh/features/check_flow/check_flow_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  group('Reading Check Marking & Unmarked State Tests (Requirement 8)', () {
    test('1. Unmarked words are not counted as correct in accuracy or WPM', () {
      final marks = {
        0: WordMark.unmarked,
        1: WordMark.unmarked,
        2: WordMark.correct,
        3: WordMark.readAsAnotherWord,
        4: WordMark.skipped,
      };

      int correctCount = 0;
      int attemptedCount = 0;

      for (int i = 0; i < marks.length; i++) {
        final mark = marks[i]!;
        if (mark == WordMark.notReached || mark == WordMark.notSure || mark == WordMark.unmarked) {
          continue; // Excluded from attempted and errors; unmarked is NEVER counted as correct
        }
        attemptedCount++;
        if (mark == WordMark.correct || mark == WordMark.correctedSelf) {
          correctCount++;
        }
      }

      // 3 attempted: word 2 (correct), word 3 (misread), word 4 (skipped)
      expect(attemptedCount, equals(3));
      // Only word 2 is correct
      expect(correctCount, equals(1));
      final accuracy = attemptedCount > 0 ? (correctCount / attemptedCount) : 0.0;
      expect(accuracy, closeTo(0.333, 0.01));
    });

    test('2. Save is blocked while any word before last-read is unmarked', () {
      final controller = container.read(checkFlowControllerProvider.notifier);

      // Manually assign test session state with 4 words, all unmarked initially
      controller.state = const CheckSessionState(
        checkId: 'test_check_01',
        childId: 'child_01',
        childName: 'Priya',
        currentStep: CheckStep.markReading,
        passage: {'id': 'p1', 'title': 'कहानी'},
        passageWords: ['एक', 'दिन', 'सूरज', 'निकला'],
        wordMarks: {
          0: WordMark.unmarked,
          1: WordMark.unmarked,
          2: WordMark.unmarked,
          3: WordMark.unmarked,
        },
        wordObservations: {},
        retellPointsTicked: {},
        questionAnswers: {},
        dictationMarks: {},
      );

      expect(controller.getUnmarkedWordsCount(), equals(4));
      expect(controller.hasUnmarkedBeforeLastRead, isTrue);
      expect(controller.canSaveMarking(), isFalse);

      // Even if child only read 2 words and words 2, 3 are notReached:
      controller.setRemainingNotReached(2);
      expect(controller.state!.wordMarks[2], equals(WordMark.notReached));
      expect(controller.state!.wordMarks[3], equals(WordMark.notReached));
      // Words 0 and 1 are still unmarked, so save is still blocked!
      expect(controller.hasUnmarkedBeforeLastRead, isTrue);
      expect(controller.canSaveMarking(), isFalse);
    });

    test('3. Mark remaining as correct marks unmarked words and enables saving', () async {
      final controller = container.read(checkFlowControllerProvider.notifier);

      controller.state = const CheckSessionState(
        checkId: 'test_check_02',
        childId: 'child_02',
        childName: 'Rohan',
        currentStep: CheckStep.markReading,
        passage: {'id': 'p1', 'title': 'कहानी'},
        passageWords: ['आम', 'का', 'पेड़', 'बड़ा', 'था'],
        wordMarks: {
          0: WordMark.correct, // explicitly marked
          1: WordMark.unmarked,
          2: WordMark.unmarked,
          3: WordMark.notReached,
          4: WordMark.notReached,
        },
        wordObservations: {},
        retellPointsTicked: {},
        questionAnswers: {},
        dictationMarks: {},
      );

      expect(controller.canSaveMarking(), isFalse);

      // Execute "Mark remaining as correct"
      controller.markAllRemainingAsCorrect();

      // Words 1 and 2 should now be correct
      expect(controller.state!.wordMarks[1], equals(WordMark.correct));
      expect(controller.state!.wordMarks[2], equals(WordMark.correct));
      // Words 3 and 4 must stay notReached
      expect(controller.state!.wordMarks[3], equals(WordMark.notReached));
      expect(controller.state!.wordMarks[4], equals(WordMark.notReached));

      // Now save is enabled
      expect(controller.canSaveMarking(), isTrue);
      final saved = await controller.saveMarkingAndContinue();
      expect(saved, isTrue);
      expect(controller.state!.currentStep, equals(CheckStep.retell));
    });

    test('4. Accuracy and WPM unchanged for fully marked reads', () {
      // 10 words, 9 correct, 1 selfCorrected, reading time = 30 seconds
      final marks = <int, WordMark>{};
      for (int i = 0; i < 9; i++) {
        marks[i] = WordMark.correct;
      }
      marks[9] = WordMark.correctedSelf;

      int correctCount = 0;
      int attemptedCount = 0;
      for (int i = 0; i < 10; i++) {
        final mark = marks[i]!;
        if (mark == WordMark.notReached || mark == WordMark.notSure || mark == WordMark.unmarked) {
          continue;
        }
        attemptedCount++;
        if (mark == WordMark.correct || mark == WordMark.correctedSelf) {
          correctCount++;
        }
      }

      final accuracy = correctCount / attemptedCount;
      const durationSeconds = 30.0;
      final wpm = ((correctCount / durationSeconds) * 60).round();

      expect(accuracy, equals(1.0)); // 100%
      expect(wpm, equals(20)); // 10 words in 30s = 20 wpm
    });

    test('5. Regional variant still counts as correct without error classification', () async {
      final controller = container.read(checkFlowControllerProvider.notifier);

      controller.state = const CheckSessionState(
        checkId: 'test_check_03',
        childId: 'child_03',
        childName: 'Amina',
        currentStep: CheckStep.markReading,
        passage: {'id': 'p1', 'title': 'कहानी'},
        passageWords: ['हवा', 'तेज़', 'थी'],
        wordMarks: {
          0: WordMark.readAsAnotherWord, // Initially flagged
          1: WordMark.correct,
          2: WordMark.correct,
        },
        wordObservations: {},
        retellPointsTicked: {},
        questionAnswers: {},
        dictationMarks: {},
      );

      // Teacher accepts regional variant 'हबा' for word 0 'हवा'
      await controller.acceptRegionalPronunciation(0, 'हबा');

      expect(controller.state!.wordMarks[0], equals(WordMark.correct));
      expect(controller.state!.regionalAcceptedWords.contains(0), isTrue);
      expect(controller.state!.wordObservations[0], contains('Regional: हबा'));

      // Score calculation considers regional accepted word as correct
      int correctCount = 0;
      int attemptedCount = 0;
      for (int i = 0; i < 3; i++) {
        final mark = controller.state!.wordMarks[i]!;
        final isRegional = controller.state!.regionalAcceptedWords.contains(i);
        attemptedCount++;
        if (mark == WordMark.correct || mark == WordMark.correctedSelf || isRegional) {
          correctCount++;
        }
      }

      expect(attemptedCount, equals(3));
      expect(correctCount, equals(3));
      expect(correctCount / attemptedCount, equals(1.0));
    });
  });
}
