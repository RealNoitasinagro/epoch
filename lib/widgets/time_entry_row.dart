import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../models/time_entry.dart';
import '../l10n/app_localizations.dart';
import 'time_string_row.dart';
import 'value_tile.dart';
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
  final String? infoLink; // optional override; falls back to entry.localizedInfoLink

  const TimeEntryRow({
    super.key,
    required this.entry,
    required this.now,
    required this.locale,
    this.hourFormat24 = true,
    this.thousandsSep = true,
    this.infoLink,
  });

  void _showInfo(BuildContext context, AppLocalizations l10n) {
    // Prefer explicit infoLink, fall back to entry's localized link.
    final link = infoLink ?? entry.localizedInfoLink(l10n);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(entry.localizedLabel(l10n)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.localizedInfo(l10n)),
            if (link != null) ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final uri = Uri.parse(link);
                  await launchUrl(uri,
                      mode: LaunchMode.externalApplication);
                },
                child: Text(
                  link,
                  style: TextStyle(
                    color: Theme.of(ctx).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ],
        ),
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
    final String localIanaZone = EpochApp.of(context).localIanaZone;

    if (entry.type == ValueType.binaryClockColumns ||
        entry.type == ValueType.binaryClockBcd) {
      return ValueTile(
        label: entry.localizedLabel(l10n),
        height: ValueTile.graphicTileHeight,
        content: GraphicValueContent(
          clock: entry.type == ValueType.binaryClockColumns
              ? ColumnBinaryClock(now: now, l10n: l10n)
              : BcdBinaryClock(now: now, l10n: l10n),
        ),
        actionSlots: [
          IconButton(
            icon: const Icon(Icons.info_outline, size: 20),
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            tooltip: l10n.aboutThisValue,
            onPressed: () => _showInfo(context, l10n),
          ),
          null, // no copy button for graphical values
          null, // third slot empty
        ],
      );
    }

    // Text-based value – delegate to TimeStringRow which uses ValueTile.
    return TimeStringRow(
      label: entry.localizedLabel(l10n),
      value: entry.computeValue(
        now,
        locale,
        hourFormat24: hourFormat24,
        thousandsSep: thousandsSep,
        localIanaZone: localIanaZone,
      ),
      info: entry.localizedInfo(l10n),
      useThousands: entry.useThousands && thousandsSep,
    );
  }
}