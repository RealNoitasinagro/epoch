import 'package:flutter/painting.dart';
import 'layout_constants.dart';

/// Color of the quarter of the day an hour of the wall clock belongs to.
Color dayQuarterColorOfHour(int wallClockHour) {
  if (wallClockHour < 6) return kColorNightRed;
  if (wallClockHour < 12) return kColorCyan;
  if (wallClockHour < 18) return kColorAmber;
  return kColorMatrixGreen;
}
