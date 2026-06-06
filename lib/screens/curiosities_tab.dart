import 'package:epoch/models/curiosities_tab_config.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../models/time_value.dart';
import '../widgets/section_header.dart';
import '../widgets/tab_value_count.dart';
import '../widgets/time_graphical_row.dart';
import '../widgets/time_string_row.dart';

class CuriositiesTab extends StatelessWidget {
  final DateTime now;
  final bool hourFormat24;

  const CuriositiesTab({
    super.key, required this.now, this.hourFormat24 = true});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return Column(
      children: [
        TabValueCount(count: curiositiesEntries.length),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                kTabHorizontalPadding, kTabVerticalPadding,
                kTabHorizontalPadding, kTabVerticalPadding),
            children: [
              SectionHeader(label: l10n.sectionInternet),
              const SizedBox(height: 8),
              TimeStringRow(
                timeValue: const TimeValue(
                    type: ValueType.swatchBeats, zone: ZoneUtc()),
                now: now,
                locale: locale,
              ),
              const Divider(height: 40),
              SectionHeader(label: l10n.sectionBinaryClock),
              const SizedBox(height: 8),
              TimeGraphicalRow(
                timeValue: const TimeValue(
                    type: ValueType.binaryClockColumns, zone: ZoneLocal()),
                now: now,
              ),
              const SizedBox(height: 24),
              TimeGraphicalRow(
                timeValue: const TimeValue(
                    type: ValueType.binaryClockBcd, zone: ZoneLocal()),
                now: now,
              ),
              const SizedBox(height: 24),
              TimeStringRow(
                timeValue: const TimeValue(
                    type: ValueType.binaryClockString, zone: ZoneLocal()),
                now: now,
                locale: locale,
              ),
              const Divider(height: 40),
              SectionHeader(label: l10n.sectionDoomsdayClock),
              const SizedBox(height: 8),
              TimeStringRow(
                timeValue: const TimeValue(
                    type: ValueType.doomsdayClock, zone: ZoneUtc()),
                now: now,
                locale: locale,
                hourFormat24: hourFormat24,
              ),
            ],
          )
        ),
      ],
    );
  }
}