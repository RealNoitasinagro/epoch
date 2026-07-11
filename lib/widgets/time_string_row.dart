import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
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

  static ({String line1, String line2}) computeDisplay(
      TimeValue timeValue,
      DateTime now,
      String locale,
      AppLocalizations l10n, {
        bool hourFormat24 = true,
        bool thousandsSep = true,
        String localIanaZone = 'UTC',
        double? longitude,
        bool showDateDetails = true,
      }) {
    final formattedValue = TimeValueFormatter.format(
      timeValue, now, locale,
      hourFormat24: hourFormat24,
      thousandsSep: thousandsSep,
      localIanaZone: localIanaZone,
      longitude: longitude,
    );

    String? subtitle;
    final zonedNow = switch (timeValue.zone) {
      ZoneLocal()                  => now,
      ZoneUtc()                    => now.toUtc(),
      ZoneNamed(ianaZone: final z) => TimeUtils.inZone(now.toUtc(), z),
    };

    if (timeValue.valueType == ValueType.date && showDateDetails) {
      subtitle = l10n.dataDateSub(
          TimeUtils.isoWeekNumber(zonedNow), TimeUtils.dayOfYear(zonedNow));
    } else if (timeValue.valueType == ValueType.gmst ||
        timeValue.valueType == ValueType.lmst) {
      final hours = TimeValueFormatter.hmsToHours(formattedValue);
      if (hours != null) {
        final deg = TimeValueFormatter.formatDecimal(
            hours * 15.0, locale, 4, thousandsSep: false);
        subtitle = '$deg°';
      }
    }

    final split = splitZoneOffset(formattedValue);
    return (
      line1: split.line1,
      line2: subtitle ?? split.line2,
    );
  }

  static ({String line1, String line2}) splitZoneOffset(String value) {
    final match = RegExp(
      r'(?:[+-]\d{2}(?:\d{2})?|\w+)\s+\(UTC[+−][0-9]{2}:[0-9]{2}\)',
    ).firstMatch(value);
    if (match == null) return (line1: value, line2: '');
    return (
      line1: value.substring(0, match.start).trim(),
      line2: match.group(0)!,
    );
  }

  static String computeLabel(AppLocalizations l10n,
      TimeValue timeValue, double? longitude) {
    return timeValue.valueType == ValueType.lmst
        ? TimeValueFormatter.lmstLabelWithLon(l10n, timeValue, longitude)
        : timeValue.localizedDisplayLabel(l10n);
  }

  void _copyToClipboard(BuildContext context, AppLocalizations l10n,
      String label, String displayValue) {
    Clipboard.setData(ClipboardData(text: '$label: $displayValue'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.messageCopiedToClipboard(label)),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localIanaZone = EpochApp.of(context).localIanaZone;

    final display = computeDisplay(
      timeValue, now, locale, l10n,
      hourFormat24: hourFormat24,
      thousandsSep: thousandsSep,
      localIanaZone: localIanaZone,
      longitude: longitude,
      showDateDetails: showDateDetails,
    );
    String label = computeLabel(l10n, timeValue, longitude);
    String clipboardValue = display.line1 + '\n' + display.line2;

    return ValueTile(
      label: label,
      showZoneIndicator: !timeValue.isZoneIndependent,
      showPinnedIndicator: timeValue.timezoneDisplayMode != TimezoneDisplayMode.auto,
      dstStatusIndicator: timeValue.getDstStatusIndicator(now.toUtc(), localIanaZone),
      content: Tooltip(
        message: l10n.hintFocusScreenOpen,
        waitDuration: const Duration(milliseconds: 1000),
        child:  TextValueContent(
          line1: display.line1,
          line2: display.line2,
          onDoubleTap: () => openFocusScreen(context, locale),
        ),
      ),
      actionSlots: [
        IconButton(
          icon: const Icon(Icons.info_outline, size: kIconSizeDefault),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.hintAboutThisValue,
          onPressed: () => showInfo(context, l10n),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: kIconSizeDefault),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.hintCopyToClipboard,
          onPressed: () => _copyToClipboard(context, l10n, label, clipboardValue),
        ),
        null,
      ],
    );
  }
}