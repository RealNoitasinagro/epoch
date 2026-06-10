import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/time_value.dart';
import '../time_utils.dart';
import '../time_value_formatter.dart';
import 'time_value_row.dart';
import 'value_tile.dart';

class TimeStringRow extends TimeValueRow {
  final String locale;
  final bool hourFormat24;
  final bool thousandsSep;
  final bool showDateDetails;
  final double? longitude;

  const TimeStringRow({
    super.key,
    required super.timeValue,
    required super.now,
    required this.locale,
    this.hourFormat24 = true,
    this.thousandsSep = true,
    this.showDateDetails = true,
    this.longitude,
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
    final label = _computeLabel(l10n);
    Clipboard.setData(ClipboardData(text: '$label: $displayValue'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.copiedToClipboard(label)),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String? _computeSubtitle(AppLocalizations l10n) {
    if (timeValue.type == ValueType.date && showDateDetails) {
      final dt = switch (timeValue.zone) {
        ZoneLocal()                  => now,
        ZoneUtc()                    => now.toUtc(),
        ZoneNamed(ianaZone: final z) => TimeUtils.inZone(now.toUtc(), z),
      };
      return l10n.dateSubtitle(
          TimeUtils.isoWeekNumber(dt), TimeUtils.dayOfYear(dt));
    }
    if (timeValue.type == ValueType.gmst ||
        timeValue.type == ValueType.lmst) {
      final computed = TimeValueFormatter.format(
        timeValue, now, locale,
        longitude: longitude,
      );
      final hours = TimeValueFormatter.hmsToHours(computed);
      if (hours != null) {
        final deg = TimeValueFormatter.formatDecimal(
            hours * 15.0, locale, 4, thousandsSep: false);
        return '$deg°';
      }
    }
    return null;
  }

  String _computeLabel(AppLocalizations l10n) {
    return timeValue.type == ValueType.lmst
        ? TimeValueFormatter.lmstLabelWithLon(l10n, timeValue, longitude)
        : timeValue.localizedDisplayLabel(l10n);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localIanaZone = EpochApp.of(context).localIanaZone;

    final formattedValue = TimeValueFormatter.format(
      timeValue,
      now,
      locale,
      hourFormat24: hourFormat24,
      thousandsSep: thousandsSep,
      localIanaZone: localIanaZone,
      longitude: longitude,
    );

    String? subtitle = _computeSubtitle(l10n);
    final split = splitZoneOffset(formattedValue);
    final line2 = subtitle ?? split.line2;
    final clipboardValue = subtitle != null
        ? '$formattedValue\n$subtitle'
        : formattedValue;
    String label = _computeLabel(l10n);

    return ValueTile(
      label: label,
      showZoneIndicator: !timeValue.isZoneIndependent,
      content: TextValueContent(line1: split.line1, line2: line2),
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
          onPressed: () => _copyToClipboard(context, l10n, clipboardValue),
        ),
        null,
      ],
    );
  }
}