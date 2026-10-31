/// The child's own thumbs up / thumbs down after a reading or an answer.
///
/// The rating is about how the child *felt*, never shown back as a score.
/// The teacher sees it next to the real result, which shows whether the
/// child knows when they are right (a self-awareness signal).
enum SelfRating { thumbsUp, thumbsDown, notGiven }

SelfRating parseSelfRating(String? raw) => switch (raw) {
      'thumbs_up' => SelfRating.thumbsUp,
      'thumbs_down' => SelfRating.thumbsDown,
      _ => SelfRating.notGiven,
    };

extension SelfRatingCode on SelfRating {
  /// Stable value stored in the database and sent to cloud sync.
  String get code => switch (this) {
        SelfRating.thumbsUp => 'thumbs_up',
        SelfRating.thumbsDown => 'thumbs_down',
        SelfRating.notGiven => 'not_recorded',
      };
}

/// How the child's feelings matched their actual answers.
class SelfRatingSummary {
  final int thumbsUp;
  final int thumbsDown;
  final int notGiven;

  /// Felt good and was right.
  final int upAndCorrect;

  /// Felt good but was wrong: may not notice their own mistakes.
  final int upButWrong;

  /// Felt unsure but was right: may lack confidence.
  final int downButCorrect;

  /// Felt unsure and was wrong: knows where they struggle.
  final int downAndWrong;

  const SelfRatingSummary({
    required this.thumbsUp,
    required this.thumbsDown,
    required this.notGiven,
    required this.upAndCorrect,
    required this.upButWrong,
    required this.downButCorrect,
    required this.downAndWrong,
  });

  static const empty = SelfRatingSummary(
    thumbsUp: 0,
    thumbsDown: 0,
    notGiven: 0,
    upAndCorrect: 0,
    upButWrong: 0,
    downButCorrect: 0,
    downAndWrong: 0,
  );

  int get rated => thumbsUp + thumbsDown;

  /// Share of rated answers where the feeling matched the result, or null
  /// when nothing was rated.
  double? get matchRatio => rated == 0 ? null : (upAndCorrect + downAndWrong) / rated;

  Map<String, dynamic> toJson() => {
        'thumbs_up': thumbsUp,
        'thumbs_down': thumbsDown,
        'not_given': notGiven,
        'up_and_correct': upAndCorrect,
        'up_but_wrong': upButWrong,
        'down_but_correct': downButCorrect,
        'down_and_wrong': downAndWrong,
      };

  factory SelfRatingSummary.fromJson(Map<String, dynamic> j) => SelfRatingSummary(
        thumbsUp: (j['thumbs_up'] as num?)?.toInt() ?? 0,
        thumbsDown: (j['thumbs_down'] as num?)?.toInt() ?? 0,
        notGiven: (j['not_given'] as num?)?.toInt() ?? 0,
        upAndCorrect: (j['up_and_correct'] as num?)?.toInt() ?? 0,
        upButWrong: (j['up_but_wrong'] as num?)?.toInt() ?? 0,
        downButCorrect: (j['down_but_correct'] as num?)?.toInt() ?? 0,
        downAndWrong: (j['down_and_wrong'] as num?)?.toInt() ?? 0,
      );

  /// Builds a summary from (rating, wasCorrect) pairs.
  factory SelfRatingSummary.from(Iterable<(SelfRating, bool)> answers) {
    var up = 0, down = 0, none = 0, upOk = 0, upWrong = 0, downOk = 0, downWrong = 0;
    for (final (rating, correct) in answers) {
      switch (rating) {
        case SelfRating.thumbsUp:
          up++;
          correct ? upOk++ : upWrong++;
        case SelfRating.thumbsDown:
          down++;
          correct ? downOk++ : downWrong++;
        case SelfRating.notGiven:
          none++;
      }
    }
    return SelfRatingSummary(
      thumbsUp: up,
      thumbsDown: down,
      notGiven: none,
      upAndCorrect: upOk,
      upButWrong: upWrong,
      downButCorrect: downOk,
      downAndWrong: downWrong,
    );
  }
}
