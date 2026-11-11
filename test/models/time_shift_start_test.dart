import 'package:epoch/effective_clock.dart';
import 'package:epoch/models/time_shift_start.dart';
import 'package:epoch/models/time_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

void main() {
  setUpAll(tzd.initializeTimeZones);

  setUp(() {
    EffectiveClock.systemNow = () => DateTime.utc(2026, 11, 9, 12).toLocal();
    EffectiveClock.reset();
  });

  tearDown(() {
    EffectiveClock.systemNow = DateTime.now;
    EffectiveClock.reset();
  });

  group('moment', () {
    test('needs Z or an offset, whole seconds', () {
      expect(parseTimeShiftMoment('2026-12-24T18:00:00Z'), DateTime.utc(2026, 12, 24, 18));
      expect(parseTimeShiftMoment('2026-12-24T18:00:00.750Z'), DateTime.utc(2026, 12, 24, 18));
      expect(parseTimeShiftMoment('2026-12-24T18:00:00+10:30'),
          DateTime.utc(2026, 12, 24, 7, 30));
      expect(parseTimeShiftMoment('2026-12-24 18:00:00'), isNull);
      expect(parseTimeShiftMoment('garbage'), isNull);
      expect(parseTimeShiftMoment(null), isNull);
    });

    test('format and parse round trip', () {
      final moment = DateTime.utc(2000, 1, 1, 0, 0, 5);
      expect(formatTimeShiftMoment(moment), '2000-01-01T00:00:05Z');
      expect(parseTimeShiftMoment(formatTimeShiftMoment(moment)), moment);
    });
  });

  group('zone in the config', () {
    test('empty is local, UTC aliases collapse, unknown falls back to local', () {
      expect(timeShiftZoneFromConfig(''), isA<ZoneLocal>());
      expect(timeShiftZoneFromConfig(null), isA<ZoneLocal>());
      expect(timeShiftZoneFromConfig('UTC'), isA<ZoneUtc>());
      expect(timeShiftZoneFromConfig('Etc/UTC'), isA<ZoneUtc>());
      expect(timeShiftZoneFromConfig('Nowhere/Land'), isA<ZoneLocal>());
      final lordHowe = timeShiftZoneFromConfig('Australia/Lord_Howe');
      expect(lordHowe, isA<ZoneNamed>());
      expect(timeShiftZoneToConfig(lordHowe), 'Australia/Lord_Howe');
      expect(timeShiftZoneToConfig(const ZoneLocal()), '');
      expect(timeShiftZoneToConfig(const ZoneUtc()), 'UTC');
    });
  });

  group('load and save', () {
    test('round trip, local zone is saved as an empty string', () async {
      SharedPreferences.setMockInitialValues({});
      await saveTimeShiftStart(TimeShiftStart(
          momentUtc: DateTime.utc(2026, 12, 24, 18), frozen: true));
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('time_shift_zone'), '');
      final loaded = (await loadTimeShiftStart())!;
      expect(loaded.momentUtc, DateTime.utc(2026, 12, 24, 18));
      expect(loaded.frozen, isTrue);
      expect(loaded.zone, isA<ZoneLocal>());
    });

    test('unusable values mean no start value', () async {
      for (final moment in ['garbage', '2040-01-01T00:00:00Z', '1960-01-01T00:00:00Z']) {
        SharedPreferences.setMockInitialValues({'time_shift_moment': moment});
        expect(await loadTimeShiftStart(), isNull, reason: moment);
      }
      SharedPreferences.setMockInitialValues({'time_shift_moment': 5});
      expect(await loadTimeShiftStart(), isNull);
      SharedPreferences.setMockInitialValues({});
      expect(await loadTimeShiftStart(), isNull);
    });

    test('a frozen flag of the wrong type means not frozen', () async {
      SharedPreferences.setMockInitialValues({
        'time_shift_moment': '2026-12-24T18:00:00Z',
        'time_shift_frozen': 'yes',
      });
      expect((await loadTimeShiftStart())!.frozen, isFalse);
    });

    test('clearing removes all three keys', () async {
      SharedPreferences.setMockInitialValues({
        'time_shift_moment': '2026-12-24T18:00:00Z',
        'time_shift_frozen': true,
        'time_shift_zone': 'UTC',
      });
      await clearTimeShiftStart();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getKeys().where((key) => key.startsWith('time_shift_')), isEmpty);
    });
  });

  group('applyTimeShiftStart', () {
    test('a frozen start value stops the clock at the moment', () async {
      SharedPreferences.setMockInitialValues({
        'time_shift_moment': '2000-01-01T00:00:00Z',
        'time_shift_frozen': true,
      });
      await applyTimeShiftStart();
      expect(EffectiveClock.isFrozen, isTrue);
      expect(EffectiveClock.now().toUtc(), DateTime.utc(2000));
    });

    test('a running start value keeps ticking from the moment', () async {
      SharedPreferences.setMockInitialValues({
        'time_shift_moment': '2000-01-01T00:00:00Z',
      });
      await applyTimeShiftStart();
      expect(EffectiveClock.isShifted, isTrue);
      expect(EffectiveClock.isFrozen, isFalse);
      EffectiveClock.systemNow = () =>
          DateTime.utc(2026, 11, 9, 12, 0, 10).toLocal();
      expect(EffectiveClock.now().toUtc(), DateTime.utc(2000, 1, 1, 0, 0, 10));
    });

    test('without a start value nothing is shifted', () async {
      SharedPreferences.setMockInitialValues({});
      await applyTimeShiftStart();
      expect(EffectiveClock.isShifted, isFalse);
    });

    test('remembers the zone the start value was entered in', () async {
      SharedPreferences.setMockInitialValues({
        'time_shift_moment': '2000-01-01T00:00:00Z',
        'time_shift_zone': 'Australia/Lord_Howe',
      });
      await applyTimeShiftStart();
      expect(timeShiftZoneToConfig(activeTimeShiftZone), 'Australia/Lord_Howe');
    });
  });
}
