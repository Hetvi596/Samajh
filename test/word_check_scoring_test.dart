import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/core/analysis/devanagari_engine.dart';
import 'package:samajh/core/analysis/word_check_scoring_engine.dart';

void main() {
  group('Word Check Scoring Weights Tests (Section 3)', () {
    final defaultThresholds = {
      'scoring_constants': {
        'correct_first_try': 1.0,
        'wrong_to_right': 0.75,
        'three_plus_changes_multiplier': 0.5,
        'slow_response_multiplier': 0.85,
        'fast_tap_flag_ms': 1000,
        'minimum_correct_score': 0.5,
        'skip_is_neutral': true,
      },
      'levels': {
        '1': {'min_items': 4, 'promotion_threshold': 0.70, 'expected_time_ms': 5000},
        '2': {'min_items': 4, 'promotion_threshold': 0.70, 'expected_time_ms': 6000},
        '3': {'min_items': 4, 'promotion_threshold': 0.75, 'expected_time_ms': 8000},
        '4': {'min_items': 4, 'promotion_threshold': 0.75, 'expected_time_ms': 10000},
      }
    };

    test('Correct first try scores 1.0 with no penalties', () {
      const choice = WordCheckItemChoice(
        itemId: 'item_1',
        level: 1,
        type: 'spelling',
        firstChoice: 'opt_correct',
        finalChoice: 'opt_correct',
        timeToFirstTapMs: 2500,
        expectedTimeMs: 5000,
        changeCount: 0,
        isCorrectFirstTry: true,
        isCorrectFinal: true,
      );

      final score = WordCheckScoringEngine.scoreItem(choice, defaultThresholds);
      expect(score.rawScore, equals(1));
      expect(score.weightedScore, equals(1.0));
      expect(score.isPossibleGuess, isFalse);
    });

    test('Wrong-to-right self correction scores 0.75', () {
      const choice = WordCheckItemChoice(
        itemId: 'item_2',
        level: 1,
        type: 'spelling',
        firstChoice: 'opt_wrong',
        finalChoice: 'opt_correct',
        timeToFirstTapMs: 2000,
        expectedTimeMs: 5000,
        changeCount: 1,
        isCorrectFirstTry: false,
        isCorrectFinal: true,
      );

      final score = WordCheckScoringEngine.scoreItem(choice, defaultThresholds);
      expect(score.rawScore, equals(1));
      expect(score.weightedScore, equals(0.75));
      expect(score.reasons, contains('self-corrected answer'));
    });

    test('Right-to-wrong changes score 0.0', () {
      const choice = WordCheckItemChoice(
        itemId: 'item_3',
        level: 1,
        type: 'spelling',
        firstChoice: 'opt_correct',
        finalChoice: 'opt_wrong',
        timeToFirstTapMs: 2000,
        expectedTimeMs: 5000,
        changeCount: 1,
        isCorrectFirstTry: true,
        isCorrectFinal: false,
      );

      final score = WordCheckScoringEngine.scoreItem(choice, defaultThresholds);
      expect(score.rawScore, equals(0));
      expect(score.weightedScore, equals(0.0));
      expect(score.reasons, contains('changed from right to wrong'));
    });

    test('3+ changes applies 0.5 multiplier for low confidence', () {
      const choice = WordCheckItemChoice(
        itemId: 'item_4',
        level: 1,
        type: 'spelling',
        firstChoice: 'opt_correct',
        finalChoice: 'opt_correct',
        timeToFirstTapMs: 2000,
        expectedTimeMs: 5000,
        changeCount: 3,
        isCorrectFirstTry: true,
        isCorrectFinal: true,
      );

      final score = WordCheckScoringEngine.scoreItem(choice, defaultThresholds);
      expect(score.weightedScore, equals(0.5)); // 1.0 * 0.5
      expect(score.reasons, contains('3+ answer changes (low confidence)'));
    });

    test('More time taken gives fewer marks: full up to expected time, falling to half at 3x', () {
      WordCheckItemChoice at(int ms) => WordCheckItemChoice(
            itemId: 'item_t$ms',
            level: 1,
            type: 'spelling',
            firstChoice: 'opt_correct',
            finalChoice: 'opt_correct',
            timeToFirstTapMs: ms,
            expectedTimeMs: 5000,
            isCorrectFirstTry: true,
            isCorrectFinal: true,
          );
      double marks(int ms) => WordCheckScoringEngine.scoreItem(at(ms), defaultThresholds).weightedScore;

      expect(marks(4000), equals(1.0), reason: 'within expected time');
      expect(marks(5000), equals(1.0));
      expect(marks(10000), closeTo(0.75, 0.001), reason: 'halfway between 1x and 3x');
      expect(marks(15000), equals(0.5), reason: '3x expected time');
      expect(marks(40000), equals(0.5), reason: 'never below half for a correct answer');
      expect(marks(6000), greaterThan(marks(9000)));
      expect(
        WordCheckScoringEngine.scoreItem(at(10000), defaultThresholds).reasons.single,
        contains('slower than expected time'),
      );
    });

    test('Higher levels carry more marks (level weight)', () {
      WordCheckItemChoice atLevel(int level) => WordCheckItemChoice(
            itemId: 'lvl_$level',
            level: level,
            type: 'spelling',
            firstChoice: 'opt_correct',
            finalChoice: 'opt_correct',
            timeToFirstTapMs: 2000,
            expectedTimeMs: 5000,
            isCorrectFirstTry: true,
            isCorrectFinal: true,
          );
      final scores = [for (var l = 1; l <= 4; l++) WordCheckScoringEngine.scoreItem(atLevel(l), defaultThresholds)];
      expect(scores.map((s) => s.weightedScore), [1.0, 2.0, 3.0, 4.0]);
      expect(scores.map((s) => s.maxMarks), [1.0, 2.0, 3.0, 4.0]);
      // Self-correction and hesitation scale with the level weight too.
      const hesitantL3 = WordCheckItemChoice(
        itemId: 'h3',
        level: 3,
        type: 'spelling',
        firstChoice: 'opt_wrong',
        finalChoice: 'opt_correct',
        timeToFirstTapMs: 2000,
        expectedTimeMs: 8000,
        changeCount: 1,
        isCorrectFirstTry: false,
        isCorrectFinal: true,
      );
      expect(WordCheckScoringEngine.scoreItem(hesitantL3, defaultThresholds).weightedScore, closeTo(2.25, 0.001));
    });

    test('Taps under 1000ms are flagged as possible guess with no bonus', () {
      const quickChoice = WordCheckItemChoice(
        itemId: 'item_7',
        level: 1,
        type: 'sound_recognition',
        firstChoice: 'opt_correct',
        finalChoice: 'opt_correct',
        timeToFirstTapMs: 650, // < 1000ms
        expectedTimeMs: 5000,
        changeCount: 0,
        isCorrectFirstTry: true,
        isCorrectFinal: true,
      );

      final score = WordCheckScoringEngine.scoreItem(quickChoice, defaultThresholds);
      expect(score.isPossibleGuess, isTrue);
      expect(score.reasons, contains('fast response (< 1s, possible guess)'));
    });

    test('Skip / Not sure is neutral and not marked as an error', () {
      const skipChoice = WordCheckItemChoice(
        itemId: 'item_8',
        level: 1,
        type: 'spelling',
        firstChoice: null,
        finalChoice: null,
        timeToFirstTapMs: 0,
        expectedTimeMs: 5000,
        changeCount: 0,
        isCorrectFirstTry: false,
        isCorrectFinal: false,
        isSkipped: true,
      );

      final score = WordCheckScoringEngine.scoreItem(skipChoice, defaultThresholds);
      expect(score.rawScore, equals(0));
      expect(score.weightedScore, equals(0.0));
      expect(score.reasons, contains('not sure / skipped (neutral)'));
    });
  });

  group('Level Promotion & Quiet Stop Rules Tests (Section 2)', () {
    final thresholds = {
      'scoring_constants': {
        'correct_first_try': 1.0,
        'wrong_to_right': 0.75,
        'three_plus_changes_multiplier': 0.5,
        'slow_response_multiplier': 0.85,
        'fast_tap_flag_ms': 1000,
        'minimum_correct_score': 0.5,
        'skip_is_neutral': true,
      },
      'levels': {
        '1': {'min_items': 4, 'promotion_threshold': 0.70, 'expected_time_ms': 5000},
        '2': {'min_items': 4, 'promotion_threshold': 0.70, 'expected_time_ms': 6000},
        '3': {'min_items': 4, 'promotion_threshold': 0.75, 'expected_time_ms': 8000},
        '4': {'min_items': 4, 'promotion_threshold': 0.75, 'expected_time_ms': 10000},
      }
    };

    test('Child promotes when score >= promotion threshold and min items met', () {
      final items = List.generate(
        4,
        (i) => WordCheckItemChoice(
          itemId: 'l1_$i',
          level: 1,
          type: 'sound_recognition',
          timeToFirstTapMs: 2500,
          isCorrectFirstTry: true,
          isCorrectFinal: true,
        ),
      );

      final result = WordCheckScoringEngine.evaluateLevel(
        level: 1,
        items: items,
        thresholds: thresholds,
      );

      expect(result.passedPromotion, isTrue);
      expect(result.scoreRatio, equals(1.0));
    });

    test('Child does not promote if below promotion threshold', () {
      final items = [
        const WordCheckItemChoice(
          itemId: 'l1_0',
          level: 1,
          type: 'sound_recognition',
          timeToFirstTapMs: 2500,
          isCorrectFirstTry: true,
          isCorrectFinal: true,
        ),
        const WordCheckItemChoice(
          itemId: 'l1_1',
          level: 1,
          type: 'sound_recognition',
          timeToFirstTapMs: 2500,
          isCorrectFirstTry: false,
          isCorrectFinal: false,
        ),
        const WordCheckItemChoice(
          itemId: 'l1_2',
          level: 1,
          type: 'sound_recognition',
          timeToFirstTapMs: 2500,
          isCorrectFirstTry: false,
          isCorrectFinal: false,
        ),
        const WordCheckItemChoice(
          itemId: 'l1_3',
          level: 1,
          type: 'sound_recognition',
          timeToFirstTapMs: 2500,
          isCorrectFirstTry: false,
          isCorrectFinal: false,
        ),
      ];

      final result = WordCheckScoringEngine.evaluateLevel(
        level: 1,
        items: items,
        thresholds: thresholds,
      );

      expect(result.passedPromotion, isFalse);
      expect(result.scoreRatio, equals(0.25));
    });

    test('A child who does not pass Level 1 never moves to Level 2', () {
      // Level 1: 1 of 4 right (not passed)
      final l1Items = [
        const WordCheckItemChoice(itemId: '1_0', level: 1, type: 'sound', timeToFirstTapMs: 2000, isCorrectFirstTry: true, isCorrectFinal: true),
        const WordCheckItemChoice(itemId: '1_1', level: 1, type: 'sound', timeToFirstTapMs: 2000, isCorrectFirstTry: false, isCorrectFinal: false),
        const WordCheckItemChoice(itemId: '1_2', level: 1, type: 'sound', timeToFirstTapMs: 2000, isCorrectFirstTry: false, isCorrectFinal: false),
        const WordCheckItemChoice(itemId: '1_3', level: 1, type: 'sound', timeToFirstTapMs: 2000, isCorrectFirstTry: false, isCorrectFinal: false),
      ];
      // Anything recorded at Level 2 is ignored.
      final l2Items = List.generate(
        4,
        (i) => WordCheckItemChoice(itemId: '2_$i', level: 2, type: 'spelling', timeToFirstTapMs: 2000, isCorrectFirstTry: true, isCorrectFinal: true),
      );

      final summary = WordCheckScoringEngine.evaluateSession(
        choices: [...l1Items, ...l2Items],
        thresholds: thresholds,
      );

      expect(summary.stoppedAtLevel, 1);
      expect(summary.highestLevelReached, 0);
      expect(summary.perLevelResults.keys, [1]);
      expect(summary.totalItemsAttempted, 4);
      expect(summary.totalWeightedScore, 1.0);
      expect(summary.maxPossibleScore, 4.0);
    });

    test('Passing Level 1 and Level 2 then stopping at Level 3', () {
      List<WordCheckItemChoice> level(int lvl, int right) => List.generate(
            4,
            (i) => WordCheckItemChoice(
              itemId: '${lvl}_$i',
              level: lvl,
              type: 'x',
              timeToFirstTapMs: 2000,
              expectedTimeMs: 5000,
              isCorrectFirstTry: i < right,
              isCorrectFinal: i < right,
            ),
          );
      final summary = WordCheckScoringEngine.evaluateSession(
        choices: [...level(1, 4), ...level(2, 3), ...level(3, 1)],
        thresholds: thresholds,
      );
      expect(summary.highestLevelReached, 2);
      expect(summary.stoppedAtLevel, 3);
      // Marks: L1 4x1 + L2 3x2 + L3 1x3 = 13 of 4 + 8 + 12 = 24.
      expect(summary.totalWeightedScore, 13.0);
      expect(summary.maxPossibleScore, 24.0);
    });

    test('A slow but correct child still passes the level; only the marks drop', () {
      final slow = List.generate(
        4,
        (i) => WordCheckItemChoice(
          itemId: 's_$i',
          level: 1,
          type: 'x',
          timeToFirstTapMs: 20000,
          expectedTimeMs: 5000,
          isCorrectFirstTry: true,
          isCorrectFinal: true,
        ),
      );
      final result = WordCheckScoringEngine.evaluateLevel(level: 1, items: slow, thresholds: thresholds);
      expect(result.passedPromotion, isTrue);
      expect(result.correctRatio, 1.0);
      expect(result.scoreRatio, 0.5);
    });
  });

  group('Dialect & Regional Distractor Guardrails Tests (Section 5)', () {
    test('Distractor never equals a valid regional variant of the target', () {
      // Test words covered in regional variants rules
      // e.g. "स्कूल" regional variant is "इस्कूल"
      expect(
        DevanagariAksharaEngine.isValidDistractor('स्कूल', 'इस्कूल'),
        isFalse,
      );

      // "स्टेशन" regional variant is "इस्टेशन"
      expect(
        DevanagariAksharaEngine.isValidDistractor('स्टेशन', 'इस्टेशन'),
        isFalse,
      );

      // Valid distractor with actual error
      expect(
        DevanagariAksharaEngine.isValidDistractor('कमल', 'कलम'),
        isTrue,
      );
    });

    test('Items where the only contrast is a dialect difference are excluded', () {
      expect(
        DevanagariAksharaEngine.isDialectOnlyContrast('स्कूल', 'इस्कूल'),
        isTrue,
      );

      expect(
        DevanagariAksharaEngine.isDialectOnlyContrast('पानी', 'पाणी'),
        isTrue,
      );

      expect(
        DevanagariAksharaEngine.isDialectOnlyContrast('पेड़', 'पेर'),
        isTrue,
      );

      // Real spelling mistake (not regional) is not dialect-only
      expect(
        DevanagariAksharaEngine.isDialectOnlyContrast('किताब', 'कतब'),
        isFalse,
      );
    });
  });
}
