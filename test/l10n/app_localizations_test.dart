import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ── helpers ──
  Set<String> stringKeysOf(String arbPath) =>
      (jsonDecode(File(arbPath).readAsStringSync()) as Map<String, dynamic>)
          .keys
          .where((key) => !key.startsWith('@'))
          .toSet();

  test('English and German define exactly the same strings', () {
    final english = stringKeysOf('lib/l10n/app_en.arb');
    final german = stringKeysOf('lib/l10n/app_de.arb');
    expect(german.difference(english), isEmpty, reason: 'only in German');
    expect(english.difference(german), isEmpty, reason: 'only in English');
  });

  test('both languages resolve', () {
    final english = lookupAppLocalizations(const Locale('en'));
    final german = lookupAppLocalizations(const Locale('de'));
    expect(english.tabCivil, 'Civil');
    expect(german.tabCivil, 'Bürgerlich');
    expect(english.settingsTheme, 'Theme');
    expect(german.settingsTheme, 'Design');
  });
}
