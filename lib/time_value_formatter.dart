import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'models/time_value.dart';
import 'time_utils.dart';

class TimeValueFormatter {
  /// Computes the display string for a given TimeValue at a given moment.
  static String format(
      TimeValue value,
      DateTime now,
      String locale,
      {
        bool hourFormat24 = true,
        bool thousandsSep = true,
        String localIanaZone = 'UTC',
      }
  ) {
    final utcNow = now.toUtc();

    // Zone-independent values.
    switch (value.type) {
      case ValueType.unixSeconds:
        final v = TimeUtils.unixTimestamp(utcNow);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.tai:
        final v = TimeUtils.taiSeconds(utcNow);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.gps:
        final v = TimeUtils.gpsTime(utcNow);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.gmst:
        return hoursToHms(TimeUtils.gmst(utcNow));
      case ValueType.julianDate:
        return formatDecimal(
            TimeUtils.julianDate(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.modifiedJulianDate:
        return formatDecimal(
            TimeUtils.modifiedJulianDate(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.modifiedJulianDate2000:
        return formatDecimal(
            TimeUtils.modifiedJulianDate2000(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.swatchBeats:
        return '@${TimeUtils.swatchBeats(utcNow).toStringAsFixed(0)}';
      case ValueType.doomsdayClock:
        return TimeUtils.doomsDayClockString(hourFormat24);
      default:
        break;
    }

    // Zone-dependent values.
    final DateTime dt;
    String tzLabel;
    final Duration offset;

    switch (value.zone) {
      case ZoneLocal():
        dt = now;
        try {
          final tzLocation = tz.getLocation(localIanaZone);
          final tzDt = tz.TZDateTime.from(now.toUtc(), tzLocation);
          tzLabel = tzDt.timeZone.abbreviation;
        } catch (_) {
          tzLabel = now.timeZoneName;
        }
        offset = now.timeZoneOffset;
      case ZoneUtc():
        dt = utcNow;
        tzLabel = 'UTC';
        offset = Duration.zero;
      case ZoneNamed(ianaZone: final z):
        final tzDt = TimeUtils.inZone(utcNow, z);
        dt = tzDt;
        tzLabel = tzDt.timeZone.abbreviation;
        offset = tzDt.timeZoneOffset;
    }

    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    final ss = dt.second.toString().padLeft(2, '0');
    final tzSuffix = '$tzLabel (${TimeUtils.utcOffsetString(offset)})';

    switch (value.type) {
      case ValueType.date:
        return formatDate(locale, dt);
      case ValueType.time:
        if (!hourFormat24) {
          return formatTime12h(dt.hour, mm, ss, tzSuffix);
        }
        return '$hh:$mm:$ss $tzSuffix';
      case ValueType.dateTime:
        final dateStr = formatDate(locale, dt);
        if (!hourFormat24) {
          return '$dateStr ${formatTime12h(dt.hour, mm, ss, tzSuffix)}';
        }
        return '$dateStr $hh:$mm:$ss $tzSuffix';
      case ValueType.daySecond:
        final v = TimeUtils.daySecond(dt);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.dayPercent:
        return formatDecimal(
            TimeUtils.dayPercent(dt), locale, 3,
            thousandsSep: false); // percent never needs thousands sep
      case ValueType.binaryClockString:
        return TimeUtils.binaryTimeString(dt);
      case ValueType.binaryClockColumns:
      case ValueType.binaryClockBcd:
      default:
        return '';
    }
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

  /// Format a date to EEE, yyyy-MMM-dd, e. g. "Tue, 2026-05-12".
  static String formatDate(String locale, DateTime dt) =>
      DateFormat('EEE, yyyy-MM-dd', locale).format(dt);

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

  /// Returns a double formatted to a given number of decimal digits.
  static String formatDecimal(
      double value, String locale, int decimals,
      { bool thousandsSep = true, }
      ) {
    final fmt = NumberFormat.decimalPatternDigits(
        locale: locale, decimalDigits: decimals);
    fmt.minimumFractionDigits = decimals;
    if (!thousandsSep) fmt.turnOffGrouping();
    return fmt.format(value);
  }
}