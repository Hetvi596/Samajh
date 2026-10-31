import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/app/theme.dart';
import 'package:samajh/core/analysis/self_rating.dart';
import 'package:samajh/core/analysis/word_check_scoring_engine.dart';
import 'package:samajh/core/i18n/generated/app_localizations.dart';
import 'package:samajh/features/check_flow/check_flow_controller.dart';
import 'package:samajh/features/check_flow/check_flow_page.dart';
import 'package:samajh/features/check_flow/reading_self_rating_step_view.dart';
import 'package:samajh/features/check_flow/typing_check_step_view.dart';
import 'package:samajh/features/check_flow/widgets/notebook_line_word_painter.dart';
import 'package:samajh/features/check_flow/word_check_step_view.dart';

Widget _app(ProviderContainer container, Widget child, {Locale locale = const Locale('hi')}) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: SamajhTheme.lightTheme,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: child,
    ),
  );
}

CheckSessionState _session(CheckStep step, {Map<String, dynamic> passage = const {'id': 'p1'}}) => CheckSessionState(
      checkId: 'check_levels_01',
      childId: 'child_levels_01',
      childName: 'Asha K.',
      currentStep: step,
      passage: passage,
      passageWords: const ['कमल', 'मटर'],
      wordMarks: const {},
      wordObservations: const {},
      retellPointsTicked: const {},
      questionAnswers: const {},
      dictationMarks: const {},
    );

const _typingThresholds = {
  'weighted_marking': {
    'level_weights': {'1': 1, '2': 2, '3': 3},
    'time_decay_end_multiple': 3.0,
    'time_decay_floor': 0.5,
  },
  'typing_levels': {
    '1': {'items': 3, 'min_items': 3, 'promotion_threshold': 0.66, 'expected_time_ms': 20000},
    '2': {'items': 3, 'min_items': 3, 'promotion_threshold': 0.66, 'expected_time_ms': 30000},
    '3': {'items': 3, 'min_items': 3, 'promotion_threshold': 0.66, 'expected_time_ms': 40000},
  },
};

/// Fails with the sizes of the row that overflowed, which the plain
/// overflow error does not name.
void expectNoOverflow(WidgetTester tester, String where) {
  final error = tester.takeException();
  if (error == null) return;
  final rows = <String>[];
  for (final flex in tester.allRenderObjects.whereType<RenderFlex>()) {
    if (!flex.hasSize) continue;
    final horizontal = flex.direction == Axis.horizontal;
    var used = 0.0;
    final parts = <String>[];
    flex.visitChildren((c) {
      final size = (c as RenderBox).size;
      used += horizontal ? size.width : size.height;
      parts.add((horizontal ? size.width : size.height).toStringAsFixed(0));
    });
    final room = horizontal ? flex.size.width : flex.size.height;
    if (used > room + 0.5) rows.add('${horizontal ? 'Row' : 'Column'} ${room.toStringAsFixed(0)} < $parts');
  }
  fail('$where: $error ${rows.join('; ')}');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Picture questions for writing on the line and letter formation', () {
    testWidgets('every drawing style paints for Hindi and English words', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      for (final word in ['कमल', 'bed']) {
        await tester.pumpWidget(_app(
          container,
          Scaffold(
            body: ListView(children: [
              for (final style in WritingPositionStyle.values)
                RuledNotebookChoiceCard(word: word, positionStyle: style, isSelected: false, onTap: () {}),
            ]),
          ),
        ));
        await tester.pump();
        expect(tester.takeException(), isNull);
      }
    });

    test('bank styles parse, each picture item has one right answer and named mistakes', () {
      final bank = jsonDecode(File('assets/practice/word_check_bank.json').readAsStringSync()) as Map<String, dynamic>;
      var letterFormation = 0;
      for (final lang in ['hindi', 'english']) {
        for (final entry in (bank[lang] as Map<String, dynamic>).entries) {
          for (final raw in entry.value as List<dynamic>) {
            final item = WordCheckItem.fromJson(raw as Map<String, dynamic>);
            expect(item.options.where((o) => o.isCorrect).length, 1, reason: item.id);
            if (!isPictureWritingItem(item.type)) continue;
            if (item.type == 'letter_formation') letterFormation++;
            expect(item.options.length, 4, reason: item.id);
            for (final o in item.options) {
              expect(o.positionStyle, isNotNull, reason: '${item.id} ${o.id}');
              if (!o.isCorrect) {
                expect(WordCheckScoringEngine.formatDistractorTag(o.distractorTag!), isNot(contains('_')),
                    reason: '${item.id} tag ${o.distractorTag} has a teacher label');
              }
            }
            if (lang == 'english') {
              expect(item.options.any((o) => o.positionStyle == WritingPositionStyle.missingShirorekha), isFalse,
                  reason: 'English has no top line');
            }
          }
        }
      }
      expect(letterFormation, greaterThanOrEqualTo(8));
    });

    test('item selection covers different types and always includes a picture item', () {
      final items = [
        for (var i = 0; i < 6; i++)
          WordCheckItem(id: 'f$i', level: 3, type: 'fill_blank', promptAudioText: '', promptLabel: '', options: const []),
        const WordCheckItem(id: 'w1', level: 3, type: 'letter_formation', promptAudioText: '', promptLabel: '', options: []),
        const WordCheckItem(id: 'o1', level: 3, type: 'odd_one_out', promptAudioText: '', promptLabel: '', options: []),
      ];
      for (var run = 0; run < 20; run++) {
        final picked = selectWordCheckItems(items, 4);
        expect(picked.length, 4);
        expect(picked.map((i) => i.type), containsAll(['letter_formation', 'odd_one_out', 'fill_blank']));
        expect(picked.map((i) => i.id).toSet().length, 4, reason: 'no repeats');
      }
    });
  });

  group('Child thumbs up / down', () {
    testWidgets('at the end of Student Mode, Next waits for one rating, then well done', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(checkFlowControllerProvider.notifier);
      notifier.state = _session(CheckStep.readingSelfRating);

      await tester.pumpWidget(_app(container, ReadingSelfRatingStepView(session: notifier.state!)));
      await tester.pump();
      final next = find.byKey(const Key('reading_self_rating_next'));
      expect(tester.widget<ElevatedButton>(next).onPressed, isNull);

      await tester.tap(find.byKey(const Key('self_rating_thumbs_down')));
      await tester.pump();
      await tester.tap(next);
      await tester.pump();

      expect(notifier.state!.readingSelfRating, SelfRating.thumbsDown);
      expect(notifier.state!.currentStep, CheckStep.shabaash);
    });
  });

  group('Typing check: levels and ratings', () {
    Future<void> typeWord(WidgetTester tester, List<String> keys, SelfRating rating) async {
      for (final k in keys) {
        await tester.tap(find.byKey(Key('typing_key_$k')));
        await tester.pump();
      }
      await tester.tap(find.byKey(const Key('typing_next'))); // Done
      await tester.pump();
      expect(find.byKey(const Key('self_rating_thumbs_up')), findsNothing, reason: 'no rating per word');
      await tester.tap(find.byKey(const Key('typing_next'))); // Next
      await tester.pump();
    }

    testWidgets('passing Level 1 opens Level 2; failing Level 2 ends the typing check', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.reset);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(checkFlowControllerProvider.notifier);
      notifier.state = _session(CheckStep.typingCheck);

      const bank = TypingBank({
        1: ['घर', 'घर', 'घर'],
        2: ['जल', 'जल', 'जल'],
        3: ['बस', 'बस', 'बस'],
      });
      await tester.pumpWidget(_app(
        container,
        TypingCheckStepView(session: notifier.state!, bank: bank, thresholds: _typingThresholds),
      ));
      await tester.pump();
      expect(find.textContaining('स्तर 1'), findsOneWidget);

      for (var i = 0; i < 3; i++) {
        await typeWord(tester, ['घ', 'र'], SelfRating.thumbsUp);
      }
      expect(find.textContaining('स्तर 2'), findsOneWidget, reason: 'Level 1 passed');

      // Level 2: the child types the wrong word each time but feels good.
      for (var i = 0; i < 3; i++) {
        await typeWord(tester, ['ज'], SelfRating.thumbsUp);
      }
      await tester.pumpAndSettle();

      final s = notifier.state!;
      expect(s.currentStep, CheckStep.readingSelfRating, reason: 'one rating at the end');
      expect(s.typingChoices.length, 6, reason: 'Level 3 never shown');
      expect(s.typingChoices.every((c) => c.type == 'typed_spelling'), isTrue);
      expect(s.typingChoices.first.firstChoice, 'घर');
      expect(s.typingChoices.last.finalChoice, 'ज');
      expect(s.typingChoices.last.chosenDistractorTag, 'missing_letter');
      expect(s.typingSummary!.highestLevelReached, 1);
      expect(s.typingSummary!.stoppedAtLevel, 2);
      expect(s.typingSummary!.selfRatings.rated, 0);
    });

    testWidgets('Not sure skips without a rating', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.reset);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(checkFlowControllerProvider.notifier);
      notifier.state = _session(CheckStep.typingCheck);
      await tester.pumpWidget(_app(
        container,
        TypingCheckStepView(
          session: notifier.state!,
          bank: const TypingBank({1: ['घर', 'घर', 'घर']}),
          thresholds: _typingThresholds,
        ),
      ));
      await tester.pump();
      for (var i = 0; i < 3; i++) {
        await tester.tap(find.byKey(const Key('typing_not_sure')));
        await tester.pump();
      }
      await tester.pumpAndSettle();
      final s = notifier.state!;
      expect(s.currentStep, CheckStep.readingSelfRating);
      expect(s.typingChoices.every((c) => c.isSkipped && c.selfRating == SelfRating.notGiven), isTrue);
      expect(s.typingSummary!.highestLevelReached, 0);
    });
  });

  group('Child screens fit a small phone (320 x 568 dp)', () {
    for (final hindi in [true, false]) {
      testWidgets('typing, reading rating and word check with rating row, ${hindi ? 'hi' : 'en'}', (tester) async {
        tester.view.physicalSize = const Size(640, 1136);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.reset);
        final container = ProviderContainer();
        addTearDown(container.dispose);
        final base = _session(CheckStep.typingCheck);
        final session = CheckSessionState(
          checkId: base.checkId,
          childId: base.childId,
          childName: base.childName,
          currentStep: base.currentStep,
          passage: base.passage,
          passageWords: hindi ? const ['कमल'] : const ['lotus'],
          wordMarks: const {},
          wordObservations: const {},
          retellPointsTicked: const {},
          questionAnswers: const {},
          dictationMarks: const {},
        );
        container.read(checkFlowControllerProvider.notifier).state = session;
        final bank = hindi ? TypingBank.fallbackHindi : TypingBank.fallbackEnglish;

        await tester.pumpWidget(_app(container, TypingCheckStepView(session: session, bank: bank, thresholds: _typingThresholds)));
        await tester.pump();
        expectNoOverflow(tester, 'typing keypad');
        await tester.tap(find.byKey(Key('typing_key_${hindi ? 'क' : 'c'}')));
        await tester.pump();
        await tester.tap(find.byKey(const Key('typing_next')));
        await tester.pump();
        expectNoOverflow(tester, 'typing rating panel');

        await tester.pumpWidget(_app(container, ReadingSelfRatingStepView(session: session)));
        await tester.pump();
        expectNoOverflow(tester, 'reading rating');

        await tester.pumpWidget(_app(container, WordCheckStepView(session: session)));
        await tester.pumpAndSettle();
        final firstOption = find.byType(InkWell).at(1);
        await tester.tap(firstOption, warnIfMissed: false);
        await tester.pump();
        expectNoOverflow(tester, 'word check with thumbs row');
      });
    }
  });

  group('Teacher questions by level', () {
    const passage = {
      'id': 'p_levels',
      'questions': [
        {'id': 'q1', 'type': 'fact', 'question_hi': 'कौन गया?', 'expected_answer_hi': 'राम'},
        {'id': 'q2', 'type': 'word_meaning', 'question_hi': 'मेला क्या है?', 'expected_answer_hi': 'उत्सव'},
        {'id': 'q3', 'type': 'why_how', 'question_hi': 'वह क्यों गया?', 'expected_answer_hi': 'खुशी'},
      ],
    };

    testWidgets('only Level 1 shows first; a wrong Level 1 answer stops the questions', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.reset);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(checkFlowControllerProvider.notifier);
      notifier.state = _session(CheckStep.questions, passage: passage);

      await tester.pumpWidget(_app(container, CheckFlowPage(childId: notifier.state!.childId)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byKey(const Key('question_card_q1')), findsOneWidget);
      expect(find.byKey(const Key('question_card_q2')), findsNothing);
      final seeResult = find.byKey(const Key('questions_see_result'));
      expect(tester.widget<ElevatedButton>(seeResult).onPressed, isNull, reason: 'no default answer any more');

      final l10n = AppLocalizations.of(tester.element(seeResult))!;
      await tester.tap(find.text(l10n.answerCorrect));
      await tester.pump();
      expect(find.byKey(const Key('question_card_q2')), findsOneWidget, reason: 'Level 1 passed, Level 2 opens');
      expect(find.byKey(const Key('self_rating_thumbs_up')), findsNothing, reason: 'no rating per question');

      // Change q1 to wrong: Level 2 closes again and the stop note shows.
      await tester.tap(find.text(l10n.answerNotCorrect).first);
      await tester.pump();
      expect(find.byKey(const Key('question_card_q2')), findsNothing);
      expect(find.text(l10n.questionsStoppedAt(1)), findsOneWidget);
      expect(tester.widget<ElevatedButton>(seeResult).onPressed, isNotNull);
    });
  });
}
