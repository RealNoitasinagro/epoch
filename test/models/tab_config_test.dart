import 'dart:ui';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/models/tab_config.dart';
import 'package:epoch/models/time_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('generateId', () {
    test('produces unique ids even when called rapidly in a loop', () {
      final ids = List.generate(50, (_) => generateId());
      expect(ids.toSet().length, equals(ids.length));
    });
  });

  group('TabConfig serialization', () {
    test('roundtrip for a builtin tab', () {
      final tab = TabConfig(
        id: '123',
        builtinKind: BuiltinTabKind.technical,
        isVisible: false,
        entries: [
          const TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc()),
        ],
      );
      final s = tab.toPrefsString();
      final tab2 = TabConfig.fromPrefsString(s);
      expect(tab2, isNotNull);
      expect(tab2!.id, equals('123'));
      expect(tab2.builtinKind, equals(BuiltinTabKind.technical));
      expect(tab2.customName, isNull);
      expect(tab2.isVisible, isFalse);
      expect(tab2.entries.length, equals(1));
    });

    test('roundtrip for a custom (Watchlist) tab', () {
      final tab = TabConfig(
        id: '456',
        customName: 'My Tab',
        entries: [],
      );
      final s = tab.toPrefsString();
      final tab2 = TabConfig.fromPrefsString(s);
      expect(tab2!.builtinKind, isNull);
      expect(tab2.customName, equals('My Tab'));
      expect(tab2.isBuiltin, isFalse);
    });

    test('malformed string (too few fields) returns null', () {
      expect(TabConfig.fromPrefsString('only\ttwo'), isNull);
    });
  });

  group('TabConfig.displayName', () {
    final l10nEn = lookupAppLocalizations(const Locale('en'));
    final l10nDe = lookupAppLocalizations(const Locale('de'));

    test('builtin tab uses the localized name, ignoring any stored customName', () {
      final tab = TabConfig(
        id: '1',
        builtinKind: BuiltinTabKind.technical,
        entries: [],
      );
      expect(tab.displayName(l10nEn), equals(l10nEn.tabTechnical));
      expect(tab.displayName(l10nDe), equals(l10nDe.tabTechnical));
    });

    test('custom tab uses the stored customName, independent of locale', () {
      final tab = TabConfig(id: '2', customName: 'My Tab', entries: []);
      expect(tab.displayName(l10nEn), equals('My Tab'));
      expect(tab.displayName(l10nDe), equals('My Tab'));
    });
  });

  group('TabConfig.copyWith', () {
    test('changes only the requested fields', () {
      final tab = TabConfig(id: '1', customName: 'A', isVisible: true, entries: []);
      final updated = tab.copyWith(isVisible: false);
      expect(updated.id, equals('1'));
      expect(updated.customName, equals('A'));
      expect(updated.isVisible, isFalse);
    });

    test('clearCustomName removes the custom name', () {
      final tab = TabConfig(id: '1', customName: 'A', entries: []);
      final updated = tab.copyWith(clearCustomName: true);
      expect(updated.customName, isNull);
    });
  });
}
