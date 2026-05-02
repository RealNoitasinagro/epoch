import 'package:flutter/material.dart';
import '../strings.dart';
import '../time_utils.dart';
import '../widgets/time_row.dart';
import '../widgets/section_header.dart';

class TechnicalTab extends StatelessWidget {
  final DateTime now;

  const TechnicalTab({super.key, required this.now});

  @override
  Widget build(BuildContext context) {
    final utcNow = now.toUtc();
    final unix = TimeUtils.unixTimestamp(utcNow);
    final unixMs = TimeUtils.unixTimestampMs(utcNow);
    final gps = TimeUtils.gpsTime(utcNow);
    final tai = TimeUtils.taiSeconds(utcNow);

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        const SectionHeader(label: AppStrings.sectionEpoch),
        const SizedBox(height: 8),
        TimeRow(
          label: AppStrings.labelUnixSeconds,
          value: unix.toString(),
        ),
        const SizedBox(height: 12),
        TimeRow(
          label: AppStrings.labelUnixMs,
          value: unixMs.toString(),
        ),
        const Divider(height: 40),
        const SectionHeader(label: AppStrings.sectionAtomicGps),
        const SizedBox(height: 8),
        TimeRow(
          label: AppStrings.labelTai,
          value: tai.toString(),
        ),
        const SizedBox(height: 12),
        TimeRow(
          label: AppStrings.labelGps,
          value: gps.toString(),
        ),
      ],
    );
  }
}