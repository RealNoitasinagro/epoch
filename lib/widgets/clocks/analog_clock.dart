import 'dart:math' as math;
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

/// The 12-hour dial shows "+12" in the second half of the day, which tells
/// morning from afternoon.
bool analogClockShowsPlusTwelve(int wallClockHour, AnalogClockScale scale) =>
    scale == AnalogClockScale.twelveHour && wallClockHour >= 12;

// ── Layout (all values as fractions of the dial radius) ─────────────────────

const double _rimWidth = 0.035;
const double _rimRadius = 1 - _rimWidth / 2;
const double _minuteScaleOuterRadius = 1 - _rimWidth - 0.01;

const double _minuteTickLength = 0.035;
const double _minuteTickWidth = 0.008;
const int _minuteTickAlpha = 130;
const double _fiveMinuteTickLength = 0.07;
const double _fiveMinuteTickWidth = 0.018;

/// Own ring of hour ticks (24-hour dial only).
const double _hourRingTickLength = 0.04;
const double _hourRingTickWidth = 0.012;

const double _hourHandWidth = 0.075;
const double _minuteHandWidth = 0.052;
const double _secondHandLength = _minuteScaleOuterRadius;
const double _secondHandTailLength = 0.18;
const double _secondHandWidth = 0.014;

/// Cutout of the hour and minute hand: a share of the hand length, near the tip.
const double _cutoutStart = 0.58;
const double _cutoutEnd = 0.88;
const double _cutoutWidthFraction = 0.45;

const double _centerRingRadius = 0.05;
const double _centerRingWidth = 0.018;

const double _plusTwelveRadius = 0.46;
const double _plusTwelveFontSize = 0.08;
const int _plusTwelveAlpha = 170;

/// What differs between the two dials.
class _DialLayout {
  /// Null: the five-minute ticks mark the hours. Otherwise the outer radius
  /// of an own ring of hour ticks inside the minute scale.
  final double? hourTickRingRadius;
  final double labelRadius;
  final double labelFontSize;
  final double hourHandLength;
  final double minuteHandLength;

  const _DialLayout({
    this.hourTickRingRadius,
    required this.labelRadius,
    required this.labelFontSize,
    required this.hourHandLength,
    required this.minuteHandLength,
  });

  static const twelveHour = _DialLayout(
    labelRadius: 0.74,
    labelFontSize: 0.13,
    hourHandLength: 0.60,
    minuteHandLength: 0.82,
  );

  /// Two separate scales: minutes outside, hours (ticks and numbers) inside.
  static const twentyFourHour = _DialLayout(
    hourTickRingRadius: 0.80,
    labelRadius: 0.64,
    labelFontSize: 0.09,
    hourHandLength: 0.52,
    minuteHandLength: 0.86,
  );
}

extension on AnalogClockScale {
  _DialLayout get layout => switch (this) {
    AnalogClockScale.twelveHour => _DialLayout.twelveHour,
    AnalogClockScale.twentyFourHour => _DialLayout.twentyFourHour,
  };
}

/// Analog clock without a dial background. The cutouts of the hands are real
/// holes (the background shows through), so no background color is needed.
class AnalogClock extends StatelessWidget {
  /// Wall-clock reading of the zone (only year ... second are used).
  final DateTime now;
  final AnalogClockScale scale;
  final bool showSeconds;
  final Color color;
  final double diameter;

  /// Null: the font of the surrounding theme.
  final String? fontFamily;

  const AnalogClock({
    super.key,
    required this.now,
    required this.scale,
    this.showSeconds = true,
    this.color = Colors.white,
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
  final String? fontFamily;

  const _AnalogClockPainter({
    required this.now,
    required this.scale,
    required this.showSeconds,
    required this.color,
    required this.fontFamily,
  });

  _DialLayout get _layout => scale.layout;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 2;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawCircle(
        Offset.zero, radius * _rimRadius, _strokePaint(radius * _rimWidth));
    _paintMinuteScale(canvas, radius);
    _paintHourTickRing(canvas, radius);
    _paintLabels(canvas, radius);
    _paintPlusTwelve(canvas, radius);
    _paintHands(canvas, radius);
    canvas.drawCircle(Offset.zero, radius * _centerRingRadius,
        _strokePaint(radius * _centerRingWidth));

    canvas.restore();
  }

  Paint _strokePaint(double width, {int? alpha}) => Paint()
    ..color = alpha == null ? color : color.withAlpha(alpha)
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..isAntiAlias = true;

  /// Point at [angle] (clockwise from the top) and [distance] from the center.
  static Offset _pointAt(double angle, double distance) =>
      Offset(distance * math.sin(angle), -distance * math.cos(angle));

  void _paintTick(Canvas canvas, double radius, double angle,
      double outerRadius, double length, Paint paint) {
    canvas.drawLine(
      _pointAt(angle, radius * outerRadius),
      _pointAt(angle, radius * (outerRadius - length)),
      paint,
    );
  }

  /// 60 minute ticks, every fifth one longer and thicker. On the 12-hour
  /// dial these are at the same time the hour ticks.
  void _paintMinuteScale(Canvas canvas, double radius) {
    final minutePaint =
    _strokePaint(radius * _minuteTickWidth, alpha: _minuteTickAlpha);
    final fiveMinutePaint = _strokePaint(radius * _fiveMinuteTickWidth);
    for (var minute = 0; minute < 60; minute++) {
      final isFiveMinuteMark = minute % 5 == 0;
      _paintTick(
        canvas, radius, minute / 60 * _fullCircle, _minuteScaleOuterRadius,
        isFiveMinuteMark ? _fiveMinuteTickLength : _minuteTickLength,
        isFiveMinuteMark ? fiveMinutePaint : minutePaint,
      );
    }
  }

  void _paintHourTickRing(Canvas canvas, double radius) {
    final ringRadius = _layout.hourTickRingRadius;
    if (ringRadius == null) return;
    final paint = _strokePaint(radius * _hourRingTickWidth);
    final markCount = scale.hoursPerRevolution;
    for (var mark = 0; mark < markCount; mark++) {
      _paintTick(canvas, radius, mark / markCount * _fullCircle, ringRadius,
          _hourRingTickLength, paint);
    }
  }

  void _paintText(Canvas canvas, String text, Offset center, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
        canvas, center - Offset(painter.width / 2, painter.height / 2));
  }

  void _paintLabels(Canvas canvas, double radius) {
    final is24Hour = scale == AnalogClockScale.twentyFourHour;
    final labelCount = scale.hoursPerRevolution;
    final style = TextStyle(
      color: color,
      fontSize: radius * _layout.labelFontSize,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
    );
    for (var index = 0; index < labelCount; index++) {
      final text = is24Hour
          ? index.toString().padLeft(2, '0')
          : (index == 0 ? 12 : index).toString();
      _paintText(
        canvas, text,
        _pointAt(index / labelCount * _fullCircle,
            radius * _layout.labelRadius),
        style,
      );
    }
  }

  /// Small hint below the 12: this is the second half of the day.
  void _paintPlusTwelve(Canvas canvas, double radius) {
    if (!analogClockShowsPlusTwelve(now.hour, scale)) return;
    _paintText(
      canvas, '+12',
      Offset(0, -radius * _plusTwelveRadius),
      TextStyle(
        color: color.withAlpha(_plusTwelveAlpha),
        fontSize: radius * _plusTwelveFontSize,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _paintHands(Canvas canvas, double radius) {
    _paintHand(
      canvas, radius, analogHourHandAngle(now, scale),
      outline: _handOutline(
          radius * _layout.hourHandLength, radius * _hourHandWidth),
      cutout: _handCutout(
          radius * _layout.hourHandLength, radius * _hourHandWidth),
    );
    _paintHand(
      canvas, radius, analogMinuteHandAngle(now),
      outline: _handOutline(
          radius * _layout.minuteHandLength, radius * _minuteHandWidth),
      cutout: _handCutout(
          radius * _layout.minuteHandLength, radius * _minuteHandWidth),
    );
    if (showSeconds) {
      final width = radius * _secondHandWidth;
      _paintHand(
        canvas, radius, analogSecondHandAngle(now),
        outline: RRect.fromLTRBR(
            -width / 2, -radius * _secondHandLength,
            width / 2, radius * _secondHandTailLength,
            Radius.circular(width / 2)),
      );
    }
  }

  /// Hand pointing up from the center, rounded at both ends.
  RRect _handOutline(double length, double width) => RRect.fromLTRBR(
      -width / 2, -length, width / 2, width / 2, Radius.circular(width / 2));

  RRect _handCutout(double length, double width) {
    final halfWidth = width * _cutoutWidthFraction / 2;
    return RRect.fromLTRBR(
        -halfWidth, -length * _cutoutEnd, halfWidth, -length * _cutoutStart,
        Radius.circular(halfWidth));
  }

  /// Every hand gets its own layer: the holes (cutout, inside of the center
  /// ring) are erased with BlendMode.clear, which works on every backend and
  /// neither touches the other hands nor the dial.
  void _paintHand(Canvas canvas, double radius, double angle,
      {required RRect outline, RRect? cutout}) {
    final clearPaint = Paint()..blendMode = BlendMode.clear;
    canvas.saveLayer(Rect.fromCircle(center: Offset.zero, radius: radius),
        Paint());
    canvas.rotate(angle);
    canvas.drawRRect(outline, Paint()..color = color..isAntiAlias = true);
    if (cutout != null) canvas.drawRRect(cutout, clearPaint);
    canvas.drawCircle(Offset.zero, radius * _centerRingRadius, clearPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_AnalogClockPainter old) =>
      old.now != now ||
      old.scale != scale ||
      old.showSeconds != showSeconds ||
      old.color != color ||
      old.fontFamily != fontFamily;
}
