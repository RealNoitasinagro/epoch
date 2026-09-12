import 'tab_entry.dart';
import 'time_value.dart';

// Used by entry_picker.dart to group the picker by category –
// independent of any per-tab restriction (there is none anymore).
const technicalTypes = [
  ValueType.unixSeconds,
  ValueType.tai,
  ValueType.gps,
];

const defaultTechnicalEntries = [
  TabSection(id: 'builtin_unix', label: '', builtinKey: BuiltinSectionKey.unix),
  TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc()),
  TabDivider(id: 'builtin_divider_tech_1'),
  TabSection(id: 'builtin_atomic', label: '', builtinKey: BuiltinSectionKey.atomic),
  TimeValue(valueType: ValueType.tai, zone: ZoneUtc()),
  TabDivider(id: 'builtin_divider_tech_2'),
  TabSection(id: 'builtin_gps', label: '', builtinKey: BuiltinSectionKey.gps),
  TimeValue(valueType: ValueType.gps, zone: ZoneUtc()),
];
