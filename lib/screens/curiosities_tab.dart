import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../time_utils.dart';
import '../widgets/section_header.dart';
import '../widgets/time_row.dart';

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
          value: '@${beats.toStringAsFixed(2)}',
          info: l10n.infoSwatch,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionBinaryClock),
        const SizedBox(height: 8),
        _BinaryClockWidget(now: now),
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

// Displays a visual binary clock with columns for hours, minutes, seconds.
class _BinaryClockWidget extends StatelessWidget {
  final DateTime now;
  const _BinaryClockWidget({required this.now});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bin = TimeUtils.binaryTime(now);
    final textTheme = Theme.of(context).textTheme;
    final dimColor = Theme.of(context).colorScheme.outline;
    final litColor = Theme.of(context).colorScheme.primary;

    // Helper: renders a column of bits top-to-bottom.
    Widget bitColumn(String bits, String header) {
      return Column(
        children: [
          Text(
            header,
            style: textTheme.labelSmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          ...bits.split('').map((b) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: b == '1' ? litColor : dimColor.withAlpha(60),
                border: Border.all(
                  color: b == '1' ? litColor : dimColor,
                  width: 1.5,
                ),
              ),
            ),
          )),
          const SizedBox(height: 6)
        ],
      );
    }

    // Decimal readout below the dots for reference.
    final decimalStr =
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bitColumn(bin.hours,   l10n.labelHours),
            const SizedBox(width: 16),
            bitColumn(bin.minutes, l10n.labelMinutes),
            const SizedBox(width: 16),
            bitColumn(bin.seconds, l10n.labelSeconds),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          decimalStr,
          style: textTheme.bodySmall?.copyWith(
            fontFamily: 'monospace',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// Tappable link to the Bulletin of the Atomic Scientists.
class _DoomsdayLink extends StatelessWidget {
  final AppLocalizations l10n;
  const _DoomsdayLink({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse('https://thebulletin.org/doomsday-clock/');
        if (await canLaunchUrl(uri)) await launchUrl(uri);
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