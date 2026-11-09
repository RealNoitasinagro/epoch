import 'package:epoch/models/pattern_tokens.dart';
import 'package:epoch/time_value_formatter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en');
  });

  group('validateDatePattern', () {
    test('typical patterns are valid, also at the length limit', () {
      for (final pattern in ['YYYY-MM-DD', 'DD.MM.YYYY', 'EEE, YYYY-MM-DD',
        'YYYYMMDD', 'MMMM D, YYYY', 'M', 'EEEE, DD. MMMM YYYY']) {
        expect(validateDatePattern(pattern), isNull, reason: pattern);
      }
    });

    test('lowercase letters and separators are literals', () {
      expect(validateDatePattern('DD-MM-YYYY'), isNull);
      expect(validateDatePattern('D x'), isNull);
    });

    test('a pattern without any token is rejected, an empty one too', () {
      expect(validateDatePattern(''), isA<PatternMissingToken>());
      expect(validateDatePattern('--'), isA<PatternMissingToken>());
    });

    test('unknown uppercase sequences are reported', () {
      final issue = validateDatePattern('YYYY-ZZ-DD');
      expect(issue, isA<PatternUnknownTokens>()
          .having((unknown) => unknown.tokens, 'tokens', ['ZZ']));
    });

    test('too long in the worst case, repeated separators count', () {
      const limit = maxDatePatternRenderedLength;
      expect(validateDatePattern('EEEE, DD. MMMM YYYY.'),
          isA<PatternTooLong>().having((l) => l.maxLength, 'max', limit));
      expect(validateDatePattern('YYYY-MM-DD ${'-' * 30}'),
          isA<PatternTooLong>());
    });
  });

  group('validateTimePattern', () {
    test('typical patterns are valid, also at the length limit', () {
      for (final pattern in ['HH:mm:ss', 'HH:mm', 'H:mm:ss', 'HHmm',
        'HH.mm.ss', 'HH h mm min ss s']) {
        expect(validateTimePattern(pattern), isNull, reason: pattern);
      }
    });

    test('hour and minutes are required', () {
      expect(validateTimePattern(''), isA<PatternMissingHour>());
      expect(validateTimePattern('mm:ss'), isA<PatternMissingHour>());
      expect(validateTimePattern('HH:ss'), isA<PatternMissingMinutes>());
    });

    test('unknown tokens come before the other issues', () {
      expect(validateTimePattern('XX:ss'), isA<PatternUnknownTokens>());
    });

    test('too long: a pattern that shows the time twice', () {
      expect(validateTimePattern('HH:mm:ss HH:mm:ss'), isA<PatternTooLong>());
    });
  });

  test('formatter and worst-case maps know exactly the same tokens', () {
    final reference = DateTime(2026, 1, 9, 8, 14, 27);
    expect(TimeValueFormatter.dateTokenValues(reference, 'en').keys.toSet(),
        datePatternWorstCase.keys.toSet());
    expect(TimeValueFormatter.timeTokenValues(reference).keys.toSet(),
        timePatternWorstCase.keys.toSet());
  });

  test('no real value is longer than its worst case (a whole leap year)', () {
    for (final locale in ['en', 'de']) {
      for (var dayOffset = 0; dayOffset < 366; dayOffset++) {
        final day = DateTime(2024, 1, 1 + dayOffset, dayOffset % 24,
            dayOffset % 60, dayOffset % 60);
        TimeValueFormatter.dateTokenValues(day, locale).forEach((token, value) {
          expect(value.length,
              lessThanOrEqualTo(datePatternWorstCase[token]!.length),
              reason: '$token $locale $day');
        });
        TimeValueFormatter.timeTokenValues(day, hourFormat24: false)
            .forEach((token, value) {
          expect(value.length,
              lessThanOrEqualTo(timePatternWorstCase[token]!.length),
              reason: token);
        });
      }
    }
  });
}
