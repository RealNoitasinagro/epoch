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

  /// Unix timestamp in seconds.
  static int unixTimestamp(DateTime utc) =>
      utc.toUtc().millisecondsSinceEpoch ~/ 1000;

  /// GPS time: seconds since 1980-01-06 00:00:00 UTC.
  /// GPS- time does not have leap seconds, currently 18s ahead of UTC.
  static int gpsTime(DateTime utc) {
    const leapSeconds = 18;
    final gpsEpoch = DateTime.utc(1980, 1, 6);
    return utc.toUtc().difference(gpsEpoch).inSeconds + leapSeconds;
  }

  /// TAI: UTC + leap seconds (currently 37).
  static int taiSeconds(DateTime utc) {
    const leapSeconds = 37;
    return utc.toUtc().millisecondsSinceEpoch ~/ 1000 + leapSeconds;
  }

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
}