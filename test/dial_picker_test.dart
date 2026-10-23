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
}
