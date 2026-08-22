import 'package:shared_preferences/shared_preferences.dart';
import 'tab_config.dart';
import 'tab_entry.dart';

/// A single migration step, applied once at every app startup.
/// Must be idempotent: safe to call repeatedly, only acts if its
/// precondition is actually met (so re-running after a successful
/// migration is a no-op).
typedef PrefsMigration = Future<void> Function(SharedPreferences prefs);

/// All migration steps, in order.
/// IMPORTANT: never remove or reorder existing entries – a user
/// upgrading across several versions must still pass through every
/// applicable step. Only ever append new steps at the end.
final List<PrefsMigration> prefsMigrations = [
  _renameSimpleKeys,
  _migrateToAllTabs,
];

Future<void> runPrefsMigrations() async {
  final prefs = await SharedPreferences.getInstance();
  for (final migration in prefsMigrations) {
    await migration(prefs);
  }
}

// ── Simple 1:1 key renames ──────────────────────────────────────────────

// Type-preserving. Add new entries here whenever a preference key is
// renamed – no bespoke migration code needed.
const _kKeyRenames = <String, String>{
  'lmst_lon': 'lmst_longitude',
  'zone_display': 'zone_display_mode',
};

Future<void> _renameSimpleKeys(SharedPreferences prefs) async {
  for (final entry in _kKeyRenames.entries) {
    final oldKey = entry.key;
    final newKey = entry.value;
    if (!prefs.containsKey(oldKey) || prefs.containsKey(newKey)) continue;

    final value = prefs.get(oldKey);
    switch (value) {
      case bool v:          await prefs.setBool(newKey, v);
      case int v:           await prefs.setInt(newKey, v);
      case double v:        await prefs.setDouble(newKey, v);
      case String v:        await prefs.setString(newKey, v);
      case List<String> v:  await prefs.setStringList(newKey, v);
    }
    await prefs.remove(oldKey);
  }
}

// ── Structural migration: civil_tab_entries + custom_tabs -> all_tabs ───

const _kLegacyCivilKey = 'civil_tab_entries';
const _kLegacyCustomTabsKey = 'custom_tabs';
const _kAllTabsKey = 'all_tabs';

Future<void> _migrateToAllTabs(SharedPreferences prefs) async {
  if (prefs.containsKey(_kAllTabsKey)) return;
  if (!prefs.containsKey(_kLegacyCivilKey) &&
      !prefs.containsKey(_kLegacyCustomTabsKey)) return;

  final tabs = defaultBuiltinTabs();

  final civilEntries = (prefs.getStringList(_kLegacyCivilKey) ?? [])
      .map(TabEntry.fromPrefsString)
      .whereType<TabEntry>()
      .toList();
  if (civilEntries.isNotEmpty) {
    tabs[0] = tabs[0].copyWith(entries: civilEntries);  // tabs[0] is civil
  }

  final legacyCustomTabRows = prefs.getStringList(_kLegacyCustomTabsKey) ?? [];
  for (final row in legacyCustomTabRows) {
    final parts = row.split('\t');
    if (parts.length < 2) continue;
    final entries = parts
        .sublist(2)
        .map(TabEntry.fromPrefsString)
        .whereType<TabEntry>()
        .toList();
    tabs.add(TabConfig(id: parts[0], customName: parts[1], entries: entries));
  }

  await saveAllTabs(tabs);
  await prefs.remove(_kLegacyCivilKey);
  await prefs.remove(_kLegacyCustomTabsKey);
}
