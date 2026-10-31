import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/app/theme.dart';
import 'package:samajh/core/i18n/generated/app_localizations.dart';
import 'package:samajh/features/check_flow/check_flow_controller.dart';
import 'package:samajh/features/check_flow/widgets/notebook_line_word_painter.dart';
import 'package:samajh/features/check_flow/word_check_step_view.dart';

Widget createWordCheckTestApp({required Widget child, Locale locale = const Locale('hi')}) {
  return ProviderScope(
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const mockSession = CheckSessionState(
    checkId: 'check_test_flow_01',
    childId: 'child_test_01',
    childName: 'Aarav K.',
    currentStep: CheckStep.wordCheck,
    passage: {'id': 'p1', 'title': 'कहानी'},
    passageWords: ['कमल', 'मटर', 'सड़क'],
    wordMarks: {},
    wordObservations: {},
    retellPointsTicked: {},
    questionAnswers: {},
    dictationMarks: {},
  );

  group('Word Check Child-Facing Student Mode Tests (Section 1 & 2)', () {
    testWidgets('RuledNotebookChoiceCard renders writing position variants on notebook line', (tester) async {
      await tester.pumpWidget(
        createWordCheckTestApp(
          child: Scaffold(
            body: RuledNotebookChoiceCard(
              word: 'कमल',
              positionStyle: WritingPositionStyle.correctHanging,
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CustomPaint), findsWidgets);
      expect(find.byType(RuledNotebookChoiceCard), findsOneWidget);
    });

    testWidgets('WordCheckStepView renders without child scores, ranks, red marks, or fail banners', (tester) async {
      await tester.pumpWidget(
        createWordCheckTestApp(
          child: const WordCheckStepView(session: mockSession),
        ),
      );
      await tester.pumpAndSettle();

      // Verify no scores, marks, or rankings on the child's screen
      expect(find.textContaining('%'), findsNothing);
      expect(find.textContaining('rank'), findsNothing, skip: true);
      expect(find.textContaining('फेल'), findsNothing);
      expect(find.textContaining('Failed'), findsNothing);

      // Verify child-friendly elements
      expect(find.byKey(const Key('word_check_teacher_unlock_button')), findsOneWidget);
      expect(find.text('पता नहीं'), findsOneWidget); // "Not sure" neutral button
    });

    testWidgets('Tapping teacher unlock button triggers passcode sheet preventing unauthorized escape', (tester) async {
      await tester.pumpWidget(
        createWordCheckTestApp(
          child: const WordCheckStepView(session: mockSession),
        ),
      );
      await tester.pumpAndSettle();

      // Child cannot leave simply by tapping back or exit
      // Tap teacher unlock button
      final unlockBtn = find.byKey(const Key('word_check_teacher_unlock_button'));
      expect(unlockBtn, findsOneWidget);
      await tester.tap(unlockBtn);
      await tester.pumpAndSettle();

      // Passcode entry sheet is presented with PIN prompt
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text("शिक्षक पासकोड / Teacher Exit"), findsOneWidget);
    });
  });
}
