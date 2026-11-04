import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/screens/optional_part_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<Set<ValueType>?> openDialogAndTap(
      WidgetTester tester, {
        required Set<ValueType> hiddenTypes,
        required List<String> tapTexts,
      }) async {
    Set<ValueType>? result;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () async {
            result = await showDialog<Set<ValueType>>(
              context: context,
              builder: (_) => OptionalPartDialog(hiddenTypes: hiddenTypes),
            );
          },
          child: const Text('open'),
        ),
      ),
    ));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    for (final text in tapTexts) {
      await tester.tap(find.text(text));
      await tester.pump();
    }
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    return result;
  }

  testWidgets('the master checkbox hides everything when all are shown', (tester) async {
    final result = await openDialogAndTap(
      tester,
      hiddenTypes: {},
      tapTexts: ['All'],
    );
    expect(result, optionalPartTypes.toSet());
  });

  testWidgets('the master checkbox shows everything when some are hidden', (tester) async {
    final result = await openDialogAndTap(
      tester,
      hiddenTypes: {ValueType.time},
      tapTexts: ['All'],
    );
    expect(result, isEmpty);
  });

  testWidgets('a single type can be hidden', (tester) async {
    final result = await openDialogAndTap(
      tester,
      hiddenTypes: {},
      tapTexts: ['Time'],
    );
    expect(result, {ValueType.time});
  });

  testWidgets('cancel discards the changes', (tester) async {
    Set<ValueType>? result = {};
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () async {
            result = await showDialog<Set<ValueType>>(
              context: context,
              builder: (_) => const OptionalPartDialog(hiddenTypes: {}),
            );
          },
          child: const Text('open'),
        ),
      ),
    ));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('All'));
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(result, isNull);
  });
}
