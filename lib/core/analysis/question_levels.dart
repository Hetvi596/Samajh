/// Level-wise comprehension questions (teacher asks, teacher marks).
///
/// Question types map to levels from simple to deep:
///   Level 1 fact · Level 2 word meaning · Level 3 why/how and cause-effect ·
///   Level 4 main idea.
/// The teacher sees Level 1 first. A higher level opens only when every
/// question of the level below has been answered and that level is passed;
/// otherwise the check stops there. Marks per question = answer credit
/// (correct 1, partly 0.5) × level weight × time factor, using the same
/// provisional constants as the word check.
library;

import 'self_rating.dart';
import 'word_check_scoring_engine.dart';

int levelForQuestionType(String? type) => switch (type) {
      'fact' || 'literal' => 1,
      'word_meaning' || 'vocabulary' || 'vocabulary_in_context' => 2,
      'why_how' || 'cause_effect' || 'inference' || 'inferential' => 3,
      'main_idea' => 4,
      _ => 1,
    };

/// Credit for a teacher's answer status; null = no evidence (not asked).
double? answerCredit(String? status) => switch (status) {
      'correct' => 1.0,
      'partly' => 0.5,
      'not_correct' || 'no_answer' => 0.0,
      _ => null,
    };

class LevelledQuestion {
  final String id;
  final String? type;
  final int level;
  const LevelledQuestion({required this.id, required this.type, required this.level});

  factory LevelledQuestion.fromJson(Map<String, dynamic> q, int index) {
    final type = q['type'] as String?;
    return LevelledQuestion(
      id: (q['id'] as String?) ?? 'q_$index',
      type: type,
      level: (q['level'] as num?)?.toInt() ?? levelForQuestionType(type),
    );
  }
}

class QuestionMark {
  final String questionId;
  final int level;
  final double credit;
  final double marks;
  final double maxMarks;
  final double timeFactor;
  const QuestionMark({
    required this.questionId,
    required this.level,
    required this.credit,
    required this.marks,
    required this.maxMarks,
    required this.timeFactor,
  });
}

class QuestionGateResult {
  /// Levels present in the passage, ascending.
  final List<int> levels;

  /// Levels the teacher may ask now.
  final Set<int> openLevels;
  final Map<int, bool> levelPassed;

  /// Highest level passed (0 = Level 1 not passed).
  final int highestLevelPassed;

  /// First level not passed; questions above it are not asked.
  final int? stoppedAtLevel;

  /// True when every open question has an answer and nothing more can open.
  final bool finished;
  final List<QuestionMark> marks;
  final double earned;
  final double possible;
  final SelfRatingSummary selfRatings;

  const QuestionGateResult({
    required this.levels,
    required this.openLevels,
    required this.levelPassed,
    required this.highestLevelPassed,
    required this.stoppedAtLevel,
    required this.finished,
    required this.marks,
    required this.earned,
    required this.possible,
    required this.selfRatings,
  });
}

class QuestionLevels {
  static const double defaultPassRatio = 0.5;
  static const int defaultExpectedMs = 30000;

  static double passRatio(Map<String, dynamic>? thresholds) =>
      ((thresholds?['question_levels'] as Map<String, dynamic>?)?['pass_ratio'] as num?)?.toDouble() ?? defaultPassRatio;

  static int expectedMs(Map<String, dynamic>? thresholds) =>
      ((thresholds?['question_levels'] as Map<String, dynamic>?)?['expected_time_ms'] as num?)?.toInt() ?? defaultExpectedMs;

  /// [answers]: questionId → status; [timesMs]: questionId → time from the
  /// question opening to the teacher's mark; [ratings]: child's feeling.
  static QuestionGateResult evaluate({
    required List<LevelledQuestion> questions,
    required Map<String, String> answers,
    Map<String, int> timesMs = const {},
    Map<String, SelfRating> ratings = const {},
    Map<String, dynamic>? thresholds,
  }) {
    final levels = {for (final q in questions) q.level}.toList()..sort();
    final ratio = passRatio(thresholds);
    final expected = expectedMs(thresholds);

    final open = <int>{};
    final passed = <int, bool>{};
    final marks = <QuestionMark>[];
    final rated = <(SelfRating, bool)>[];
    int highest = 0;
    int? stopped;
    var finished = true;

    for (final lvl in levels) {
      open.add(lvl);
      final qs = questions.where((q) => q.level == lvl).toList();
      final allAnswered = qs.every((q) => answers.containsKey(q.id));
      var earnedCredit = 0.0;
      var asked = 0;
      for (final q in qs) {
        final credit = answerCredit(answers[q.id]);
        if (credit == null) continue;
        asked++;
        earnedCredit += credit;
        final weight = WordCheckScoringEngine.levelWeight(lvl, thresholds);
        final tf = WordCheckScoringEngine.timeFactor(timesMs[q.id] ?? 0, expected, thresholds);
        marks.add(QuestionMark(
          questionId: q.id,
          level: lvl,
          credit: credit,
          marks: double.parse((credit * weight * tf).toStringAsFixed(2)),
          maxMarks: weight,
          timeFactor: double.parse(tf.toStringAsFixed(2)),
        ));
        final r = ratings[q.id];
        if (r != null && r != SelfRating.notGiven) rated.add((r, credit >= 1.0));
      }
      if (!allAnswered) {
        finished = false;
        break;
      }
      final ok = asked > 0 && earnedCredit / asked >= ratio - 1e-9;
      passed[lvl] = ok;
      if (ok) {
        highest = lvl;
      } else {
        stopped = lvl;
        break;
      }
    }

    final earned = marks.fold<double>(0, (s, m) => s + m.marks);
    final possible = marks.fold<double>(0, (s, m) => s + m.maxMarks);
    return QuestionGateResult(
      levels: levels,
      openLevels: open,
      levelPassed: passed,
      highestLevelPassed: highest,
      stoppedAtLevel: stopped,
      finished: finished,
      marks: marks,
      earned: double.parse(earned.toStringAsFixed(2)),
      possible: double.parse(possible.toStringAsFixed(2)),
      selfRatings: SelfRatingSummary.from(rated),
    );
  }
}
