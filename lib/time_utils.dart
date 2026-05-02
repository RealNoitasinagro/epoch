import 'package:timezone/timezone.dart' as tz;

class TimeUtils {
  /// Gibt die TZDateTime für eine gegebene IANA-Zeitzone zurück.
  static tz.TZDateTime inZone(DateTime utc, String ianaZone) {
    final location = tz.getLocation(ianaZone);
    return tz.TZDateTime.from(utc, location);
  }

  /// Kurzes Zeitzonenkürzel aus TZDateTime, z. B. "CEST", "EST".
  static String tzAbbr(tz.TZDateTime dt) => dt.timeZone.abbreviation;

  /// UTC-Offset als formatierten String, z. B. "UTC+02:00".
  static String utcOffsetString(Duration offset) {
    final sign = offset.isNegative ? '−' : '+';
    final h = offset.inHours.abs().toString().padLeft(2, '0');
    final m = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    return 'UTC$sign$h:$m';
  }

  /// Tagessekunde (Sekunden seit Mitternacht) für ein DateTime.
  static int daySecond(DateTime dt) =>
      dt.hour * 3600 + dt.minute * 60 + dt.second;

  /// Unix-Timestamp in Sekunden.
  static int unixTimestamp(DateTime utc) =>
      utc.toUtc().millisecondsSinceEpoch ~/ 1000;

  /// Unix-Timestamp in Millisekunden.
  static int unixTimestampMs(DateTime utc) =>
      utc.toUtc().millisecondsSinceEpoch;

  /// GPS-Zeit: Sekunden seit 1980-01-06 00:00:00 UTC.
  /// GPS-Zeit kennt keine Schaltsekunden, liegt aktuell 18s vor UTC.
  static int gpsTime(DateTime utc) {
    const leapSeconds = 18;
    final gpsEpoch = DateTime.utc(1980, 1, 6);
    return utc.toUtc().difference(gpsEpoch).inSeconds + leapSeconds;
  }

  /// TAI: UTC + aktuelle Schaltsekunden (aktuell 37).
  static int taiSeconds(DateTime utc) {
    const leapSeconds = 37;
    return utc.toUtc().millisecondsSinceEpoch ~/ 1000 + leapSeconds;
  }
}