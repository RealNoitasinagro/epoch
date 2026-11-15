import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/app_settings.dart';
import '../models/time_value.dart';
import '../models/timezone_abbreviation_localization.dart';
import '../models/value_format_settings.dart';
import '../time_utils.dart';
import '../time_value_formatter.dart';
import '../zoned_moment.dart';
import 'time_value_row.dart';
import 'value_tile.dart';

class TimeStringRow extends TimeValueRow {
  final String locale;

  const TimeStringRow({
    super.key,
    required super.timeValue,
    required super.now,
    required this.locale,
    super.infoLinkOverride,
  });

  static ({String line1, String line2}) computeDisplay(
      TimeValue timeValue,
      DateTime now,
      String locale,
      AppLocalizations l10n,
      { ValueFormatSettings settings = const ValueFormatSettings(), }
    ) {
    final formattedValue = TimeValueFormatter.format(
      timeValue, now, locale,
      settings: settings
    );

    final moment = ZonedMoment.of(timeValue, now, settings.localIanaZone);

    String? subtitle;
    if (timeValue.valueType == ValueType.date && settings.showsDetails(timeValue)) {
      subtitle = l10n.dataDateSub(TimeUtils.isoWeekNumber(moment.wallClock),
          TimeUtils.dayOfYear(moment.wallClock));
    } else if ((timeValue.valueType == ValueType.gmst ||
        timeValue.valueType == ValueType.lmst) &&
        settings.showsDetails(timeValue)) {
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
      String? ianaZone = moment.ianaZone;

      if (ianaZone != null &&
          timeValue.timezoneClockChangeMode == TimezoneClockChangeMode.auto) {
        // DST warning takes precedence over ZoneDisplayMode:
        final warning = _dstWarning(ianaZone, now.toUtc(), settings.localIanaZone, l10n);
        if (warning != null) {
          zoneLine = warning;
        }
      }

      // No warning – apply ZoneDisplayMode to the existing split.line2:
      if (zoneLine == null) {
        zoneLine = _applyZoneDisplayMode(
          split.line2,
          settings.zoneDisplayModeFor(timeValue),
        );
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

  static String? _dstWarning(String ianaZone, DateTime nowUtc,
      String localIanaZone, AppLocalizations l10n) {
    final next = TimeUtils.nextDstTransition(ianaZone, nowUtc);
    if (next == null) return null;

    // Calendar days in the zone "local" stands for. Counted in UTC, so that
    // a clock change of that zone cannot skew the difference by an hour.
    DateTime localDate(DateTime utc) {
      final wallClock = localWallClockAt(utc, localIanaZone);
      return DateTime.utc(wallClock.year, wallClock.month, wallClock.day);
    }
    final daysUntil = localDate(next).difference(localDate(nowUtc)).inDays;
    if (daysUntil > 7) return null;

    final abbrs = TimeUtils.dstTransitionAbbreviations(ianaZone, next);
    final before = localizeTimezoneAbbr(abbrs.before, l10n.localeName);
    final after  = localizeTimezoneAbbr(abbrs.after,  l10n.localeName);
    final arrow = '$before → $after';

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

  static String computeClipboardDisplay(TimeValue timeValue, ({String line1, String line2}) display) {
    String clipboardValue = display.line2.isEmpty
        ? display.line1
        : '${display.line1}\n${display.line2}';
    if (timeValue.valueType == ValueType.romanNumeralsTime) {
      String period = '';
      if (clipboardValue.endsWith('AM') || clipboardValue.endsWith('PM')) {
        period = clipboardValue.substring(clipboardValue.length - 3);
        clipboardValue = clipboardValue.substring(0, clipboardValue.length - 3);
      }
      clipboardValue = clipboardValue.split(':').map((s) => s.trim()).join(':');
      clipboardValue += period;
    }
    return clipboardValue;
  }

  void _copyToClipboard(BuildContext context, AppLocalizations l10n,
      String label, String displayValue, { bool copyValueWithLabel = true }) {
    String clipboardText = copyValueWithLabel
        ? '$label: $displayValue'
        : displayValue;
    Clipboard.setData(ClipboardData(text: clipboardText));
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
    final app = EpochApp.of(context);
    final settings = app.formatSettings;
    final l10n = AppLocalizations.of(context)!;
    final localIanaZone = EpochApp.of(context).localIanaZone;

    final display = computeDisplay(
      timeValue, now, locale, l10n,
      settings: settings
    );
    String label = computeLabel(l10n, timeValue, settings.longitude);
    String clipboardValue = computeClipboardDisplay(timeValue, display);

    final moment = ZonedMoment.of(timeValue, now, localIanaZone);

    final Color? dayQuarterColor = app.dayQuarterColor &&
        app.themeMode != AppThemeMode.night && !timeValue.isZoneIndependent
        ? TimeUtils.dayQuarterColor(moment.wallClock.hour)
        : null;

    return ValueTile(
      label: label,
      showZoneIndicator: !timeValue.isZoneIndependent,
      showPinnedIndicator: timeValue.isPinned(now.toUtc(), localIanaZone),
      dstStatusIndicator: timeValue.getDstStatusIndicator(now.toUtc(), localIanaZone),
      content: Tooltip(
        message: l10n.hintFocusScreenOpen,
        waitDuration: const Duration(milliseconds: 1000),
        child: TextValueContent(
          line1: display.line1,
          line2: display.line2,
          dayQuarterColor: dayQuarterColor,
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
          onLongPress: () => _copyToClipboard(context, l10n, label, clipboardValue,
              copyValueWithLabel: false),
        ),
        null,
      ],
    );
  }
}
