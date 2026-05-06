import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../time_utils.dart';
import '../widgets/section_header.dart';
import '../widgets/time_row.dart';

class TechnicalTab extends StatelessWidget {
  final DateTime now;
  final bool thousandsSep;

  const TechnicalTab({super.key, required this.now, this.thousandsSep = true});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final utcNow = now.toUtc();
    final unix = TimeUtils.unixTimestamp(utcNow);
    final gps = TimeUtils.gpsTime(utcNow);
    final tai = TimeUtils.taiSeconds(utcNow);

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        SectionHeader(label: l10n.sectionEpoch),
        const SizedBox(height: 8),
        TimeRow(
          label: l10n.labelUnixSeconds,
          value: unix.toString(),
          useThousands: thousandsSep,
          info: l10n.infoUnixSeconds,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionAtomicGps),
        const SizedBox(height: 8),
        TimeRow(
          label: l10n.labelTai,
          value: tai.toString(),
          useThousands: thousandsSep,
          info: l10n.infoTai,
        ),
        const SizedBox(height: 12),
        TimeRow(
          label: l10n.labelGps,
          value: gps.toString(),
          useThousands: thousandsSep,
          info: l10n.infoGps,
        ),
      ],
    );
  }
}