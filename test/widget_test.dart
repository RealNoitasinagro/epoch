import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epoch/main.dart';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  setUpAll(() {
    tz.initializeTimeZones();
  });

  testWidgets('App starts and shows main tab',
          (WidgetTester tester) async {
        await tester.pumpWidget(const EpochApp());
        await tester.pumpAndSettle();
        // Verify the app renders without crashing.
        expect(find.byType(TabBar), findsOneWidget);
      });

  testWidgets('EN localization keys resolve',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale('en'),
            home: Scaffold(body: SizedBox.shrink()),
          ),
        );
        await tester.pumpAndSettle();
        final l10n = lookupAppLocalizations(const Locale('en'));
        expect(l10n.appName, 'Epoch');
        expect(l10n.tabMain, 'Main');
        expect(l10n.tabTechnical, 'Technical');
        expect(l10n.settingsTheme, 'Theme');
      });

  testWidgets('DE localization keys resolve',
          (WidgetTester tester) async {
        final l10n = lookupAppLocalizations(const Locale('de'));
        expect(l10n.appName, 'Epoch');
        expect(l10n.tabMain, 'Haupt');
        expect(l10n.tabTechnical, 'Technisch');
        expect(l10n.settingsTheme, 'Design');
      });
}