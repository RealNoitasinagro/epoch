import 'package:epoch/models/astronomical_tab_config.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../models/app_settings.dart';
import '../models/time_value.dart';
import '../widgets/section_header.dart';
import '../widgets/tab_value_count.dart';
import '../widgets/time_string_row.dart';

class AstronomicalTab extends StatelessWidget {
  final DateTime now;
  final bool thousandsSep;
  final LmstMode lmstMode;
  final double? lmstLongitude;

  const AstronomicalTab({
    super.key,
    required this.now,
    this.thousandsSep = true,
    this.lmstMode = LmstMode.off,
    this.lmstLongitude,
  });

  bool get _showLmst =>
      lmstMode != LmstMode.off && lmstLongitude != null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final count = astronomicalEntries.length + (_showLmst ? 1 : 0);

    return Column(
      children: [
        TabValueCount(count: count),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                kTabHorizontalPadding, kTabVerticalPadding,
                kTabHorizontalPadding, kTabVerticalPadding),
            children: [
              SectionHeader(label: l10n.sectionSidereal),
              const SizedBox(height: 8),
              TimeStringRow(
                timeValue: const TimeValue(
                    type: ValueType.gmst, zone: ZoneUtc()),
                now: now,
                locale: locale,
                thousandsSep: thousandsSep,
              ),
              if (_showLmst) ...[
                const SizedBox(height: 12),
                TimeStringRow(
                  timeValue: const TimeValue(
                      type: ValueType.lmst, zone: ZoneUtc()),
                  now: now,
                  locale: locale,
                  thousandsSep: thousandsSep,
                  longitude: lmstLongitude,
                ),
              ],
              const Divider(height: 40),
              SectionHeader(label: l10n.sectionJulian),
              const SizedBox(height: 8),
              TimeStringRow(
                timeValue: const TimeValue(
                    type: ValueType.julianDate, zone: ZoneUtc()),
                now: now,
                locale: locale,
                thousandsSep: thousandsSep,
              ),
              const SizedBox(height: 12),
              TimeStringRow(
                timeValue: const TimeValue(
                    type: ValueType.modifiedJulianDate, zone: ZoneUtc()),
                now: now,
                locale: locale,
                thousandsSep: thousandsSep,
              ),
              const SizedBox(height: 12),
              TimeStringRow(
                timeValue: const TimeValue(
                    type: ValueType.modifiedJulianDate2000, zone: ZoneUtc()),
                now: now,
                locale: locale,
                thousandsSep: thousandsSep,
              ),
            ],
          ),
        ),
      ],
    );
  }
}