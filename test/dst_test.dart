import 'package:flutter_test/flutter_test.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/time_utils.dart';
import 'package:epoch/time_value_formatter.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  setUpAll(() => tz.initializeTimeZones());

  // ── TimezoneDisplayMode serialization ────────────────────────────────────

  group('TimeValue.timezoneDisplayMode serialization', () {
    test('default timezoneDisplayMode is auto', () {
      const tv = TimeValue(valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      expect(tv.timezoneDisplayMode, equals(TimezoneDisplayMode.auto));
    });

    test('auto timezoneDisplayMode roundtrips without suffix', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.auto,
      );
      final s = tv.toPrefsString();
      expect(s.contains('dst:'), isFalse);
      final tv2 = TimeValue.fromPrefsString(s);
      expect(tv2?.timezoneDisplayMode, equals(TimezoneDisplayMode.auto));
    });

    test('forceDst roundtrips correctly', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceDst,
      );
      final s = tv.toPrefsString();
      expect(s.contains('dst:forceDst'), isTrue);
      final tv2 = TimeValue.fromPrefsString(s);
      expect(tv2?.timezoneDisplayMode, equals(TimezoneDisplayMode.forceDst));
    });

    test('forceStandard roundtrips correctly', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      final s = tv.toPrefsString();
      expect(s.contains('dst:forceStandard'), isTrue);
      final tv2 = TimeValue.fromPrefsString(s);
      expect(tv2?.timezoneDisplayMode, equals(TimezoneDisplayMode.forceStandard));
    });

    test('timezoneDisplayMode roundtrip preserves customLabel', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        customLabel: 'My Berlin Time',
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      final s = tv.toPrefsString();
      final tv2 = TimeValue.fromPrefsString(s);
      expect(tv2?.customLabel, equals('My Berlin Time'));
      expect(tv2?.timezoneDisplayMode, equals(TimezoneDisplayMode.forceStandard));
    });

    test('no duplicate dst suffix on repeated serialization', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceDst,
      );
      final s1 = tv.toPrefsString();
      final tv2 = TimeValue.fromPrefsString(s1)!;
      final s2 = tv2.toPrefsString();
      expect(s1, equals(s2));
      expect('dst:'.allMatches(s2).length, equals(1));
    });

    test('legacy prefs string (no dst suffix) parses as auto', () {
      // Backward compatibility: existing saved entries without dst suffix
      const legacy = 'time/named:Europe/Berlin';
      final tv = TimeValue.fromPrefsString(legacy);
      expect(tv?.timezoneDisplayMode, equals(TimezoneDisplayMode.auto));
    });

    test('legacy prefs string with customLabel parses as auto', () {
      const legacy = 'time/named:Europe/Berlin|My Label';
      final tv = TimeValue.fromPrefsString(legacy);
      expect(tv?.timezoneDisplayMode, equals(TimezoneDisplayMode.auto));
      expect(tv?.customLabel, equals('My Label'));
    });
  });

  // ── TimeUtils.hasDaylightSavingTime ───────────────────────────────────────

  group('TimeUtils.hasDaylightSavingTime', () {
    test('Europe/Berlin has DST', () {
      expect(TimeUtils.hasDaylightSavingTime('Europe/Berlin'), isTrue);
    });

    test('Europe/Paris has DST', () {
      expect(TimeUtils.hasDaylightSavingTime('Europe/Paris'), isTrue);
    });

    test('America/New_York has DST', () {
      expect(TimeUtils.hasDaylightSavingTime('America/New_York'), isTrue);
    });

    test('Australia/Lord_Howe has DST', () {
      // Lord Howe Island: +00:30 offset DST, unusual
      expect(TimeUtils.hasDaylightSavingTime('Australia/Lord_Howe'), isTrue);
    });

    test('Asia/Tokyo has no DST', () {
      expect(TimeUtils.hasDaylightSavingTime('Asia/Tokyo'), isFalse);
    });

    test('UTC has no DST', () {
      expect(TimeUtils.hasDaylightSavingTime('UTC'), isFalse);
    });

    test('America/Bogota has no DST', () {
      expect(TimeUtils.hasDaylightSavingTime('America/Bogota'), isFalse);
    });

    test('Europe/Moscow has no DST', () {
      expect(TimeUtils.hasDaylightSavingTime('Europe/Moscow'), isFalse);
    });
  });

  // ── TimeUtils.daylightOrStandardOffset ───────────────────────────────────

  group('TimeUtils.daylightOrStandardOffset', () {
    test('Berlin standard time is UTC+01:00 / CET', () {
      final info = TimeUtils.daylightOrStandardOffset('Europe/Berlin', false);
      expect(info, isNotNull);
      expect(info!.offset, equals(const Duration(hours: 1)));
      expect(info.abbreviation, equals('CET'));
    });

    test('Berlin daylight time is UTC+02:00 / CEST', () {
      final info = TimeUtils.daylightOrStandardOffset('Europe/Berlin', true);
      expect(info, isNotNull);
      expect(info!.offset, equals(const Duration(hours: 2)));
      expect(info.abbreviation, equals('CEST'));
    });

    test('New York standard time is UTC-05:00 / EST', () {
      final info = TimeUtils.daylightOrStandardOffset('America/New_York', false);
      expect(info, isNotNull);
      expect(info!.offset, equals(const Duration(hours: -5)));
      expect(info.abbreviation, equals('EST'));
    });

    test('New York daylight time is UTC-04:00 / EDT', () {
      final info = TimeUtils.daylightOrStandardOffset('America/New_York', true);
      expect(info, isNotNull);
      expect(info!.offset, equals(const Duration(hours: -4)));
      expect(info.abbreviation, equals('EDT'));
    });

    test('Tokyo returns null (no DST)', () {
      expect(TimeUtils.daylightOrStandardOffset('Asia/Tokyo', false), isNull);
      expect(TimeUtils.daylightOrStandardOffset('Asia/Tokyo', true), isNull);
    });

    test('Lord Howe DST offset is +30min relative to standard', () {
      final std = TimeUtils.daylightOrStandardOffset('Australia/Lord_Howe', false);
      final dst = TimeUtils.daylightOrStandardOffset('Australia/Lord_Howe', true);
      expect(std, isNotNull);
      expect(dst, isNotNull);
      final diff = dst!.offset - std!.offset;
      expect(diff, equals(const Duration(minutes: 30)));
    });

    test('Troll DST offset is +120min relative to standard', () {
      final std = TimeUtils.daylightOrStandardOffset('Antarctica/Troll', false);
      final dst = TimeUtils.daylightOrStandardOffset('Antarctica/Troll', true);
      expect(std, isNotNull);
      expect(dst, isNotNull);
      final diff = dst!.offset - std!.offset;
      expect(diff, equals(const Duration(minutes: 120)));
    });
  });

  // ── TimeValueFormatter with timezoneDisplayMode ──────────────────────────────────────

  group('TimeValueFormatter.format with timezoneDisplayMode', () {
    // June = DST active in Berlin (CEST = UTC+2)
    final summerUtc = DateTime.utc(2026, 6, 15, 12, 0, 0);
    // January = standard time in Berlin (CET = UTC+1)
    final winterUtc = DateTime.utc(2026, 1, 15, 12, 0, 0);

    test('auto in summer shows CEST', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.auto,
      );
      final result = TimeValueFormatter.format(tv, summerUtc, 'en');
      expect(result, contains('CEST'));
    });

    test('auto in winter shows CET', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.auto,
      );
      final result = TimeValueFormatter.format(tv, winterUtc, 'en');
      expect(result, contains('CET'));
    });

    test('forceStandard in summer shows CET (winter abbreviation)', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      final result = TimeValueFormatter.format(tv, summerUtc, 'en');
      expect(result, contains('CET'));
      expect(result, isNot(contains('CEST')));
    });

    test('forceDst in winter shows CEST (summer abbreviation)', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceDst,
      );
      final result = TimeValueFormatter.format(tv, winterUtc, 'en');
      expect(result, contains('CEST'));
      expect(result, isNot(contains('CET ')));
    });

    test('forceStandard shows UTC+01:00 in summer', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      final result = TimeValueFormatter.format(tv, summerUtc, 'en');
      expect(result, contains('UTC+01:00'));
    });

    test('forceDst shows UTC+02:00 in winter', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceDst,
      );
      final result = TimeValueFormatter.format(tv, winterUtc, 'en');
      expect(result, contains('UTC+02:00'));
    });

    test('forceStandard shifts time by 1h compared to auto in summer', () {
      const tvAuto = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.auto,
      );
      const tvStd = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      final autoResult = TimeValueFormatter.format(tvAuto, summerUtc, 'en');
      final stdResult = TimeValueFormatter.format(tvStd, summerUtc, 'en');
      // auto = 14:00 CEST, forceStandard = 13:00 CET
      expect(autoResult, startsWith('14:00:00'));
      expect(stdResult, startsWith('13:00:00'));
    });

    test('forceStandard on Tokyo (no DST) falls back to auto', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Asia/Tokyo'),
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      const tvAuto = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Asia/Tokyo'),
        timezoneDisplayMode: TimezoneDisplayMode.auto,
      );
      final forced = TimeValueFormatter.format(tv, summerUtc, 'en');
      final auto = TimeValueFormatter.format(tvAuto, summerUtc, 'en');
      expect(forced, equals(auto));
    });

    test('daySecond shifts by 3600 with forceStandard in summer', () {
      const tvAuto = TimeValue(
        valueType: ValueType.daySecond,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.auto,
      );
      const tvStd = TimeValue(
        valueType: ValueType.daySecond,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      final autoVal = int.parse(
          TimeValueFormatter.format(tvAuto, summerUtc, 'en',
              thousandsSep: false));
      final stdVal = int.parse(
          TimeValueFormatter.format(tvStd, summerUtc, 'en',
              thousandsSep: false));
      expect(autoVal - stdVal, equals(3600));
    });
  });

  // ── withDstMode ──────────────────────────────────────────────────────────

  group('TimeValue.timezoneDisplayMode', () {
    test('creates new instance with updated timezoneDisplayMode', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.auto,
      );
      final tv2 = tv.withTimezoneDisplayMode(TimezoneDisplayMode.forceStandard);
      expect(tv2.timezoneDisplayMode, equals(TimezoneDisplayMode.forceStandard));
      expect(tv2.valueType, equals(tv.valueType));
      expect(tv2.zone, equals(tv.zone));
      expect(tv2.customLabel, equals(tv.customLabel));
    });

    test('key changes when timezoneDisplayMode changes', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
      );
      final tv2 = tv.withTimezoneDisplayMode(TimezoneDisplayMode.forceStandard);
      expect(tv2.key, isNot(equals(tv.key)));
      expect(tv2.key, equals('time/named:Europe/Berlin/std'));
    });

    test('key for forceDst has /dst suffix', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceDst,
      );
      expect(tv.key, equals('time/named:Europe/Berlin/dst'));
    });

    test('key for forceStandard has /std suffix', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      expect(tv.key, equals('time/named:Europe/Berlin/std'));
    });

    test('sameZoneAndType is true regardless of timezoneDisplayMode', () {
      const tvAuto = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.auto,
      );
      const tvDst = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceDst,
      );
      const tvStd = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        timezoneDisplayMode: TimezoneDisplayMode.forceStandard,
      );
      expect(tvAuto.sameZoneAndType(tvDst), isTrue);
      expect(tvAuto.sameZoneAndType(tvStd), isTrue);
      expect(tvDst.sameZoneAndType(tvStd), isTrue);
    });

    test('sameZoneAndType is false for different zones', () {
      const tvBerlin = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
      );
      const tvVienna = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Vienna'),
      );
      expect(tvBerlin.sameZoneAndType(tvVienna), isFalse);
    });

    test('sameZoneAndType is false for different valueType', () {
      const tvTime = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
      );
      const tvDateTime = TimeValue(
        valueType: ValueType.dateTime,
        zone: ZoneNamed('Europe/Berlin'),
      );
      expect(tvTime.sameZoneAndType(tvDateTime), isFalse);
    });
  });
}