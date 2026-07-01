import 'package:epoch/models/time_value.dart';

const technicalTypes = [
  ValueType.unixSeconds,
  ValueType.tai,
  ValueType.gps,
];

const technicalEntries = [
  TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.tai, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.gps, zone: ZoneUtc()),
];