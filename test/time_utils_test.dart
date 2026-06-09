import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/time_value_formatter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epoch/time_utils.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzd;

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

  group('TimeValueFormatter.hoursToHms', () {
    test('0.0 hours = 00:00:00', () {
      expect(TimeValueFormatter.hoursToHms(0.0), equals('00:00:00'));
    });

    test('12.5 hours = 12:30:00', () {
      expect(TimeValueFormatter.hoursToHms(12.5), equals('12:30:00'));
    });

    test('23.0 hours = 23:00:00', () {
      expect(TimeValueFormatter.hoursToHms(23.0), equals('23:00:00'));
    });
  });

  group('TimeValueFormatter.formatTime12h', () {
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

  group('TimeValueFormatter.formatDecimal', () {
    test('decimal with thousands separator EN', () {
      expect(TimeValueFormatter.formatDecimal(2461196.382, 'en', 3),
          equals('2,461,196.382'));
    });
    test('decimal with thousands separator DE', () {
      expect(TimeValueFormatter.formatDecimal(2461196.382, 'de', 3),
          equals('2.461.196,382'));
    });
    test('decimal without thousands separator EN', () {
      expect(
          TimeValueFormatter.formatDecimal(2461196.382, 'en', 3,
              thousandsSep: false),
          equals('2461196.382'));
    });
    test('decimal without thousands separator DE uses comma', () {
      expect(
          TimeValueFormatter.formatDecimal(61195.879, 'de', 3,
              thousandsSep: false),
          equals('61195,879'));
    });
    test('small decimal no thousands needed', () {
      expect(TimeValueFormatter.formatDecimal(96.348, 'en', 3),
          equals('96.348'));
    });
  });

  group('IANA timezone names', () {
    tzd.initializeTimeZones();

    test('Europe/London', () {
      String ianaZone = 'Europe/London';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Dublin', () {
      String ianaZone = 'Europe/Dublin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Lisbon', () {
      String ianaZone = 'Europe/Lisbon';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Berlin', () {
      String ianaZone = 'Europe/Berlin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Vienna', () {
      String ianaZone = 'Europe/Vienna';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Zurich', () {
      String ianaZone = 'Europe/Zurich';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Paris', () {
      String ianaZone = 'Europe/Paris';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Brussels', () {
      String ianaZone = 'Europe/Brussels';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Madrid', () {
      String ianaZone = 'Europe/Madrid';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Rome', () {
      String ianaZone = 'Europe/Rome';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Prague', () {
      String ianaZone = 'Europe/Prague';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Warsaw', () {
      String ianaZone = 'Europe/Warsaw';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Budapest', () {
      String ianaZone = 'Europe/Budapest';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Helsinki', () {
      String ianaZone = 'Europe/Helsinki';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Athens', () {
      String ianaZone = 'Europe/Athens';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Bucharest', () {
      String ianaZone = 'Europe/Bucharest';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Kyiv', () {
      String ianaZone = 'Europe/Kyiv';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Istanbul', () {
      String ianaZone = 'Europe/Istanbul';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Moscow', () {
      String ianaZone = 'Europe/Moscow';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Casablanca', () {
      String ianaZone = 'Africa/Casablanca';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Cairo', () {
      String ianaZone = 'Africa/Cairo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Johannesburg', () {
      String ianaZone = 'Africa/Johannesburg';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Nairobi', () {
      String ianaZone = 'Africa/Nairobi';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Lagos', () {
      String ianaZone = 'Africa/Lagos';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Abidjan', () {
      String ianaZone = 'Africa/Abidjan';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Tunis', () {
      String ianaZone = 'Africa/Tunis';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/New_York', () {
      String ianaZone = 'America/New_York';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Chicago', () {
      String ianaZone = 'America/Chicago';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Denver', () {
      String ianaZone = 'America/Denver';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Los_Angeles', () {
      String ianaZone = 'America/Los_Angeles';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Anchorage', () {
      String ianaZone = 'America/Anchorage';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Toronto', () {
      String ianaZone = 'America/Toronto';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Vancouver', () {
      String ianaZone = 'America/Vancouver';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Halifax', () {
      String ianaZone = 'America/Halifax';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/St_Johns', () {
      String ianaZone = 'America/St_Johns';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Mexico_City', () {
      String ianaZone = 'America/Mexico_City';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Bogota', () {
      String ianaZone = 'America/Bogota';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Sao_Paulo', () {
      String ianaZone = 'America/Sao_Paulo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Buenos_Aires', () {
      String ianaZone = 'America/Argentina/Buenos_Aires';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Dubai', () {
      String ianaZone = 'Asia/Dubai';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tehran', () {
      String ianaZone = 'Asia/Tehran';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Karachi', () {
      String ianaZone = 'Asia/Karachi';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kolkata', () {
      String ianaZone = 'Asia/Kolkata';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Colombo', () {
      String ianaZone = 'Asia/Colombo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kathmandu', () {
      String ianaZone = 'Asia/Kathmandu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Dhaka', () {
      String ianaZone = 'Asia/Dhaka';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Yangon', () {
      String ianaZone = 'Asia/Yangon';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Bangkok', () {
      String ianaZone = 'Asia/Bangkok';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Jakarta', () {
      String ianaZone = 'Asia/Jakarta';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Shanghai', () {
      String ianaZone = 'Asia/Shanghai';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Hong_Kong', () {
      String ianaZone = 'Asia/Hong_Kong';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Singapore', () {
      String ianaZone = 'Asia/Singapore';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Taipei', () {
      String ianaZone = 'Asia/Taipei';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Manila', () {
      String ianaZone = 'Asia/Manila';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Seoul', () {
      String ianaZone = 'Asia/Seoul';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tokyo', () {
      String ianaZone = 'Asia/Tokyo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Baghdad', () {
      String ianaZone = 'Asia/Baghdad';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Perth', () {
      String ianaZone = 'Australia/Perth';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Darwin', () {
      String ianaZone = 'Australia/Darwin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Brisbane', () {
      String ianaZone = 'Australia/Brisbane';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Adelaide', () {
      String ianaZone = 'Australia/Adelaide';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Sydney', () {
      String ianaZone = 'Australia/Sydney';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Hobart', () {
      String ianaZone = 'Australia/Hobart';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Lord_Howe', () {
      String ianaZone = 'Australia/Lord_Howe';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Auckland', () {
      String ianaZone = 'Pacific/Auckland';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Honolulu', () {
      String ianaZone = 'Pacific/Honolulu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Fiji', () {
      String ianaZone = 'Pacific/Fiji';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Guam', () {
      String ianaZone = 'Pacific/Guam';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Tongatapu', () {
      String ianaZone = 'Pacific/Tongatapu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Tahiti', () {
      String ianaZone = 'Pacific/Tahiti';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Marquesas', () {
      String ianaZone = 'Pacific/Marquesas';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Pago_Pago', () {
      String ianaZone = 'Pacific/Pago_Pago';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Norfolk', () {
      String ianaZone = 'Pacific/Norfolk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Port_Moresby', () {
      String ianaZone = 'Pacific/Port_Moresby';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Azores', () {
      String ianaZone = 'Atlantic/Azores';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Cape_Verde', () {
      String ianaZone = 'Atlantic/Cape_Verde';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/South_Georgia', () {
      String ianaZone = 'Atlantic/South_Georgia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Canary', () {
      String ianaZone = 'Atlantic/Canary';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Troll', () {
      String ianaZone = 'Antarctica/Troll';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Palmer', () {
      String ianaZone = 'Antarctica/Palmer';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });
  });

  group('IANA timezone names deprecated', () {
    test('Stockholm', () {
      String ianaZone = 'Europe/Berlin';
      var searchTerm = 'stockholm';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Oslo', () {
      String ianaZone = 'Europe/Berlin';
      var searchTerm = 'oslo';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Copenhagen', () {
      String ianaZone = 'Europe/Berlin';
      var searchTerm = 'copenhagen';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Longyearbyen', () {
      String ianaZone = 'Europe/Berlin';
      var searchTerm = 'longyearbyen';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Amsterdam', () {
      String ianaZone = 'Europe/Brussels';
      var searchTerm = 'amsterdam';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Reykjavik', () {
      String ianaZone = 'Africa/Abidjan';
      var searchTerm = 'reykjavik';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Kuala Lumpur', () {
      String ianaZone = 'Asia/Singapore';
      var searchTerm = 'kuala lumpur';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Midway', () {
      String ianaZone = 'Pacific/Pago_Pago';
      var searchTerm = 'midway';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('McMurdo', () {
      String ianaZone = 'Pacific/Auckland';
      var searchTerm = 'mcmurdo';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Kiev', () {
      String ianaZone = 'Europe/Kyiv';
      var searchTerm = 'kiev';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });
  });
}