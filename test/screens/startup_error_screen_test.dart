import 'package:epoch/screens/startup_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the error details and a copy button', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: StartupErrorScreen(
          error: StateError('prefs broken'), stackTrace: StackTrace.current),
    ));
    expect(find.textContaining('prefs broken'), findsOneWidget);
    expect(find.byIcon(Icons.copy), findsOneWidget);
  });
}
