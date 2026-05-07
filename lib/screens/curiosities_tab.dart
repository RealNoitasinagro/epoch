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
        // Column-style binary clock (one column per unit).
        TimeRow(
          label: l10n.labelBinaryClockColumns,
          value: '',
          info: l10n.infoBinaryClock,
        ),
        const SizedBox(height: 8),
        _ColumnBinaryClock(now: now, l10n: l10n),
        const SizedBox(height: 24),
        // BCD-style binary clock (two columns per digit, like Wikipedia).
        TimeRow(
          label: l10n.labelBinaryClockBcd,
          value: '',
          info: l10n.infoBinaryClockBcd,
        ),
        const SizedBox(height: 8),
        _BcdBinaryClock(now: now, l10n: l10n),
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

// One column per unit (H, M, S), top-aligned, most significant bit at top.
class _ColumnBinaryClock extends StatelessWidget {
  final DateTime now;
  final AppLocalizations l10n;
  const _ColumnBinaryClock({required this.now, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final bin = TimeUtils.binaryTime(now);
    final litColor = Theme.of(context).colorScheme.primary;
    final dimColor = Theme.of(context).colorScheme.outline;

    // Max column height is 6 bits (minutes/seconds).
    // Hours column (5 bits) gets one empty slot at top to align bit values.
    Widget bitColumn(String bits, String header, int totalRows) {
      final padding = totalRows - bits.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            header,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          // Empty spacers for alignment.
          ...List.generate(padding, (_) => const SizedBox(height: 28)),
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
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bitColumn(bin.hours,   l10n.labelHours,   6),
        const SizedBox(width: 16),
        bitColumn(bin.minutes, l10n.labelMinutes, 6),
        const SizedBox(width: 16),
        bitColumn(bin.seconds, l10n.labelSeconds, 6),
      ],
    );
  }
}

// BCD-style: two columns per unit (tens digit, units digit).
class _BcdBinaryClock extends StatelessWidget {
  final DateTime now;
  final AppLocalizations l10n;
  const _BcdBinaryClock({required this.now, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final bcd = TimeUtils.bcdTime(now);
    final litColor = Theme.of(context).colorScheme.primary;
    final dimColor = Theme.of(context).colorScheme.outline;

    Widget bitColumn(String bits, int totalRows) {
      final padding = totalRows - bits.length;
      return Column(
        children: [
          ...List.generate(padding, (_) => const SizedBox(height: 28)),
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
        ],
      );
    }

    // Group header above two columns.
    Widget groupLabel(String label) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );

    // BCD max rows: hourTens=2, hourUnits=4, minTens=3, minUnits=4, etc.
    // Tallest column is 4 bits.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group headers.
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 50, child: groupLabel(l10n.labelHours)),
            const SizedBox(width: 8),
            SizedBox(width: 50, child: groupLabel(l10n.labelMinutes)),
            const SizedBox(width: 8),
            SizedBox(width: 50, child: groupLabel(l10n.labelSeconds)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bitColumn(bcd.hourTens,  2),
            const SizedBox(width: 6),
            bitColumn(bcd.hourUnits, 4),
            const SizedBox(width: 8),
            bitColumn(bcd.minTens,   3),
            const SizedBox(width: 6),
            bitColumn(bcd.minUnits,  4),
            const SizedBox(width: 8),
            bitColumn(bcd.secTens,   3),
            const SizedBox(width: 6),
            bitColumn(bcd.secUnits,  4),
          ],
        ),
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
        final uri = Uri.parse('https://thebulletin.org/doomsday-clock/');
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