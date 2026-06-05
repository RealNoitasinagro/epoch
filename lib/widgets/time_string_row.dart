import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../time_value_formatter.dart';
import 'time_value_row.dart';
import 'value_tile.dart';

class TimeStringRow extends TimeValueRow {
  final String locale;
  final bool hourFormat24;
  final bool thousandsSep;

  const TimeStringRow({
    super.key,
    required super.timeValue,
    required super.now,
    required this.locale,
    this.hourFormat24 = true,
    this.thousandsSep = true,
    super.infoLinkOverride,
  });

  static ({String line1, String line2}) splitZoneOffset(String value) {
    final match = RegExp(
      r'\b\w+\s+\(UTC[+−][0-9]{2}:[0-9]{2}\)',
    ).firstMatch(value);
    if (match == null) return (line1: value, line2: '');
    return (
    line1: value.substring(0, match.start).trim(),
    line2: match.group(0)!,
    );
  }

  void _copyToClipboard(BuildContext context, AppLocalizations l10n,
      String displayValue) {
    // Clipboard gets the formatted display value for consistency.
    final label = timeValue.localizedLabel(l10n);
    Clipboard.setData(ClipboardData(text: '$label: $displayValue'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.copiedToClipboard(label)),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localIanaZone = EpochApp.of(context).localIanaZone;

    final computed = TimeValueFormatter.format(
      timeValue,
      now,
      locale,
      hourFormat24: hourFormat24,
      thousandsSep: thousandsSep,
      localIanaZone: localIanaZone,
    );
    final split = splitZoneOffset(computed);

    return ValueTile(
      label: timeValue.localizedLabel(l10n),
      content: TextValueContent(line1: split.line1, line2: split.line2),
      actionSlots: [
        IconButton(
          icon: const Icon(Icons.info_outline, size: 20),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.aboutThisValue,
          onPressed: () => showInfo(context, l10n),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 20),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.copyToClipboard,
          onPressed: () => _copyToClipboard(context, l10n, computed),
        ),
        null,
      ],
    );
  }
}