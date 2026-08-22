import 'tab_entry.dart';
import 'time_value.dart';

const astronomicalTypes = [
  ValueType.gmst,
  ValueType.lmst,
  ValueType.julianDate,
  ValueType.modifiedJulianDate,
  ValueType.modifiedJulianDate2000,
];

const defaultAstronomicalEntries = [
  TabSection(id: 'builtin_sidereal', label: '', builtinKey: BuiltinSectionKey.sidereal),
  TimeValue(valueType: ValueType.gmst, zone: ZoneUtc()),
  // LMST intentionally left out of the default configuration – it is only
  // meaningful once a longitude is configured, and can be added manually
  // via the entry picker once LMST mode is enabled in Settings.
  TabDivider(id: 'builtin_divider_astro_1'),
  TabSection(id: 'builtin_julian', label: '', builtinKey: BuiltinSectionKey.julian),
  TimeValue(valueType: ValueType.julianDate, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.modifiedJulianDate, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.modifiedJulianDate2000, zone: ZoneUtc()),
];
