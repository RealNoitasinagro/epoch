import 'package:epoch/widgets/time_string_row.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/time_value_formatter.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  setUpAll(() => tz.initializeTimeZones());

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
      final beats = int.tryParse(result.substring(1));
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
}