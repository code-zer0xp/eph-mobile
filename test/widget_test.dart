// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exploreph/main.dart';

void main() {
  testWidgets('ExplorePH app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExplorePHApp());

    // Verify that the app starts with the home screen
    expect(find.text('Home Screen'), findsOneWidget);

    // Verify bottom navigation bar is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Test navigation to auth screen
    await tester.tap(find.text('Auth'));
    await tester.pumpAndSettle();
    expect(find.text('Auth Screen'), findsOneWidget);

    // Test navigation to settings screen
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('ExplorePH Settings'), findsOneWidget);

    // Test navigation back to home
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Home Screen'), findsOneWidget);

    // Test floating action button
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Settings screen buttons test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExplorePHApp());

    // Navigate to settings screen
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    // Verify buttons are present
    expect(find.text('Save Settings'), findsOneWidget);
    expect(find.text('Show Warning'), findsOneWidget);
    expect(find.text('Show Error'), findsOneWidget);
  });
}
