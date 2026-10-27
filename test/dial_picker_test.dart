import 'dart:math' as math;
import 'package:epoch/widgets/dial_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every hour survives a roundtrip through dial coordinates', () {
    for (var hour = 0; hour < 24; hour++) {
      final dial = dialPositionOfHour(hour);
      expect(
        hourFromDialPosition(dial.clockPosition, isInnerRing: dial.isInnerRing),
        hour,
      );
    }
  });

  test('outer ring shows 12, 1..11; inner ring 00, 13..23', () {
    expect(hourFromDialPosition(0, isInnerRing: false), 12);
    expect(hourFromDialPosition(5, isInnerRing: false), 5);
    expect(hourFromDialPosition(0, isInnerRing: true), 0);
    expect(hourFromDialPosition(5, isInnerRing: true), 17);
  });

  /// Point at [degrees] clockwise from the top, [distance] from the center.
  Offset pointAt(double degrees, double distance) {
    final radians = degrees * math.pi / 180;
    return Offset(distance * math.sin(radians), -distance * math.cos(radians));
  }

  // Outer ring radius ≈ 104, inner ≈ 68, ring switch at ≈ 86.
  const outerDistance = 100.0;
  const innerDistance = 60.0;

  group('dialValueAtOffset – hours24', () {
    test('cardinal points on the outer ring', () {
      expect(dialValueAtOffset(pointAt(0, outerDistance), DialScale.hours24), 12);
      expect(dialValueAtOffset(pointAt(90, outerDistance), DialScale.hours24), 3);
      expect(dialValueAtOffset(pointAt(180, outerDistance), DialScale.hours24), 6);
      expect(dialValueAtOffset(pointAt(270, outerDistance), DialScale.hours24), 9);
    });

    test('cardinal points on the inner ring', () {
      expect(dialValueAtOffset(pointAt(0, innerDistance), DialScale.hours24), 0);
      expect(dialValueAtOffset(pointAt(90, innerDistance), DialScale.hours24), 15);
      expect(dialValueAtOffset(pointAt(180, innerDistance), DialScale.hours24), 18);
      expect(dialValueAtOffset(pointAt(270, innerDistance), DialScale.hours24), 21);
    });

    test('every hour is hit at its own dial position', () {
      for (var hour = 0; hour < 24; hour++) {
        final position = dialPositionOfHour(hour);
        final point = pointAt(position.clockPosition * 30.0,
            position.isInnerRing ? innerDistance : outerDistance);
        expect(dialValueAtOffset(point, DialScale.hours24), hour, reason: '$hour');
      }
    });

    test('small angular deviations still select the nearest hour', () {
      expect(dialValueAtOffset(pointAt(14, outerDistance), DialScale.hours24), 12);
      expect(dialValueAtOffset(pointAt(-14, outerDistance), DialScale.hours24), 12);
      expect(dialValueAtOffset(pointAt(16, outerDistance), DialScale.hours24), 1);
    });
  });

  group('dialValueAtOffset – sixty', () {
    test('cardinal points', () {
      expect(dialValueAtOffset(pointAt(0, outerDistance), DialScale.sixty), 0);
      expect(dialValueAtOffset(pointAt(90, outerDistance), DialScale.sixty), 15);
      expect(dialValueAtOffset(pointAt(180, outerDistance), DialScale.sixty), 30);
      expect(dialValueAtOffset(pointAt(270, outerDistance), DialScale.sixty), 45);
    });

    test('every value is hit at its own dial position, at any distance', () {
      for (var value = 0; value < 60; value++) {
        for (final distance in [innerDistance, outerDistance]) {
          expect(dialValueAtOffset(pointAt(value * 6.0, distance), DialScale.sixty),
              value, reason: '$value @ $distance');
        }
      }
    });

    test('small angular deviations select the nearest value, also across 0', () {
      expect(dialValueAtOffset(pointAt(2.9, outerDistance), DialScale.sixty), 0);
      expect(dialValueAtOffset(pointAt(-2.9, outerDistance), DialScale.sixty), 0);
      expect(dialValueAtOffset(pointAt(3.1, outerDistance), DialScale.sixty), 1);
      expect(dialValueAtOffset(pointAt(-3.1, outerDistance), DialScale.sixty), 59);
    });
  });
}
