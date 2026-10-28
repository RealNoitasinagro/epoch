import 'dart:ui';
import 'package:numerus/numerus.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:week_number/iso.dart';
import 'effective_clock.dart';
import 'layout_constants.dart';
import 'models/time_value.dart';
import 'models/zone_rules.dart';
import 'time_value_formatter.dart';

class TimeUtils {
  static const int secondsPerDay = 24 * 60 * 60;  // 86400

  /// TAI − UTC at the start of 1972, when UTC was defined as it is today.
  static const _taiMinusUtcAtStartOf1972 = 10;

  /// TAI − GPS time, constant by definition.
  static const _taiMinusGpsSeconds = 19;

  /// First UTC moment after each inserted leap second (year, month).
  /// All 27 insertions to date; none are scheduled, abolition in 2027.
  static final List<DateTime> _leapSecondBoundaries = [
    for (final (year, month) in const [
      (1972, 7), (1973, 1), (1974, 1), (1975, 1), (1976, 1), (1977, 1),
      (1978, 1), (1979, 1), (1980, 1), (1981, 7), (1982, 7), (1983, 7),
      (1985, 7), (1988, 1), (1990, 1), (1991, 1), (1992, 7), (1993, 7),
      (1994, 7), (1996, 1), (1997, 7), (1999, 1), (2006, 1), (2009, 1),
      (2012, 7), (2015, 7), (2017, 1),
    ])
      DateTime.utc(year, month),
  ];

  static const CommonRomanNumeralsConfig _romanNumeralsConfig = CommonRomanNumeralsConfig(nulla: 'N');

  static int dayOfYear(DateTime dt) => dt.ordinalDate;

  static int isoWeekNumber(DateTime dt) => dt.weekNumber;

  /// Returns TZDateTime for a given IANA time zone.
  static tz.TZDateTime inZone(DateTime utc, String ianaZone) {
    try {
      final location = tz.getLocation(ianaZone);
      return tz.TZDateTime.from(utc, location);
    } catch (_) {
      // Fallback for outdated/unknown zones:
      return tz.TZDateTime.from(utc, tz.UTC);
    }
  }

  /// Abbreviated time zone from TZDateTime, e. g. "CEST", "EST".
  static String tzAbbr(tz.TZDateTime dt) => dt.timeZone.abbreviation;

  /// UTC offset as a formatted string, e. g. "UTC+02:00".
  static String utcOffsetString(Duration offset) =>
      formatUtcOffset(offset, withUtcPrefix: true, typographicMinus: true);

  /// Returns true/false for a given time zone independently of current date.
  static bool hasDaylightSavingTime(String ianaZone, {DateTime? referenceUtc}) =>
      zoneRulesAt(ianaZone, referenceUtc ?? EffectiveClock.now().toUtc())?.hasDst ?? false;

  /// Returns the summer or winter/standard offset for a given IANA time zone.
  static ({Duration offset, String abbreviation})? daylightOrStandardOffset(
      String ianaZone, bool dst, {DateTime? referenceUtc}) {
    final rules = zoneRulesAt(ianaZone, referenceUtc ?? EffectiveClock.now().toUtc());
    if (rules == null || !rules.hasDst) return null;
    return dst
        ? (offset: rules.dstOffset, abbreviation: rules.dstAbbr)
        : (offset: rules.standardOffset, abbreviation: rules.standardAbbr);
  }

  /// Converts a UTC DateTime to local time for the given TimeValue,
  /// respecting its timezoneClockChangeMode (auto/forceDst/forceStandard).
  static DateTime resolveLocalTime(
      TimeValue timeValue,
      DateTime utcNow,
      String localIanaZone) {
    switch (timeValue.zone) {
      case ZoneLocal():
        return utcNow.toLocal();  // always auto for local
      case ZoneUtc():
        return utcNow;
      case ZoneNamed(ianaZone: final zone):
        if (timeValue.timezoneClockChangeMode != TimezoneClockChangeMode.auto) {
          final info = TimeUtils.daylightOrStandardOffset(
              zone,
              timeValue.timezoneClockChangeMode == TimezoneClockChangeMode.forceDst);
          if (info != null) {
            return utcNow.add(info.offset);
          }
        }
        return TimeUtils.inZone(utcNow, zone);
    }
  }

  /// Determine IANA zone identifier (Area/Location) from a timeValue.
  static String? resolveIanaZone(TimeValue timeValue, String localIanaZone) {
    final ianaZone = switch (timeValue.zone) {
      ZoneLocal()                  => localIanaZone,
      ZoneNamed(ianaZone: final z) => z,
      ZoneUtc()                    => null,
    };
    return ianaZone;
  }

  /// Returns the DateTime of the next clock change for a ianaZone.
  static DateTime? nextDstTransition(String ianaZone, DateTime afterUtc) {
    return nextDstTransitions(ianaZone, afterUtc, count: 1).firstOrNull;
  }

  /// Returns a list of DateTime for the next n clock changes for a ianaZone.
  static List<DateTime> nextDstTransitions(String ianaZone,
      DateTime afterUtc, {int count = 4}) {
    try {
      final loc = tz.getLocation(ianaZone);
      final afterUtcMs = afterUtc.millisecondsSinceEpoch;
      final result = <DateTime>[];
      for (final t in loc.transitionAt) {
        if (t <= afterUtcMs) continue;
        final at = DateTime.fromMillisecondsSinceEpoch(t, isUtc: true);
        if (!_changesClock(loc, at)) continue;
        result.add(at);
        if (result.length >= count) break;
      }
      return result;
    } catch (_) { return []; }
  }

  /// The package data ends with a pseudo-transition (2038-01-19 03:14:08 UTC)
  /// into the very same state; real changes alter offset, DST flag or abbreviation.
  static bool _changesClock(tz.Location loc, DateTime transitionUtc) {
    final before = tz.TZDateTime.from(
        transitionUtc.subtract(const Duration(seconds: 1)), loc).timeZone;
    final after = tz.TZDateTime.from(transitionUtc, loc).timeZone;
    return before.offset != after.offset ||
        before.isDst != after.isDst ||
        before.abbreviation != after.abbreviation;
  }

  /// Returns the timezone abbreviations immediately before and after
  /// a DST transition, e.g. ('CEST', 'CET').
  static ({String before, String after}) dstTransitionAbbreviations(
      String ianaZone, DateTime transitionUtc) {
    try {
      final loc = tz.getLocation(ianaZone);
      final before = tz.TZDateTime.from(
          transitionUtc.subtract(const Duration(hours: 1)), loc)
          .timeZone.abbreviation;
      final after = tz.TZDateTime.from(
          transitionUtc.add(const Duration(hours: 1)), loc)
          .timeZone.abbreviation;
      return (before: before, after: after);
    } catch (_) {
      return (before: '?', after: '?');
    }
  }

  /// Wall-clock readings in [ianaZone] directly before and after a clock change
  /// at [transitionUtc], e.g. 03:00:00 -> 02:00:00 for Berlin in autumn (so
  /// 02:00:00-02:59:59 occurs twice) or 02:00:00 -> 03:00:00 in spring (so
  /// 02:00:00-02:59:59 does not exist). The returned DateTimes are UTC-kind and
  /// only carry the wall-clock fields.
  static ({DateTime before, DateTime after}) wallClockAroundTransition(
      String ianaZone, DateTime transitionUtc) {
    final offsetBefore = inZone(
        transitionUtc.subtract(const Duration(seconds: 1)), ianaZone)
        .timeZoneOffset;
    final offsetAfter = inZone(transitionUtc, ianaZone).timeZoneOffset;
    return (
      before: transitionUtc.add(offsetBefore),
      after: transitionUtc.add(offsetAfter),
    );
  }

  /// Seconds elapsed since the start of the local day, and the real length of
  /// that day in [ianaZone]: 82,800 or 90,000 on days with a clock change.
  /// A midnight skipped by a clock change resolves to the transition instant,
  /// so that day simply starts later.
  static ({int elapsedSeconds, int lengthSeconds}) dayProgressInZone(
      DateTime utc, String ianaZone) {
    tz.Location location;
    try {
      location = tz.getLocation(ianaZone);
    } catch (_) {
      location = tz.UTC;  // same fallback as inZone()
    }
    final moment = tz.TZDateTime.from(utc, location);
    final dayStart =
    tz.TZDateTime(location, moment.year, moment.month, moment.day);
    final nextDayStart =
    tz.TZDateTime(location, moment.year, moment.month, moment.day + 1);
    return (
      elapsedSeconds: moment.difference(dayStart).inSeconds,
      lengthSeconds: nextDayStart.difference(dayStart).inSeconds,
    );
  }

  /// For fixed offsets (UTC, pinned standard or summer time) every day has
  /// exactly 86,400 seconds.
  static ({int elapsedSeconds, int lengthSeconds}) dayProgressFixedOffset(
      DateTime wallClock) {
    return (elapsedSeconds: daySecond(wallClock), lengthSeconds: secondsPerDay);
  }

  /// Return a color depending on what quarter of the day it is.
  static Color dayQuarterColor(DateTime utc, String? ianaZone) {
    int hour;
    if (ianaZone == null) {
      hour = utc.hour;
    } else {
      tz.TZDateTime tzDt = inZone(utc, ianaZone);
      hour = tzDt.hour;
    }
    if (hour < 6)  return kColorNightRed;
    if (hour < 12) return kColorCyan;
    if (hour < 18) return kColorAmber;
    return kColorMatrixGreen;
  }


  // ── Value Type functions ───────────────────────────────────────────────────

  /// Day second (seconds since midnight) for a DateTime.
  static int daySecond(DateTime dt) =>
      dt.hour * 3600 + dt.minute * 60 + dt.second;

  /// Percentage of the day elapsed.
  static double dayPercent(DateTime dt) {
    int currentDaySecond = daySecond(dt);
    var percent = currentDaySecond / secondsPerDay * 100;
    return percent;
  }

  /// Percentage of the hour elapsed.
  static double hourPercent(DateTime dt) {
    int secondsPerHour = 60 * 60;  // 3600
    int currentHourSecond = dt.minute * 60 + dt.second;
    var percent = currentHourSecond / secondsPerHour * 100;
    return percent;
  }

  /// Percentage of the minute elapsed.
  static double minutePercent (DateTime dt) {
    return dt.second / 60 * 100;
  }

  /// Unix timestamp in seconds.
  static int unixTimestamp(DateTime utc) =>
      utc.toUtc().millisecondsSinceEpoch ~/ 1000;

  /// TAI − UTC in seconds at the given moment. Before 1972 UTC had no leap
  /// seconds in today's sense; the 1972 value is used as an approximation.
  static int taiMinusUtcSeconds(DateTime utc) {
    final moment = utc.toUtc();
    final insertedLeapSeconds = _leapSecondBoundaries
        .where((boundary) => !boundary.isAfter(moment))
        .length;
    return _taiMinusUtcAtStartOf1972 + insertedLeapSeconds;
  }

  /// TAI: Unix time plus the leap seconds inserted so far.
  static int taiUnixTimestamp(DateTime utc) =>
      unixTimestamp(utc) + taiMinusUtcSeconds(utc);

  /// GPS time: seconds since 1980-01-06 00:00:00 UTC, including the leap
  /// seconds inserted since then (GPS itself has none).
  static int gpsTime(DateTime utc) {
    final gpsEpoch = DateTime.utc(1980, 1, 6);
    final leapSecondsSinceGpsEpoch =
        taiMinusUtcSeconds(utc) - _taiMinusGpsSeconds;
    return utc.toUtc().difference(gpsEpoch).inSeconds + leapSecondsSinceGpsEpoch;
  }

  /// Greenwich Mean Sidereal Time (GMST) in hours (0–24).
  /// Based on the IAU 1982 formula, accurate to ~0.1s for dates near J2000.
  static double gmst(DateTime utc) {
    final jd = julianDate(utc.toUtc());
    // Julian centuries since J2000.0
    final t = (jd - 2451545.0) / 36525.0;
    // GMST in seconds at 0h UT
    double gmstSec = 24110.54841
        + 8640184.812866 * t
        + 0.093104 * t * t
        - 6.2e-6 * t * t * t;
    // Add UT seconds elapsed today.
    final ut = utc.toUtc();
    final secondsToday =
        ut.hour * 3600 + ut.minute * 60 + ut.second + ut.millisecond / 1000.0;
    gmstSec += secondsToday * 1.00273790935;
    // Normalize to 0–24h.
    final hours = (gmstSec / 3600.0) % 24.0;
    return hours < 0 ? hours + 24.0 : hours;
  }

  /// Local Mean Sidereal Time (LMST) for a given longitude (in deg).
  static double lmst(DateTime utc, double longitudeDeg) {
    final gmstHours = gmst(utc);
    // LMST = GMST + longitude/15
    final lmstHours = (gmstHours + longitudeDeg / 15.0) % 24.0;
    return lmstHours < 0 ? lmstHours + 24.0 : lmstHours;
  }

  /// Julian Date for a given UTC DateTime.
  static double julianDate(DateTime utc) {
    final y = utc.year;
    final mo = utc.month;
    final d = utc.day +
        (utc.hour + utc.minute / 60.0 + utc.second / 3600.0 - 12.0) / 24.0;
    final a = ((14 - mo) / 12).floor();
    final yy = y + 4800 - a;
    final mm = mo + 12 * a - 3;
    return d +
        ((153 * mm + 2) / 5).floor() +
        365 * yy +
        (yy / 4).floor() -
        (yy / 100).floor() +
        (yy / 400).floor() -
        32045;
  }

  /// Reduced Julian Date: RJD = JD - 2400000
  static double reducedJulianDate(DateTime utc) =>
      julianDate(utc.toUtc()) - 2400000;

  /// Modified Julian Date: MJD = JD - 2400000.5
  static double modifiedJulianDate(DateTime utc) =>
      julianDate(utc.toUtc()) - 2400000.5;

  /// Dublin Julian Date: DJD = JD - 2415020
  static double dublinJulianDate(DateTime utc) =>
      julianDate(utc.toUtc()) - 2415020;

  /// CNES Julian Date: CNES JD = JD - 2433282.5
  static double cnesJulianDate(DateTime utc) =>
      julianDate(utc.toUtc()) - 2433282.5;

  /// CCSDS Julian Date: CCSDS JD = JD - 2436204.5
  static double ccsdsJulianDate(DateTime utc) =>
      julianDate(utc.toUtc()) - 2436204.5;

  /// Modified Julian Date 2000: MJD2000 = JD - 2451544.5 / MJD - 51544
  static double modifiedJulianDate2000(DateTime utc) =>
      julianDate(utc.toUtc()) - 2451544.5;

  /// Decimal time (French Revolutionary time): day = 10 decimal hours,
  /// 1 decimal hour = 100 decimal minutes, 1 decimal minute = 100 decimal
  /// seconds (100,000 decimal seconds per day total).
  static ({int hours, int minutes, int seconds}) decimalTime(DateTime dt,
      {int? elapsedSeconds, int dayLengthSeconds = secondsPerDay}) {
    final totalDecimalSeconds =
        ((elapsedSeconds ?? daySecond(dt)) / dayLengthSeconds * 100000)
            .round() % 100000;
    return (
      hours:   totalDecimalSeconds ~/ 10000,
      minutes: (totalDecimalSeconds % 10000) ~/ 100,
      seconds: totalDecimalSeconds % 100,
    );
  }

  /// Decimal time as "H:MM:SS", e.g. "7:52:19".
  static String decimalTimeString(DateTime dt,
      {int? elapsedSeconds, int dayLengthSeconds = secondsPerDay}) {
    final d = decimalTime(dt,
        elapsedSeconds: elapsedSeconds, dayLengthSeconds: dayLengthSeconds);
    return '${d.hours}\u02b0'
        '${d.minutes.toString().padLeft(2, '0')}\u1d50'
        '${d.seconds.toString().padLeft(2, '0')}\u02e2';
  }

  /// Swatch Internet Time (.beat): 1 day = 1000 beats, based on UTC+1.
  static double swatchBeats(DateTime utc) {
    final bmt = utc.toUtc().add(const Duration(hours: 1));
    final seconds = bmt.hour * 3600 + bmt.minute * 60 + bmt.second;
    return seconds / 86.4; // 86400s / 1000 beats
  }

  /// New Earth Time (NET) / degree time: day expressed as 0–360°,
  /// analogous to a compass. 1° = 240 seconds (86400s / 360).
  static double newEarthTimeDegrees(DateTime dt) => dayPercent(dt) / 100 * 360;

  /// Binary clock representation: hours, minutes, seconds as binary strings.
  static ({String hours, String minutes, String seconds}) binaryTime(
      DateTime dt) {
    String toBin(int n, int width) =>
        n.toRadixString(2).padLeft(width, '0');
    return (
      hours:   toBin(dt.hour,   5),
      minutes: toBin(dt.minute, 6),
      seconds: toBin(dt.second, 6),
    );
  }

  /// BCD (two-column) binary clock: each decimal digit as separate 4-bit value.
  /// Returns pairs (tens, units) for hours, minutes, seconds.
  static ({
    String hourTens,   String hourUnits,
    String minTens,    String minUnits,
    String secTens,    String secUnits,
  }) bcdTime(DateTime dt) {
    String toBin(int n, int width) => n.toRadixString(2).padLeft(width, '0');
    return (
    hourTens:  toBin(dt.hour   ~/ 10, 2),
    hourUnits: toBin(dt.hour    % 10, 4),
    minTens:   toBin(dt.minute ~/ 10, 3),
    minUnits:  toBin(dt.minute  % 10, 4),
    secTens:   toBin(dt.second ~/ 10, 3),
    secUnits:  toBin(dt.second  % 10, 4),
    );
  }

  /// Binary clock string representation, e.g. "10:110000:10111".
  static String binaryTimeString(DateTime dt, {bool showSeconds = true}) {
    final bin = binaryTime(dt);
    if (!showSeconds) return [bin.hours, bin.minutes].join(':');
    return [bin.hours, bin.minutes, bin.seconds].join(':');
  }

  /// Seconds since midnight (0–86399), represented in the given number
  /// base, zero-padded to a fixed width. Used for octal/hexadecimal time.
  static String daySecondInBase(DateTime dt, int base, int digits,
      {int? elapsedSeconds}) {
    return (elapsedSeconds ?? daySecond(dt))
          .toRadixString(base).padLeft(digits, '0').toUpperCase();
  }

  /// Octal time: day second in base 8, e.g. "250577" (6 digits fit up to
  /// 86399 = 0o250577, since 8^6 > 86400 > 8^5).
  static String octalTimeString(DateTime dt, {int? elapsedSeconds}) =>
      daySecondInBase(dt, 8, 6, elapsedSeconds: elapsedSeconds);

  /// Hexadecimal time: day second in base 16, grouped with underscores
  /// every 2 digits for readability, e.g. "1_51_7F" (5 digits fit up to
  /// 86399 = 0x1517F, since 16^5 > 86400 > 16^4).
  static String hexadecimalTimeString(DateTime dt, {int? elapsedSeconds}) {
    final hex = daySecondInBase(dt, 16, 5, elapsedSeconds: elapsedSeconds);
    // Group from the right in pairs, e.g. "1517F" -> "1_51_7F":
    final buffer = StringBuffer();
    for (int i = 0; i < hex.length; i++) {
      if (i > 0 && (hex.length - i) % 2 == 0) buffer.write('_');
      buffer.write(hex[i]);
    }
    return buffer.toString();
  }

  /// Roman numerals time: time shown in Roman numerals. N for zeros.
  static String romanNumeralsTime(bool hourFormat24, DateTime dt,
      {bool showSeconds = true}) {
    final displayHour = hourFormat24
        ? dt.hour
        : (dt.hour % 12 == 0 ? 12 : dt.hour % 12);
    final period = hourFormat24 ? '' : (dt.hour < 12 ? ' AM' : ' PM');
    final fields = [displayHour, dt.minute, if (showSeconds) dt.second]
        .map((value) => _centered(value.toRomanNumeralString(config: _romanNumeralsConfig) ?? '--'));
    return '${fields.join(':')}$period';
  }

  // Fixed width (longest numeral: XXXVIII = 7), centered; extra space goes left.
  static String _centered(String text, {int width = 7}) {
    final padding = width - text.length;
    if (padding <= 0) return text;
    return text.padLeft(text.length + (padding + 1) ~/ 2).padRight(width);
  }

  /// Doomsday Clock settings: year -> seconds to midnight. A setting applies
  /// from 1 January of its year until the next entry (simplification: changes
  /// within a year are not modelled). Source: the timeline at
  /// https://en.wikipedia.org/wiki/Doomsday_Clock – verify when adding entries.
  /// Last check for accuracy of hardcoded values: 2026-10-27.
  static const Map<int, int> _doomsdaySecondsToMidnightByYear = {
    1969: 600,  1972: 720,  1974: 540,  1980: 420,  1981: 240,
    1984: 180,  1988: 360,  1990: 600,  1991: 1020, 1995: 840,
    1998: 540,  2002: 420,  2007: 300,  2010: 360,  2012: 300,
    2015: 180,  2017: 150,  2018: 120,  2020: 100,  2023: 90,
    2025: 89,   2026: 85,
  };

  /// Seconds to midnight at the given moment; the latest known setting
  /// applies to all dates after the last table entry.
  static int doomsdaySecondsToMidnight(DateTime utc) {
    final year = utc.toUtc().year;
    final settingYear = _doomsdaySecondsToMidnightByYear.keys.lastWhere(
            (candidate) => candidate <= year,
        orElse: () => _doomsdaySecondsToMidnightByYear.keys.first);
    return _doomsdaySecondsToMidnightByYear[settingYear]!;
  }

  /// The Doomsday Clock as a time of day (23:5x:xx) for the given moment.
  static String doomsDayClockString(bool hourFormat24, DateTime utc) {
    final secondOfDay = 24 * 60 * 60 - doomsdaySecondsToMidnight(utc);
    return TimeValueFormatter.formatTime(
        hourFormat24,
        secondOfDay ~/ 3600,
        (secondOfDay % 3600) ~/ 60,
        secondOfDay % 60,
        tzSuffix: null);
  }
}
