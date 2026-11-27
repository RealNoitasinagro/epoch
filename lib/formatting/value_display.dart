import '../l10n/app_localizations.dart';
import '../models/time_value.dart';
import '../settings/app_settings.dart';
import '../time/fuzzy_time.dart';
import '../time/time_utils.dart';
import '../time/zone_abbreviations.dart';
import '../time/zoned_moment.dart';
import 'fuzzy_time_words.dart';
import 'time_value_formatter.dart';
import 'time_value_texts.dart';
import 'value_format_settings.dart';

String? _dstWarning(
  String ianaZone,
  DateTime nowUtc,
  String localIanaZone,
  AppLocalizations l10n,
) {
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
  final after = localizeTimezoneAbbr(abbrs.after, l10n.localeName);
  final arrow = '$before → $after';

  if (daysUntil == 0) return '$arrow ${l10n.labelDstChangeToday}';
  if (daysUntil == 1) return '$arrow ${l10n.labelDstChangeTomorrow}';
  return '$arrow ${l10n.labelDstChangeInDays(daysUntil)}';
}

// "CEST (UTC+02:00)" -> "CEST"
String _extractAbbreviation(String zoneLine) {
  final spaceIdx = zoneLine.indexOf(' ');
  return spaceIdx > 0 ? zoneLine.substring(0, spaceIdx) : zoneLine;
}

// Transforms "CEST (UTC+02:00)" according to ZoneDisplayMode.
// Input is always the full format from splitZoneOffset.
String? _applyZoneDisplayMode(String fullZoneLine, ZoneDisplayMode mode) {
  if (fullZoneLine.isEmpty) return null;
  return switch (mode) {
    ZoneDisplayMode.hidden => null,
    ZoneDisplayMode.full => fullZoneLine,
    ZoneDisplayMode.abbreviation => _extractAbbreviation(fullZoneLine),
    ZoneDisplayMode.offsetLong => _extractOffset(fullZoneLine, 'long'),
    ZoneDisplayMode.offsetShort => _extractOffset(fullZoneLine, 'short'),
    ZoneDisplayMode.offsetMini => _extractOffset(fullZoneLine, 'mini'),
  };
}

// long: "CEST (UTC+02:00)" -> "UTC+02:00"
// short: "CEST (UTC+02:00)" -> "+02:00"
// mini: "CEST (UTC+02:00)" -> "+2"
String _extractOffset(String zoneLine, String format) {
  final match = RegExp(r'UTC([+−])([0-9]{2}):([0-9]{2})').firstMatch(zoneLine);
  if (match == null) return zoneLine;
  final sign = match.group(1)!;
  final hours = int.parse(match.group(2)!);
  final minutes = int.parse(match.group(3)!);
  return switch (format) {
    'long' => 'UTC$sign${match.group(2)}:${match.group(3)}',
    'short' => '$sign${match.group(2)}:${match.group(3)}',
    'mini' => minutes == 0 ? '$sign$hours' : '$sign$hours:${match.group(3)}',
    _ => zoneLine,
  };
}

/// Two equal lines: no zone line, no clock change notice.
({String line1, String line2}) _fuzzyDisplay(
  TimeValue timeValue,
  DateTime now,
  AppLocalizations l10n,
  ValueFormatSettings settings,
) {
  final level = timeValue.options.effectiveFuzzyLevel;
  final wallClock = ZonedMoment.of(
    timeValue,
    now,
    settings.localIanaZone,
  ).wallClock;
  final lines = layoutFuzzyLines(
    fuzzyTimeSegments(quantizeFuzzyTime(wallClock, level), level, l10n),
  );
  return (line1: lines.first, line2: lines.length > 1 ? lines[1] : '');
}

({String line1, String line2}) computeDisplay(
  TimeValue timeValue,
  DateTime now,
  String locale,
  AppLocalizations l10n, {
  ValueFormatSettings settings = const ValueFormatSettings(),
}) {
  if (timeValue.valueType == ValueType.fuzzyTime) {
    return _fuzzyDisplay(timeValue, now, l10n, settings);
  }

  final formattedValue = TimeValueFormatter.format(
    timeValue,
    now,
    locale,
    settings: settings,
  );

  final moment = ZonedMoment.of(timeValue, now, settings.localIanaZone);

  String? subtitle;
  if (timeValue.valueType == ValueType.date &&
      settings.showsDetails(timeValue)) {
    subtitle = l10n.dataDateSub(
      TimeUtils.isoWeekNumber(moment.wallClock),
      TimeUtils.dayOfYear(moment.wallClock),
    );
  } else if ((timeValue.valueType == ValueType.gmst ||
          timeValue.valueType == ValueType.lmst) &&
      settings.showsDetails(timeValue)) {
    final hours = TimeValueFormatter.hmsToHours(formattedValue);
    if (hours != null) {
      final deg = TimeValueFormatter.formatDecimal(
        hours * 15.0,
        locale,
        4,
        thousandsSep: false,
      );
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
      final warning = _dstWarning(
        ianaZone,
        now.toUtc(),
        settings.localIanaZone,
        l10n,
      );
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

  return (line1: split.line1, line2: subtitle ?? zoneLine ?? '');
}

String computeLabel(
  AppLocalizations l10n,
  TimeValue timeValue,
  double? longitude,
) {
  return timeValue.valueType == ValueType.lmst
      ? TimeValueFormatter.lmstLabelWithLon(l10n, timeValue, longitude)
      : timeValue.localizedDisplayLabel(l10n);
}

String computeClipboardDisplay(
  TimeValue timeValue,
  ({String line1, String line2}) display,
) {
  if (timeValue.valueType == ValueType.fuzzyTime) {
    return [display.line1, display.line2].where((l) => l.isNotEmpty).join(' ');
  }

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

({String line1, String line2}) splitZoneOffset(String value) {
  final match = RegExp(
    r'(?:[+-]\d{2}(?:\d{2})?|\w+)\s+\(UTC[+−][0-9]{2}:[0-9]{2}\)',
  ).firstMatch(value);
  if (match == null) return (line1: value, line2: '');
  return (
    line1: value.substring(0, match.start).trim(),
    line2: match.group(0)!,
  );
}
