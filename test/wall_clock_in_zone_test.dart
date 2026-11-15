import 'package:epoch/models/time_value.dart';
import 'package:epoch/wall_clock_in_zone.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

void main() {
  setUpAll(tzd.initializeTimeZones);

  const berlin = ZoneNamed('Europe/Berlin');
  const lordHowe = ZoneNamed('Australia/Lord_Howe');

  test('a normal reading, in summer and winter', () {
    expect(instantOfWallClock(DateTime.utc(2026, 6, 15, 14), berlin),
        DateTime.utc(2026, 6, 15, 12));
    expect(instantOfWallClock(DateTime.utc(2026, 1, 15, 14), berlin),
        DateTime.utc(2026, 1, 15, 13));
    expect(instantOfWallClock(DateTime.utc(2026, 1, 15, 12), lordHowe),
        DateTime.utc(2026, 1, 15, 1));
    expect(instantOfWallClock(DateTime.utc(2026, 7, 15, 12), lordHowe),
        DateTime.utc(2026, 7, 15, 1, 30));
  });

  test('wallClockOf is the reverse', () {
    expect(wallClockOf(DateTime.utc(2026, 6, 15, 12), berlin),
        DateTime.utc(2026, 6, 15, 14));
    expect(wallClockOf(DateTime.utc(2026, 7, 15, 1, 30), lordHowe),
        DateTime.utc(2026, 7, 15, 12));
    expect(wallClockOf(DateTime.utc(2026, 6, 15, 12), const ZoneUtc()),
        DateTime.utc(2026, 6, 15, 12));
  });

  test('a skipped reading continues after the clock change', () {
    final instant = instantOfWallClock(DateTime.utc(2027, 3, 28, 2, 30), berlin);
    expect(instant, DateTime.utc(2027, 3, 28, 1, 30));
    expect(wallClockOf(instant, berlin), DateTime.utc(2027, 3, 28, 3, 30));

    // Lord Howe: a change of 30 minutes.
    final lordHoweInstant =
    instantOfWallClock(DateTime.utc(2026, 10, 4, 2, 15), lordHowe);
    expect(wallClockOf(lordHoweInstant, lordHowe), DateTime.utc(2026, 10, 4, 2, 45));
  });

  test('a repeated reading means its first occurrence', () {
    expect(instantOfWallClock(DateTime.utc(2026, 10, 25, 2, 30), berlin),
        DateTime.utc(2026, 10, 25, 0, 30));
  });

  test('the system zone: a round trip', () {
    final instant = DateTime.utc(2026, 6, 15, 12);
    final reading = wallClockOf(instant, const ZoneLocal());
    expect(instantOfWallClock(reading, const ZoneLocal()), instant);
  });

  test('offsets', () {
    expect(offsetInZone(DateTime.utc(2026, 6, 15, 12), berlin), const Duration(hours: 2));
    expect(offsetInZone(DateTime.utc(2026, 1, 15, 12), berlin), const Duration(hours: 1));
    expect(offsetInZone(DateTime.utc(2026, 1, 15, 12), const ZoneUtc()), Duration.zero);
  });
}
