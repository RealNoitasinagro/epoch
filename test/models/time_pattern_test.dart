import 'package:epoch/models/time_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('timePatternWithoutSeconds', () {
    test('removes the seconds and the separator before them', () {
      expect(timePatternWithoutSeconds('HH:mm:ss'), 'HH:mm');
      expect(timePatternWithoutSeconds('H:mm:ss'), 'H:mm');
      expect(timePatternWithoutSeconds('HHmmss'), 'HHmm');
      expect(timePatternWithoutSeconds('HH.mm.ss'), 'HH.mm');
    });

    test('keeps text after the seconds', () {
      expect(timePatternWithoutSeconds('HH:mm:ss Uhr'), 'HH:mm Uhr');
    });

    test('leaves patterns without seconds, or with them before the minutes, alone', () {
      expect(timePatternWithoutSeconds('HH:mm'), 'HH:mm');
      expect(timePatternWithoutSeconds('ss:mm:HH'), 'ss:mm:HH');
    });
  });

  group('timePatternWithSeconds', () {
    test('adds the seconds in the style of the pattern', () {
      expect(timePatternWithSeconds('HH:mm'), 'HH:mm:ss');
      expect(timePatternWithSeconds('H:mm'), 'H:mm:ss');
      expect(timePatternWithSeconds('HH.mm'), 'HH.mm.ss');
      expect(timePatternWithSeconds('HHmm'), 'HHmmss');
    });

    test('keeps text after the minutes', () {
      expect(timePatternWithSeconds('HH:mm Uhr'), 'HH:mm:ss Uhr');
    });

    test('uses a colon if the separator is text', () {
      expect(timePatternWithSeconds('HH h mm min'), 'HH h mm:ss min');
    });

    test('leaves patterns that have seconds alone', () {
      expect(timePatternWithSeconds('HH:mm:ss'), 'HH:mm:ss');
      expect(timePatternWithSeconds('ss:mm'), 'ss:mm');
    });
  });

  test('timePatternHasSeconds', () {
    expect(timePatternHasSeconds('HH:mm:ss'), isTrue);
    expect(timePatternHasSeconds('HH:mm'), isFalse);
  });
}
