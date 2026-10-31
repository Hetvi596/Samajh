import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/app/theme.dart';
import 'package:samajh/core/i18n/generated/app_localizations.dart';
import 'package:samajh/features/setup/welcome_screen.dart';
import 'package:samajh/features/setup/privacy_promise_screen.dart';
import 'package:samajh/features/setup/passcode_setup_screen.dart';
import 'package:samajh/features/setup/unlock_screen.dart';
import 'package:samajh/features/setup/class_setup_screen.dart';
import 'package:samajh/features/student_mode/kiran_mascot.dart';

Widget createTestApp({Widget? child, Locale locale = const Locale('en')}) {
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
  group('Onboarding, Privacy Promise & Passcode Tests', () {
    testWidgets('Welcome screen renders with branding and language selection', (tester) async {
      await tester.pumpWidget(createTestApp(child: const WelcomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Samajh समझ'), findsWidgets);
      expect(find.text('Get started'), findsOneWidget);
      expect(find.byKey(const Key('welcome_continue_button')), findsOneWidget);
      expect(find.text('हिंदी'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('Privacy Promise screen displays all 4 core offline commitments and requires consent', (tester) async {
      await tester.pumpWidget(createTestApp(child: const PrivacyPromiseScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Privacy'), findsOneWidget);
      expect(find.text('Everything is stored on this phone, encrypted'), findsOneWidget);
      expect(find.text('Recordings deleted after checking'), findsOneWidget);
      expect(find.text('Minimal information needed'), findsOneWidget);
      expect(find.text('Your classroom, 100% offline'), findsOneWidget);
      expect(find.byKey(const Key('privacy_accept_button')), findsOneWidget);

      // Verify continue button is initially disabled
      final buttonBefore = tester.widget<ElevatedButton>(find.byKey(const Key('privacy_accept_button')));
      expect(buttonBefore.onPressed, isNull);

      // Scroll down so checkboxes are built and visible
      await tester.drag(find.byType(ListView), const Offset(0, -350));
      await tester.pumpAndSettle();

      // Tick storage consent
      expect(find.byKey(const Key('consent_storage_checkbox')), findsOneWidget);
      await tester.tap(find.byKey(const Key('consent_storage_checkbox')));
      await tester.pumpAndSettle();
      expect(tester.widget<ElevatedButton>(find.byKey(const Key('privacy_accept_button'))).onPressed, isNull);

      // Tick audio consent
      expect(find.byKey(const Key('consent_audio_checkbox')), findsOneWidget);
      await tester.tap(find.byKey(const Key('consent_audio_checkbox')));
      await tester.pumpAndSettle();

      // Now continue button should be enabled
      final buttonAfter = tester.widget<ElevatedButton>(find.byKey(const Key('privacy_accept_button')));
      expect(buttonAfter.onPressed, isNotNull);
    });

    testWidgets('Passcode setup handles 6-digit entry and confirmation', (tester) async {
      await tester.pumpWidget(createTestApp(child: const PasscodeSetupScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Create Teacher Passcode'), findsOneWidget);

      // Enter 6 digits: 1 2 3 4 5 6
      for (final d in ['1', '2', '3', '4', '5', '6']) {
        await tester.tap(find.byKey(Key('digit_button_$d')));
        await tester.pumpAndSettle();
      }

      // Screen should prompt for confirmation
      expect(find.text('Enter it again'), findsOneWidget);

      // Enter wrong 6th digit to test mismatch: 1 2 3 4 5 9
      for (final d in ['1', '2', '3', '4', '5', '9']) {
        await tester.tap(find.byKey(Key('digit_button_$d')));
        await tester.pumpAndSettle();
      }

      expect(find.text('Passcodes do not match. Please try again.'), findsOneWidget);
    });

    testWidgets('Kiran mascot renders smoothly with smiling sun geometry', (tester) async {
      await tester.pumpWidget(
        createTestApp(
          child: const Scaffold(
            body: Center(
              child: KiranMascot(
                size: 140,
                spokenText: "नमस्ते! कहानी आराम से पढ़ो।",
                animated: false,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(KiranMascot), findsOneWidget);
      expect(find.text("नमस्ते! कहानी आराम से पढ़ो।"), findsOneWidget);
    });

    testWidgets('Unlock screen renders mascot, title, prompt, and responds to keypad entry', (tester) async {
      await tester.pumpWidget(createTestApp(child: const UnlockScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Samajh समझ'), findsOneWidget);
      expect(find.text('Enter passcode to unlock'), findsOneWidget);
      expect(find.byKey(const Key('digit_button_1')), findsOneWidget);

      // Enter digits
      for (final d in ['1', '2', '3']) {
        await tester.tap(find.byKey(Key('digit_button_$d')));
        await tester.pumpAndSettle();
      }

      // Tap delete
      await tester.tap(find.byKey(const Key('keypad_delete_button')));
      await tester.pumpAndSettle();

      // Enter 4 more digits to reach 6 digits: 4, 5, 6, 7
      for (final d in ['4', '5', '6', '7']) {
        await tester.tap(find.byKey(Key('digit_button_$d')));
        await tester.pumpAndSettle();
      }

      // Since mock DB has no hash or mismatch, it verifies or resets gracefully
      expect(tester.takeException(), isNull);
    });

    testWidgets('ClassSetupScreen displays all grade chips, section chips, board dropdown, and create button', (tester) async {
      await tester.pumpWidget(createTestApp(child: const ClassSetupScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Set Up Your Class'), findsOneWidget);
      expect(find.text('Grade / Class'), findsOneWidget);
      expect(find.text('Section'), findsOneWidget);
      expect(find.text('Board / Curriculum'), findsOneWidget);
      expect(find.text('Medium of instruction'), findsOneWidget);

      // Verify 5 grade chips (1 to 5)
      for (int g = 1; g <= 5; g++) {
        expect(find.byKey(Key('grade_chip_$g')), findsOneWidget);
      }

      // Verify section chips (A, B, C, D)
      for (final sec in ['A', 'B', 'C', 'D']) {
        expect(find.byKey(Key('section_chip_$sec')), findsOneWidget);
      }

      // Tap Grade 4 and Section B
      await tester.tap(find.byKey(const Key('grade_chip_4')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('section_chip_B')));
      await tester.pumpAndSettle();

      // Create button is present (drag to scroll down)
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('create_class_button')), findsOneWidget);
    });
  });
}
