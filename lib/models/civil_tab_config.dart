import 'package:shared_preferences/shared_preferences.dart';
import 'time_value.dart';

const _kCivilTabKey = 'civil_tab_entries';

// Civil tab: configurable but restricted to civil value types.
// All zone-dependent civil types are allowed; zone selection is unrestricted.
const civilTypes = [
  ValueType.date,
  ValueType.time,
  ValueType.dateTime,
  ValueType.daySecond,
  ValueType.dayPercent,
];

// Default entries for the Civil tab.
const defaultCivilEntries = [
  TimeValue(type: ValueType.date,       zone: ZoneLocal()),
  TimeValue(type: ValueType.time,       zone: ZoneLocal()),
  TimeValue(type: ValueType.daySecond,  zone: ZoneLocal()),
  TimeValue(type: ValueType.dayPercent, zone: ZoneLocal()),
  TimeValue(type: ValueType.time,       zone: ZoneUtc()),
  TimeValue(type: ValueType.daySecond,  zone: ZoneUtc()),
];

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