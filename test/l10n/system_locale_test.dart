import 'dart:ui';
import 'package:epoch/l10n/system_locale.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('supported system languages are taken, others fall back',
          (tester) async {
        addTearDown(tester.platformDispatcher.clearLocaleTestValue);
        const fallback = Locale('en');

        tester.platformDispatcher.localeTestValue = const Locale('de', 'DE');
        expect(supportedSystemLocale(fallback: fallback), const Locale('de'));

        tester.platformDispatcher.localeTestValue = const Locale('fr', 'FR');
        expect(supportedSystemLocale(fallback: fallback), fallback);
      });
}
