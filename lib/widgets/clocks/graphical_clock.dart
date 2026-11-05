import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../layout_constants.dart';
import '../../models/app_settings.dart';
import '../../models/time_value.dart';
import 'binary_coded_decimal_clock.dart';
import 'binary_columns_clock.dart';
import 'seven_segment_clock.dart';

/// Builds the clock widget of a graphical [ValueType]. [focusSize] selects the
/// large variant of the Focus screen (bigger, without labels).
Widget buildGraphicalClock({
  required ValueType valueType,
  required DateTime now,
  required AppLocalizations l10n,
  required bool showSeconds,
  required bool hourFormat24,
  required Color segmentColor,
  bool focusSize = false,
}) {
  return switch (valueType) {
    ValueType.sevenSegmentClock => SevenSegmentClock(
      now: now,
      l10n: l10n,
      digitHeight: focusSize
          ? kGraphicalSegmentClockHeightFocus
          : kGraphicalSegmentClockHeightDefault,
      showSeconds: showSeconds,
      hourFormat24: hourFormat24,
      color: segmentColor,
    ),
    ValueType.binaryClockColumns => BinaryColumnsClock(
      now: now,
      l10n: l10n,
      dotSize: focusSize
          ? kGraphicalBinaryClockDotSizeFocus
          : kGraphicalBinaryClockDotSizeDefault,
      showSeconds: showSeconds,
      showLabels: !focusSize,
    ),
    ValueType.binaryClockBcd => BinaryCodedDecimalClock(
      now: now,
      l10n: l10n,
      dotSize: focusSize
          ? kGraphicalBinaryClockDotSizeFocus
          : kGraphicalBinaryClockDotSizeDefault,
      showSeconds: showSeconds,
      showLabels: !focusSize,
    ),
    _ => throw StateError('Unhandled graphical ValueType: $valueType'),
  };
}

/// Foreground color of the seven-segment clock for the theme setting.
Color graphicalClockColor(AppThemeMode themeMode, Brightness systemBrightness) =>
    switch (themeMode) {
      AppThemeMode.light  => Colors.black,
      AppThemeMode.dark   => Colors.white,
      AppThemeMode.night  => kColorNightRed,
      AppThemeMode.system => systemBrightness == Brightness.dark
          ? Colors.white : Colors.black,
    };
