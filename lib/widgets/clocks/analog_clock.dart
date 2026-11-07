import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../layout_constants.dart';

/// Which time span one revolution of the hour hand covers.
enum AnalogClockScale { twelveHour, twentyFourHour }

extension AnalogClockScaleProps on AnalogClockScale {
  int get hoursPerRevolution => switch (this) {
    AnalogClockScale.twelveHour => 12,
    AnalogClockScale.twentyFourHour => 24,
  };
}

const double _fullCircle = 2 * math.pi;
const int _hoursPerDayQuarter = 6;

// ── Geometry helpers (angles: radians, clockwise from 12 o'clock) ───────────

/// Hour hand: moves continuously, never jumps.
double analogHourHandAngle(DateTime wallClock, AnalogClockScale scale) {
  final hoursIntoRevolution = wallClock.hour % scale.hoursPerRevolution +
      wallClock.minute / 60 +
      wallClock.second / 3600;
  return hoursIntoRevolution / scale.hoursPerRevolution * _fullCircle;
}

/// Minute hand: moves continuously (whole seconds are enough, no visible steps).
double analogMinuteHandAngle(DateTime wallClock) =>
    (wallClock.minute + wallClock.second / 60) / 60 * _fullCircle;

/// Second hand: ticks, always pointing at one of the 60 marks.
double analogSecondHandAngle(DateTime wallClock) =>
    wallClock.second / 60 * _fullCircle;

typedef AnalogClockArc = ({double startAngle, double sweepAngle});

/// The part of the dial covered by the current quarter of the day:
/// a quarter circle on the 24-hour dial, a half circle on the 12-hour dial.
AnalogClockArc analogDayQuarterArc(int wallClockHour, AnalogClockScale scale) {
  final quarterStartHour =
      wallClockHour ~/ _hoursPerDayQuarter * _hoursPerDayQuarter;
  return (
  startAngle: quarterStartHour % scale.hoursPerRevolution /
      scale.hoursPerRevolution * _fullCircle,
  sweepAngle: _hoursPerDayQuarter / scale.hoursPerRevolution * _fullCircle,
  );
}

// ── Layout (all values as fractions of the dial radius) ─────────────────────

const double _rimWidth = 0.035;
const double _dayQuarterBandWidth = 0.045;
const double _rimRadius = 1 - _dayQuarterBandWidth / 2;
const double _tickOuterRadius = _rimRadius - _dayQuarterBandWidth / 2 - 0.01;

const double _minuteTickLength = 0.035;
const double _minuteTickWidth = 0.008;
const double _hourTickLength = 0.07;
const double _hourTickWidth = 0.018;
const int _minuteTickAlpha = 130;

const double _hourHandLength = 0.50;
const double _hourHandWidth = 0.075;
const double _minuteHandLength = 0.74;
const double _minuteHandWidth = 0.052;
const double _secondHandLength = _tickOuterRadius;
const double _secondHandTailLength = 0.18;
const double _secondHandWidth = 0.014;

/// Cutout of the hour and minute hand: a share of the hand length, near the tip.
const double _cutoutStart = 0.58;
const double _cutoutEnd = 0.88;
const double _cutoutWidthFraction = 0.45;

const double _centerRingRadius = 0.05;
const double _centerRingWidth = 0.018;

/// Analog clock without a dial background. The cutouts of the hands are real
/// holes (the background shows through), so no background color is needed.
class AnalogClock extends StatelessWidget {
  /// Wall-clock reading of the zone (only year ... second are used).
  final DateTime now;
  final AnalogClockScale scale;
  final bool showSeconds;
  final Color color;

  /// Null: no day quarter indicator (setting off, night mode).
  final Color? dayQuarterColor;

  final double diameter;

  /// Null: the font of the surrounding theme.
  final String? fontFamily;

  const AnalogClock({
    super.key,
    required this.now,
    required this.scale,
    this.showSeconds = true,
    this.color = Colors.white,
    this.dayQuarterColor,
    this.diameter = kGraphicalAnalogClockDiameterDefault,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(diameter),
      painter: _AnalogClockPainter(
        now: now,
        scale: scale,
        showSeconds: showSeconds,
        color: color,
        dayQuarterColor: dayQuarterColor,
        fontFamily: fontFamily,
      ),
    );
  }
}

class _AnalogClockPainter extends CustomPainter {
  final DateTime now;
  final AnalogClockScale scale;
  final bool showSeconds;
  final Color color;
  final Color? dayQuarterColor;
  final String? fontFamily;

  const _AnalogClockPainter({
    required this.now,
    required this.scale,
    required this.showSeconds,
    required this.color,
    required this.dayQuarterColor,
    required this.fontFamily,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 2;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    _paintRim(canvas, radius);
    _paintTicks(canvas, radius);
    _paintLabels(canvas, radius);
    _paintHands(canvas, radius);
    _paintCenterRing(canvas, radius);

    canvas.restore();
  }

  Paint _strokePaint(double width, {Color? strokeColor}) => Paint()
    ..color = strokeColor ?? color
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..isAntiAlias = true;

  Paint get _fillPaint => Paint()
    ..color = color
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  /// Point at [angle] (clockwise from the top) and [distance] from the center.
  static Offset _pointAt(double angle, double distance) =>
      Offset(distance * math.sin(angle), -distance * math.cos(angle));

  void _paintRim(Canvas canvas, double radius) {
    canvas.drawCircle(
        Offset.zero, radius * _rimRadius, _strokePaint(radius * _rimWidth));

    final indicatorColor = dayQuarterColor;
    if (indicatorColor == null) return;
    // A wider stripe over the rim, only for the current quarter of the day:
    final arc = analogDayQuarterArc(now.hour, scale);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: radius * _rimRadius),
      arc.startAngle - math.pi / 2,  // canvas angles start at 3 o'clock
      arc.sweepAngle,
      false,
      _strokePaint(radius * _dayQuarterBandWidth, strokeColor: indicatorColor),
    );
  }

  void _paintTicks(Canvas canvas, double radius) {
    final minutePaint = _strokePaint(radius * _minuteTickWidth,
        strokeColor: color.withAlpha(_minuteTickAlpha));
    for (var minute = 0; minute < 60; minute++) {
      _paintTick(canvas, radius, minute / 60 * _fullCircle,
          _minuteTickLength, minutePaint);
    }
    final hourPaint = _strokePaint(radius * _hourTickWidth);
    final hourMarks = scale.hoursPerRevolution;
    for (var mark = 0; mark < hourMarks; mark++) {
      _paintTick(canvas, radius, mark / hourMarks * _fullCircle,
          _hourTickLength, hourPaint);
    }
  }

  void _paintTick(Canvas canvas, double radius, double angle,
      double length, Paint paint) {
    canvas.drawLine(
      _pointAt(angle, radius * _tickOuterRadius),
      _pointAt(angle, radius * (_tickOuterRadius - length)),
      paint,
    );
  }

  void _paintLabels(Canvas canvas, double radius) {
    final is24Hour = scale == AnalogClockScale.twentyFourHour;
    final labelCount = scale.hoursPerRevolution;
    final fontSize = radius * (is24Hour ? 0.09 : 0.13);
    final labelRadius = radius * (is24Hour ? 0.78 : 0.74);
    final style = TextStyle(
        color: color, fontSize: fontSize, fontFamily: fontFamily,
        fontWeight: FontWeight.w500);

    for (var index = 0; index < labelCount; index++) {
      final text = is24Hour
          ? index.toString().padLeft(2, '0')
          : (index == 0 ? 12 : index).toString();
      final painter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      final center = _pointAt(index / labelCount * _fullCircle, labelRadius);
      painter.paint(
          canvas, center - Offset(painter.width / 2, painter.height / 2));
    }
  }

  void _paintHands(Canvas canvas, double radius) {
    final centerDisc = Path()
      ..addOval(Rect.fromCircle(
          center: Offset.zero, radius: radius * _centerRingRadius));

    _paintHand(
      canvas, analogHourHandAngle(now, scale),
      _hollowHandPath(radius * _hourHandLength, radius * _hourHandWidth,
          centerDisc),
    );
    _paintHand(
      canvas, analogMinuteHandAngle(now),
      _hollowHandPath(radius * _minuteHandLength, radius * _minuteHandWidth,
          centerDisc),
    );
    if (showSeconds) {
      _paintHand(
        canvas, analogSecondHandAngle(now),
        _secondHandPath(radius, centerDisc),
      );
    }
  }

  void _paintHand(Canvas canvas, double angle, Path path) {
    canvas.save();
    canvas.rotate(angle);
    canvas.drawPath(path, _fillPaint);
    canvas.restore();
  }

  /// Hand pointing up from the center, with a hole near the tip. The area
  /// inside the center ring is cut out as well, so the ring stays clean.
  Path _hollowHandPath(double length, double width, Path centerDisc) {
    final outline = Path()
      ..addRRect(RRect.fromLTRBR(
          -width / 2, -length, width / 2, width / 2, Radius.circular(width / 2)));
    final holeHalfWidth = width * _cutoutWidthFraction / 2;
    final hole = Path()
      ..addRRect(RRect.fromLTRBR(
          -holeHalfWidth, -length * _cutoutEnd,
          holeHalfWidth, -length * _cutoutStart,
          Radius.circular(holeHalfWidth)));
    final withHole =
    ui.Path.combine(ui.PathOperation.difference, outline, hole);
    return ui.Path.combine(ui.PathOperation.difference, withHole, centerDisc);
  }

  /// Thin hand from the tail across the center to the tick marks.
  Path _secondHandPath(double radius, Path centerDisc) {
    final width = radius * _secondHandWidth;
    final hand = Path()
      ..addRRect(RRect.fromLTRBR(
          -width / 2, -radius * _secondHandLength,
          width / 2, radius * _secondHandTailLength,
          Radius.circular(width / 2)));
    return ui.Path.combine(ui.PathOperation.difference, hand, centerDisc);
  }

  void _paintCenterRing(Canvas canvas, double radius) {
    canvas.drawCircle(
      Offset.zero,
      radius * _centerRingRadius,
      _strokePaint(radius * _centerRingWidth),
    );
  }

  @override
  bool shouldRepaint(_AnalogClockPainter old) =>
      old.now != now ||
          old.scale != scale ||
          old.showSeconds != showSeconds ||
          old.color != color ||
          old.dayQuarterColor != dayQuarterColor ||
          old.fontFamily != fontFamily;
}
