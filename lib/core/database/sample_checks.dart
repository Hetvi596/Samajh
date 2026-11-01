import 'dart:convert';

import 'package:drift/drift.dart';

import '../analysis/devanagari_engine.dart';
import 'app_database.dart';

/// Completed checks for six of the fictional children in the sample class,
/// so anyone who installs the app can see results, support groups, practice
/// plans and reports straight away. Every child, mark and answer here is
/// made up. The results are worked out from these made-up marks with the
/// same rules a real check uses (see computeFinalResultAndSave).

/// "सूरज और हवा की शर्त" (p_g3_01 in assets/passages/bank.json).
const _passageId = 'p_g3_01';
const _passageTitle = 'सूरज और हवा की शर्त';
const _passageText = "एक बार सूरज और हवा में बहस छिड़ गई। हवा ने कहा, 'मैं तुमसे अधिक बलवान हूँ।' "
    "सूरज ने मुस्कुराकर कहा, 'देखते हैं।' तभी रास्ते में एक आदमी कोट पहनकर जा रहा था। "
    "हवा ने कहा, 'जो इस आदमी का कोट उतरवा देगा, वही जीतेगा।' हवा तेज़ बहने लगी। "
    "आदमी ने कोट कसकर पकड़ लिया। अब सूरज तपने लगा। गर्मी बढ़ी तो आदमी ने कोट उतार दिया। "
    "हवा ने हार मान ली।";
const _questions = [
  ('q_g3_01_1', 'fact'),
  ('q_g3_01_2', 'word_meaning'),
  ('q_g3_01_3', 'why_how'),
  ('q_g3_01_4', 'main_idea'),
];
const _retellPoints = [
  'सूरज और हवा में बलवान होने पर बहस हुई',
  'रास्ते में एक आदमी कोट पहनकर जा रहा था',
  'कोट उतरवाने की शर्त रखी गई',
  'हवा तेज़ चली तो आदमी ने कोट कस लिया',
  'सूरज तपा तो गर्मी से आदमी ने कोट उतार दिया',
  'हवा ने अपनी हार मान ली',
];

class _SampleCheck {
  final int child; // demo_child_<n>
  final int daysAgo;
  final double seconds;
  final Set<int> misread;
  final Set<int> skipped;
  final int notReachedFrom; // words from here on were not reached
  final List<String> answers; // one per question
  final Set<int> retold;

  const _SampleCheck({
    required this.child,
    required this.daysAgo,
    required this.seconds,
    this.misread = const {},
    this.skipped = const {},
    this.notReachedFrom = 999,
    required this.answers,
    this.retold = const {},
  });
}

const _samples = [
  // Aarav: accurate, fluent, answers everything.
  _SampleCheck(child: 1, daysAgo: 2, seconds: 62, misread: {19, 41}, answers: ['correct', 'correct', 'correct', 'correct'], retold: {0, 1, 3, 4, 5}),
  // Diya: accurate and understands.
  _SampleCheck(child: 2, daysAgo: 3, seconds: 70, misread: {7, 52}, skipped: {60}, answers: ['correct', 'correct', 'partly', 'correct'], retold: {0, 2, 4}),
  // Kabir: understands the story but reads slowly with matra and conjunct errors.
  _SampleCheck(
    child: 3,
    daysAgo: 4,
    seconds: 118,
    misread: {7, 13, 15, 19, 24, 29, 41, 44, 52, 53, 57, 59, 60},
    skipped: {21},
    answers: ['correct', 'correct', 'correct', 'partly'],
    retold: {0, 1, 4},
  ),
  // Ananya: reads fluently but misses the why and main-idea questions.
  _SampleCheck(child: 4, daysAgo: 4, seconds: 58, misread: {19, 44, 57}, answers: ['correct', 'not_correct', 'not_correct', 'no_answer'], retold: {1}),
  // Rohan: needs help with both; stopped before the end.
  _SampleCheck(
    child: 5,
    daysAgo: 5,
    seconds: 125,
    misread: {7, 12, 13, 14, 15, 16, 19, 21, 22, 24, 29, 36, 41, 42, 44, 47, 52, 53},
    skipped: {20, 35, 43},
    notReachedFrom: 55,
    answers: ['partly', 'not_correct', 'no_answer', 'no_answer'],
  ),
  // Meera: accurate, understands most of it.
  _SampleCheck(child: 6, daysAgo: 6, seconds: 74, misread: {15, 41, 53, 60}, answers: ['correct', 'correct', 'correct', 'not_correct'], retold: {0, 3, 5}),
];

Future<void> seedSampleChecks(AppDatabase db, String classId, DateTime now) async {
  final words = _passageText.split(RegExp(r'\s+')).where((w) => w.trim().isNotEmpty).toList();

  for (final s in _samples) {
    final childId = 'demo_child_${s.child}';
    final checkId = 'sample_check_${s.child}';
    final at = now.subtract(Duration(days: s.daysAgo, hours: s.child));

    // Reading: the same counting rules as a real check.
    int correct = 0;
    int attempted = 0;
    final stuck = <String>{};
    final marks = <String>[];
    for (int i = 0; i < words.length; i++) {
      final mark = i >= s.notReachedFrom
          ? 'notReached'
          : s.skipped.contains(i)
              ? 'skipped'
              : s.misread.contains(i)
                  ? 'readAsAnotherWord'
                  : 'correct';
      marks.add(mark);
      if (mark == 'notReached') continue;
      attempted++;
      if (mark == 'correct') {
        correct++;
      } else {
        stuck.add(DevanagariAksharaEngine.formatFeatureLabel(DevanagariAksharaEngine.classifyPrimaryMistake(words[i])));
      }
    }
    final accuracy = correct / attempted;
    final wpm = ((correct / s.seconds) * 60).round();

    // Understanding: correct = full credit, partly = half.
    double earned = 0;
    int points = 0;
    for (final a in s.answers) {
      if (a == 'correct') {
        earned += 1;
        points += 2;
      } else if (a == 'partly') {
        earned += 0.5;
        points += 1;
      }
    }
    final compRatio = earned / _questions.length;

    final meetsDecoding = accuracy >= 0.85 && wpm >= 40;
    final meetsUnderstanding = compRatio >= 0.6 || s.retold.length >= 2;
    final String group;
    final String nextStep;
    if (meetsDecoding && meetsUnderstanding) {
      group = 'On track';
      nextStep = 'Fluency practice, 10 minutes a day with grade-level storybooks';
    } else if (!meetsDecoding && meetsUnderstanding) {
      group = 'Understands, needs help reading words';
      nextStep = 'Decoding practice, 10 minutes a day focusing on aksharas and matras';
    } else if (meetsDecoding && !meetsUnderstanding) {
      group = 'Reads words, needs help understanding';
      nextStep = "Comprehension conversations: pause after each paragraph and ask 'why' and 'how'";
    } else {
      group = 'Needs help with both';
      nextStep = 'Paired reading and decodable word practice, 10 minutes daily';
    }

    await db.into(db.checksTable).insert(
          ChecksTableCompanion.insert(
            id: checkId,
            childId: childId,
            classId: classId,
            scope: 'demo',
            status: 'completed',
            currentStep: 'result',
            passageId: _passageId,
            passageTitle: _passageTitle,
            passageLevel: 3,
            noiseLevel: const Value(0.12),
            benchmarkUsedJson: const Value('NIPUN Lakshya & FLS 2022'),
            rubricVersion: const Value('v0.1 (provisional)'),
            readingDurationSeconds: Value(s.seconds),
            startedAt: at.subtract(const Duration(minutes: 5)),
            completedAt: Value(at),
          ),
        );
    for (int i = 0; i < words.length; i++) {
      await db.into(db.wordMarksTable).insert(
            WordMarksTableCompanion.insert(
              id: 'wm_${checkId}_$i',
              checkId: checkId,
              wordIndex: i,
              expectedWord: words[i],
              mark: marks[i],
            ),
          );
    }
    for (int i = 0; i < _retellPoints.length; i++) {
      await db.into(db.retellPointsTable).insert(
            RetellPointsTableCompanion.insert(
              id: 'retell_${checkId}_$i',
              checkId: checkId,
              pointIndex: i,
              pointText: _retellPoints[i],
              isMentioned: s.retold.contains(i),
            ),
          );
    }
    for (int i = 0; i < _questions.length; i++) {
      await db.into(db.questionAnswersTable).insert(
            QuestionAnswersTableCompanion.insert(
              id: 'qa_${checkId}_$i',
              checkId: checkId,
              questionId: _questions[i].$1,
              questionType: _questions[i].$2,
              answerStatus: s.answers[i],
            ),
          );
    }
    await db.into(db.resultsTable).insert(
          ResultsTableCompanion.insert(
            id: 'result_$checkId',
            checkId: checkId,
            childId: childId,
            scope: 'demo',
            groupAssigned: group,
            groupReason: group == 'On track' ? 'On track: reads with fluency and understanding' : group,
            nextStepRecommendation: nextStep,
            totalWords: words.length,
            attemptedWords: attempted,
            correctWords: correct,
            accuracyPercentage: accuracy,
            readingSpeedWpm: Value(wpm.toDouble()),
            speedHasEvidence: true,
            comprehensionFactScore: '$points comprehension points',
            retellScore: '${s.retold.length} story points',
            dictationScore: 'Skipped',
            stuckOnAksharasJson: Value(jsonEncode(stuck.toList())),
            isLowConfidence: false,
            createdAt: at,
          ),
        );
    await db.into(db.groupAssignmentsTable).insert(
          GroupAssignmentsTableCompanion.insert(
            id: 'group_$checkId',
            childId: childId,
            scope: 'demo',
            fromGroup: 'not_grouped',
            toGroup: group,
            reason: Value('Calculated from check on ${at.day}/${at.month}'),
            movedAt: at,
          ),
        );
  }
}
