import 'package:epoch/models/timezone_search_zones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epoch/time_utils.dart';


void main() {

  // Civil

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

  group('TimeUtils.dayOfYear', () {
    test('January 1 = day 1', () {
      expect(TimeUtils.dayOfYear(DateTime(2026, 1, 1)), equals(1));
    });

    test('December 31 non-leap year = 365', () {
      expect(TimeUtils.dayOfYear(DateTime(2026, 12, 31)), equals(365));
    });

    test('December 31 leap year = 366', () {
      expect(TimeUtils.dayOfYear(DateTime(2024, 12, 31)), equals(366));
    });

    test('June 10 2026 = day 161', () {
      expect(TimeUtils.dayOfYear(DateTime(2026, 6, 10)), equals(161));
    });
  });

  group('TimeUtils.isoWeekNumber', () {
    test('2026-01-01 is week 1', () {
      expect(TimeUtils.isoWeekNumber(DateTime(2026, 1, 1)), equals(1));
    });

    test('2026-06-10 is week 24', () {
      expect(TimeUtils.isoWeekNumber(DateTime(2026, 6, 10)), equals(24));
    });

    test('2015-12-31 is week 53 of 2015', () {
      // Edge case: last day of year in week 53
      expect(TimeUtils.isoWeekNumber(DateTime(2015, 12, 31)), equals(53));
    });

    test('2016-01-01 is week 53 of 2015', () {
      // Edge case: first days of year can be in previous year's last week
      expect(TimeUtils.isoWeekNumber(DateTime(2016, 1, 1)), equals(53));
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


  // Technical

  group('TimeUtils.unixTimestamp', () {
    test('UNIX epoch = 0', () {
      final epoch = DateTime.utc(1970, 1, 1, 0, 0, 0);
      expect(TimeUtils.unixTimestamp(epoch), equals(0));
    });

    test('2001-09-09 01:46:40 UTC = 1000000000', () {
      final dt = DateTime.utc(2001, 9, 9, 1, 46, 40);
      expect(TimeUtils.unixTimestamp(dt), equals(1000000000));
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


  // Astronomical

  group('TimeUtils.gmst', () {
    test('J2000.0 epoch GMST is approximately 18h 45m', () {
      // J2000.0: 2000-01-01 12:00:00 UTC
      // GMST at J2000.0 is known: ~280.46° = 18.697h
      final j2000 = DateTime.utc(2000, 1, 1, 12, 0, 0);
      final result = TimeUtils.gmst(j2000);
      expect(result, closeTo(18.697, 0.05));
    });

    test('GMST advances ~24.0657h per solar day', () {
      final t1 = DateTime.utc(2026, 6, 10, 12, 0, 0);
      final t2 = DateTime.utc(2026, 6, 11, 12, 0, 0);
      final diff = (TimeUtils.gmst(t2) - TimeUtils.gmst(t1) + 24.0) % 24.0;
      // Sidereal day is ~23h 56m = 23.9345h, so GMST gains ~0.0657h/day
      expect(diff, closeTo(0.0657, 0.001));
    });

    test('GMST is between 0 and 24', () {
      final dt = DateTime.utc(2026, 6, 10, 15, 30, 0);
      final result = TimeUtils.gmst(dt);
      expect(result, greaterThanOrEqualTo(0.0));
      expect(result, lessThan(24.0));
    });
  });

  group('TimeUtils.lmst', () {
    test('LMST at longitude 0 equals GMST', () {
      final dt = DateTime.utc(2026, 6, 10, 12, 0, 0);
      expect(TimeUtils.lmst(dt, 0.0), closeTo(TimeUtils.gmst(dt), 0.0001));
    });

    test('LMST at longitude 180 is GMST + 12h mod 24', () {
      final dt = DateTime.utc(2026, 6, 10, 12, 0, 0);
      final gmst = TimeUtils.gmst(dt);
      final lmst = TimeUtils.lmst(dt, 180.0);
      expect(lmst, closeTo((gmst + 12.0) % 24.0, 0.0001));
    });

    test('LMST at negative longitude (West)', () {
      final dt = DateTime.utc(2026, 6, 10, 12, 0, 0);
      final lmst = TimeUtils.lmst(dt, -74.0); // New York
      expect(lmst, greaterThanOrEqualTo(0.0));
      expect(lmst, lessThan(24.0));
    });

    test('LMST wraps around 24h correctly', () {
      // LMST should never be negative or >= 24
      for (var lon = -180.0; lon <= 180.0; lon += 30.0) {
        final result = TimeUtils.lmst(DateTime.utc(2026, 1, 1), lon);
        expect(result, greaterThanOrEqualTo(0.0));
        expect(result, lessThan(24.0));
      }
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

  group('TimeUtils.modifiedJulianDate2000', () {
    test('MJD2000 at J2000.0 epoch = 0.0', () {
      // J2000.0: 2000-01-01 00:00:00 UTC (MJD2000 starts at midnight)
      final j2000 = DateTime.utc(2000, 1, 1, 0, 0, 0);
      expect(TimeUtils.modifiedJulianDate2000(j2000), closeTo(0.0, 0.0001));
    });

    test('MJD2000 = MJD - 51544', () {
      final dt = DateTime.utc(2026, 6, 10, 12, 0, 0);
      final mjd = TimeUtils.modifiedJulianDate(dt);
      final mjd2000 = TimeUtils.modifiedJulianDate2000(dt);
      expect(mjd2000, closeTo(mjd - 51544.0, 0.0001));
    });
  });


  // Curiosities

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
}