import 'tab_entry.dart';
import 'time_value.dart';

// Used by entry_picker.dart to group the picker by category.
const civilTypes = [
  ValueType.date,
  ValueType.time,
  ValueType.dateTime,
  ValueType.daySecond,
  ValueType.dayPercent,
  ValueType.sevenSegmentClock,
];

const defaultCivilEntries = [
  TabSection(id: 'builtin_local', label: '', builtinKey: BuiltinSectionKey.local),
  TimeValue(valueType: ValueType.date,              zone: ZoneLocal()),
  TimeValue(valueType: ValueType.time,              zone: ZoneLocal()),
  TimeValue(valueType: ValueType.daySecond,         zone: ZoneLocal()),
  TimeValue(valueType: ValueType.dayPercent,        zone: ZoneLocal()),
  TimeValue(valueType: ValueType.sevenSegmentClock, zone: ZoneLocal()),
  TabDivider(id: 'builtin_divider_civil_1'),
  TabSection(id: 'builtin_other', label: '', builtinKey: BuiltinSectionKey.other),
  TimeValue(valueType: ValueType.time,              zone: ZoneUtc()),
  TimeValue(valueType: ValueType.daySecond,         zone: ZoneUtc()),
];
