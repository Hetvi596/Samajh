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

void main() {
  const testWidths = [320.0, 360.0, 411.0];
  const testTextScales = [1.0, 1.3, 2.0];
  const testLocales = [Locale('en'), Locale('hi')];

  Widget buildTestWidget({
    required Widget child,
    required double width,
    required double textScale,
    required Locale locale,
  }) {
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
        home: MediaQuery(
          data: MediaQueryData(
            size: Size(width, 800),
            textScaler: TextScaler.linear(textScale),
          ),
          child: SizedBox(
            width: width,
            height: 800,
            child: child,
          ),
        ),
      ),
    );
  }

  group('Layout Robustness Tests across screen widths and text scales', () {
    for (final width in testWidths) {
      for (final scale in testTextScales) {
        for (final loc in testLocales) {
          testWidgets(
            'WelcomeScreen renders with no overflow at ${width}dp, textScale $scale, ${loc.languageCode}',
            (tester) async {
              tester.view.physicalSize = Size(width, 800);
              tester.view.devicePixelRatio = 1.0;
              addTearDown(tester.view.resetPhysicalSize);

              await tester.pumpWidget(
                buildTestWidget(
                  child: const WelcomeScreen(),
                  width: width,
                  textScale: scale,
                  locale: loc,
                ),
              );
              await tester.pumpAndSettle();

              expect(tester.takeException(), isNull);
            },
          );

          testWidgets(
            'PrivacyPromiseScreen renders with no overflow at ${width}dp, textScale $scale, ${loc.languageCode}',
            (tester) async {
              tester.view.physicalSize = Size(width, 800);
              tester.view.devicePixelRatio = 1.0;
              addTearDown(tester.view.resetPhysicalSize);

              await tester.pumpWidget(
                buildTestWidget(
                  child: const PrivacyPromiseScreen(),
                  width: width,
                  textScale: scale,
                  locale: loc,
                ),
              );
              await tester.pumpAndSettle();

              expect(tester.takeException(), isNull);
            },
          );

          testWidgets(
            'PasscodeSetupScreen renders with no overflow at ${width}dp, textScale $scale, ${loc.languageCode}',
            (tester) async {
              tester.view.physicalSize = Size(width, 800);
              tester.view.devicePixelRatio = 1.0;
              addTearDown(tester.view.resetPhysicalSize);

              await tester.pumpWidget(
                buildTestWidget(
                  child: const PasscodeSetupScreen(),
                  width: width,
                  textScale: scale,
                  locale: loc,
                ),
              );
              await tester.pumpAndSettle();

              expect(tester.takeException(), isNull);
            },
          );

          testWidgets(
            'UnlockScreen renders with no overflow at ${width}dp, textScale $scale, ${loc.languageCode}',
            (tester) async {
              tester.view.physicalSize = Size(width, 800);
              tester.view.devicePixelRatio = 1.0;
              addTearDown(tester.view.resetPhysicalSize);

              await tester.pumpWidget(
                buildTestWidget(
                  child: const UnlockScreen(),
                  width: width,
                  textScale: scale,
                  locale: loc,
                ),
              );
              await tester.pumpAndSettle();

              expect(tester.takeException(), isNull);
            },
          );
        }
      }
    }
  });
}
