import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'models/time_value.dart';
import 'time_utils.dart';

class TimeValueFormatter {
  /// Computes the display string for a given TimeValue at a given moment.
  static String compute(
      TimeValue value,
      DateTime now,
      String locale, {
        bool hourFormat24 = true,
        bool thousandsSep = true,
        String localIanaZone = 'UTC',
      }) {
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
        return TimeUtils.hoursToHms(TimeUtils.gmst(utcNow));
      case ValueType.julianDate:
        return TimeUtils.formatDecimal(
            TimeUtils.julianDate(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.modifiedJulianDate:
        return TimeUtils.formatDecimal(
            TimeUtils.modifiedJulianDate(utcNow), locale, 5,
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
        return TimeUtils.formatDate(locale, dt);
      case ValueType.time:
        if (!hourFormat24) {
          return TimeUtils.formatTime12h(dt.hour, mm, ss, tzSuffix);
        }
        return '$hh:$mm:$ss $tzSuffix';
      case ValueType.dateTime:
        final dateStr = TimeUtils.formatDate(locale, dt);
        if (!hourFormat24) {
          return '$dateStr ${TimeUtils.formatTime12h(dt.hour, mm, ss, tzSuffix)}';
        }
        return '$dateStr $hh:$mm:$ss $tzSuffix';
      case ValueType.daySecond:
        final v = TimeUtils.daySecond(dt);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.dayPercent:
        return TimeUtils.formatDecimal(
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

  /// For clipboard: always raw value without locale formatting.
  static String computeRaw(TimeValue value, DateTime now) {
    final utcNow = now.toUtc();
    return switch (value.type) {
      ValueType.unixSeconds        => TimeUtils.unixTimestamp(utcNow).toString(),
      ValueType.tai                => TimeUtils.taiSeconds(utcNow).toString(),
      ValueType.gps                => TimeUtils.gpsTime(utcNow).toString(),
      ValueType.julianDate         =>
          TimeUtils.julianDate(utcNow).toStringAsFixed(5),
      ValueType.modifiedJulianDate =>
          TimeUtils.modifiedJulianDate(utcNow).toStringAsFixed(5),
      _                            => '', // zone-dependent: use compute()
    };
  }
}