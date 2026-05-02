import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import '../strings.dart';
import '../time_utils.dart';
import '../widgets/time_row.dart';
import '../widgets/section_header.dart';

class MainTab extends StatelessWidget {
  final DateTime now; // local system time from DateTime.now()
  final String ianaZone; // IANA zone name, or 'local' for system zone

  const MainTab({
    super.key,
    required this.now,
    this.ianaZone = 'local',
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final utcNow = now.toUtc();

    // Determine local display time and timezone metadata.
    // When ianaZone is 'local', use the system DateTime directly to avoid
    // tz.local being unset or mismatched on some platforms.
    final DateTime localDt;
    final String tzLabel;
    final Duration offset;

    if (ianaZone == 'local') {
      localDt = now;
      tzLabel = now.timeZoneName;
      offset = now.timeZoneOffset;
    } else {
      final tzDt = TimeUtils.inZone(utcNow, ianaZone);
      localDt = tzDt;
      tzLabel = tzDt.timeZone.abbreviation;
      offset = tzDt.timeZoneOffset;
    }

    final localDate = DateFormat('EEE, yyyy-MM-dd', locale).format(localDt);
    final localTime =
        '${localDt.hour.toString().padLeft(2, '0')}:'
        '${localDt.minute.toString().padLeft(2, '0')}:'
        '${localDt.second.toString().padLeft(2, '0')} '
        '$tzLabel (${TimeUtils.utcOffsetString(offset)})';

    final utcDate = DateFormat('EEE, yyyy-MM-dd', locale).format(utcNow);
    final utcTime =
        '${utcNow.hour.toString().padLeft(2, '0')}:'
        '${utcNow.minute.toString().padLeft(2, '0')}:'
        '${utcNow.second.toString().padLeft(2, '0')} UTC';

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        const SectionHeader(label: AppStrings.labelLocal),
        const SizedBox(height: 8),
        TimeRow(label: AppStrings.labelDate, value: localDate),
        const SizedBox(height: 12),
        TimeRow(label: AppStrings.labelLocalTime, value: localTime),
        const SizedBox(height: 12),
        TimeRow(
          label: AppStrings.labelDaySecond,
          value: TimeUtils.daySecond(localDt).toString(),
        ),
        const Divider(height: 40),
        const SectionHeader(label: AppStrings.labelUtc),
        const SizedBox(height: 8),
        TimeRow(label: AppStrings.labelDate, value: utcDate),
        const SizedBox(height: 12),
        TimeRow(label: AppStrings.labelUtcTime, value: utcTime),
        const SizedBox(height: 12),
        TimeRow(
          label: AppStrings.labelDaySecond,
          value: TimeUtils.daySecond(utcNow).toString(),
        ),
      ],
    );
  }
}