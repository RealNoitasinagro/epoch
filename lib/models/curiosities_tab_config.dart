import 'package:epoch/models/time_value.dart';

const curiosityTypes = [
  ValueType.binaryClockString,
  ValueType.binaryClockColumns,
  ValueType.binaryClockBcd,
  ValueType.swatchBeats,
  ValueType.doomsdayClock
];

const curiositiesEntries = [
  TimeValue(valueType: ValueType.swatchBeats, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.binaryClockColumns, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.binaryClockBcd, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.binaryClockString, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.doomsdayClock, zone: ZoneUtc()),
];