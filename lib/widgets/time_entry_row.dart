import 'package:flutter/material.dart';
import '../models/time_entry.dart';
import '../l10n/app_localizations.dart';
import 'time_string_row.dart';
import 'binary_columns_clock.dart';
import 'binary_coded_decimal_clock.dart';

// Renders a TimeEntry as a display row – text value or graphical widget.
// Used by ConfigurableTab and CuriositiesTab.
class TimeEntryRow extends StatelessWidget {
  final TimeEntry entry;
  final DateTime now;
  final String locale;
  final bool hourFormat24;
  final bool thousandsSep;

  const TimeEntryRow({
    super.key,
    required this.entry,
    required this.now,
    required this.locale,
    this.hourFormat24 = true,
    this.thousandsSep = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (entry.type == ValueType.binaryClockColumns) {
      return _GraphicalRow(
        label: entry.localizedLabel(l10n),
        info: entry.localizedInfo(l10n),
        graphicalClock: ColumnBinaryClock(now: now, l10n: l10n),
      );
    }
    if (entry.type == ValueType.binaryClockBcd) {
      return _GraphicalRow(
        label: entry.localizedLabel(l10n),
        info: entry.localizedInfo(l10n),
        graphicalClock: BcdBinaryClock(now: now, l10n: l10n),
      );
    }

    return TimeStringRow(
      label: entry.localizedLabel(l10n),
      value: entry.computeValue(
        now,
        locale,
        hourFormat24: hourFormat24,
        thousandsSep: thousandsSep,
      ),
      info: entry.localizedInfo(l10n),
      useThousands: entry.useThousands && thousandsSep,
    );
  }
}

// Internal widget: label + info button flush with the graphic below.
// The Row height matches exactly the label line, avoiding the excess
// whitespace that occurs when TimeRow renders an empty value string.
class _GraphicalRow extends StatelessWidget {
  final String label;
  final String info;
  final Widget graphicalClock;

  const _GraphicalRow({
    required this.label,
    required this.info,
    required this.graphicalClock,
  });

  void _showInfo(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        content: Text(info),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.5,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                ),
              ),
              const SizedBox(height: 4),
              graphicalClock,
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.info_outline, size: 20),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.aboutThisValue,
          onPressed: () => _showInfo(context, l10n),
        ),
      ],
    );
  }
}