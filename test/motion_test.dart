import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samajh/app/motion.dart';

Widget _host(Widget child, {bool reduced = false}) => MaterialApp(
  home: MediaQuery(
    data: MediaQueryData(disableAnimations: reduced),
    child: Scaffold(body: child),
  ),
);

int _confettiPaints(WidgetTester tester) => find
    .descendant(of: find.byType(ConfettiBurst), matching: find.byType(CustomPaint))
    .evaluate()
    .where((e) => (e.widget as CustomPaint).painter != null)
    .length;

void main() {
  testWidgets('confetti plays once, then clears', (tester) async {
    await tester.pumpWidget(_host(const ConfettiBurst(child: Text('Done'))));
    await tester.pump(const Duration(milliseconds: 400));
    expect(_confettiPaints(tester), 1);
    await tester.pumpAndSettle();
    expect(_confettiPaints(tester), 0);
    expect(find.text('Done'), findsOneWidget);
  });

  testWidgets('no confetti when the phone asks for less motion', (tester) async {
    await tester.pumpWidget(_host(const ConfettiBurst(child: Text('Done')), reduced: true));
    await tester.pump(const Duration(milliseconds: 400));
    expect(_confettiPaints(tester), 0);
  });

  testWidgets('count-up lands on the real number', (tester) async {
    await tester.pumpWidget(_host(const CountUpText(42)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('42'), findsNothing);
    await tester.pumpAndSettle();
    expect(find.text('42'), findsOneWidget);
  });

  testWidgets('count-up shows the number straight away without motion', (tester) async {
    await tester.pumpWidget(_host(const CountUpText(7), reduced: true));
    expect(find.text('7'), findsOneWidget);
  });

  testWidgets('entrance fade ends fully visible and in place', (tester) async {
    await tester.pumpWidget(_host(const EntranceFade(index: 3, child: Text('Card'))));
    await tester.pumpAndSettle();
    final opacity = tester.widget<Opacity>(find.ancestor(of: find.text('Card'), matching: find.byType(Opacity)));
    expect(opacity.opacity, 1);
  });

  testWidgets('progress bar grows to its value', (tester) async {
    await tester.pumpWidget(_host(const AnimatedBar(value: 0.6, color: Colors.green, background: Colors.grey)));
    await tester.pumpAndSettle();
    final bar = tester.widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator));
    expect(bar.value, closeTo(0.6, 0.001));
  });
}
