import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/app/theme.dart';
import 'package:samajh/core/database/app_database.dart';
import 'package:samajh/core/i18n/generated/app_localizations.dart';
import 'package:samajh/core/providers/database_provider.dart';
import 'package:samajh/features/check_flow/check_flow_controller.dart';
import 'package:samajh/features/check_flow/check_flow_page.dart';

const testPassage = {
  'id': 'p_decouple_test',
  'title_hi': 'बड़ा पेड़',
  'title_en': 'The Big Tree',
  'text_hi': 'एक बड़ा पेड़ था। उस पर एक चिड़िया रहती थी।',
  'text_en': 'There was a big tree. A bird lived on it.',
  'retell_points': ['पेड़ बड़ा था', 'उस पर चिड़िया थी'],
  'retell_points_en': ['The tree was big', 'A bird was on it'],
  'questions': [
    {
      'id': 'q1',
      'type': 'fact',
      'question_hi': 'पेड़ पर कौन रहता था?',
      'question_en': 'Who lived on the tree?',
      'expected_answer_hi': 'चिड़िया',
      'expected_answer_en': 'A bird',
    }
  ],
};

Widget createTestCheckFlowApp({
  required ProviderContainer container,
  required Locale appLocale,
  String childId = 'child_1',
}) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      theme: SamajhTheme.lightTheme,
      locale: appLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: CheckFlowPage(childId: childId),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Child Language Decoupling Tests (Requirement 7)', () {
    testWidgets(
        'English App + Hindi Class: Student Mode, questions, answers, and retell points are in Hindi',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          appLanguageProvider.overrideWith((ref) => const Locale('en')),
          readingLanguageProvider.overrideWith((ref) => 'hi'),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(checkFlowControllerProvider.notifier);

      // 1. Student Reading Screen
      controller.state = const CheckSessionState(
        checkId: 'check_lang_1',
        childId: 'child_1',
        childName: 'Aarav',
        currentStep: CheckStep.studentReading,
        passage: testPassage,
        passageWords: ['एक', 'बड़ा', 'पेड़', 'था।'],
        wordMarks: {},
        wordObservations: {},
        retellPointsTicked: {},
        questionAnswers: {},
        dictationMarks: {},
        markWithoutRecording: true,
      );

      await tester.pumpWidget(createTestCheckFlowApp(
        container: container,
        appLocale: const Locale('en'),
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Passage text and button must be Hindi
      expect(find.text('एक बड़ा पेड़ था। उस पर एक चिड़िया रहती थी।'), findsOneWidget);
      expect(find.text('मैंने पढ़ लिया'), findsOneWidget);
      expect(find.text('I have finished'), findsNothing);
      expect(find.text('कहानी बोलकर पढ़ो। आराम से।'), findsOneWidget);

      // 2. Shabaash Screen (Well done transition)
      controller.state = controller.state!.copyWith(currentStep: CheckStep.shabaash);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('शाबाश!'), findsAtLeastNWidgets(1));
      expect(find.text('अब यह फोन शिक्षक जी को वापस दे दीजिए।'), findsOneWidget);
      expect(find.text('Well done!'), findsNothing);

      // 3. Retell Screen (Teacher marks, but points are Hindi)
      controller.state = controller.state!.copyWith(currentStep: CheckStep.retell);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('पेड़ बड़ा था'), findsOneWidget);
      expect(find.text('उस पर चिड़िया थी'), findsOneWidget);
      expect(find.text('The tree was big'), findsNothing);

      // 4. Questions Screen (Teacher UI in English, but child questions/answers in Hindi)
      controller.state = controller.state!.copyWith(currentStep: CheckStep.questions);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('पेड़ पर कौन रहता था?'), findsOneWidget);
      expect(find.text('Who lived on the tree?'), findsNothing);
      expect(find.textContaining('चिड़िया'), findsOneWidget);
      expect(find.textContaining('A bird'), findsNothing);
    });

    testWidgets(
        'Hindi App + English Class: Student Mode, questions, answers, and retell points are in English',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          appLanguageProvider.overrideWith((ref) => const Locale('hi')),
          readingLanguageProvider.overrideWith((ref) => 'en'),
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(checkFlowControllerProvider.notifier);

      // 1. Student Reading Screen
      controller.state = const CheckSessionState(
        checkId: 'check_lang_2',
        childId: 'child_2',
        childName: 'Pooja',
        currentStep: CheckStep.studentReading,
        passage: testPassage,
        passageWords: ['There', 'was', 'a', 'tree.'],
        wordMarks: {},
        wordObservations: {},
        retellPointsTicked: {},
        questionAnswers: {},
        dictationMarks: {},
        markWithoutRecording: true,
      );

      await tester.pumpWidget(createTestCheckFlowApp(
        container: container,
        appLocale: const Locale('hi'),
        childId: 'child_2',
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Passage text and button must be English
      expect(find.text('There was a big tree. A bird lived on it.'), findsOneWidget);
      expect(find.text('I have finished'), findsOneWidget);
      expect(find.text('मैंने पढ़ लिया'), findsNothing);
      expect(find.text('Read this story aloud. Take your time.'), findsOneWidget);

      // 2. Shabaash Screen (Well done transition)
      controller.state = controller.state!.copyWith(currentStep: CheckStep.shabaash);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Well done!'), findsAtLeastNWidgets(1));
      expect(find.text('Now hand the phone back to the teacher.'), findsOneWidget);
      expect(find.text('शाबाश!'), findsNothing);

      // 3. Retell Screen (Teacher marks, but points are English)
      controller.state = controller.state!.copyWith(currentStep: CheckStep.retell);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('The tree was big'), findsOneWidget);
      expect(find.text('A bird was on it'), findsOneWidget);
      expect(find.text('पेड़ बड़ा था'), findsNothing);

      // 4. Questions Screen (Teacher UI in Hindi, but child questions/answers in English)
      controller.state = controller.state!.copyWith(currentStep: CheckStep.questions);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Who lived on the tree?'), findsOneWidget);
      expect(find.text('पेड़ पर कौन रहता था?'), findsNothing);
      expect(find.textContaining('A bird'), findsOneWidget);
      expect(find.textContaining('चिड़िया'), findsNothing);
    });

    testWidgets(
        'Passage in Hindi guarantees retell checklist and questions are in Hindi',
        (tester) async {
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          appLanguageProvider.overrideWith((ref) => const Locale('en')),
          readingLanguageProvider.overrideWith((ref) => 'en'), // Even if readingLanguage was 'en'
        ],
      );
      addTearDown(container.dispose);

      final controller = container.read(checkFlowControllerProvider.notifier);

      // Child has Hindi passage words
      controller.state = const CheckSessionState(
        checkId: 'check_passage_hi',
        childId: 'child_1',
        childName: 'Aarav',
        currentStep: CheckStep.retell,
        passage: testPassage,
        passageWords: ['एक', 'बड़ा', 'पेड़', 'था।'],
        passageLanguage: 'hi',
        wordMarks: {},
        wordObservations: {},
        retellPointsTicked: {},
        questionAnswers: {},
        dictationMarks: {},
        markWithoutRecording: true,
      );

      await tester.pumpWidget(createTestCheckFlowApp(
        container: container,
        appLocale: const Locale('en'),
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Retell checklist must be Hindi because passage is Hindi
      expect(find.text('पेड़ बड़ा था'), findsOneWidget);
      expect(find.text('The tree was big'), findsNothing);

      // Questions screen must be Hindi because passage is Hindi
      controller.state = controller.state!.copyWith(currentStep: CheckStep.questions);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('पेड़ पर कौन रहता था?'), findsOneWidget);
      expect(find.text('Who lived on the tree?'), findsNothing);
      expect(find.textContaining('चिड़िया'), findsOneWidget);
      expect(find.textContaining('A bird'), findsNothing);
    });
  });
}
