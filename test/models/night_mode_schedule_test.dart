import 'package:epoch/models/night_mode_schedule.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const overMidnight = NightModeSchedule(startMinute: 23 * 60, endMinute: 7 * 60);
  const sameDay = NightModeSchedule(startMinute: 13 * 60, endMinute: 15 * 60);

  test('only two different times switch the window on', () {
    expect(const NightModeSchedule(startMinute: 60).isActive, isFalse);
    expect(const NightModeSchedule(endMinute: 60).isActive, isFalse);
    expect(const NightModeSchedule(startMinute: 60, endMinute: 60).isActive, isFalse);
    expect(NightModeSchedule.none.isActive, isFalse);
    expect(overMidnight.isActive, isTrue);
  });

  group('isNightAt', () {
    test('a window over midnight: start included, end excluded', () {
      expect(overMidnight.isNightAt(DateTime(2026, 1, 1, 22, 59)), isFalse);
      expect(overMidnight.isNightAt(DateTime(2026, 1, 1, 23, 0)), isTrue);
      expect(overMidnight.isNightAt(DateTime(2026, 1, 1, 3, 0)), isTrue);
      expect(overMidnight.isNightAt(DateTime(2026, 1, 1, 6, 59, 59)), isTrue);
      expect(overMidnight.isNightAt(DateTime(2026, 1, 1, 7, 0)), isFalse);
    });

    test('a window within one day', () {
      expect(sameDay.isNightAt(DateTime(2026, 1, 1, 12, 59)), isFalse);
      expect(sameDay.isNightAt(DateTime(2026, 1, 1, 13, 0)), isTrue);
      expect(sameDay.isNightAt(DateTime(2026, 1, 1, 14, 59)), isTrue);
      expect(sameDay.isNightAt(DateTime(2026, 1, 1, 15, 0)), isFalse);
    });

    test('never at night without an active window', () {
      expect(NightModeSchedule.none.isNightAt(DateTime(2026, 1, 1, 3)), isFalse);
    });
  });

  group('nextChangeAfter', () {
    test('before the start, inside the window, before the end', () {
      expect(overMidnight.nextChangeAfter(DateTime(2026, 1, 1, 22)),
          DateTime(2026, 1, 1, 23));
      expect(overMidnight.nextChangeAfter(DateTime(2026, 1, 1, 23, 30)),
          DateTime(2026, 1, 2, 7));
      expect(overMidnight.nextChangeAfter(DateTime(2026, 1, 1, 6, 59, 30)),
          DateTime(2026, 1, 1, 7));
    });

    test('exactly on a boundary the next one counts', () {
      expect(overMidnight.nextChangeAfter(DateTime(2026, 1, 1, 7)),
          DateTime(2026, 1, 1, 23));
      expect(overMidnight.nextChangeAfter(DateTime(2026, 1, 1, 23)),
          DateTime(2026, 1, 2, 7));
    });

    test('none without an active window', () {
      expect(NightModeSchedule.none.nextChangeAfter(DateTime(2026, 1, 1)), isNull);
    });
  });

  test('minute of day: parsing and formatting', () {
    expect(parseMinuteOfDay('23:00'), 23 * 60);
    expect(parseMinuteOfDay('7:30'), 7 * 60 + 30);
    expect(parseMinuteOfDay('24:00'), isNull);
    expect(parseMinuteOfDay('12:60'), isNull);
    expect(parseMinuteOfDay(''), isNull);
    expect(parseMinuteOfDay(null), isNull);
    expect(formatMinuteOfDay(7 * 60 + 5), '07:05');
    expect(parseMinuteOfDay(formatMinuteOfDay(1439)), 1439);
  });
}
