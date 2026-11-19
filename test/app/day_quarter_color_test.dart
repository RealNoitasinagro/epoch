import 'package:epoch/app/day_quarter_color.dart';
import 'package:epoch/app/layout_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('day quarter colors', () {
    expect(dayQuarterColorOfHour(0), kColorNightRed);
    expect(dayQuarterColorOfHour(5), kColorNightRed);
    expect(dayQuarterColorOfHour(6), kColorCyan);
    expect(dayQuarterColorOfHour(11), kColorCyan);
    expect(dayQuarterColorOfHour(12), kColorAmber);
    expect(dayQuarterColorOfHour(17), kColorAmber);
    expect(dayQuarterColorOfHour(18), kColorMatrixGreen);
    expect(dayQuarterColorOfHour(23), kColorMatrixGreen);
  });
}
