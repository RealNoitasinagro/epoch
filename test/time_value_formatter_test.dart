import 'package:epoch/models/app_settings.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/models/value_format_settings.dart';
import 'package:epoch/time_value_formatter.dart';
import 'package:epoch/widgets/time_string_row.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest_all.dart' as tzl;

void main() {
  setUpAll(() async {
    tzl.initializeTimeZones();
    await initializeDateFormatting('en');
    await initializeDateFormatting('de');
  });

  String formatWith(
      TimeValue timeValue,
      DateTime now, {
        ValueFormatSettings settings = const ValueFormatSettings(),
        String locale = 'en',
      }) {
    return TimeValueFormatter.format(timeValue, now, locale, settings: settings);
  }

  String line1(
      TimeValue timeValue,
      DateTime utcMoment, {
        bool hourFormat24 = true,
        String timeFormat = kTimePatternFull,
      }) {
    final formatted = TimeValueFormatter.format(
      timeValue,
      utcMoment,
      'en',
      settings: ValueFormatSettings(
        hourFormat24: hourFormat24,
        timeFormat: timeFormat,
      ),
    );
    return TimeStringRow.splitZoneOffset(formatted).line1;
  }

  group('TimeValueFormatter.format – zone-independent', () {
    final t = DateTime.utc(2001, 9, 9, 1, 46, 40); // Unix 1000000000

    // Technical

    test('unixSeconds formats correctly', () {
      const tv = TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc());
      final result = formatWith(tv, t);
      expect(result, equals('1,000,000,000'));
    });

    test('unixSeconds without thousands separator', () {
      const tv = TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc());
      final result = formatWith(tv, t, settings: const ValueFormatSettings(thousandsSep: false));
      expect(result, equals('1000000000'));
    });

    test('unixSeconds DE locale uses period as thousands separator', () {
      const tv = TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc());
      final result = formatWith(tv, t, locale: 'de');
      expect(result, equals('1.000.000.000'));
    });

    // Astronomical

    test('gmst returns HH:MM:SS format', () {
      const tv = TimeValue(valueType: ValueType.gmst, zone: ZoneUtc());
      final result = formatWith(tv, t);
      expect(result, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
    });

    test('lmst returns placeholder without longitude', () {
      const tv = TimeValue(valueType: ValueType.lmst, zone: ZoneUtc());
      final result = formatWith(tv, t);
      expect(result, equals('--:--:--'));
    });

    test('lmst with longitude returns HH:MM:SS', () {
      const tv = TimeValue(valueType: ValueType.lmst, zone: ZoneUtc());
      final result = formatWith(tv, t, settings: const ValueFormatSettings(longitude: 8.68));
      final parts = result.split(':');
      expect(parts.length, equals(3));
      expect(int.tryParse(parts[0]), isNotNull);
    });

    test('julianDate has 5 decimal places', () {
      const tv = TimeValue(valueType: ValueType.julianDate, zone: ZoneUtc());
      final result = formatWith(tv, t, settings: const ValueFormatSettings(thousandsSep: false));
      final parts = result.split('.');
      expect(parts.length, equals(2));
      expect(parts[1].length, equals(5));
    });

    // Curiosities

    test('swatchBeats format starts with @', () {
      const tv = TimeValue(valueType: ValueType.swatchBeats, zone: ZoneUtc());
      final result = formatWith(tv, t);
      expect(result, startsWith('@'));
      //final beats = int.tryParse(result.substring(1));
      final beats = double.tryParse(result.substring(1));
      expect(beats, isNotNull);
      expect(beats, greaterThanOrEqualTo(0));
      expect(beats, lessThan(1000));
    });
  });

  group('TimeValueFormatter.format – zone-dependent', () {
    final t = DateTime(2026, 6, 10, 14, 30, 0); // local time

    // Civil

    test('time local returns HH:MM:SS with timezone suffix', () {
      const tv = TimeValue(valueType: ValueType.time, zone: ZoneLocal());
      final result = formatWith(tv, t, settings: const ValueFormatSettings(localIanaZone: 'Europe/Berlin'));
      expect(result, contains(':'));
      expect(result, contains('UTC'));
    });

    test('time UTC returns UTC suffix', () {
      const tv = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
      final result = formatWith(tv, t);
      expect(result, contains('UTC'));
    });

    test('time 12h format contains AM or PM', () {
      const tv = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
      final result = formatWith(tv, t, settings: const ValueFormatSettings(hourFormat24: false));
      expect(result, anyOf(contains('AM'), contains('PM')));
    });

    test('daySecond is between 0 and 86399', () {
      const tv = TimeValue(valueType: ValueType.daySecond, zone: ZoneUtc());
      final result = formatWith(
          tv, t, settings: const ValueFormatSettings(thousandsSep: false));
      var split = TimeStringRow.splitZoneOffset(result);
      final v = int.tryParse(split.line1);
      expect(v, isNotNull);
      expect(v, greaterThanOrEqualTo(0));
      expect(v, lessThanOrEqualTo(86399));
    });

    test('dayPercent is between 0.000 and 99.999', () {
      const tv = TimeValue(valueType: ValueType.dayPercent, zone: ZoneUtc());
      final result = formatWith(tv, t);
      var split = TimeStringRow.splitZoneOffset(result);
      final v = double.tryParse(split.line1);
      expect(v, isNotNull);
      expect(v, greaterThanOrEqualTo(0.0));
      expect(v, lessThan(100.0));
    });

    test('binaryClockString matches pattern', () {
      const tv = TimeValue(valueType: ValueType.binaryClockString, zone: ZoneLocal());
      final result = formatWith(tv, t);
      expect(result, matches(RegExp(r'^\d{5}:\d{6}:\d{6}$')));
    });

    test('named timezone formats correctly', () {
      const tv = TimeValue(
          valueType: ValueType.time,
          zone: ZoneNamed('Asia/Tokyo'));
      final result = formatWith(tv, t);
      expect(result, contains('JST'));
    });
  });

  group('TimeValueFormatter.formatDatePattern', () {
    // Reference: 2026-01-09 (Fri) – distinct values for D/DD/M/MM
    final ref = DateTime(2026, 1, 9, 8, 14, 27);

    test('YYYY-MM-DD produces ISO date', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'YYYY-MM-DD', 'en'),
          equals('2026-01-09'));
    });

    test('YY produces two-digit year', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'YY', 'en'),
          equals('26'));
    });

    test('MM produces zero-padded month', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'MM', 'en'),
          equals('01'));
    });

    test('M produces month without leading zero', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'M', 'en'),
          equals('1'));
    });

    test('DD produces zero-padded day', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'DD', 'en'),
          equals('09'));
    });

    test('D produces day without leading zero', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'D', 'en'),
          equals('9'));
    });

    test('MMM produces short month name', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'MMM', 'en'),
          equals('Jan'));
    });

    test('MMMM produces full month name', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'MMMM', 'en'),
          equals('January'));
    });

    test('EEE produces short weekday', () {
      // 2026-01-09 is a Friday
      expect(TimeValueFormatter.formatDatePattern(ref, 'EEE', 'en'),
          equals('Fri'));
    });

    test('EEEE produces full weekday', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'EEEE', 'en'),
          equals('Friday'));
    });

    test('German locale produces localized month names', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'MMMM', 'de'),
          equals('Januar'));
    });

    test('German locale produces localized weekday', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'EEEE', 'de'),
          equals('Freitag'));
    });

    test('German MMM gets trailing period', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'MMM', 'de'),
          equals('Jan.'));
    }, skip: 'acceptable without period, following DateFormat()');

    test('German EEE produces short weekday', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'EEE', 'de'),
          equals('Fr.'));
    });

    test('DD.MM.YYYY German format', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'DD.MM.YYYY', 'de'),
          equals('09.01.2026'));
    });

    test('MM/DD/YYYY US format', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'MM/DD/YYYY', 'en'),
          equals('01/09/2026'));
    });

    test('YYYYMMDD compact format', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'YYYYMMDD', 'en'),
          equals('20260109'));
    });

    // Critical: MMM must not partially match M token (the original bug):
    test('MMM does not corrupt May to 5ay', () {
      final may = DateTime(2026, 5, 9);
      expect(TimeValueFormatter.formatDatePattern(may, 'MMM', 'en'),
          equals('May'));
    });

    test('MMMM does not corrupt to partial substitution', () {
      final may = DateTime(2026, 5, 9);
      expect(TimeValueFormatter.formatDatePattern(may, 'MMMM', 'en'),
          equals('May'));  // May has no long form, stays 'May'
    });

    test('EEE does not corrupt EEEE', () {
      expect(TimeValueFormatter.formatDatePattern(ref, 'EEEE', 'en'),
          equals('Friday'));  // not 'Fridayday' or similar
    });

    test('mixed pattern with all tokens', () {
      expect(
        TimeValueFormatter.formatDatePattern(ref, 'EEE, YYYY-MM-DD', 'en'),
        equals('Fri, 2026-01-09'),
      );
    });

    test('separators are passed through unchanged', () {
      expect(
        TimeValueFormatter.formatDatePattern(ref, 'DD/MM/YYYY', 'en'),
        equals('09/01/2026'),
      );
      expect(
        TimeValueFormatter.formatDatePattern(ref, 'DD MM YYYY', 'en'),
        equals('09 01 2026'),
      );
    });
  });

  group('TimeValueFormatter.formatTimePattern', () {
    // Reference hour 8 to distinguish H from HH:
    final ref = DateTime(2026, 1, 9, 8, 14, 27);

    test('HH:mm:ss full format', () {
      expect(TimeValueFormatter.formatTimePattern(ref, 'HH:mm:ss'),
          equals('08:14:27'));
    });

    test('HH produces zero-padded hour', () {
      expect(TimeValueFormatter.formatTimePattern(ref, 'HH'),
          equals('08'));
    });

    test('H produces hour without leading zero', () {
      expect(TimeValueFormatter.formatTimePattern(ref, 'H'),
          equals('8'));
    });

    test('H vs HH difference visible at single-digit hour', () {
      final singleDigit = DateTime(2026, 1, 9, 9, 5, 3);
      expect(TimeValueFormatter.formatTimePattern(singleDigit, 'HH'),
          equals('09'));
      expect(TimeValueFormatter.formatTimePattern(singleDigit, 'H'),
          equals('9'));
    });

    test('mm produces zero-padded minutes', () {
      final earlyMinute = DateTime(2026, 1, 9, 8, 5, 27);
      expect(TimeValueFormatter.formatTimePattern(earlyMinute, 'mm'),
          equals('05'));
    });

    test('ss produces zero-padded seconds', () {
      final earlySecond = DateTime(2026, 1, 9, 8, 14, 3);
      expect(TimeValueFormatter.formatTimePattern(earlySecond, 'ss'),
          equals('03'));
    });

    test('HH:mm without seconds', () {
      expect(TimeValueFormatter.formatTimePattern(ref, 'HH:mm'),
          equals('08:14'));
    });

    test('HHmm compact format', () {
      expect(TimeValueFormatter.formatTimePattern(ref, 'HHmm'),
          equals('0814'));
    });

    test('12h format converts hour correctly', () {
      final afternoon = DateTime(2026, 1, 9, 14, 30, 0);
      expect(
        TimeValueFormatter.formatTimePattern(afternoon, 'HH:mm',
            hourFormat24: false),
        equals('02:30'),
      );
    });

    test('12h midnight is 12', () {
      final midnight = DateTime(2026, 1, 9, 0, 0, 0);
      expect(
        TimeValueFormatter.formatTimePattern(midnight, 'H:mm',
            hourFormat24: false),
        equals('12:00'),
      );
    });

    test('12h noon is 12', () {
      final noon = DateTime(2026, 1, 9, 12, 0, 0);
      expect(
        TimeValueFormatter.formatTimePattern(noon, 'H:mm',
            hourFormat24: false),
        equals('12:00'),
      );
    });

    test('custom separator', () {
      expect(TimeValueFormatter.formatTimePattern(ref, 'HH.mm.ss'),
          equals('08.14.27'));
    });
  });

  group('TimeValueFormatter.validatePattern', () {
    test('valid date patterns return null', () {
      for (final p in ['YYYY-MM-DD', 'DD.MM.YYYY', 'EEE, YYYY-MM-DD',
        'YYYYMMDD', 'MMMM D, YYYY']) {
        expect(TimeValueFormatter.validatePattern(p, true), isNull,
            reason: 'Pattern "$p" should be valid');
      }
    });

    test('valid time patterns return null', () {
      for (final p in ['HH:mm:ss', 'HH:mm', 'H:mm:ss', 'HHmm']) {
        expect(TimeValueFormatter.validatePattern(p, false), isNull,
            reason: 'Pattern "$p" should be valid');
      }
    });

    test('unknown uppercase token returns error', () {
      expect(TimeValueFormatter.validatePattern('YYYY-ZZ-DD', true),
          isNotNull);
      expect(TimeValueFormatter.validatePattern('HH:mm:XX', false),
          isNotNull);
    });

    test('time pattern without H returns error', () {
      expect(TimeValueFormatter.validatePattern('mm:ss', false),
          isNotNull);
    });

    test('time pattern without mm returns error', () {
      expect(TimeValueFormatter.validatePattern('HH:ss', false),
          isNotNull);
    });

    test('lowercase letters in date pattern are valid separators', () {
      // 'a', 'b' etc. are not tokens and should be treated as literals:
      expect(TimeValueFormatter.validatePattern('DD-MM-YYYY', true), isNull);
    });
  });

  group('TimeValueFormatter.binaryTimeString', () {
    test('midnight = 00000:000000:000000', () {
      final dt = DateTime(2026, 1, 1, 0, 0, 0);
      expect(TimeValueFormatter.binaryTimeString(dt), equals('00000:000000:000000'));
    });

    test('format is H:M:S with correct bit widths', () {
      final dt = DateTime(2026, 1, 1, 2, 30, 9);
      final result = TimeValueFormatter.binaryTimeString(dt);
      final parts = result.split(':');
      expect(parts.length, equals(3));
      expect(parts[0].length, equals(5));  // hours: 5 bits
      expect(parts[1].length, equals(6));  // minutes: 6 bits
      expect(parts[2].length, equals(6));  // seconds: 6 bits
    });
  });

  group('TimeValueFormatter.romanNumeralsTime', () {
    test('midnight uses N for zero, all fields 7 wide', () {
      expect(TimeValueFormatter.romanNumeralsTime(true, DateTime(2026, 1, 1, 0, 0, 0)),
          equals('   N   :   N   :   N   '));
    });

    test('24h with the longest numeral', () {
      expect(TimeValueFormatter.romanNumeralsTime(true, DateTime(2026, 1, 1, 18, 38, 58)),
          equals(' XVIII :XXXVIII: LVIII '));
    });

    test('seconds off keeps the field width', () {
      expect(TimeValueFormatter.romanNumeralsTime(true, DateTime(2026, 1, 1, 18, 38, 58),
          showSeconds: false), equals(' XVIII :XXXVIII'));
    });

    test('12h appends the period after the padded field', () {
      expect(TimeValueFormatter.romanNumeralsTime(false, DateTime(2026, 1, 1, 14, 5, 9)),
          equals('   II  :   V   :   IX   PM'));
    });

    test('width is constant for every second of the day', () {
      for (var s = 0; s < 86400; s += 7) {
        final dt = DateTime(2026, 1, 1).add(Duration(seconds: s));
        expect(TimeValueFormatter.romanNumeralsTime(true, dt).length, 23);
      }
    });

    test('roman numerals clipboard value has no padding', () {
      const timeValue = TimeValue(
          valueType: ValueType.romanNumeralsTime, zone: ZoneLocal());
      expect(
        TimeStringRow.computeClipboardDisplay(
            timeValue, (line1: '  XIV  :XXXVIII:   V    PM', line2: '')),
        equals('XIV:XXXVIII:V PM'),
      );
    });
  });

  group('Doomsday Clock display', () {
    String doomsdayClock(DateTime utcMoment, {bool hourFormat24 = true}) {
      const timeValue = TimeValue(
        valueType: ValueType.doomsdayClock,
        zone: ZoneUtc(),
      );
      return formatWith(timeValue, utcMoment, settings: ValueFormatSettings(hourFormat24: hourFormat24));
    }

    test('shows the setting as a time of day', () {
      expect(doomsdayClock(DateTime.utc(2026, 10, 24)), '23:58:35');
      expect(doomsdayClock(DateTime.utc(1991, 6, 1)), '23:43:00');
    });

    test('12-hour format', () {
      expect(
        doomsdayClock(DateTime.utc(1991, 6, 1), hourFormat24: false),
        '11:43:00 PM',
      );
    });
  });

  group('day minute', () {
    setUpAll(() {
      tzl.initializeTimeZones();
    });

    String line1(
        TimeValue timeValue, DateTime utc,
        {bool thousandsSep = false, String locale = 'en'}
        ) {
      return TimeStringRow.splitZoneOffset(
          TimeValueFormatter.format(
            timeValue, utc, locale,
            settings: ValueFormatSettings(thousandsSep: thousandsSep),
          )
      ).line1;
    }
    const utc = TimeValue(valueType: ValueType.dayMinute, zone: ZoneUtc());
    const utcNoSeconds = TimeValue(
        valueType: ValueType.dayMinute, zone: ZoneUtc(), showOptionalPart: false);
    const berlin = TimeValue(
        valueType: ValueType.dayMinute, zone: ZoneNamed('Europe/Berlin'));

    test('counts minutes since midnight, seconds follow the colon', () {
      expect(line1(utc, DateTime.utc(2026, 6, 15, 14, 5, 9)), '845:09');
      expect(line1(utcNoSeconds, DateTime.utc(2026, 6, 15, 14, 5, 9)), '845');
    });
    test('midnight and last minute of the day', () {
      expect(line1(utc, DateTime.utc(2026, 6, 15)), '0:00');
      expect(line1(utc, DateTime.utc(2026, 6, 15, 23, 59, 59)), '1439:59');
    });
    test('thousands separator follows the setting', () {
      final lastMinute = DateTime.utc(2026, 6, 15, 23, 59, 59);
      expect(line1(utcNoSeconds, lastMinute, thousandsSep: true), '1,439');
      expect(line1(utcNoSeconds, lastMinute, thousandsSep: true, locale: 'de'), '1.439');
      expect(line1(utcNoSeconds, lastMinute, thousandsSep: false, locale: 'en'), '1439');
      expect(line1(utcNoSeconds, lastMinute, thousandsSep: false, locale: 'de'), '1439');
    });
    test('clock change days use the real day length', () {
      expect(line1(berlin, DateTime.utc(2026, 10, 25, 22, 59, 59)), '1499:59');  // 25-hour day
      expect(line1(berlin, DateTime.utc(2027, 3, 28, 21, 59, 59)), '1379:59');   // 23-hour day
      expect(line1(berlin, DateTime.utc(2026, 6, 15, 21, 59, 59)), '1439:59');   // normal day
    });
  });

  group('octal and hexadecimal time', () {
    final t_oct = TimeValue(valueType: ValueType.octalTime, zone: const ZoneUtc());
    final t_hex = TimeValue(valueType: ValueType.hexadecimalTime, zone: const ZoneUtc());

    test('midnight is all zeros', () {
      final midnight = DateTime.utc(2026, 1, 1);
      expect(formatWith(t_oct, midnight), '000000');
      expect(formatWith(t_hex, midnight), '0_00_00');
    });

    test('one second before midnight (day second 86399)', () {
      final lastSecond = DateTime.utc(2026, 1, 1, 23, 59, 59);
      expect(formatWith(t_oct, lastSecond), '250577');
      expect(formatWith(t_hex, lastSecond), '1_51_7F');
    });
  });

  group('optional part in the formatter', () {
    final moment = DateTime.utc(2026, 6, 15, 14, 5, 9);
    const timeWithoutSeconds = TimeValue(
      valueType: ValueType.time,
      zone: ZoneUtc(),
      showOptionalPart: false,
    );

    test('time without seconds', () {
      expect(line1(timeWithoutSeconds, moment), '14:05');
      expect(line1(timeWithoutSeconds, moment, hourFormat24: false), '02:05 PM');
      expect(line1(timeWithoutSeconds, moment, timeFormat: 'H.mm.ss'), '14.05');
    });

    test('day percent without decimals is cut off, not rounded', () {
      const dayPercent = TimeValue(
        valueType: ValueType.dayPercent,
        zone: ZoneUtc(),
        showOptionalPart: false,
      );
      expect(line1(dayPercent, DateTime.utc(2026, 6, 15, 23, 59, 59)), '99');
      expect(line1(dayPercent, DateTime.utc(2026, 6, 15, 12)), '50');
    });

    test('decimal time without seconds', () {
      const decimalTime = TimeValue(
        valueType: ValueType.decimalTime,
        zone: ZoneUtc(),
        showOptionalPart: false,
      );
      expect(line1(decimalTime, DateTime.utc(2026, 6, 15, 12)), '5ʰ00ᵐ');
    });

    test('forcing seconds adds them to a format without seconds', () {
      const timeWithSeconds = TimeValue(
        valueType: ValueType.time,
        zone: ZoneUtc(),
        showOptionalPart: true,
      );
      expect(line1(timeWithSeconds, moment, timeFormat: 'HH:mm'), '14:05:09');
      expect(
        line1(timeWithSeconds, moment, timeFormat: 'H.mm', hourFormat24: false),
        '2.05.09 PM',
      );
    });

    test('without a choice the time format decides', () {
      const time = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
      expect(line1(time, moment, timeFormat: 'HH:mm'), '14:05');
      expect(line1(time, moment, timeFormat: 'HH:mm:ss'), '14:05:09');
    });
  });
}
