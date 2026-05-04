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
          useThousands: true,
          info: 'Unix time counts the seconds elapsed since the Unix epoch: '
              '1970-01-01 00:00:00 UTC. It does not account for leap seconds.',
        ),
        const Divider(height: 40),
        const SectionHeader(label: AppStrings.sectionAtomicGps),
        const SizedBox(height: 8),
        TimeRow(
          label: AppStrings.labelTai,
          value: tai.toString(),
          useThousands: true,
          info: 'International Atomic Time (TAI) is a continuous time scale '
              'based on atomic clocks. It currently runs 37 seconds ahead of UTC, '
              'the difference growing each time a leap second is added to UTC.',
        ),
        const SizedBox(height: 12),
        TimeRow(
          label: AppStrings.labelGps,
          value: gps.toString(),
          useThousands: true,
          info: 'GPS time counts seconds since 1980-01-06 00:00:00 UTC and does '
              'not include leap seconds. It currently runs 18 seconds ahead of UTC.',
        ),
      ],
    );
  }
}