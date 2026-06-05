import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../time_utils.dart';

// One column per unit (H, M, S), top-aligned, most significant bit at top.
class BinaryColumnsClock extends StatelessWidget {
  final DateTime now;
  final AppLocalizations l10n;
  const BinaryColumnsClock({super.key, required this.now, required this.l10n});

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
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(150),),
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