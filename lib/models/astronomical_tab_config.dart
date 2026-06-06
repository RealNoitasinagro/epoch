import 'package:epoch/models/time_value.dart';

const astronomicalTypes = [
  ValueType.gmst,
  ValueType.julianDate,
  ValueType.modifiedJulianDate,
];

const astronomicalEntries = [
  TimeValue(type: ValueType.gmst, zone: ZoneUtc()),
  TimeValue(type: ValueType.julianDate, zone: ZoneUtc()),
  TimeValue(type: ValueType.modifiedJulianDate, zone: ZoneUtc()),
];