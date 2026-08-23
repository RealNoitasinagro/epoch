import 'package:epoch/models/prefs_migrations.dart';
import 'package:epoch/models/tab_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('_renameSimpleKeys (via runPrefsMigrations)', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('renames lmst_lon to lmst_longitude, preserving the value', () async {
      SharedPreferences.setMockInitialValues({'lmst_lon': 8.68});
      await runPrefsMigrations();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getDouble('lmst_longitude'), equals(8.68));
      expect(prefs.containsKey('lmst_lon'), isFalse);
    });

    test('renames zone_display to zone_display_mode', () async {
      SharedPreferences.setMockInitialValues({'zone_display': 'abbreviation'});
      await runPrefsMigrations();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('zone_display_mode'), equals('abbreviation'));
    });

    test('is idempotent – running twice does not error or duplicate', () async {
      SharedPreferences.setMockInitialValues({'lmst_lon': 8.68});
      await runPrefsMigrations();
      await runPrefsMigrations();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getDouble('lmst_longitude'), equals(8.68));
    });

    test('does nothing when neither old nor new key is present', () async {
      await runPrefsMigrations();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('lmst_longitude'), isFalse);
    });
  });

  group('_migrateToAllTabs (via runPrefsMigrations)', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('migrates civil_tab_entries into the civil builtin tab', () async {
      SharedPreferences.setMockInitialValues({
        'civil_tab_entries': ['time/local', 'date/local'],
      });
      await runPrefsMigrations();
      final tabs = await loadAllTabs();
      final civil = tabs.firstWhere((t) => t.builtinKind == BuiltinTabKind.civil);
      expect(civil.entries.length, equals(2));
    });

    test('migrates legacy custom_tabs rows as Watchlist tabs, appended after builtins', () async {
      SharedPreferences.setMockInitialValues({
        'custom_tabs': ['999\tMy Old Tab\ttime/utc'],
      });
      await runPrefsMigrations();
      final tabs = await loadAllTabs();
      expect(tabs.length, equals(5)); // 4 builtins + 1 legacy custom tab
      expect(tabs.last.customName, equals('My Old Tab'));
      expect(tabs.last.isBuiltin, isFalse);
    });

    test('is a no-op on a fresh install (no legacy keys at all)', () async {
      await runPrefsMigrations();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('all_tabs'), isFalse);
    });

    test('does not re-run once all_tabs already exists', () async {
      SharedPreferences.setMockInitialValues({
        'civil_tab_entries': ['time/local'],
        'all_tabs': ['999\t\tcivil\t1'],  // already migrated, different content
      });
      await runPrefsMigrations();
      final prefs = await SharedPreferences.getInstance();
      // Untouched – migration must not clobber an existing all_tabs:
      expect(prefs.getStringList('all_tabs'), equals(['999\t\tcivil\t1']));
    });
  });
}
