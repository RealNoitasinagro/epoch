import 'package:epoch/models/time_value.dart';

const technicalTypes = [
  ValueType.unixSeconds,
  ValueType.tai,
  ValueType.gps,
];

const technicalEntries = [
  TimeValue(type: ValueType.unixSeconds, zone: ZoneUtc()),
  TimeValue(type: ValueType.tai, zone: ZoneUtc()),
  TimeValue(type: ValueType.gps, zone: ZoneUtc()),
];