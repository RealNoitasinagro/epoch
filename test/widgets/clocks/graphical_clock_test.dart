import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/layout_constants.dart';
import 'package:epoch/models/app_settings.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/widgets/clocks/binary_coded_decimal_clock.dart';
import 'package:epoch/widgets/clocks/binary_columns_clock.dart';
import 'package:epoch/widgets/clocks/graphical_clock.dart';
import 'package:epoch/widgets/clocks/seven_segment_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  Widget clockOf(ValueType type, {bool focusSize = false}) => buildGraphicalClock(
    valueType: type,
    now: DateTime(2026, 1, 1, 12),
    l10n: l10n,
    showSeconds: true,
    hourFormat24: true,
    segmentColor: Colors.white,
    focusSize: focusSize,
  );

  group('buildGraphicalClock', () {
    test('returns the clock widget of each graphical type', () {
      expect(clockOf(ValueType.sevenSegmentClock), isA<SevenSegmentClock>());
      expect(clockOf(ValueType.binaryClockColumns), isA<BinaryColumnsClock>());
      expect(clockOf(ValueType.binaryClockBcd), isA<BinaryCodedDecimalClock>());
    });

    test('focus size uses the large variants, binary clocks lose their labels', () {
      final segments = clockOf(ValueType.sevenSegmentClock, focusSize: true)
      as SevenSegmentClock;
      expect(segments.digitHeight, kGraphicalSegmentClockHeightFocus);
      final columns = clockOf(ValueType.binaryClockColumns, focusSize: true)
      as BinaryColumnsClock;
      expect(columns.dotSize, kGraphicalBinaryClockDotSizeFocus);
      expect(columns.showLabels, isFalse);
    });

    test('rejects value types that are not graphical', () {
      expect(() => clockOf(ValueType.time), throwsStateError);
    });
  });

  group('graphicalClockColor', () {
    test('light, dark and night ignore the system brightness', () {
      expect(graphicalClockColor(AppThemeMode.light, Brightness.dark), Colors.black);
      expect(graphicalClockColor(AppThemeMode.dark, Brightness.light), Colors.white);
      expect(graphicalClockColor(AppThemeMode.night, Brightness.light), kColorNightRed);
    });

    test('system follows the brightness', () {
      expect(graphicalClockColor(AppThemeMode.system, Brightness.dark), Colors.white);
      expect(graphicalClockColor(AppThemeMode.system, Brightness.light), Colors.black);
    });
  });
}
