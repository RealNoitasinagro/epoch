import 'package:shared_preferences/shared_preferences.dart';
import 'time_value.dart';

const _kCivilTabKey = 'civil_tab_entries';

Future<List<TimeValue>> loadCivilEntries() async {
  final prefs = await SharedPreferences.getInstance();
  final stored = prefs.getStringList(_kCivilTabKey);
  if (stored == null) return List.of(defaultCivilEntries);
  return stored
      .map(TimeValue.fromPrefsString)
      .whereType<TimeValue>()
      .toList();
}

Future<void> saveCivilEntries(List<TimeValue> entries) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(
    _kCivilTabKey,
    entries.map((e) => e.toPrefsString()).toList(),
  );
}

Future<void> resetCivilEntries() async {
  await saveCivilEntries(List.of(defaultCivilEntries));
}