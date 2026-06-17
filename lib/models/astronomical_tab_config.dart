import 'package:epoch/models/time_value.dart';

const astronomicalTypes = [
  ValueType.gmst,
  ValueType.lmst,
  ValueType.julianDate,
  ValueType.modifiedJulianDate,
  ValueType.modifiedJulianDate2000,
];

const astronomicalEntries = [
  TimeValue(valueType: ValueType.gmst, zone: ZoneUtc()),
  // LMST will be displayed dynamically depending on longitude availability
  TimeValue(valueType: ValueType.julianDate, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.modifiedJulianDate, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.modifiedJulianDate2000, zone: ZoneUtc()),
];
