import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/time_value.dart';
import '../widgets/section_header.dart';
import '../widgets/time_string_row.dart';

class TechnicalTab extends StatelessWidget {
  final DateTime now;
  final bool thousandsSep;

  const TechnicalTab({super.key, required this.now, this.thousandsSep = true});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        SectionHeader(label: l10n.sectionEpoch),
        const SizedBox(height: 8),
        TimeStringRow(
          timeValue: const TimeValue(
              type: ValueType.unixSeconds, zone: ZoneUtc()),
          now: now,
          locale: locale,
          thousandsSep: thousandsSep,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionAtomic),
        const SizedBox(height: 8),
        TimeStringRow(
          timeValue: const TimeValue(type: ValueType.tai, zone: ZoneUtc()),
          now: now,
          locale: locale,
          thousandsSep: thousandsSep,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionGps),
        const SizedBox(height: 8),
        TimeStringRow(
          timeValue: const TimeValue(type: ValueType.gps, zone: ZoneUtc()),
          now: now,
          locale: locale,
          thousandsSep: thousandsSep,
        ),
      ],
    );
  }
}