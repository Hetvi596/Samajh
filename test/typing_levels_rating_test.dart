import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/analysis/question_levels.dart';
import 'package:samajh/core/analysis/self_rating.dart';
import 'package:samajh/core/analysis/typed_spelling_checker.dart';
import 'package:samajh/core/analysis/word_check_scoring_engine.dart';

void main() {
  group('Typed spelling checker', () {
    test('exact and spacing-only differences are correct', () {
      expect(TypedSpellingChecker.check('पानी', 'पानी').isCorrect, isTrue);
      expect(TypedSpellingChecker.check('पानी', ' पानी ').isCorrect, isTrue);
      expect(TypedSpellingChecker.check('School', 'school').isCorrect, isTrue);
    });

    test('short and long vowel signs are named', () {
      expect(TypedSpellingChecker.check('पानी', 'पानि').tags, ['short_long_i_ee']);
      expect(TypedSpellingChecker.check('सूरज', 'सुरज').tags, ['short_long_u_oo']);
    });

    test('a missing or wrong matra is a matra mistake', () {
      expect(TypedSpellingChecker.check('पानी', 'पनी').primaryTag, 'wrong_matra');
      expect(TypedSpellingChecker.check('मेला', 'मोला').primaryTag, 'wrong_matra');
    });

    test('a dropped half letter is a conjunct mistake', () {
      expect(TypedSpellingChecker.check('गुब्बारा', 'गुबारा').primaryTag, 'dropped_conjunct');
      expect(TypedSpellingChecker.check('स्कूल', 'सकूल').primaryTag, 'dropped_conjunct');
    });

    test('bindu and chandrabindu are named', () {
      expect(TypedSpellingChecker.check('चाँद', 'चाद').primaryTag, 'bindu_chandrabindu');
      expect(TypedSpellingChecker.check('बंदर', 'बदर').primaryTag, 'bindu_chandrabindu');
    });

    test('look-alike and other letters', () {
      expect(TypedSpellingChecker.check('बस', 'वस').primaryTag, 'similar_shape_letter');
      expect(TypedSpellingChecker.check('घर', 'कर').primaryTag, 'wrong_letter');
      expect(TypedSpellingChecker.check('कमल', 'कल').primaryTag, 'missing_letter');
      expect(TypedSpellingChecker.check('cat', 'cart').primaryTag, 'extra_letter');
      expect(TypedSpellingChecker.check('cat', '').primaryTag, 'missing_letter');
    });

    test('tags have labels in both languages', () {
      for (final tag in ['short_long_u_oo', 'wrong_letter', 'missing_letter', 'extra_letter', 'nukta']) {
        expect(WordCheckScoringEngine.formatDistractorTag(tag), isNot(contains('_')));
        expect(RegExp(r'[ऀ-ॿ]').hasMatch(WordCheckScoringEngine.formatDistractorTag(tag, isHindi: true)), isTrue);
      }
    });
  });

  group('Level-wise comprehension questions', () {
    final questions = [
      const LevelledQuestion(id: 'q1', type: 'fact', level: 1),
      const LevelledQuestion(id: 'q2', type: 'word_meaning', level: 2),
      const LevelledQuestion(id: 'q3', type: 'why_how', level: 3),
      const LevelledQuestion(id: 'q4', type: 'main_idea', level: 4),
    ];

    test('question types map to levels', () {
      expect(levelForQuestionType('fact'), 1);
      expect(levelForQuestionType('word_meaning'), 2);
      expect(levelForQuestionType('why_how'), 3);
      expect(levelForQuestionType('cause_effect'), 3);
      expect(levelForQuestionType('main_idea'), 4);
      expect(LevelledQuestion.fromJson({'id': 'x', 'type': 'main_idea'}, 0).level, 4);
      expect(LevelledQuestion.fromJson({'id': 'x', 'type': 'fact', 'level': 2}, 0).level, 2, reason: 'explicit level wins');
    });

    test('only Level 1 is open until it is answered', () {
      final r = QuestionLevels.evaluate(questions: questions, answers: const {});
      expect(r.openLevels, {1});
      expect(r.finished, isFalse);
    });

    test('a wrong Level 1 answer stops the questions there', () {
      final r = QuestionLevels.evaluate(questions: questions, answers: const {'q1': 'not_correct'});
      expect(r.openLevels, {1});
      expect(r.stoppedAtLevel, 1);
      expect(r.highestLevelPassed, 0);
      expect(r.finished, isTrue);
    });

    test('passing levels opens the next one; marks grow with level', () {
      final r = QuestionLevels.evaluate(
        questions: questions,
        answers: const {'q1': 'correct', 'q2': 'partly', 'q3': 'correct'},
        timesMs: const {'q1': 10000, 'q2': 10000, 'q3': 10000},
      );
      expect(r.openLevels, {1, 2, 3, 4});
      expect(r.highestLevelPassed, 3);
      expect(r.finished, isFalse, reason: 'Level 4 still to ask');
      // 1x1 + 0.5x2 + 1x3 = 5 of 1 + 2 + 3 = 6
      expect(r.earned, 5.0);
      expect(r.possible, 6.0);
    });

    test('a slow answer earns fewer marks', () {
      final fast = QuestionLevels.evaluate(questions: questions, answers: const {'q1': 'correct'}, timesMs: const {'q1': 20000});
      final slow = QuestionLevels.evaluate(questions: questions, answers: const {'q1': 'correct'}, timesMs: const {'q1': 60000});
      expect(fast.earned, 1.0);
      expect(slow.earned, closeTo(0.75, 0.001));
    });

    test('"not asked" gives no evidence, so the next level does not open', () {
      final r = QuestionLevels.evaluate(questions: questions, answers: const {'q1': 'not_asked'});
      expect(r.levelPassed[1], isFalse);
      expect(r.openLevels, {1});
      expect(r.possible, 0.0);
    });
  });

  group('Thumbs up / down summary', () {
    test('matches feelings with results', () {
      final s = SelfRatingSummary.from(const [
        (SelfRating.thumbsUp, true),
        (SelfRating.thumbsUp, false),
        (SelfRating.thumbsDown, true),
        (SelfRating.thumbsDown, false),
        (SelfRating.notGiven, true),
      ]);
      expect((s.thumbsUp, s.thumbsDown, s.notGiven), (2, 2, 1));
      expect((s.upAndCorrect, s.upButWrong, s.downButCorrect, s.downAndWrong), (1, 1, 1, 1));
      expect(s.matchRatio, 0.5);
      expect(SelfRatingSummary.empty.matchRatio, isNull);
    });

    test('codes round-trip for storage and sync', () {
      for (final r in SelfRating.values) {
        expect(parseSelfRating(r.code), r);
      }
    });

    test('word check summary carries the child ratings, skips excluded', () {
      final summary = WordCheckScoringEngine.evaluateSession(choices: const [
        WordCheckItemChoice(itemId: 'a', level: 1, type: 'x', timeToFirstTapMs: 2000, finalChoice: 'a', isCorrectFirstTry: true, isCorrectFinal: true, selfRating: SelfRating.thumbsUp),
        WordCheckItemChoice(itemId: 'b', level: 1, type: 'x', timeToFirstTapMs: 2000, finalChoice: 'b', isCorrectFirstTry: true, isCorrectFinal: true, selfRating: SelfRating.thumbsDown),
        WordCheckItemChoice(itemId: 'c', level: 1, type: 'x', timeToFirstTapMs: 2000, finalChoice: 'c', isCorrectFirstTry: true, isCorrectFinal: true, selfRating: SelfRating.thumbsUp),
        WordCheckItemChoice(itemId: 'd', level: 1, type: 'x', timeToFirstTapMs: 2000, isCorrectFirstTry: false, isCorrectFinal: false, isSkipped: true, selfRating: SelfRating.thumbsDown),
      ]);
      expect(summary.selfRatings.thumbsUp, 2);
      expect(summary.selfRatings.downButCorrect, 1);
      expect(summary.selfRatings.rated, 3);
    });
  });
}
