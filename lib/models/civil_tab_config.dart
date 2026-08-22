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
  TimeValue(valueType: ValueType.date,              zone: ZoneLocal()),
  TimeValue(valueType: ValueType.time,              zone: ZoneLocal()),
  TimeValue(valueType: ValueType.daySecond,         zone: ZoneLocal()),
  TimeValue(valueType: ValueType.dayPercent,        zone: ZoneLocal()),
  TimeValue(valueType: ValueType.time,              zone: ZoneUtc()),
  TimeValue(valueType: ValueType.daySecond,         zone: ZoneUtc()),
  TimeValue(valueType: ValueType.sevenSegmentClock, zone: ZoneLocal()),
];
