import 'package:shared_preferences/shared_preferences.dart';
import 'time_entry.dart';

const _kCivilTabKey = 'civil_tab_entries';

Future<List<TimeEntry>> loadCivilEntries() async {
  final prefs = await SharedPreferences.getInstance();
  final stored = prefs.getStringList(_kCivilTabKey);
  if (stored == null) return List.of(defaultCivilEntries);
  return stored
      .map(TimeEntry.fromPrefsString)
      .whereType<TimeEntry>()
      .toList();
}

Future<void> saveCivilEntries(List<TimeEntry> entries) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(
    _kCivilTabKey,
    entries.map((e) => e.toPrefsString()).toList(),
  );
}

Future<void> resetCivilEntries() async {
  await saveCivilEntries(List.of(defaultCivilEntries));
}