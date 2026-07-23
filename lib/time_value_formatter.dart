import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'l10n/app_localizations.dart';
import 'models/time_value.dart';
import 'models/timezone_abbr_localization.dart';
import 'time_utils.dart';

class TimeValueFormatter {
  /// Computes the display string for a given TimeValue at a given moment.
  static String format(
      TimeValue timeValue,
      DateTime now,
      String locale,
      {
        bool hourFormat24 = true,
        bool thousandsSep = true,
        String localIanaZone = 'UTC',
        double? longitude,
      }
  ) {
    final utcNow = now.toUtc();

    // Zone-independent values.
    switch (timeValue.valueType) {
      // Technical
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
      // Astronomical
      case ValueType.gmst:
        return hoursToHms(TimeUtils.gmst(utcNow));
      case ValueType.lmst:
        if (longitude == null) return '--:--:--';
        return TimeValueFormatter.hoursToHms(TimeUtils.lmst(utcNow, longitude));
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
      // Curiosities
      case ValueType.swatchBeats:
        return '@${TimeUtils.swatchBeats(utcNow).toStringAsFixed(0)}';
      case ValueType.doomsdayClock:
        return TimeUtils.doomsDayClockString(hourFormat24);
      default:
        break;
    }

    // Zone-dependent values.
    String tzLabel;
    DateTime dt;
    final Duration offset;

    switch (timeValue.zone) {
      case ZoneUtc():
        dt = utcNow;
        tzLabel = 'UTC';
        offset = Duration.zero;
      case ZoneLocal():
        dt = now;
        try {
          final tzLocation = tz.getLocation(localIanaZone);
          final tzDt = tz.TZDateTime.from(now.toUtc(), tzLocation);
          tzLabel = localizeTimezoneAbbr(tzDt.timeZone.abbreviation, locale);
        } catch (_) { tzLabel = now.timeZoneName; }
        offset = now.timeZoneOffset;
      case ZoneNamed(ianaZone: final zone):
        final tzDt = TimeUtils.inZone(utcNow, zone);
        if (timeValue.timezoneClockChangeMode != TimezoneClockChangeMode.auto) {
          final info = TimeUtils.daylightOrStandardOffset(
              zone, timeValue.timezoneClockChangeMode == TimezoneClockChangeMode.forceDst);
          if (info != null) {
            tzLabel = localizeTimezoneAbbr(info.abbreviation, locale);
            offset = info.offset;
            dt = utcNow.add(offset);
            break;
          }
        }
        dt = tzDt;
        tzLabel = localizeTimezoneAbbr(tzDt.timeZone.abbreviation, locale);
        offset = tzDt.timeZoneOffset;
    }
    final tzSuffix = '$tzLabel (${TimeUtils.utcOffsetString(offset)})';

    switch (timeValue.valueType) {
      // Civil
      case ValueType.date:
        return formatDate(locale, dt);
      case ValueType.time:
        return formatTime(hourFormat24, dt.hour, dt.minute, dt.second, tzSuffix);
      case ValueType.dateTime:
        return formatDateTime(hourFormat24, locale, dt, tzSuffix);
      case ValueType.daySecond:
        final value = TimeUtils.daySecond(dt);
        String formattedValue = thousandsSep
            ? NumberFormat.decimalPattern(locale).format(value)
            : value.toString();
        formattedValue += ' $tzSuffix';
        return formattedValue;
      case ValueType.dayPercent:
        String formattedValue = formatDecimal(
            TimeUtils.dayPercent(dt), locale, 3,
            thousandsSep: false); // percent never needs thousands sep
        formattedValue += ' $tzSuffix';
        return formattedValue;
      // Curiosities
      case ValueType.binaryClockString:
        return TimeUtils.binaryTimeString(dt);
      case ValueType.sevenSegmentClock:
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

  /// Formats HH:MM:SS back to decimal hours, or null if there is an error.
  static double? hmsToHours(String hms) {
    final parts = hms.split(':');
    if (parts.length != 3) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final s = int.tryParse(parts[2]);
    if (h == null || m == null || s == null) return null;
    return h + m / 60.0 + s / 3600.0;
  }

  /// Format a date to EEE, yyyy-MMM-dd, e. g. "Tue, 2026-05-12".
  static String formatDate(String locale, DateTime dt) =>
      DateFormat('EEE, yyyy-MM-dd', locale).format(dt);

  static String formatTime(bool hourFormat24, int hour, int minute, int second, String? tzSuffix) {
    final period = hour < 12 ? 'AM' : 'PM';
    hour = !hourFormat24 ? hour % 12 == 0 ? 12 : hour % 12 : hour;
    final hh = hour.toString().padLeft(2, '0');
    final mm = minute.toString().padLeft(2, '0');
    final ss = second.toString().padLeft(2, '0');
    String timeFormat = '$hh:$mm:$ss';
    if (!hourFormat24) timeFormat += ' $period';
    if (tzSuffix != null) timeFormat += ' $tzSuffix';
    return timeFormat;
  }

  static String formatDateTime(bool hourFormat24, String locale, DateTime dt,
      String? tzSuffix) {
    String formattedDate = formatDate(locale, dt);
    String formattedTime = formatTime(hourFormat24, dt.hour, dt.minute, dt.second, tzSuffix);
    return "$formattedDate $formattedTime";
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

  /// Adds longitude to the LMST label.
  static String lmstLabelWithLon(AppLocalizations l10n, TimeValue timeValue, double? longitude ) {
    String locale = l10n.localeName;
    if (longitude == null) return timeValue.localizedDisplayLabel(l10n);
    final dir = longitude >= 0 ? 'E' : 'W';
    final deg = formatDecimal(longitude.abs(), locale, 2, thousandsSep: false);
    return '${timeValue.localizedDisplayLabel(l10n)} ($deg° $dir)';
  }
}