import 'package:epoch/models/tab_entry.dart';
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
  ValueType.sevenSegmentClock,
];

// Default entries for the Civil tab.
const defaultCivilEntries = [
  TimeValue(valueType: ValueType.date,              zone: ZoneLocal()),
  TimeValue(valueType: ValueType.time,              zone: ZoneLocal()),
  TimeValue(valueType: ValueType.daySecond,         zone: ZoneLocal()),
  TimeValue(valueType: ValueType.dayPercent,        zone: ZoneLocal()),
  TimeValue(valueType: ValueType.time,              zone: ZoneUtc()),
  TimeValue(valueType: ValueType.daySecond,         zone: ZoneUtc()),
  TimeValue(valueType: ValueType.sevenSegmentClock, zone: ZoneLocal()),
];

Future<List<TabEntry>> loadCivilEntries() async {
  final prefs = await SharedPreferences.getInstance();
  final stored = prefs.getStringList(_kCivilTabKey);
  if (stored == null) return List.of(defaultCivilEntries);
  return stored
      .map(TabEntry.fromPrefsString)
      .whereType<TabEntry>()
      .toList();
}

Future<void> saveCivilEntries(List<TabEntry> entries) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(
    _kCivilTabKey,
    entries.map((e) => e.toPrefsString()).toList(),
  );
}

Future<void> resetCivilEntries() async {
  await saveCivilEntries(List.of(defaultCivilEntries));
}