import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iguana_taman_wisata/main.dart';

void main() {
  testWidgets('App should display login screen initially', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify if the initial screen is AuthScreen
    expect(find.text('Login'), findsOneWidget); // Ganti dengan teks yang ada di AuthScreen
  });

  testWidgets('Login button should work', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Enter username and password
    await tester.enterText(find.byType(TextField).at(0), 'testuser');
    await tester.enterText(find.byType(TextField).at(1), 'testpassword');

    // Tap the login button
    await tester.tap(find.byType(ElevatedButton));

    // Trigger a frame
    await tester.pumpAndSettle();

    // Verify if navigation occurs (replace with expected behavior)
    expect(find.text('Home'), findsOneWidget); // Ganti dengan teks yang ada di HomeScreen
  });
}
