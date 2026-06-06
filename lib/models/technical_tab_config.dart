import 'package:epoch/models/time_value.dart';

const technicalEntries = [
  TimeValue(type: ValueType.unixSeconds, zone: ZoneUtc()),
  TimeValue(type: ValueType.tai, zone: ZoneUtc()),
  TimeValue(type: ValueType.gps, zone: ZoneUtc()),
];