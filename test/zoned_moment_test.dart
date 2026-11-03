import 'package:epoch/models/time_value.dart';
import 'package:epoch/zoned_moment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzl;

void main() {
  setUpAll(() {
    tzl.initializeTimeZones();
  });

  const utcValue = TimeValue(
    valueType: ValueType.time,
    zone: ZoneUtc(),
  );
  const berlinValue = TimeValue(
    valueType: ValueType.time,
    zone: ZoneNamed('Europe/Berlin'),
  );
  const berlinStandardValue = TimeValue(
    valueType: ValueType.time,
    zone: ZoneNamed('Europe/Berlin'),
    timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard,
  );
  const localBerlinValue = TimeValue(
    valueType: ValueType.time,
    zone: ZoneLocal(),
  );

  ZonedMoment berlinAt(DateTime utc) {
    return ZonedMoment.of(berlinValue, utc, 'UTC');
  }

  group('wall clock, offset and abbreviation', () {
    test('UTC', () {
      final moment = ZonedMoment.of(utcValue, DateTime.utc(2026, 6, 15, 12), 'UTC');
      expect(moment.wallClock.hour, 12);
      expect(moment.offset, Duration.zero);
      expect(moment.abbreviation, 'UTC');
      expect(moment.ianaZone, isNull);
    });

    test('named zone in summer', () {
      final moment = berlinAt(DateTime.utc(2026, 6, 15, 12));
      expect(moment.wallClock.hour, 14);
      expect(moment.offset, const Duration(hours: 2));
      expect(moment.abbreviation, 'CEST');
    });

    test('pinned to standard time in summer', () {
      final moment = ZonedMoment.of(
        berlinStandardValue,
        DateTime.utc(2026, 6, 15, 12),
        'UTC',
      );
      expect(moment.wallClock.hour, 13);
      expect(moment.offset, const Duration(hours: 1));
      expect(moment.abbreviation, 'CET');
      expect(moment.elapsedSeconds, 13 * 3600);
      expect(moment.daySeconds, 86400);
    });
  });

  group('progress of the local day', () {
    test('a normal day', () {
      final moment = berlinAt(DateTime.utc(2026, 6, 15, 21, 59, 59));
      expect(moment.elapsedSeconds, 86399);
      expect(moment.daySeconds, 86400);
    });

    test('a 25-hour day continues through the repeated hour', () {
      expect(berlinAt(DateTime.utc(2026, 10, 25, 0, 59, 59)).elapsedSeconds, 10799);
      expect(berlinAt(DateTime.utc(2026, 10, 25, 1)).elapsedSeconds, 10800);
      final lastSecond = berlinAt(DateTime.utc(2026, 10, 25, 22, 59, 59));
      expect(lastSecond.elapsedSeconds, 89999);
      expect(lastSecond.daySeconds, 90000);
    });

    test('a 23-hour day', () {
      final moment = berlinAt(DateTime.utc(2027, 3, 28, 1));
      expect(moment.elapsedSeconds, 7200);
      expect(moment.daySeconds, 82800);
    });

    test('the local zone uses the given zone name, not the device', () {
      final moment = ZonedMoment.of(
        localBerlinValue,
        DateTime.utc(2026, 10, 25, 22, 59, 59),
        'Europe/Berlin',
      );
      expect(moment.ianaZone, 'Europe/Berlin');
      expect(moment.daySeconds, 90000);
    });
  });

  group('values derived from the day progress', () {
    test('day minute', () {
      final moment = berlinAt(DateTime.utc(2026, 10, 25, 22, 59, 59));
      expect(moment.dayMinute, (minutes: 1499, seconds: 59));
    });

    test('decimal time is a share of the real day length', () {
      expect(
        ZonedMoment.of(utcValue, DateTime.utc(2026, 1, 1, 12), 'UTC').decimalTime,
        (hours: 5, minutes: 0, seconds: 0),
      );
      expect(
        berlinAt(DateTime.utc(2026, 10, 25, 22, 59, 59)).decimalTime,
        (hours: 9, minutes: 99, seconds: 99),
      );
    });
  });
}
