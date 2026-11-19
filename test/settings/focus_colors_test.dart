import 'dart:math';

import 'package:epoch/settings/focus_colors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('no palette color is too dark on black (contrast at least 3:1)', () {
    for (final color in focusSolidColors) {
      expect(
        (color.computeLuminance() + 0.05) / 0.05,
        greaterThanOrEqualTo(3.0),
        reason: '$color',
      );
    }
  });

  test('the colors differ from each other', () {
    expect(focusSolidColors.toSet().length, focusSolidColors.length);
  });

  test('a random color is never the excluded one, over many draws', () {
    final random = Random(1);
    for (final excluded in focusSolidColors) {
      for (var draw = 0; draw < 50; draw++) {
        final color = pickRandomFocusColor(random, exclude: excluded);
        expect(color, isNot(excluded));
        expect(focusSolidColors, contains(color));
      }
    }
  });
}
