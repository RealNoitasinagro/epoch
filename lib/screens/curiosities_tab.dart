import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/time_entry.dart';
import '../time_utils.dart';
import '../widgets/section_header.dart';
import '../widgets/time_entry_row.dart';
import '../widgets/time_string_row.dart';

class CuriositiesTab extends StatelessWidget {
  final DateTime now;
  final bool hourFormat24;
  const CuriositiesTab({super.key, required this.now, this.hourFormat24 = true});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final utcNow = now.toUtc();
    final beats = TimeUtils.swatchBeats(utcNow);
    final doomsdayClock = TimeUtils.doomsDayClockString(hourFormat24);

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        SectionHeader(label: l10n.sectionSwatch),
        const SizedBox(height: 8),
        TimeStringRow(
          label: l10n.valueTypeSwatchBeats,
          //value: '@${beats.toStringAsFixed(2)}',
          value: '@${beats.toStringAsFixed(0)}',
          info: l10n.infoSwatch,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionBinaryClock),
        const SizedBox(height: 8),
        TimeEntryRow(
          entry: const TimeEntry(
              type: ValueType.binaryClockColumns, zone: ZoneLocal()),
          now: now,
          locale: locale,
        ),
        const SizedBox(height: 24),
        TimeEntryRow(
          entry: const TimeEntry(
              type: ValueType.binaryClockBcd, zone: ZoneLocal()),
          now: now,
          locale: locale,
        ),
        const SizedBox(height: 24),
        // Compact string representation.
        TimeStringRow(
          label: l10n.valueTypeBinaryClockString,
          value: TimeUtils.binaryTimeString(now),
          info: l10n.infoBinaryClockString,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionDoomsdayClock),
        const SizedBox(height: 8),
        TimeStringRow(
          label: l10n.valueTypeDoomsdayClock,
          value: doomsdayClock,
          info: l10n.infoDoomsday,
          infoLink: l10n.infoLinkDoomsday,
        ),
      ],
    );
  }
}
