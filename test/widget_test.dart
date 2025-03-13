import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:feces_sht_project/main.dart';

void main() {
  setUpAll(() async {
    await Hive.initFlutter(); // Initialize Hive for testing
  });

  testWidgets('App loads and shows home screen title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts on the home screen
    expect(find.text("Smart Habit Tracker"), findsOneWidget);
  });

  testWidgets('Adding a habit updates the list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find the text field and enter a habit name
    await tester.enterText(find.byType(TextField), 'Drink Water');

    // Tap the add button (suffix icon)
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the new habit appears in the list
    expect(find.text('Drink Water'), findsOneWidget);
  });
}
