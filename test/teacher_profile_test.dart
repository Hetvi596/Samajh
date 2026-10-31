import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/app/theme.dart';
import 'package:samajh/core/database/app_database.dart';
import 'package:samajh/core/i18n/generated/app_localizations.dart';
import 'package:samajh/core/providers/database_provider.dart';
import 'package:samajh/features/profile/teacher_profile_edit_screen.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(overrides: [appDatabaseProvider.overrideWithValue(db)]);
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  Future<void> open(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: SamajhTheme.lightTheme,
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const TeacherProfileEditScreen(),
        ),
      ),
    );
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pumpAndSettle();
  }

  Finder field(String label) => find.widgetWithText(TextFormField, label);

  testWidgets('saves every detail to the profile on this phone', (tester) async {
    await open(tester);
    await tester.enterText(find.byKey(const Key('profile_name_field')), 'Sunita Meena');
    await tester.enterText(field('What children call you'), 'Sunita ji');
    await tester.tap(find.text('Head teacher'));
    await tester.enterText(field('School name'), 'GPS Kalwar');
    await tester.enterText(field('UDISE code'), '08120300101');
    await tester.enterText(field('District'), 'Jaipur');
    await tester.ensureVisible(find.text('Rajasthan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rajasthan'));
    await tester.enterText(field('Years of teaching'), '12');
    await tester.scrollUntilVisible(field('Mobile number'), 200, scrollable: find.byType(Scrollable).first);
    await tester.enterText(field('Mobile number'), '9876543210');
    await tester.pump();
    await tester.tap(find.byKey(const Key('profile_save_button')));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pumpAndSettle();

    final p = (await tester.runAsync(db.getTeacherProfile))!;
    expect(p.teacherName, 'Sunita Meena');
    expect(p.displayName, 'Sunita ji');
    expect(p.role, 'head_teacher');
    expect(p.udiseCode, '08120300101');
    expect(p.district, 'Jaipur');
    expect(p.state, 'rajasthan');
    expect(p.yearsTeaching, 12);
    expect(p.phone, '9876543210');
    expect(p.email, isNull, reason: 'left empty');
  });

  testWidgets('a wrong UDISE code or phone number is caught before saving', (tester) async {
    await open(tester);
    await tester.enterText(find.byKey(const Key('profile_name_field')), 'Sunita Meena');
    await tester.enterText(field('UDISE code'), '1234');
    await tester.scrollUntilVisible(field('Mobile number'), 200, scrollable: find.byType(Scrollable).first);
    await tester.enterText(field('Mobile number'), '12345');
    await tester.tap(find.byKey(const Key('profile_save_button')));
    await tester.pumpAndSettle();

    expect(find.text('A UDISE code has 11 digits'), findsOneWidget);
    expect(find.text('Enter a 10-digit mobile number'), findsOneWidget);
    final p = await tester.runAsync(db.getTeacherProfile);
    expect(p?.udiseCode, isNull, reason: 'nothing saved');
  });

  testWidgets('the name is required', (tester) async {
    await open(tester);
    await tester.enterText(find.byKey(const Key('profile_name_field')), '');
    await tester.tap(find.byKey(const Key('profile_save_button')));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your name'), findsOneWidget);
  });
}
