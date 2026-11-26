import 'package:epoch/formatting/number_words.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('numberWords: German', () {
    test('selected numbers', () {
      for (final (number, words) in [
        (0, 'null'),
        (1, 'eins'),
        (5, 'fünf'),
        (12, 'zwölf'),
        (17, 'siebzehn'),
        (20, 'zwanzig'),
        (21, 'einundzwanzig'),
        (27, 'siebenundzwanzig'),
        (30, 'dreißig'),
        (45, 'fünfundvierzig'),
        (59, 'neunundfünfzig'),
      ]) {
        expect(numberWords(number, 'de'), words, reason: '$number');
      }
    });
  });

  group('numberWords: English', () {
    test('selected numbers', () {
      for (final (number, words) in [
        (0, 'zero'),
        (1, 'one'),
        (12, 'twelve'),
        (19, 'nineteen'),
        (20, 'twenty'),
        (21, 'twenty-one'),
        (27, 'twenty-seven'),
        (40, 'forty'),
        (59, 'fifty-nine'),
      ]) {
        expect(numberWords(number, 'en'), words, reason: '$number');
      }
    });
  });

  test('every number from 0 to 59 has a word in both languages', () {
    for (var number = 0; number < 60; number++) {
      expect(numberWords(number, 'de'), isNotEmpty);
      expect(numberWords(number, 'en'), isNotEmpty);
    }
  });

  test('numbers out of range are rejected', () {
    expect(() => numberWords(60, 'en'), throwsRangeError);
    expect(() => numberWords(-1, 'de'), throwsRangeError);
  });
}
