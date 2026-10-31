import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/services.dart';

import 'self_rating.dart';

/// Represents a single response by a child: a visual choice (word check) or
/// a typed word (typing check, `type == 'typed_spelling'`).
class WordCheckItemChoice {
  final String itemId;
  final int level;
  final String type;
  final String? firstChoice;
  final String? finalChoice;
  final int timeToFirstTapMs;
  final int expectedTimeMs;
  final int changeCount;
  final bool isCorrectFirstTry;
  final bool isCorrectFinal;
  final bool isSkipped;
  final String? chosenDistractorTag;

  /// The child's own thumbs up / down after this item.
  final SelfRating selfRating;

  const WordCheckItemChoice({
    required this.itemId,
    required this.level,
    required this.type,
    this.firstChoice,
    this.finalChoice,
    required this.timeToFirstTapMs,
    this.expectedTimeMs = 5000,
    this.changeCount = 0,
    required this.isCorrectFirstTry,
    required this.isCorrectFinal,
    this.isSkipped = false,
    this.chosenDistractorTag,
    this.selfRating = SelfRating.notGiven,
  });
}

/// Computed marks and explanatory reasons for an item.
class WordCheckItemScore {
  final int rawScore; // 1 or 0 (skip is 0 raw, but neutral)

  /// Marks awarded: base credit × level weight × time factor.
  final double weightedScore;

  /// The most this item can earn (its level weight).
  final double maxMarks;
  final double timeFactor;
  final bool isPossibleGuess;
  final List<String> reasons;

  const WordCheckItemScore({
    required this.rawScore,
    required this.weightedScore,
    this.maxMarks = 1.0,
    this.timeFactor = 1.0,
    required this.isPossibleGuess,
    required this.reasons,
  });
}

/// Level result summary.
class WordCheckLevelResult {
  final int level;
  final int totalItems;
  final int rawCorrect;
  final double weightedScore;
  final double maxPossibleWeightedScore;

  /// Marks earned ÷ marks possible (shown to the teacher).
  final double scoreRatio;

  /// Right answers ÷ items (decides promotion; time never blocks promotion).
  final double correctRatio;
  final bool passedPromotion;
  final List<String> reasons;

  const WordCheckLevelResult({
    required this.level,
    required this.totalItems,
    required this.rawCorrect,
    required this.weightedScore,
    required this.maxPossibleWeightedScore,
    required this.scoreRatio,
    this.correctRatio = 0.0,
    required this.passedPromotion,
    required this.reasons,
  });
}

/// Comprehensive session summary across levels.
class WordCheckSessionSummary {
  final List<WordCheckItemChoice> items;
  final List<WordCheckItemScore> itemScores;
  final Map<int, WordCheckLevelResult> perLevelResults;

  /// Highest level the child passed (0 = Level 1 not passed).
  final int highestLevelReached;

  /// First level the child did not pass; the check stopped there. Null when
  /// every level attempted was passed.
  final int? stoppedAtLevel;
  final int totalRawCorrect;
  final int totalItemsAttempted;
  final double totalWeightedScore;
  final double maxPossibleScore;
  final List<String> topMistakeTags;
  final List<String> overallReasons;
  final SelfRatingSummary selfRatings;

  const WordCheckSessionSummary({
    required this.items,
    required this.itemScores,
    required this.perLevelResults,
    required this.highestLevelReached,
    required this.stoppedAtLevel,
    required this.totalRawCorrect,
    required this.totalItemsAttempted,
    required this.totalWeightedScore,
    required this.maxPossibleScore,
    required this.topMistakeTags,
    required this.overallReasons,
    this.selfRatings = SelfRatingSummary.empty,
  });
}

/// Pure Dart scoring engine: levelled progression and weighted marks.
///
/// Marks for one item = base credit × level weight × time factor:
/// - base credit: 1.0 right first time, 0.75 corrected to right, ×0.5 for
///   3 or more changes, 0 for wrong; "not sure" is neutral (0, not an error);
/// - level weight: higher levels are worth more (default L1 = 1 … L4 = 4);
/// - time factor: 1.0 up to the expected time, then falling in a straight
///   line to 0.5 at 3× the expected time (never below 0.5).
/// A level is passed on right answers alone, so a slow but correct child is
/// never held back; slowness lowers only the marks. A child always starts at
/// Level 1 and stops at the first level not passed.
/// All numbers are provisional (thresholds.json) and Samajh's own choice.
class WordCheckScoringEngine {
  static const double kCorrectFirstTry = 1.0;
  static const double kWrongToRight = 0.75;
  static const double kRightToWrong = 0.0;
  static const double kThreePlusChangesMultiplier = 0.5;
  static const int kFastTapThresholdMs = 1000;
  static const Map<int, double> kLevelWeights = {1: 1.0, 2: 2.0, 3: 3.0, 4: 4.0};
  static const double kTimeDecayEndMultiple = 3.0;
  static const double kTimeDecayFloor = 0.5;

  static Map<String, dynamic>? _cachedThresholds;

  /// Loads thresholds config from assets/config/thresholds.json.
  /// Falls back to built-in provisional defaults in pure unit tests.
  static Future<Map<String, dynamic>> loadThresholds() async {
    if (_cachedThresholds != null) return _cachedThresholds!;
    try {
      final jsonStr = await rootBundle.loadString('assets/config/thresholds.json');
      _cachedThresholds = jsonDecode(jsonStr) as Map<String, dynamic>;
      return _cachedThresholds!;
    } catch (_) {
      return {
        'status': 'provisional',
        'scoring': {
          'correct_first_try': kCorrectFirstTry,
          'wrong_to_right': kWrongToRight,
          'right_to_wrong': kRightToWrong,
          'three_plus_changes_multiplier': kThreePlusChangesMultiplier,
          'fast_tap_flag_ms': kFastTapThresholdMs,
          'skip_is_neutral': true,
        },
        'weighted_marking': {
          'level_weights': {for (final e in kLevelWeights.entries) '${e.key}': e.value},
          'time_decay_end_multiple': kTimeDecayEndMultiple,
          'time_decay_floor': kTimeDecayFloor,
        },
        'word_check_levels': {
          '1': {'level': 1, 'min_items': 3, 'promotion_threshold': 0.66, 'expected_time_ms': 5000},
          '2': {'level': 2, 'min_items': 3, 'promotion_threshold': 0.66, 'expected_time_ms': 6000},
          '3': {'level': 3, 'min_items': 3, 'promotion_threshold': 0.66, 'expected_time_ms': 8000},
          '4': {'level': 4, 'min_items': 3, 'promotion_threshold': 0.66, 'expected_time_ms': 10000},
        },
        'typing_levels': {
          '1': {'level': 1, 'min_items': 2, 'promotion_threshold': 0.66, 'expected_time_ms': 20000},
          '2': {'level': 2, 'min_items': 2, 'promotion_threshold': 0.66, 'expected_time_ms': 30000},
          '3': {'level': 3, 'min_items': 2, 'promotion_threshold': 0.66, 'expected_time_ms': 40000},
        },
      };
    }
  }

  /// Marks a level is worth per item.
  static double levelWeight(int level, [Map<String, dynamic>? config]) {
    final weights = (config?['weighted_marking'] as Map<String, dynamic>?)?['level_weights'] as Map<String, dynamic>?;
    final fromConfig = (weights?['$level'] as num?)?.toDouble();
    if (fromConfig != null) return fromConfig;
    return kLevelWeights[level] ?? math.max(1, level).toDouble();
  }

  /// 1.0 up to [expectedMs]; then a straight line down to the floor at
  /// `end_multiple × expectedMs`; the floor after that.
  static double timeFactor(int timeMs, int expectedMs, [Map<String, dynamic>? config]) {
    final marking = config?['weighted_marking'] as Map<String, dynamic>?;
    final endMultiple = (marking?['time_decay_end_multiple'] as num?)?.toDouble() ?? kTimeDecayEndMultiple;
    final floor = (marking?['time_decay_floor'] as num?)?.toDouble() ?? kTimeDecayFloor;
    if (expectedMs <= 0 || timeMs <= expectedMs) return 1.0;
    final endMs = expectedMs * endMultiple;
    if (timeMs >= endMs) return floor;
    final progress = (timeMs - expectedMs) / (endMs - expectedMs);
    return 1.0 - progress * (1.0 - floor);
  }

  /// Expected answer time for a level from config (word check or typing).
  static int expectedTimeMs(int level, Map<String, dynamic>? thresholds, {String levelsKey = 'word_check_levels'}) {
    final cfg = _levelConfig(thresholds, level, key: levelsKey);
    return (cfg?['expected_time_ms'] as num?)?.toInt() ??
        (levelsKey == 'typing_levels' ? 20000 + 10000 * (level - 1) : const {1: 5000, 2: 6000, 3: 8000, 4: 10000}[level] ?? 6000);
  }

  static double _round(double v) => double.parse(v.toStringAsFixed(2));

  /// Scores a single item.
  static WordCheckItemScore scoreItem(
    WordCheckItemChoice item, [
    Map<String, dynamic>? config,
  ]) {
    final reasons = <String>[];
    bool isPossibleGuess = false;

    final scoringConfig = (config?['scoring_constants'] ?? config?['scoring']) as Map<String, dynamic>?;
    final correctFirstTry = (scoringConfig?['correct_first_try'] as num?)?.toDouble() ?? kCorrectFirstTry;
    final wrongToRight = (scoringConfig?['wrong_to_right'] as num?)?.toDouble() ?? kWrongToRight;
    final threePlusChangesMultiplier =
        (scoringConfig?['three_plus_changes_multiplier'] as num?)?.toDouble() ?? kThreePlusChangesMultiplier;
    final fastTapThresholdMs = (scoringConfig?['fast_tap_flag_ms'] as num?)?.toInt() ?? kFastTapThresholdMs;

    final weight = levelWeight(item.level, config);

    if (item.timeToFirstTapMs > 0 && item.timeToFirstTapMs < fastTapThresholdMs) {
      isPossibleGuess = true;
      reasons.add("fast response (< 1s, possible guess)");
    }

    if (item.isSkipped || (item.finalChoice == null && !item.isCorrectFinal)) {
      return WordCheckItemScore(
        rawScore: 0,
        weightedScore: 0.0,
        maxMarks: weight,
        isPossibleGuess: isPossibleGuess,
        reasons: const ["not sure / skipped (neutral)"],
      );
    }

    if (item.isCorrectFinal) {
      double base;
      if (item.isCorrectFirstTry) {
        base = correctFirstTry;
      } else {
        base = wrongToRight;
        reasons.add("self-corrected answer");
      }
      if (item.changeCount >= 3) {
        base *= threePlusChangesMultiplier;
        reasons.add("3+ answer changes (low confidence)");
      }
      final tf = timeFactor(item.timeToFirstTapMs, item.expectedTimeMs, config);
      if (tf < 1.0) {
        reasons.add("slower than expected time (marks x${tf.toStringAsFixed(2)})");
      }
      return WordCheckItemScore(
        rawScore: 1,
        weightedScore: _round(base * weight * tf),
        maxMarks: weight,
        timeFactor: _round(tf),
        isPossibleGuess: isPossibleGuess,
        reasons: reasons,
      );
    }

    if (item.isCorrectFirstTry && !item.isCorrectFinal) {
      reasons.add("changed from right to wrong");
    } else {
      reasons.add("incorrect answer");
    }
    if (item.chosenDistractorTag != null) {
      reasons.add("Error tag: ${formatDistractorTag(item.chosenDistractorTag!)}");
    }
    return WordCheckItemScore(
      rawScore: 0,
      weightedScore: 0.0,
      maxMarks: weight,
      isPossibleGuess: isPossibleGuess,
      reasons: reasons,
    );
  }

  /// Calculates one level's result. Promotion needs at least [minItems]
  /// items and right answers ÷ items ≥ [promotionThreshold].
  static WordCheckLevelResult calculateLevelResult(
    int level,
    List<WordCheckItemChoice> levelItems, {
    double promotionThreshold = 0.70,
    int minItems = 4,
    Map<String, dynamic>? config,
  }) {
    if (levelItems.isEmpty) {
      return WordCheckLevelResult(
        level: level,
        totalItems: 0,
        rawCorrect: 0,
        weightedScore: 0.0,
        maxPossibleWeightedScore: 0.0,
        scoreRatio: 0.0,
        passedPromotion: false,
        reasons: const ["No items attempted"],
      );
    }

    int rawCorrect = 0;
    double earned = 0.0;
    double possible = 0.0;
    final levelReasons = <String>[];
    for (final item in levelItems) {
      final s = scoreItem(item, config);
      rawCorrect += s.rawScore;
      earned += s.weightedScore;
      possible += s.maxMarks;
      levelReasons.addAll(s.reasons);
    }

    final correctRatio = rawCorrect / levelItems.length;
    final passed = levelItems.length >= minItems && correctRatio >= promotionThreshold - 1e-9;

    return WordCheckLevelResult(
      level: level,
      totalItems: levelItems.length,
      rawCorrect: rawCorrect,
      weightedScore: _round(earned),
      maxPossibleWeightedScore: _round(possible),
      scoreRatio: possible > 0 ? _round(earned / possible) : 0.0,
      correctRatio: _round(correctRatio),
      passedPromotion: passed,
      reasons: levelReasons,
    );
  }

  static Map<String, dynamic>? _levelConfig(Map<String, dynamic>? thresholds, int level, {String key = 'word_check_levels'}) =>
      (thresholds?['levels']?['$level'] ?? thresholds?[key]?['$level']) as Map<String, dynamic>?;

  /// Evaluates a single level against thresholds.
  static WordCheckLevelResult evaluateLevel({
    required int level,
    required List<WordCheckItemChoice> items,
    Map<String, dynamic>? thresholds,
    String levelsKey = 'word_check_levels',
  }) {
    final cfg = _levelConfig(thresholds, level, key: levelsKey);
    return calculateLevelResult(
      level,
      items,
      promotionThreshold: (cfg?['promotion_threshold'] as num?)?.toDouble() ?? 0.66,
      minItems: (cfg?['min_items'] as num?)?.toInt() ?? 3,
      config: thresholds,
    );
  }

  /// Evaluates a whole session level by level from Level 1. Stops at the
  /// first level not passed; anything recorded above it is ignored.
  static WordCheckSessionSummary evaluateSession({
    List<WordCheckItemChoice>? items,
    List<WordCheckItemChoice>? choices,
    Map<String, dynamic>? thresholds,
    String levelsKey = 'word_check_levels',
  }) {
    final all = items ?? choices ?? const <WordCheckItemChoice>[];
    final byLevel = <int, List<WordCheckItemChoice>>{};
    for (final it in all) {
      byLevel.putIfAbsent(it.level, () => []).add(it);
    }

    final perLevel = <int, WordCheckLevelResult>{};
    final counted = <WordCheckItemChoice>[];
    int highestPassed = 0;
    int? stoppedAt;
    for (final lvl in byLevel.keys.toList()..sort()) {
      final res = evaluateLevel(level: lvl, items: byLevel[lvl]!, thresholds: thresholds, levelsKey: levelsKey);
      perLevel[lvl] = res;
      counted.addAll(byLevel[lvl]!);
      if (res.passedPromotion) {
        highestPassed = math.max(highestPassed, lvl);
      } else {
        stoppedAt = lvl;
        break;
      }
    }

    final scores = counted.map((it) => scoreItem(it, thresholds)).toList();
    final totalRaw = scores.fold<int>(0, (s, x) => s + x.rawScore);
    final totalEarned = scores.fold<double>(0.0, (s, x) => s + x.weightedScore);
    final totalPossible = scores.fold<double>(0.0, (s, x) => s + x.maxMarks);

    final reasons = <String>{};
    for (final s in scores) {
      for (final r in s.reasons) {
        if (!r.contains("incorrect answer") && !r.contains("Error tag:")) reasons.add(r);
      }
    }

    return WordCheckSessionSummary(
      items: counted,
      itemScores: scores,
      perLevelResults: perLevel,
      highestLevelReached: highestPassed,
      stoppedAtLevel: stoppedAt,
      totalRawCorrect: totalRaw,
      totalItemsAttempted: counted.length,
      totalWeightedScore: _round(totalEarned),
      maxPossibleScore: _round(totalPossible),
      topMistakeTags: aggregateTopDistractorTags(counted, limit: 3),
      overallReasons: reasons.toList(),
      selfRatings: SelfRatingSummary.from([
        for (final it in counted)
          if (!it.isSkipped) (it.selfRating, it.isCorrectFinal),
      ]),
    );
  }

  /// Aggregates top distractor tags from mistakes.
  static List<String> aggregateTopDistractorTags(List<WordCheckItemChoice> items, {int limit = 3}) {
    final counts = <String, int>{};
    for (final it in items) {
      if (!it.isCorrectFinal && it.chosenDistractorTag != null && it.chosenDistractorTag!.isNotEmpty) {
        final tag = it.chosenDistractorTag!;
        counts[tag] = (counts[tag] ?? 0) + 1;
      }
    }
    final sorted = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(limit).map((e) => e.key).toList();
  }

  /// Human-readable label for a mistake tag in English and Hindi.
  static String formatDistractorTag(String tag, {bool isHindi = false}) {
    switch (tag) {
      case 'short_long_i_ee':
        return isHindi ? "छोटी/बड़ी ई (इ/ई) मात्रा अंतर" : "Short / Long i/ee matra";
      case 'short_long_u_oo':
        return isHindi ? "छोटा/बड़ा उ (उ/ऊ) मात्रा अंतर" : "Short / Long u/oo matra";
      case 'wrong_matra':
        return isHindi ? "मात्रा त्रुटि" : "Wrong or missing matra";
      case 'dropped_conjunct':
        return isHindi ? "छूटा हुआ संयुक्त व्यंजन (आधा अक्षर)" : "Dropped conjunct / half-letter";
      case 'bindu_chandrabindu':
        return isHindi ? "बिंदु / चंद्रबिंदु अंतर" : "Bindu / Chandrabindu";
      case 'nukta':
        return isHindi ? "नुक्ता" : "Nukta";
      case 'similar_shape_letter':
        return isHindi ? "समान आकृति अक्षर भ्रम" : "Similar-shape letter confusion";
      case 'wrong_letter':
        return isHindi ? "गलत अक्षर" : "Wrong letter";
      case 'missing_letter':
        return isHindi ? "अक्षर छूटा" : "Missing letter";
      case 'extra_letter':
        return isHindi ? "अतिरिक्त अक्षर" : "Extra letter";
      case 'floating_above':
        return isHindi ? "लाइन के ऊपर तैरता हुआ" : "Writes floating above the line";
      case 'sinking_below':
        return isHindi ? "लाइन के नीचे डूबता हुआ" : "Writes sinking below the line";
      case 'crossing_line':
        return isHindi ? "लाइन को काटता हुआ" : "Crosses through the line";
      case 'missing_shirorekha':
        return isHindi ? "शिरोरेखा नहीं लगाई" : "Missing top line (shirorekha)";
      case 'letters_spread_apart':
        return isHindi ? "अक्षर दूर-दूर" : "Letters spread apart";
      case 'mirrored_letter':
        return isHindi ? "अक्षर उल्टा लिखा (b/d, p/q)" : "Letter written back to front (b/d, p/q)";
      case 'uneven_letters':
        return isHindi ? "अक्षर टेढ़े और छोटे-बड़े" : "Uneven, tilted letters";
      case 'illogical_object':
        return isHindi ? "अर्थहीन विकल्प" : "Illogical context option";
      case 'opposite_emotion':
        return isHindi ? "विपरीत भावार्थ" : "Opposite emotion / meaning";
      case 'opposite_size':
        return isHindi ? "आकार का गलत अनुमान" : "Incorrect size inference";
      case 'same_first_sound':
        return isHindi ? "पहली ध्वनि एक जैसी, शब्द अलग" : "Same first sound, different word";
      case 'letter_order':
        return isHindi ? "अक्षरों का क्रम बदला" : "Letters in the wrong order";
      case 'r_form':
        return isHindi ? "र के रूप (प्र, र्, ृ) में भ्रम" : "Mixed-up forms of र (प्र, र्, ृ)";
      case 'similar_sound':
        return isHindi ? "मिलती-जुलती ध्वनि (श/स)" : "Similar sound (श/स)";
      case 'opposite_meaning':
        return isHindi ? "उल्टा अर्थ" : "Opposite meaning";
      case 'wrong_inference':
        return isHindi ? "गलत अनुमान" : "Wrong inference";
      case 'not_in_story':
        return isHindi ? "जो बात सुनी ही नहीं" : "Something not in what was heard";
      default:
        final words = tag.replaceAll('_', ' ').trim();
        return words.isEmpty ? tag : words[0].toUpperCase() + words.substring(1);
    }
  }
}
