import 'tab_entry.dart';
import 'time_value.dart';

const curiosityTypes = [
  ValueType.decimalTime,
  ValueType.swatchBeats,
  ValueType.newEarthTime,
  ValueType.binaryClockColumns,
  ValueType.binaryClockBcd,
  ValueType.binaryClockString,
  ValueType.octalTime,
  ValueType.hexadecimalTime,
  ValueType.doomsdayClock,
];

const defaultCuriositiesEntries = [
  TabSection(id: 'builtin_alternative', label: '', builtinKey: BuiltinSectionKey.alternative),
  TimeValue(valueType: ValueType.decimalTime, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.swatchBeats, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.newEarthTime, zone: ZoneUtc()),
  TabDivider(id: 'builtin_divider_curio_1'),
  TabSection(id: 'builtin_numberSystems', label: '', builtinKey: BuiltinSectionKey.numberSystems),
  TimeValue(valueType: ValueType.binaryClockColumns, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.binaryClockBcd, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.binaryClockString, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.octalTime, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.hexadecimalTime, zone: ZoneLocal()),
  TabDivider(id: 'builtin_divider_curio_2'),
  TabSection(id: 'builtin_doomsdayClock', label: '', builtinKey: BuiltinSectionKey.doomsdayClock),
  TimeValue(valueType: ValueType.doomsdayClock, zone: ZoneUtc()),
];
