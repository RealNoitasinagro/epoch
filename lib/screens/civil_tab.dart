import 'package:flutter/material.dart';
import '../models/civil_tab_config.dart';
import '../models/time_value.dart';
import 'configurable_tab.dart';

class CivilTab extends StatelessWidget {
  final DateTime now;
  final bool thousandsSep;
  final bool hourFormat24;
  final List<TimeValue> entries;
  final ValueChanged<List<TimeValue>> onEntriesChanged;

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
      allowedTypes: civilTypes,
    );
  }
}