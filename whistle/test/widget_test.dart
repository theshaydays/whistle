// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whistle/HomeScreen.dart';
import 'package:whistle/NewProject.dart';

import 'package:whistle/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  group('HomeScreen', () {
    testWidgets('New Project Icon ', (WidgetTester tester) async {
      //find widget
      final newProject = find.byKey(ValueKey('ToNewProject'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.tap(newProject);
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('NewProjectPage')), findsOneWidget);
    });

    testWidgets('Sample Keyboard Icon', (WidgetTester tester) async {
      //find widget
      final button = find.byKey(ValueKey('SampleKeyboard'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.tap(button);
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('KeyboardPage')), findsOneWidget);
    });

    testWidgets('Recent Projects', (WidgetTester tester) async {
      //find widget
      final button = find.byKey(ValueKey('RecentProjectsButton'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.tap(button);
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('RecentProjectsPage')), findsOneWidget);
    });
  });

  group('New Projects Page', () {
    testWidgets('Home Icon', (WidgetTester tester) async {
      //find widget
      final homeButton = find.byKey(ValueKey('HomeButton'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: NewProject()));
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('GoHomeDialog')), findsOneWidget);
    });

    testWidgets('Test Home Icon No', (WidgetTester tester) async {
      //find widget
      final homeButtonNo = find.byKey(ValueKey('HomeButtonNo'));
      final homeButton = find.byKey(ValueKey('HomeButton'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: NewProject()));
      await tester.tap(homeButton);
      await tester.pumpAndSettle();
      await tester.tap(homeButtonNo);
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('NewProjectPage')), findsOneWidget);
    });

    testWidgets('Test Home Icon Yes', (WidgetTester tester) async {
      //find widget
      final homeButtonYes = find.byKey(ValueKey('HomeButtonYes'));
      final homeButton = find.byKey(ValueKey('HomeButton'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: NewProject()));
      await tester.tap(homeButton);
      await tester.pumpAndSettle();
      await tester.tap(homeButtonYes);
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('HomeScreen')), findsOneWidget);
    });

    testWidgets('Test Back Icon', (WidgetTester tester) async {
      //find widget
      //final backButtonNo = find.byKey(ValueKey('BackButtonNo'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: NewProject()));
      await tester.pageBack();
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('BackButton')), findsOneWidget);
    });

    testWidgets('Test Back Icon No', (WidgetTester tester) async {
      //find widget
      final backButtonNo = find.byKey(ValueKey('BackButtonNo'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: NewProject()));
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(backButtonNo);
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('NewProjectPage')), findsOneWidget);
    });

    testWidgets('Test Back Icon Yes', (WidgetTester tester) async {
      //find widget
      final backButtonYes = find.byKey(ValueKey('BackButtonYes'));

      //execute test
      await tester.pumpWidget(MaterialApp(home: NewProject()));
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(backButtonYes);
      await tester.pumpAndSettle();

      //check outputs
      expect(find.byKey(ValueKey('HomeScreen')), findsNothing);
    });
  });
}
