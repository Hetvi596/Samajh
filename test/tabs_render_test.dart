import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/app/theme.dart';
import 'package:samajh/core/i18n/generated/app_localizations.dart';
import 'package:samajh/features/practice/practice_tab.dart';
import 'package:samajh/features/reports/reports_tab.dart';

void main() {
  const widths = [320.0, 360.0, 411.0];
  const locales = [Locale('en'), Locale('hi')];

  for (final width in widths) {
    for (final loc in locales) {
      testWidgets('PracticeTab renders with zero overflow at ${width}dp, ${loc.languageCode}', (tester) async {
        tester.view.physicalSize = Size(width, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: SamajhTheme.lightTheme,
              locale: loc,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const PracticeTab(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(PracticeTab), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('ReportsTab renders with zero overflow at ${width}dp, ${loc.languageCode}', (tester) async {
        tester.view.physicalSize = Size(width, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: SamajhTheme.lightTheme,
              locale: loc,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const ReportsTab(),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(ReportsTab), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }
  }
}
