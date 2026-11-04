import 'package:intl/intl.dart';
import 'package:numerus/numerus.dart';
import 'l10n/app_localizations.dart';
import 'models/app_settings.dart';
import 'models/time_value.dart';
import 'models/timezone_abbreviation_localization.dart';
import 'models/value_format_settings.dart';
import 'models/zone_rules.dart';
import 'time_utils.dart';
import 'zoned_moment.dart';

class TimeValueFormatter {
  static const CommonRomanNumeralsConfig _romanNumeralsConfig = CommonRomanNumeralsConfig(nulla: 'N');

  /// Computes the display string for a given TimeValue at a given moment.
  static String format(
      TimeValue timeValue,
      DateTime now,
      String locale,
      {
        ValueFormatSettings settings = const ValueFormatSettings(),
      }
  ) {
    final hourFormat24 = settings.hourFormat24;
    final thousandsSep = settings.thousandsSep;
    final dateFormat = settings.dateFormat;
    final timeFormat = settings.timeFormat;
    final localIanaZone = settings.localIanaZone;
    final longitude = settings.longitude;
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
        final v = TimeUtils.taiUnixTimestamp(utcNow);
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
      case ValueType.reducedJulianDate:
        return formatDecimal(
            TimeUtils.reducedJulianDate(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.modifiedJulianDate:
        return formatDecimal(
            TimeUtils.modifiedJulianDate(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.dublinJulianDate:
        return formatDecimal(
            TimeUtils.dublinJulianDate(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.cnesJulianDate:
        return formatDecimal(
            TimeUtils.cnesJulianDate(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.ccsdsJulianDate:
        return formatDecimal(
            TimeUtils.ccsdsJulianDate(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      case ValueType.modifiedJulianDate2000:
        return formatDecimal(
            TimeUtils.modifiedJulianDate2000(utcNow), locale, 5,
            thousandsSep: thousandsSep);
      // Curiosities
      case ValueType.swatchBeats:
        final double swatchBeats = TimeUtils.swatchBeats(utcNow);
        return '@${timeValue.showOptionalPart
            ? swatchBeats.toStringAsFixed(2)
            : swatchBeats.toInt()}';
      case ValueType.newEarthTime:
        final double deg = TimeUtils.newEarthTimeDegrees(utcNow);
        return '${timeValue.showOptionalPart
            ? formatDecimal(deg, locale, 2, thousandsSep:  false)
            : deg.toInt()}°';
      case ValueType.doomsdayClock:
        final secondOfDay = TimeUtils.doomsdayClockSecondOfDay(utcNow);
        return formatTime(
          hourFormat24,
          secondOfDay ~/ 3600,
          (secondOfDay % 3600) ~/ 60,
          secondOfDay % 60,
          tzSuffix: null,
        );
      default:
        break;
    }

    // Zone-dependent values.
    final moment = ZonedMoment.of(timeValue, utcNow, localIanaZone);
    final wallClock = moment.wallClock;
    final tzLabel = localizeTimezoneAbbr(moment.abbreviation, locale);
    final utcOffset = formatUtcOffset(
        moment.offset, withUtcPrefix: true, typographicMinus: true
    );
    final tzSuffix = '$tzLabel (${utcOffset})';

    switch (timeValue.valueType) {
    // Civil
      case ValueType.date:
        return formatDate(locale, wallClock, pattern: dateFormat);
      case ValueType.time:
        return formatTime(
          hourFormat24,
          wallClock.hour,
          wallClock.minute,
          wallClock.second,
          tzSuffix: tzSuffix,
          pattern: timeFormat,
        );
      case ValueType.dateTime:
        return formatDateTime(
          hourFormat24,
          locale,
          wallClock,
          tzSuffix,
          datePattern: dateFormat,
          timePattern: timeFormat,
        );
      case ValueType.daySecond:
        final value = moment.dayProgress.elapsedSeconds;
        String formattedValue = thousandsSep
            ? NumberFormat.decimalPattern(locale).format(value)
            : value.toString();
        formattedValue += ' $tzSuffix';
        return formattedValue;
      case ValueType.dayPercent:
        String formattedValue = formatDecimal(
          TimeUtils.dayPercent(moment.dayProgress),
          locale,
          3,
          thousandsSep: false,
        );
        formattedValue += ' $tzSuffix';
        return formattedValue;
      case ValueType.dayMinute:
        final dayMinute = TimeUtils.dayMinute(moment.dayProgress);
        String formattedValue = thousandsSep
            ? NumberFormat.decimalPattern(locale).format(dayMinute.minutes)
            : dayMinute.minutes.toString();
        if (timeValue.showOptionalPart) {
          formattedValue += ':${dayMinute.seconds.toString().padLeft(2, '0')}';
        }
        formattedValue += ' $tzSuffix';
        return formattedValue;
    // Curiosities
      case ValueType.decimalTime:
        final decimalTime = TimeUtils.decimalTime(moment.dayProgress);
        return '${_decimalTimeText(decimalTime)} $tzSuffix';
      case ValueType.binaryClockString:
        return binaryTimeString(
          wallClock,
          showSeconds: timeValue.showOptionalPart,
        );
      case ValueType.octalTime:
        return _secondsInBase(moment.dayProgress.elapsedSeconds, 8, 6);
      case ValueType.hexadecimalTime:
        return _hexadecimalText(moment.dayProgress.elapsedSeconds);
      case ValueType.romanNumeralsTime:
        return romanNumeralsTime(
          hourFormat24,
          wallClock,
          showSeconds: timeValue.showOptionalPart,
        );
      case ValueType.binaryClockBcd:
      case ValueType.binaryClockColumns:
      case ValueType.sevenSegmentClock:
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
  static String formatDate(String locale, DateTime dt,
      {String pattern = kDatePatternIso}) =>
      formatDatePattern(dt, pattern, locale);

  static String formatTime(bool hourFormat24, int hour, int minute,
      int second, { String? tzSuffix, String pattern = kTimePatternFull }) {
    final dt = DateTime(2000, 1, 1, hour, minute, second);
    final timeStr = formatTimePattern(dt, pattern, hourFormat24: hourFormat24);
    final period = !hourFormat24 ? (hour < 12 ? ' AM' : ' PM') : '';
    return tzSuffix != null
        ? '$timeStr$period $tzSuffix'
        : '$timeStr$period';
  }

  static String formatDateTime(
      bool hourFormat24, String locale, DateTime dt, String? tzSuffix,
      {String datePattern = kDatePatternIso, String timePattern = kTimePatternFull}
    ) {
    String formattedDate = formatDate(locale, dt, pattern: datePattern);
    String formattedTime = formatTime(
        hourFormat24, dt.hour, dt.minute, dt.second,
        tzSuffix: tzSuffix, pattern: timePattern);
    return "$formattedDate $formattedTime";
  }

  static String formatDatePattern(DateTime dt, String pattern, String locale) {
    // Use intl for localized names:
    final monthLong    = DateFormat('MMMM', locale).format(dt);
    final monthShort   = DateFormat('MMM',  locale).format(dt);
    final weekDayLong  = DateFormat('EEEE', locale).format(dt);
    final weekDayShort = DateFormat('EEE',  locale).format(dt);

    // Apply tokens longest-first to avoid partial substitution:
    final tokens = <String, String>{
      'YYYY': dt.year.toString().padLeft(4, '0'),
      'YY':   (dt.year % 100).toString().padLeft(2, '0'),
      'MMMM': monthLong,
      'MMM':  monthShort,
      'MM':   dt.month.toString().padLeft(2, '0'),
      'M':    dt.month.toString(),
      'EEEE': weekDayLong,
      'EEE':  weekDayShort,
      'DD':   dt.day.toString().padLeft(2, '0'),
      'D':    dt.day.toString(),
    };
    return _applyTokens(pattern, tokens);
  }

  static String formatTimePattern(DateTime dt, String pattern,
      {bool hourFormat24 = true}) {
    final displayHour = hourFormat24
        ? dt.hour
        : (dt.hour % 12 == 0 ? 12 : dt.hour % 12);
    final tokens = <String, String>{
      'HH': displayHour.toString().padLeft(2, '0'),
      'H':  displayHour.toString(),
      'mm': dt.minute.toString().padLeft(2, '0'),
      'ss': dt.second.toString().padLeft(2, '0'),
    };
    return _applyTokens(pattern, tokens);
  }

  static String _applyTokens(String pattern, Map<String, String> tokens) {
    // Sort tokens by length descending for greedy matching:
    final sorted = tokens.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    final buffer = StringBuffer();
    int i = 0;
    while (i < pattern.length) {
      bool matched = false;
      for (final token in sorted) {
        if (pattern.startsWith(token, i)) {
          buffer.write(tokens[token]);
          i += token.length;
          matched = true;
          break;
        }
      }
      if (!matched) {
        buffer.write(pattern[i]);
        i++;
      }
    }
    return buffer.toString();
  }

  /// Returns a double formatted to a given number of decimal digits.
  static String formatDecimal(double value, String locale, int decimals,
      { bool thousandsSep = true,}) {
    final fmt = NumberFormat.decimalPatternDigits(
        locale: locale, decimalDigits: decimals);
    fmt.minimumFractionDigits = decimals;
    if (!thousandsSep) fmt.turnOffGrouping();
    return fmt.format(value);
  }

  /// Adds longitude to the LMST label.
  static String lmstLabelWithLon(AppLocalizations l10n, TimeValue timeValue,
      double? longitude) {
    String locale = l10n.localeName;
    if (longitude == null) return timeValue.localizedDisplayLabel(l10n);
    final dir = longitude >= 0 ? 'E' : 'W';
    final deg = formatDecimal(longitude.abs(), locale, 2, thousandsSep: false);
    return '${timeValue.localizedDisplayLabel(l10n)} ($deg° $dir)';
  }

  static String? validatePattern(String pattern, bool isDate) =>
      isDate ? validateDatePattern(pattern) : validateTimePattern(pattern);

  static String? validateDatePattern(String pattern) {
    final validTokens = {
      'YYYY', 'YY', 'MMMM', 'MMM', 'MM', 'M', 'EEEE', 'EEE', 'DD', 'D'};
    return _validatePattern(pattern, validTokens, requireAny: true);
  }

  static String? validateTimePattern(String pattern) {
    const validTokens = {'HH', 'H', 'mm', 'ss'};
    final error = _validatePattern(pattern, validTokens, requireAny: false);
    if (error != null) return error;
    if (!pattern.contains('HH') && !pattern.contains('H')) {
      return 'H or HH required';
    }
    if (!pattern.contains('mm')) return 'mm required';
    return null;
  }

  static String? _validatePattern(String pattern,
      Set<String> validTokens, {required bool requireAny}) {
    var remaining = pattern;
    // Remove all valid tokens:
    for (final token in validTokens) {
      remaining = remaining.replaceAll(token, '');
    }
    // Check for leftover uppercase sequences:
    final badTokens = RegExp(r'[A-Z]+').allMatches(remaining)
        .map((m) => m.group(0)!)
        .where((s) => s.isNotEmpty)
        .toSet();
    if (badTokens.isNotEmpty) return 'Unknown: ${badTokens.join(', ')}';
    return null;
  }

  static String _decimalTimeText(
      ({int hours, int minutes, int seconds}) decimalTime,
      ) {
    return '${decimalTime.hours}\u02b0'
        '${decimalTime.minutes.toString().padLeft(2, '0')}\u1d50'
        '${decimalTime.seconds.toString().padLeft(2, '0')}\u02e2';
  }

  /// Seconds since midnight in the given base, zero-padded to a fixed width.
  static String _secondsInBase(int seconds, int base, int digits) {
    return seconds.toRadixString(base).padLeft(digits, '0').toUpperCase();
  }

  /// Seconds since midnight in base 16, grouped in pairs from the right,
  /// e.g. "1_51_7F".
  static String _hexadecimalText(int seconds) {
    final hex = _secondsInBase(seconds, 16, 5);
    final buffer = StringBuffer();
    for (var index = 0; index < hex.length; index++) {
      if (index > 0 && (hex.length - index) % 2 == 0) buffer.write('_');
      buffer.write(hex[index]);
    }
    return buffer.toString();
  }

  /// Binary clock string representation, e.g. "10:110000:10111".
  static String binaryTimeString(DateTime wallClock, {bool showSeconds = true}) {
    final bin = TimeUtils.binaryTime(wallClock);
    if (!showSeconds) return [bin.hours, bin.minutes].join(':');
    return [bin.hours, bin.minutes, bin.seconds].join(':');
  }

  /// Roman numerals time: time shown in Roman numerals. N for zeros.
  static String romanNumeralsTime(bool hourFormat24, DateTime wallClock,
      {bool showSeconds = true}) {
    final displayHour = hourFormat24
        ? wallClock.hour
        : (wallClock.hour % 12 == 0 ? 12 : wallClock.hour % 12);
    final period = hourFormat24 ? '' : (wallClock.hour < 12 ? ' AM' : ' PM');
    final fields = [displayHour, wallClock.minute, if (showSeconds) wallClock.second]
        .map((value) => _centered(value.toRomanNumeralString(config: _romanNumeralsConfig) ?? '--'));
    return '${fields.join(':')}$period';
  }

  // Fixed width (longest numeral: XXXVIII = 7), centered; extra space goes left.
  static String _centered(String text, {int width = 7}) {
    final padding = width - text.length;
    if (padding <= 0) return text;
    return text.padLeft(text.length + (padding + 1) ~/ 2).padRight(width);
  }
}
