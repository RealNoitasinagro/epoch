import 'package:epoch/models/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart' as tz;
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
      AppLocalizations l10n,
      {
        String localIanaZone = 'UTC',
        bool hourFormat24 = true,
        bool thousandsSep = true,
        bool showDateDetails = true,
        ZoneDisplayMode zoneDisplayMode = ZoneDisplayMode.full,
        double? longitude,
      }
    ) {
    final formattedValue = TimeValueFormatter.format(
      timeValue, now, locale,
      localIanaZone: localIanaZone,
      hourFormat24: hourFormat24,
      thousandsSep: thousandsSep,
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

    // Determine zone-related line2:
    String? zoneLine;
    if (subtitle == null && split.line2.isNotEmpty) {
      final ianaZone = switch (timeValue.zone) {
        ZoneLocal()                  => localIanaZone,
        ZoneNamed(ianaZone: final z) => z,
        ZoneUtc()                    => null,
      };

      if (ianaZone != null &&
          timeValue.timezoneClockChangeMode == TimezoneClockChangeMode.auto) {
        // DST warning takes precedence over ZoneDisplayMode:
        final warning = _dstWarning(ianaZone, now.toUtc(), l10n);
        if (warning != null) {
          zoneLine = warning;
        }
      }

      // No warning – apply ZoneDisplayMode to the existing split.line2:
      if (zoneLine == null) {
        zoneLine = _applyZoneDisplayMode(split.line2, zoneDisplayMode);
      }
    }

    return (
      line1: split.line1,
      line2: subtitle ?? zoneLine ?? '',
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

  static String? _dstWarning(
      String ianaZone, DateTime nowUtc, AppLocalizations l10n) {
    if (!TimeUtils.hasDaylightSavingTime(ianaZone)) return null;
    final next = TimeUtils.nextDstTransition(ianaZone, nowUtc);
    if (next == null) return null;

    final localNow  = nowUtc.toLocal();
    final nowDate   = DateTime(localNow.year, localNow.month, localNow.day);
    final localNext = next.toLocal();
    final nextDate  = DateTime(localNext.year, localNext.month, localNext.day);
    final daysUntil = nextDate.difference(nowDate).inDays;
    if (daysUntil > 7) return null;

    // Abbreviations before and after the transition:
    final loc = tz.getLocation(ianaZone);
    final abbrBefore = tz.TZDateTime.from(
        next.subtract(const Duration(hours: 1)), loc).timeZone.abbreviation;
    final abbrAfter = tz.TZDateTime.from(
        next.add(const Duration(hours: 1)), loc).timeZone.abbreviation;
    final arrow = '$abbrBefore → $abbrAfter';

    if (daysUntil == 0) return '$arrow ${l10n.labelDstChangeToday}';
    if (daysUntil == 1) return '$arrow ${l10n.labelDstChangeTomorrow}';
    return '$arrow ${l10n.labelDstChangeInDays(daysUntil)}';
  }

  // Transforms "CEST (UTC+02:00)" according to ZoneDisplayMode.
  // Input is always the full format from splitZoneOffset.
  static String? _applyZoneDisplayMode(String fullZoneLine, ZoneDisplayMode mode) {
    if (fullZoneLine.isEmpty) return null;
    return switch (mode) {
      ZoneDisplayMode.hidden       => null,
      ZoneDisplayMode.full         => fullZoneLine,
      ZoneDisplayMode.abbreviation => _extractAbbreviation(fullZoneLine),
      ZoneDisplayMode.offsetLong   => _extractOffset(fullZoneLine, 'long'),
      ZoneDisplayMode.offsetShort  => _extractOffset(fullZoneLine, 'short'),
      ZoneDisplayMode.offsetMini   => _extractOffset(fullZoneLine, 'mini'),
    };
  }

  // "CEST (UTC+02:00)" -> "CEST"
  static String _extractAbbreviation(String zoneLine) {
    final spaceIdx = zoneLine.indexOf(' ');
    return spaceIdx > 0 ? zoneLine.substring(0, spaceIdx) : zoneLine;
  }

  // long: "CEST (UTC+02:00)" -> "UTC+02:00"
  // short: "CEST (UTC+02:00)" -> "+02:00"
  // mini: "CEST (UTC+02:00)" -> "+2"
  static String _extractOffset(String zoneLine, String format) {
    final match = RegExp(r'UTC([+−])([0-9]{2}):([0-9]{2})').firstMatch(zoneLine);
    if (match == null) return zoneLine;
    final sign    = match.group(1)!;
    final hours   = int.parse(match.group(2)!);
    final minutes = int.parse(match.group(3)!);
    return switch (format) {
      'long'  => 'UTC$sign${match.group(2)}:${match.group(3)}',
      'short' => '$sign${match.group(2)}:${match.group(3)}',
      'mini'  => minutes == 0
          ? '$sign$hours'
          : '$sign$hours:${match.group(3)}',
      _       => zoneLine,
    };
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
      localIanaZone: localIanaZone,
      hourFormat24: hourFormat24,
      thousandsSep: thousandsSep,
      showDateDetails: showDateDetails,
      zoneDisplayMode: EpochApp.of(context).zoneDisplayMode,
      longitude: longitude,
    );
    String label = computeLabel(l10n, timeValue, longitude);
    String clipboardValue = display.line1 + '\n' + display.line2;

    return ValueTile(
      label: label,
      showZoneIndicator: !timeValue.isZoneIndependent,
      showPinnedIndicator: timeValue.timezoneClockChangeMode != TimezoneClockChangeMode.auto,
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