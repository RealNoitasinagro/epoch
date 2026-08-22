import 'tab_entry.dart';
import 'time_value.dart';

const curiosityTypes = [
  ValueType.binaryClockString,
  ValueType.binaryClockColumns,
  ValueType.binaryClockBcd,
  ValueType.swatchBeats,
  ValueType.doomsdayClock,
];

const defaultCuriositiesEntries = [
  TabSection(id: 'builtin_internet', label: '', builtinKey: BuiltinSectionKey.internet),
  TimeValue(valueType: ValueType.swatchBeats, zone: ZoneUtc()),
  TabDivider(id: 'builtin_divider_curio_1'),
  TabSection(id: 'builtin_binaryClock', label: '', builtinKey: BuiltinSectionKey.binaryClock),
  TimeValue(valueType: ValueType.binaryClockColumns, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.binaryClockBcd, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.binaryClockString, zone: ZoneLocal()),
  TabDivider(id: 'builtin_divider_curio_2'),
  TabSection(id: 'builtin_doomsdayClock', label: '', builtinKey: BuiltinSectionKey.doomsdayClock),
  TimeValue(valueType: ValueType.doomsdayClock, zone: ZoneUtc()),
];
