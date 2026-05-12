import 'package:flutter/material.dart';
import '../models/time_entry.dart';
import 'configurable_tab.dart';

// Civil tab: configurable but restricted to civil value types.
// All zone-dependent civil types are allowed; zone selection is unrestricted.
const _civilTypes = [
  ValueType.date,
  ValueType.time,
  ValueType.dateTime,
  ValueType.daySecond,
];

class CivilTab extends StatelessWidget {
  final DateTime now;
  final bool thousandsSep;
  final bool hourFormat24;
  final List<TimeEntry> entries;
  final ValueChanged<List<TimeEntry>> onEntriesChanged;

  const CivilTab({
    super.key,
    required this.now,
    required this.entries,
    required this.onEntriesChanged,
    this.thousandsSep = true,
    this.hourFormat24 = true,
  });

  @override
  Widget build(BuildContext context) {
    return ConfigurableTab(
      now: now,
      entries: entries,
      onEntriesChanged: onEntriesChanged,
      thousandsSep: thousandsSep,
      hourFormat24: hourFormat24,
      allowedTypes: _civilTypes,
    );
  }
}