import 'dart:ui';
import 'package:epoch/formatting/fuzzy_time_words.dart';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/time/fuzzy_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ── helpers ──
  final german = lookupAppLocalizations(const Locale('de'));
  final english = lookupAppLocalizations(const Locale('en'));

  String clockText(
    AppLocalizations l10n,
    int hour,
    int minute, {
    FuzzyTimeLevel level = FuzzyTimeLevel.fiveMinutes,
  }) => fuzzyTimeText(ClockTimeCell((hour: hour, minute: minute)), level, l10n);

  String textAt(
    AppLocalizations l10n,
    DateTime wallClock,
    FuzzyTimeLevel level,
  ) => fuzzyTimeText(quantizeFuzzyTime(wallClock, level), level, l10n);

  group('fuzzyTimeText: German clock', () {
    test('five minutes: all twelve cells of an hour', () {
      const expected = {
        0: 'zwölf Uhr',
        5: 'fünf nach zwölf',
        10: 'zehn nach zwölf',
        15: 'viertel nach zwölf',
        20: 'zwanzig nach zwölf',
        25: 'fünf vor halb eins',
        30: 'halb eins',
        35: 'fünf nach halb eins',
        40: 'zwanzig vor eins',
        45: 'viertel vor eins',
        50: 'zehn vor eins',
        55: 'fünf vor eins',
      };
      expected.forEach((minute, text) {
        expect(clockText(german, 12, minute), text, reason: '$minute');
      });
    });

    test('"ein Uhr" on the full hour, "eins" otherwise', () {
      expect(clockText(german, 1, 0), 'ein Uhr');
      expect(clockText(german, 1, 5), 'fünf nach eins');
      expect(clockText(german, 12, 55), 'fünf vor eins');
      expect(clockText(german, 12, 30), 'halb eins');
    });

    test('quarter hour', () {
      const level = FuzzyTimeLevel.quarterHour;
      expect(clockText(german, 2, 15, level: level), 'viertel nach zwei');
      expect(clockText(german, 2, 45, level: level), 'viertel vor drei');
    });

    test('minute: relative to the nearest full hour, "Minuten" always', () {
      const level = FuzzyTimeLevel.minute;
      expect(
        clockText(german, 12, 27, level: level),
        'siebenundzwanzig Minuten nach zwölf',
      );
      expect(clockText(german, 12, 57, level: level), 'drei Minuten vor eins');
      expect(clockText(german, 12, 1, level: level), 'eine Minute nach zwölf');
      expect(clockText(german, 12, 59, level: level), 'eine Minute vor eins');
      expect(clockText(german, 12, 5, level: level), 'fünf Minuten nach zwölf');
      expect(clockText(german, 12, 30, level: level), 'halb eins');
      expect(clockText(german, 12, 0, level: level), 'zwölf Uhr');
    });
  });

  group('fuzzyTimeText: English clock', () {
    test('five minutes', () {
      const expected = {
        0: 'twelve o\'clock',
        5: 'five past twelve',
        15: 'quarter past twelve',
        20: 'twenty past twelve',
        25: 'twenty-five past twelve',
        30: 'half past twelve',
        35: 'twenty-five to one',
        40: 'twenty to one',
        45: 'quarter to one',
        50: 'ten to one',
        55: 'five to one',
      };
      expected.forEach((minute, text) {
        expect(clockText(english, 12, minute), text, reason: '$minute');
      });
    });

    test('quarter hour', () {
      const level = FuzzyTimeLevel.quarterHour;
      expect(clockText(english, 2, 15, level: level), 'quarter past two');
      expect(clockText(english, 2, 45, level: level), 'quarter to three');
    });

    test('minute', () {
      const level = FuzzyTimeLevel.minute;
      expect(
        clockText(english, 12, 15, level: level),
        'fifteen minutes past twelve',
      );
      expect(clockText(english, 12, 57, level: level), 'three minutes to one');
      expect(clockText(english, 12, 1, level: level), 'one minute past twelve');
    });
  });

  group('fuzzyTimeText: from a wall-clock reading', () {
    test('rounding up into the next hour', () {
      final reading = DateTime(2026, 1, 1, 12, 58);
      expect(textAt(german, reading, FuzzyTimeLevel.fiveMinutes), 'ein Uhr');
      expect(
        textAt(english, reading, FuzzyTimeLevel.fiveMinutes),
        'one o\'clock',
      );
    });

    test('midnight and noon are both twelve', () {
      expect(
        textAt(german, DateTime(2026, 1, 1, 0), FuzzyTimeLevel.minute),
        'zwölf Uhr',
      );
      expect(
        textAt(german, DateTime(2026, 1, 1, 12), FuzzyTimeLevel.minute),
        'zwölf Uhr',
      );
    });
  });

  group('fuzzyTimeText: parts of the day', () {
    test('every part has a word in both languages', () {
      for (final l10n in [german, english]) {
        for (var hour = 0; hour < 24; hour++) {
          for (final level in [
            FuzzyTimeLevel.dayOrNight,
            FuzzyTimeLevel.partOfDay,
            FuzzyTimeLevel.earlyOrLate,
          ]) {
            expect(
              textAt(l10n, DateTime(2026, 1, 1, hour), level),
              isNotEmpty,
              reason: '${l10n.localeName} $hour $level',
            );
          }
        }
      }
    });

    test('a few examples', () {
      expect(
        textAt(german, DateTime(2026, 1, 1, 15), FuzzyTimeLevel.partOfDay),
        'Nachmittag',
      );
      expect(
        textAt(german, DateTime(2026, 1, 1, 17), FuzzyTimeLevel.earlyOrLate),
        'später Nachmittag',
      );
      expect(
        textAt(english, DateTime(2026, 1, 1, 10), FuzzyTimeLevel.earlyOrLate),
        'late morning',
      );
      expect(
        textAt(german, DateTime(2026, 1, 1, 3), FuzzyTimeLevel.dayOrNight),
        'Nacht',
      );
    });
  });

  group('layoutFuzzyLines', () {
    test('what fits stays in one line', () {
      expect(layoutFuzzyLines(['fünf vor halb eins']), ['fünf vor halb eins']);
      expect(layoutFuzzyLines(['siebzehn', 'nach eins']), [
        'siebzehn nach eins',
      ]);
    });

    test('what does not fit gets one line per segment', () {
      expect(layoutFuzzyLines(['siebenundzwanzig Minuten', 'nach zwölf']), [
        'siebenundzwanzig Minuten',
        'nach zwölf',
      ]);
    });
  });

  test('every minute level text fits in two lines of 25 characters', () {
    for (final l10n in [german, english]) {
      for (var hour = 1; hour <= 12; hour++) {
        for (var minute = 0; minute < 60; minute++) {
          final cell = ClockTimeCell((hour: hour, minute: minute));
          final lines = layoutFuzzyLines(
            fuzzyTimeSegments(cell, FuzzyTimeLevel.minute, l10n),
          );
          // print(lines[0]);
          // if (lines.length > 1) print(lines[1]);
          // print("");
          expect(lines.length, lessThanOrEqualTo(2));
          for (final line in lines) {
            expect(
              line.length,
              lessThanOrEqualTo(kFuzzyTimeLineLength),
              reason: '${l10n.localeName} $hour:$minute "$line"',
            );
          }
        }
      }
    }
  });

  test('the other levels always fit in one line', () {
    for (final l10n in [german, english]) {
      for (final level in [
        FuzzyTimeLevel.quarterHour,
        FuzzyTimeLevel.fiveMinutes,
      ]) {
        for (var hour = 1; hour <= 12; hour++) {
          for (var minute = 0; minute < 60; minute += 5) {
            final cell = ClockTimeCell((hour: hour, minute: minute));
            expect(
              layoutFuzzyLines(fuzzyTimeSegments(cell, level, l10n)),
              hasLength(1),
              reason: '${l10n.localeName} $hour:$minute',
            );
          }
        }
      }
    }
  });
}
