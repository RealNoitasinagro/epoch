import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../time_utils.dart';

// BCD-style: two columns per unit (tens digit, units digit).
class BcdBinaryClock extends StatelessWidget {
  final DateTime now;
  final AppLocalizations l10n;
  const BcdBinaryClock({super.key, required this.now, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final bcd = TimeUtils.bcdTime(now);
    final litColor = Theme.of(context).colorScheme.primary;
    final dimColor = Theme.of(context).colorScheme.outline;

    Widget bitColumn(String bits, int totalRows) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: bits.split('').map((b) => Padding(
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
        )).toList(),
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
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(150),),
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
          crossAxisAlignment: CrossAxisAlignment.end, // align bottoms
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