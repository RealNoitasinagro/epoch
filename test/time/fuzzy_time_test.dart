import 'package:epoch/time/fuzzy_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DateTime at(int hour, [int minute = 0, int second = 0]) =>
      DateTime(2026, 1, 1, hour, minute, second);

  ClockCell clockCellOf(DateTime wallClock, FuzzyTimeLevel level) =>
      (quantizeFuzzyTime(wallClock, level) as ClockTimeCell).value;

  group('quantizeFuzzyTime: five minutes', () {
    const level = FuzzyTimeLevel.fiveMinutes;

    test('the middle of a cell belongs to the higher one', () {
      expect(clockCellOf(at(12, 2, 29), level), (hour: 12, minute: 0));
      expect(clockCellOf(at(12, 2, 30), level), (hour: 12, minute: 5));
      expect(clockCellOf(at(12, 7, 29), level), (hour: 12, minute: 5));
      expect(clockCellOf(at(12, 7, 30), level), (hour: 12, minute: 10));
    });

    test('rounding up can reach the next hour', () {
      expect(clockCellOf(at(12, 57, 30), level), (hour: 1, minute: 0));
      expect(clockCellOf(at(23, 58), level), (hour: 12, minute: 0));
    });

    test('the half hour and the hour after it', () {
      expect(clockCellOf(at(12, 35), level), (hour: 12, minute: 35));
      expect(clockCellOf(at(13, 25), level), (hour: 1, minute: 25));
    });
  });

  group('quantizeFuzzyTime: quarter hour and minute', () {
    test('quarter hour rounds to 0, 15, 30, 45', () {
      const level = FuzzyTimeLevel.quarterHour;
      expect(clockCellOf(at(14, 7, 29), level), (hour: 2, minute: 0));
      expect(clockCellOf(at(14, 7, 30), level), (hour: 2, minute: 15));
      expect(clockCellOf(at(14, 52, 29), level), (hour: 2, minute: 45));
      expect(clockCellOf(at(14, 52, 30), level), (hour: 3, minute: 0));
    });

    test('minute rounds seconds, 12 stands for noon and midnight', () {
      const level = FuzzyTimeLevel.minute;
      expect(clockCellOf(at(12, 27, 29), level), (hour: 12, minute: 27));
      expect(clockCellOf(at(12, 27, 30), level), (hour: 12, minute: 28));
      expect(clockCellOf(at(0, 0), level), (hour: 12, minute: 0));
      expect(clockCellOf(at(0, 59, 30), level), (hour: 1, minute: 0));
    });
  });

  group('quantizeFuzzyTime: parts of the day', () {
    test('day or night: daytime from 06:00 to 22:00', () {
      for (final (hour, expected) in [
        (5, DayOrNight.night),
        (6, DayOrNight.day),
        (21, DayOrNight.day),
        (22, DayOrNight.night),
      ]) {
        expect(
          quantizeFuzzyTime(at(hour), FuzzyTimeLevel.dayOrNight),
          DayOrNightCell(expected),
          reason: '$hour',
        );
      }
    });

    test('every hour belongs to exactly one part, and parts nest', () {
      final coarseOfFine = <FuzzyDayPart, Set<CoarseDayPart>>{};
      for (var hour = 0; hour < 24; hour++) {
        final fine = fuzzyDayPartOfHour(hour);
        final coarse =
            (quantizeFuzzyTime(at(hour), FuzzyTimeLevel.partOfDay)
                    as DayPartCell)
                .value;
        expect(coarse, fine.coarse, reason: '$hour');
        coarseOfFine.putIfAbsent(fine, () => {}).add(coarse);
      }
      expect(coarseOfFine.keys.toSet(), FuzzyDayPart.values.toSet());
      expect(coarseOfFine.values.every((coarse) => coarse.length == 1), isTrue);
    });

    test('noon and midnight lie in the expected parts', () {
      expect(fuzzyDayPartOfHour(12), FuzzyDayPart.noon);
      expect(fuzzyDayPartOfHour(0), FuzzyDayPart.night);
      expect(fuzzyDayPartOfHour(3), FuzzyDayPart.deepNight);
    });
  });
}
