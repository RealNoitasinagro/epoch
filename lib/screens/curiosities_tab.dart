import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../time_utils.dart';
import '../widgets/section_header.dart';
import '../widgets/time_row.dart';
import '../widgets/binary_coded_decimal_clock.dart';
import '../widgets/binary_columns_clock.dart';

class CuriositiesTab extends StatelessWidget {
  final DateTime now;
  const CuriositiesTab({super.key, required this.now});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final utcNow = now.toUtc();
    final beats = TimeUtils.swatchBeats(utcNow);

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        SectionHeader(label: l10n.sectionSwatch),
        const SizedBox(height: 8),
        TimeRow(
          label: l10n.labelSwatchBeats,
          //value: '@${beats.toStringAsFixed(2)}',
          value: '@${beats.toStringAsFixed(0)}',
          info: l10n.infoSwatch,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionBinaryClock),
        const SizedBox(height: 8),
        TimeRow(
          label: l10n.labelBinaryClockColumns,
          info: l10n.infoBinaryClock,
          value: '',
        ),
        const SizedBox(height: 24),
        TimeRow(
          label: l10n.labelBinaryClockBcd,
          info: l10n.infoBinaryClockBcd,
          value: '',
        ),
        const SizedBox(height: 24),
        // Compact string representation.
        TimeRow(
          label: l10n.labelBinaryClockString,
          value: TimeUtils.binaryTimeString(now),
          info: l10n.infoBinaryClockString,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionDoomsday),
        const SizedBox(height: 8),
        TimeRow(
          label: l10n.labelDoomsdayClock,
          value: '23:58:35',
          info: l10n.infoDoomsday,
        ),
        const SizedBox(height: 8),
        _DoomsdayLink(l10n: l10n),
      ],
    );
  }
}

class _DoomsdayLink extends StatelessWidget {
  final AppLocalizations l10n;
  const _DoomsdayLink({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(l10n.doomsdayLink);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
      child: Text(
        l10n.doomsdayLink,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}