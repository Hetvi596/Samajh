import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samajh/main.dart';

void main() {
  testWidgets('SamajhApp launches into Welcome Screen with Hindi default', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: SamajhApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Welcome Screen elements in default Hindi
    expect(find.text('समझ'), findsWidgets);
    expect(find.byKey(const Key('welcome_continue_button')), findsOneWidget);
    expect(find.text('शुरू करें'), findsOneWidget);

    // Switch language to English
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Verify UI dynamically changed to English
    expect(find.textContaining('Samajh'), findsWidgets);
    expect(find.text('Get started'), findsOneWidget);
  });
}
