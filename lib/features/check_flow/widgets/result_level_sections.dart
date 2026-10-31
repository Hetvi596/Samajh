import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/analysis/question_levels.dart';
import '../../../core/analysis/self_rating.dart';
import '../../../core/analysis/word_check_scoring_engine.dart';
import '../../../core/i18n/generated/app_localizations.dart';
import '../check_flow_controller.dart';

/// Teacher-only result sections for the level-wise checks: questions by
/// level, the typing check, and the child's own ratings beside the results.
class LevelResultSections extends StatelessWidget {
  final CheckSessionState session;

  const LevelResultSections({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: WordCheckScoringEngine.loadThresholds(),
      builder: (context, snap) {
        final gate = QuestionLevels.evaluate(
          questions: session.levelledQuestions,
          answers: session.questionAnswers,
          timesMs: session.questionTimesMs,
          ratings: session.questionRatings,
          thresholds: snap.data,
        );
        final ratings = buildSelfRatingSummary(
          session,
          gate,
          readingWentWell: !session.notEnoughEvidence && session.accuracy >= kReadingWentWellAccuracy,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _QuestionLevelsCard(gate: gate),
            const SizedBox(height: 20),
            _TypingCard(session: session),
            const SizedBox(height: 20),
            _SelfRatingCard(session: session, summary: ratings),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

String _fmt(double v) => v.toStringAsFixed(1);

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: SamajhColors.textNavy)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: SamajhColors.dividerColor),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
      ],
    );
  }
}

const _body = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: SamajhColors.textNavy);
const _muted = TextStyle(fontSize: 12, color: SamajhColors.textMuted, height: 1.35);

class _QuestionLevelsCard extends StatelessWidget {
  final QuestionGateResult gate;
  const _QuestionLevelsCard({required this.gate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _Section(
      title: l10n.questionsTitle,
      children: [
        Text(
          gate.highestLevelPassed > 0 ? l10n.highestLevelPassed(gate.highestLevelPassed) : l10n.levelOneNotPassed,
          style: _body,
        ),
        if (gate.possible > 0) ...[
          const SizedBox(height: 4),
          Text(l10n.marksLine(_fmt(gate.earned), _fmt(gate.possible)), style: _body),
        ],
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            for (final lvl in gate.levels)
              if (gate.levelPassed.containsKey(lvl))
                _chip(
                  '${l10n.questionLevelLabel(lvl)}: ${gate.levelPassed[lvl]! ? '✓' : '✗'}',
                  gate.levelPassed[lvl]! ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                ),
          ],
        ),
        const SizedBox(height: 8),
        Text(l10n.weightedMarkingNote, style: _muted),
      ],
    );
  }
}

class _TypingCard extends StatelessWidget {
  final CheckSessionState session;
  const _TypingCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isHindi = session.isPassageHindi;
    final s = session.typingSummary;
    if (s == null || session.typingChoices.isEmpty) {
      return _Section(title: l10n.typingSection, children: [Text(l10n.typingSkipped, style: _body)]);
    }
    final font = isHindi ? 'NotoSansDevanagari' : 'Inter';
    return _Section(
      title: l10n.typingSection,
      children: [
        Text(l10n.typingScoreLine(s.totalRawCorrect, s.totalItemsAttempted), style: _body),
        const SizedBox(height: 4),
        Text(l10n.marksLine(_fmt(s.totalWeightedScore), _fmt(s.maxPossibleScore)), style: _body),
        const SizedBox(height: 4),
        Text(s.highestLevelReached > 0 ? l10n.highestLevelPassed(s.highestLevelReached) : l10n.levelOneNotPassed,
            style: _body),
        const SizedBox(height: 10),
        for (final c in session.typingChoices)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.isCorrectFinal ? '✓ ' : (c.isSkipped ? '· ' : '✗ '),
                    style: TextStyle(color: c.isCorrectFinal ? SamajhColors.forestGreen : const Color(0xFF92400E))),
                Expanded(
                  child: Text(
                    [
                      c.isSkipped
                          ? l10n.typedWordNotSure(c.firstChoice ?? '')
                          : l10n.typedWordRow(c.firstChoice ?? '', c.finalChoice ?? ''),
                      if (!c.isCorrectFinal && c.chosenDistractorTag != null)
                        WordCheckScoringEngine.formatDistractorTag(c.chosenDistractorTag!, isHindi: isHindi),
                    ].join('  ·  '),
                    style: TextStyle(fontFamily: font, fontSize: 13, color: SamajhColors.textNavy),
                  ),
                ),
                Text(_ratingEmoji(c.selfRating)),
              ],
            ),
          ),
      ],
    );
  }
}

class _SelfRatingCard extends StatelessWidget {
  final CheckSessionState session;
  final SelfRatingSummary summary;
  const _SelfRatingCard({required this.session, required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final match = summary.matchRatio;
    return _Section(
      title: l10n.selfRatingSection,
      children: [
        if (session.readingSelfRating == SelfRating.thumbsUp) Text(l10n.readingFeltGood, style: _body),
        if (session.readingSelfRating == SelfRating.thumbsDown) Text(l10n.readingFeltHard, style: _body),
        if (summary.rated == 1 && session.readingSelfRating != SelfRating.notGiven) ...[
          const SizedBox(height: 8),
          _chip(
            switch ((session.readingSelfRating, summary.upAndCorrect + summary.downButCorrect > 0)) {
              (SelfRating.thumbsUp, true) => l10n.selfRatingOverallUpWell,
              (SelfRating.thumbsUp, false) => l10n.selfRatingOverallUpHard,
              (SelfRating.thumbsDown, true) => l10n.selfRatingOverallDownWell,
              _ => l10n.selfRatingOverallDownHard,
            },
            summary.upButWrong > 0
                ? const Color(0xFFFEF3C7)
                : summary.downButCorrect > 0
                    ? const Color(0xFFE0F2FE)
                    : SamajhColors.paleMint,
          ),
        ] else if (summary.rated == 0)
          Text(l10n.selfRatingNone, style: _body)
        else ...[
          const SizedBox(height: 4),
          Text(l10n.selfRatingCounts(summary.thumbsUp, summary.thumbsDown), style: _body),
          if (match != null) ...[
            const SizedBox(height: 4),
            Text(l10n.selfRatingMatch((match * 100).round()), style: _body),
          ],
          const SizedBox(height: 8),
          if (summary.upButWrong > 0)
            _chip(l10n.selfRatingUpButWrong(summary.upButWrong), const Color(0xFFFEF3C7)),
          if (summary.downButCorrect > 0) ...[
            const SizedBox(height: 6),
            _chip(l10n.selfRatingDownButCorrect(summary.downButCorrect), const Color(0xFFE0F2FE)),
          ],
        ],
        const SizedBox(height: 8),
        Text(l10n.selfRatingNote, style: _muted),
      ],
    );
  }
}

String _ratingEmoji(SelfRating r) => switch (r) {
      SelfRating.thumbsUp => '👍',
      SelfRating.thumbsDown => '👎',
      SelfRating.notGiven => '',
    };

Widget _chip(String text, Color bg) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: SamajhColors.textNavy)),
    );
