import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class TimeUtils {
  /// Returns TZDateTime for a given IANA time zone.
  static tz.TZDateTime inZone(DateTime utc, String ianaZone) {
    final location = tz.getLocation(ianaZone);
    return tz.TZDateTime.from(utc, location);
  }

  /// Abbreviated time zone from TZDateTime, e. g. "CEST", "EST".
  static String tzAbbr(tz.TZDateTime dt) => dt.timeZone.abbreviation;

  /// UTC offset as a formatted string, e. g. "UTC+02:00".
  static String utcOffsetString(Duration offset) {
    final sign = offset.isNegative ? '−' : '+';
    final h = offset.inHours.abs().toString().padLeft(2, '0');
    final m = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    return 'UTC$sign$h:$m';
  }

  /// Day second (seconds since midnight) for a DateTime.
  static int daySecond(DateTime dt) =>
      dt.hour * 3600 + dt.minute * 60 + dt.second;

  /// Percentage of the day elapsed.
  static double dayPercent(DateTime dt) {
    int secondsPerDay = 24 * 60 * 60;  // 86400
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

  /// Format a date to EEE, yyyy-MMM-dd, e. g. "Tue, 2026-05-12".
  static String formatDate(String locale, DateTime dt) => DateFormat('EEE, yyyy-MM-dd', locale).format(dt);

  /// Format a time to 12-hour format with timezone, e. g. "08:13:10 AM UTC".
  static String formatTime12h(int hh, String mm, String ss, String? tzSuffix) {
    final hour12 = hh % 12 == 0 ? 12 : hh % 12;
    final period = hh < 12 ? 'AM' : 'PM';
    final h12 = hour12.toString().padLeft(2, '0');
    String timeFormat12h = '$h12:$mm:$ss $period';
    if (tzSuffix != null) {
      timeFormat12h = '$timeFormat12h $tzSuffix';
    }
    return timeFormat12h;
  }

  /// Unix timestamp in seconds.
  static int unixTimestamp(DateTime utc) =>
      utc.toUtc().millisecondsSinceEpoch ~/ 1000;

  /// TAI: UTC + leap seconds (currently 37).
  static int taiSeconds(DateTime utc) {
    const leapSeconds = 37;
    return utc.toUtc().millisecondsSinceEpoch ~/ 1000 + leapSeconds;
  }

  /// GPS time: seconds since 1980-01-06 00:00:00 UTC.
  /// GPS- time does not have leap seconds, currently 18s ahead of UTC.
  static int gpsTime(DateTime utc) {
    const leapSeconds = 18;
    final gpsEpoch = DateTime.utc(1980, 1, 6);
    return utc.toUtc().difference(gpsEpoch).inSeconds + leapSeconds;
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

  /// Formats a fractional hour value as HH:MM:SS.
  static String hoursToHms(double hours) {
    final total = (hours * 3600).round();
    final h = (total ~/ 3600) % 24;
    final m = (total % 3600) ~/ 60;
    final s = total % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  /// Julian Date for a given UTC DateTime.
  static double julianDate(DateTime utc) {
    final y = utc.year;
    final mo = utc.month;
    final d = utc.day +
        (utc.hour + utc.minute / 60.0 + utc.second / 3600.0) / 24.0;
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

  /// Modified Julian Date: JD − 2400000.5
  static double modifiedJulianDate(DateTime utc) =>
      julianDate(utc.toUtc()) - 2400000.5;

  /// Swatch Internet Time (.beat): 1 day = 1000 beats, based on UTC+1.
  static double swatchBeats(DateTime utc) {
    final bmt = utc.toUtc().add(const Duration(hours: 1));
    final seconds = bmt.hour * 3600 + bmt.minute * 60 + bmt.second;
    return seconds / 86.4; // 86400s / 1000 beats
  }

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
  static String binaryTimeString(DateTime dt) {
    String toBin(int n, int width) => n.toRadixString(2).padLeft(width, '0');
    final h = toBin(dt.hour, 5);
    final m = toBin(dt.minute, 6);
    final s = toBin(dt.second, 6);
    return '$h:$m:$s';
  }

  /// Returns the current Doomsday Clock time as of Jan 2026.
  static String doomsDayClockString(bool hourFormat24) {
    int hh = 23;
    int mm = 58;
    int ss = 35;

    return !hourFormat24
        ? formatTime12h(hh, '$mm', '$ss', null)
        : '$hh:$mm:$ss';
  }
}