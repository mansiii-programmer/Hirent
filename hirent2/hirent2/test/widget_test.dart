import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: unused_import
import 'package:hirent2/main.dart';
import 'package:hirent2/screens/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HirentApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

class MyApp {
  const MyApp();
}
