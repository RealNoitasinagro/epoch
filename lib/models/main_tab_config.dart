import 'package:shared_preferences/shared_preferences.dart';
import 'time_value.dart';

const _kMainTabKey = 'main_tab_entries';

Future<List<MainTabEntry>> loadMainTabEntries() async {
  final prefs = await SharedPreferences.getInstance();
  final stored = prefs.getStringList(_kMainTabKey);
  if (stored == null) return List.of(defaultMainTabEntries);
  return stored
      .map(MainTabEntry.fromPrefsString)
      .whereType<MainTabEntry>()
      .toList();
}

Future<void> saveMainTabEntries(List<MainTabEntry> entries) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(
    _kMainTabKey,
    entries.map((e) => e.toPrefsString()).toList(),
  );
}

// Resets the Main tab to the default entry list.
Future<void> resetMainTabEntries() async {
  await saveMainTabEntries(List.of(defaultMainTabEntries));
}