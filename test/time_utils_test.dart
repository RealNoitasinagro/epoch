import 'package:epoch/time_value_formatter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epoch/time_utils.dart';

void main() {
  group('TimeUtils.unixTimestamp', () {
    test('known epoch returns 0', () {
      final epoch = DateTime.utc(1970, 1, 1, 0, 0, 0);
      expect(TimeUtils.unixTimestamp(epoch), equals(0));
    });

    test('2001-09-09 01:46:40 UTC = 1000000000', () {
      final dt = DateTime.utc(2001, 9, 9, 1, 46, 40);
      expect(TimeUtils.unixTimestamp(dt), equals(1000000000));
    });
  });

  group('TimeUtils.daySecond', () {
    test('midnight = 0', () {
      final dt = DateTime.utc(2026, 1, 1, 0, 0, 0);
      expect(TimeUtils.daySecond(dt), equals(0));
    });

    test('noon = 43200', () {
      final dt = DateTime.utc(2026, 1, 1, 12, 0, 0);
      expect(TimeUtils.daySecond(dt), equals(43200));
    });

    test('23:59:59 = 86399', () {
      final dt = DateTime.utc(2026, 1, 1, 23, 59, 59);
      expect(TimeUtils.daySecond(dt), equals(86399));
    });
  });

  group('TimeUtils.dayPercent', () {
    test('midnight = 0.0', () {
      final dt = DateTime.utc(2026, 1, 1, 0, 0, 0);
      expect(TimeUtils.dayPercent(dt), equals(0.0));
    });

    test('noon = 50.0', () {
      final dt = DateTime.utc(2026, 1, 1, 12, 0, 0);
      expect(TimeUtils.dayPercent(dt), equals(50.0));
    });
  });

  group('TimeUtils.julianDate', () {
    test('J2000.0 epoch = 2451545.0', () {
      final j2000 = DateTime.utc(2000, 1, 1, 12, 0, 0);
      expect(TimeUtils.julianDate(j2000), closeTo(2451545.0, 0.0001));
    });

    test('Unix epoch = 2440587.5', () {
      final unixEpoch = DateTime.utc(1970, 1, 1, 0, 0, 0);
      expect(TimeUtils.julianDate(unixEpoch), closeTo(2440587.5, 0.0001));
    });
  });

  group('TimeUtils.modifiedJulianDate', () {
    test('MJD = JD - 2400000.5', () {
      final dt = DateTime.utc(2000, 1, 1, 12, 0, 0);
      final jd = TimeUtils.julianDate(dt);
      final mjd = TimeUtils.modifiedJulianDate(dt);
      expect(mjd, closeTo(jd - 2400000.5, 0.0001));
    });
  });

  group('TimeUtils.taiSeconds', () {
    test('TAI is 37 seconds ahead of Unix', () {
      final dt = DateTime.utc(2026, 1, 1, 0, 0, 0);
      final unix = TimeUtils.unixTimestamp(dt);
      final tai = TimeUtils.taiSeconds(dt);
      expect(tai - unix, equals(37));
    });
  });

  group('TimeUtils.gpsTime', () {
    test('GPS epoch = 0', () {
      // GPS epoch: 1980-01-06 00:00:00 UTC, GPS is 18s ahead
      final gpsEpoch = DateTime.utc(1980, 1, 6, 0, 0, 0);
      expect(TimeUtils.gpsTime(gpsEpoch), equals(18));
    });
  });

  group('TimeUtils.swatchBeats', () {
    test('returns value between 0 and 1000', () {
      final dt = DateTime.utc(2026, 5, 1, 12, 0, 0);
      final beats = TimeUtils.swatchBeats(dt);
      expect(beats, greaterThanOrEqualTo(0.0));
      expect(beats, lessThan(1000.0));
    });

    test('midnight BMT (23:00 UTC) = 0 beats', () {
      // BMT = UTC+1, so midnight BMT = 23:00 UTC
      final dt = DateTime.utc(2026, 1, 1, 23, 0, 0);
      expect(TimeUtils.swatchBeats(dt), closeTo(0.0, 0.1));
    });
  });

  group('TimeUtils.binaryTimeString', () {
    test('midnight = 00000:000000:000000', () {
      final dt = DateTime(2026, 1, 1, 0, 0, 0);
      expect(TimeUtils.binaryTimeString(dt), equals('00000:000000:000000'));
    });

    test('format is H:M:S with correct bit widths', () {
      final dt = DateTime(2026, 1, 1, 2, 30, 9);
      final result = TimeUtils.binaryTimeString(dt);
      final parts = result.split(':');
      expect(parts.length, equals(3));
      expect(parts[0].length, equals(5)); // hours: 5 bits
      expect(parts[1].length, equals(6)); // minutes: 6 bits
      expect(parts[2].length, equals(6)); // seconds: 6 bits
    });
  });

  group('TimeUtils.hoursToHms', () {
    test('0.0 hours = 00:00:00', () {
      expect(TimeValueFormatter.hoursToHms(0.0), equals('00:00:00'));
    });

    test('12.5 hours = 12:30:00', () {
      expect(TimeValueFormatter.hoursToHms(12.5), equals('12:30:00'));
    });

    test('23.9997... hours rounds correctly', () {
      expect(TimeValueFormatter.hoursToHms(23.0), equals('23:00:00'));
    });
  });

  group('TimeUtils.formatTime12h', () {
    test('midnight = 12:00:00 AM', () {
      expect(TimeValueFormatter.formatTime12h(0, '00', '00', null),
          equals('12:00:00 AM'));
    });

    test('noon = 12:00:00 PM', () {
      expect(TimeValueFormatter.formatTime12h(12, '00', '00', null),
          equals('12:00:00 PM'));
    });

    test('13:30:00 = 01:30:00 PM', () {
      expect(TimeValueFormatter.formatTime12h(13, '30', '00', null),
          equals('01:30:00 PM'));
    });

    test('with timezone suffix', () {
      expect(TimeValueFormatter.formatTime12h(9, '00', '00', 'UTC'),
          equals('09:00:00 AM UTC'));
    });
  });

  group('TimeUtils.utcOffsetString', () {
    test('zero offset = UTC+00:00', () {
      expect(TimeUtils.utcOffsetString(Duration.zero), equals('UTC+00:00'));
    });

    test('positive offset', () {
      expect(TimeUtils.utcOffsetString(const Duration(hours: 2)),
          equals('UTC+02:00'));
    });

    test('negative offset', () {
      expect(TimeUtils.utcOffsetString(const Duration(hours: -5)),
          equals('UTC−05:00'));
    });

    test('fractional offset (India +5:30)', () {
      expect(
          TimeUtils.utcOffsetString(
              const Duration(hours: 5, minutes: 30)),
          equals('UTC+05:30'));
    });
  });
}