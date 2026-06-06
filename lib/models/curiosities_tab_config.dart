import 'package:epoch/models/time_value.dart';

const curiosityTypes = [
  ValueType.binaryClockString,
  ValueType.binaryClockColumns,
  ValueType.binaryClockBcd,
  ValueType.swatchBeats,
  ValueType.doomsdayClock
];

const curiositiesEntries = [
  TimeValue(type: ValueType.swatchBeats, zone: ZoneUtc()),
  TimeValue(type: ValueType.binaryClockColumns, zone: ZoneLocal()),
  TimeValue(type: ValueType.binaryClockBcd, zone: ZoneLocal()),
  TimeValue(type: ValueType.binaryClockString, zone: ZoneLocal()),
  TimeValue(type: ValueType.doomsdayClock, zone: ZoneUtc()),
];