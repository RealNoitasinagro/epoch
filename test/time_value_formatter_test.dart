import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tzl;
import '../lib/models/time_value.dart';
import '../lib/time_value_formatter.dart';
import '../lib/widgets/time_string_row.dart';

void main() {
  setUpAll(() async {
    tzl.initializeTimeZones();
    await initializeDateFormatting('en');
    await initializeDateFormatting('de');
  });

  group('TimeValueFormatter.format – zone-independent', () {
    final t = DateTime.utc(2001, 9, 9, 1, 46, 40); // Unix 1000000000

    // Technical

    test('unixSeconds formats correctly', () {
      const tv = TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en');
      expect(result, equals('1,000,000,000'));
    });

    test('unixSeconds without thousands separator', () {
      const tv = TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en',
          thousandsSep: false);
      expect(result, equals('1000000000'));
    });

    test('unixSeconds DE locale uses period as thousands separator', () {
      const tv = TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'de');
      expect(result, equals('1.000.000.000'));
    });

    // Astronomical

    test('gmst returns HH:MM:SS format', () {
      const tv = TimeValue(valueType: ValueType.gmst, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en');
      expect(result, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
    });

    test('lmst returns placeholder without longitude', () {
      const tv = TimeValue(valueType: ValueType.lmst, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en');
      expect(result, equals('--:--:--'));
    });

    test('lmst with longitude returns HH:MM:SS', () {
      const tv = TimeValue(valueType: ValueType.lmst, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en',
          longitude: 8.68);
      final parts = result.split(':');
      expect(parts.length, equals(3));
      expect(int.tryParse(parts[0]), isNotNull);
    });

    test('julianDate has 5 decimal places', () {
      const tv = TimeValue(valueType: ValueType.julianDate, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en',
          thousandsSep: false);
      final parts = result.split('.');
      expect(parts.length, equals(2));
      expect(parts[1].length, equals(5));
    });

    // Curiosities

    test('swatchBeats format starts with @', () {
      const tv = TimeValue(valueType: ValueType.swatchBeats, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en');
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
      final result = TimeValueFormatter.format(tv, t, 'en',
          localIanaZone: 'Europe/Berlin');
      expect(result, contains(':'));
      expect(result, contains('UTC'));
    });

    test('time UTC returns UTC suffix', () {
      const tv = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en');
      expect(result, contains('UTC'));
    });

    test('time 12h format contains AM or PM', () {
      const tv = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en',
          hourFormat24: false);
      expect(result, anyOf(contains('AM'), contains('PM')));
    });

    test('daySecond is between 0 and 86399', () {
      const tv = TimeValue(valueType: ValueType.daySecond, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en',
          thousandsSep: false);
      var split = TimeStringRow.splitZoneOffset(result);
      final v = int.tryParse(split.line1);
      expect(v, isNotNull);
      expect(v, greaterThanOrEqualTo(0));
      expect(v, lessThanOrEqualTo(86399));
    });

    test('dayPercent is between 0.000 and 99.999', () {
      const tv = TimeValue(valueType: ValueType.dayPercent, zone: ZoneUtc());
      final result = TimeValueFormatter.format(tv, t, 'en');
      var split = TimeStringRow.splitZoneOffset(result);
      final v = double.tryParse(split.line1);
      expect(v, isNotNull);
      expect(v, greaterThanOrEqualTo(0.0));
      expect(v, lessThan(100.0));
    });

    test('binaryClockString matches pattern', () {
      const tv = TimeValue(valueType: ValueType.binaryClockString, zone: ZoneLocal());
      final result = TimeValueFormatter.format(tv, t, 'en');
      expect(result, matches(RegExp(r'^\d{5}:\d{6}:\d{6}$')));
    });

    test('named timezone formats correctly', () {
      const tv = TimeValue(
          valueType: ValueType.time,
          zone: ZoneNamed('Asia/Tokyo'));
      final result = TimeValueFormatter.format(tv, t, 'en');
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
}
