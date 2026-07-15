import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

// Segment indices:
//   0 = top
//   1 = top-left
//   2 = top-right
//   3 = middle
//   4 = bottom-left
//   5 = bottom-right
//   6 = bottom
//
//    _
//   |_|
//   |_|
//
// Digit -> which segments are lit:
const _digitSegments = <int, List<bool>>{
  0: [true,  true,  true,  false, true,  true,  true ],
  1: [false, false, true,  false, false, true,  false],
  2: [true,  false, true,  true,  true,  false, true ],
  3: [true,  false, true,  true,  false, true,  true ],
  4: [false, true,  true,  true,  false, true,  false],
  5: [true,  true,  false, true,  false, true,  true ],
  6: [true,  true,  false, true,  true,  true,  true ],
  7: [true,  false, true,  false, false, true,  false],
  8: [true,  true,  true,  true,  true,  true,  true ],
  9: [true,  true,  true,  true,  false, true,  true ],
};

class SevenSegmentClock extends StatelessWidget {
  final DateTime now;
  final AppLocalizations l10n;
  final bool showSeconds;
  final bool hourFormat24;
  final Color color;

  const SevenSegmentClock({
    super.key,
    required this.now,
    required this.l10n,
    this.showSeconds = true,
    this.hourFormat24 = true,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    // Digit size constants – these are the base units that FittedBox scales:
    const digitWidth  = 40.0;
    const digitHeight = 72.0;
    const segmentThickness = 6.0;
    const colonWidth  = 16.0;
    const amPmWidth   = 28.0;  // space for AM/PM indicator on the right
    const gap         = 6.0;   // gap between digits in a group

    final int hour   = hourFormat24 ? now.hour : (now.hour % 12 == 0 ? 12 : now.hour % 12);
    final int minute = now.minute;
    final int second = now.second;
    final bool isPm  = now.hour >= 12;
    final bool show12 = !hourFormat24;

    // Build digit groups: HH:MM or HH:MM:SS
    final List<int?> digits = [
      hour ~/ 10,
      hour % 10,
      null,   // colon
      minute ~/ 10,
      minute % 10,
      if (showSeconds) ...[
        null, // colon
        second ~/ 10,
        second % 10,
      ],
    ];

    // Calculate total width:
    double totalWidth = 0;
    for (final d in digits) {
      totalWidth += d == null ? colonWidth : digitWidth;
      totalWidth += gap;
    }
    totalWidth -= gap;
    if (show12) totalWidth += amPmWidth + gap;

    return CustomPaint(
      size: Size(totalWidth, digitHeight),
      painter: _SevenSegmentPainter(
        digits: digits,
        digitWidth: digitWidth,
        digitHeight: digitHeight,
        segmentThickness: segmentThickness,
        colonWidth: colonWidth,
        gap: gap,
        color: color,
        showAmPm: show12,
        isPm: isPm,
        amPmWidth: amPmWidth,
      ),
    );
  }
}

class _SevenSegmentPainter extends CustomPainter {
  final List<int?> digits;
  final double digitWidth;
  final double digitHeight;
  final double segmentThickness;
  final double colonWidth;
  final double gap;
  final Color color;
  final bool showAmPm;
  final bool isPm;
  final double amPmWidth;

  _SevenSegmentPainter({
    required this.digits,
    required this.digitWidth,
    required this.digitHeight,
    required this.segmentThickness,
    required this.colonWidth,
    required this.gap,
    required this.color,
    required this.showAmPm,
    required this.isPm,
    required this.amPmWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final litPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final dimPaint = Paint()
      ..color = color.withAlpha(28)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    double x = 0;

    for (final digit in digits) {
      if (digit == null) {
        // Colon separator:
        _drawColon(canvas, x, colonWidth, litPaint);
        x += colonWidth + gap;
      } else {
        // Draw all 7 segments (lit or dim):
        final segments = _digitSegments[digit]!;
        for (int i = 0; i < 7; i++) {
          final paint = segments[i] ? litPaint : dimPaint;
          _drawSegment(canvas, x, i, paint);
        }
        x += digitWidth + gap;
      }
    }

    // AM/PM indicator:
    if (showAmPm) {
      x += 2;  // small extra gap before AM/PM
      _drawAmPm(canvas, x, isPm, litPaint, dimPaint);
    }
  }

  // Draw one of the 7 segments at position (offsetX, 0).
  // Segments are beveled trapezoids for the classic LED look.
  void _drawSegment(Canvas canvas, double offsetX, int index, Paint paint) {
    final t = segmentThickness;
    final w = digitWidth;
    final h = digitHeight;
    final bevel = t * 0.35;  // bevel size for trapezoid ends

    Path path;
    switch (index) {
      case 0: // top horizontal
        path = _horizontalSegment(
            offsetX, 0, w, t, bevel);
      case 1: // top-left vertical
        path = _verticalSegment(
            offsetX, 0, t, h / 2, bevel);
      case 2: // top-right vertical
        path = _verticalSegment(
            offsetX + w - t, 0, t, h / 2, bevel);
      case 3: // middle horizontal
        path = _horizontalSegment(
            offsetX, (h - t) / 2, w, t, bevel);
      case 4: // bottom-left vertical
        path = _verticalSegment(
            offsetX, h / 2, t, h / 2, bevel);
      case 5: // bottom-right vertical
        path = _verticalSegment(
            offsetX + w - t, h / 2, t, h / 2, bevel);
      case 6: // bottom horizontal
        path = _horizontalSegment(
            offsetX, h - t, w, t, bevel);
      default:
        return;
    }
    canvas.drawPath(path, paint);
  }

  // Horizontal segment as beveled hexagon:
  //   bevel /            \ bevel
  //        /              \
  //        \              /
  //   bevel \            / bevel
  Path _horizontalSegment(
      double x, double y, double w, double t, double bevel) {
    return Path()
      ..moveTo(x + bevel, y)
      ..lineTo(x + w - bevel, y)
      ..lineTo(x + w, y + t / 2)
      ..lineTo(x + w - bevel, y + t)
      ..lineTo(x + bevel, y + t)
      ..lineTo(x, y + t / 2)
      ..close();
  }

  // Vertical segment as beveled hexagon:
  Path _verticalSegment(
      double x, double y, double w, double h, double bevel) {
    return Path()
      ..moveTo(x, y + bevel)
      ..lineTo(x + w / 2, y)
      ..lineTo(x + w, y + bevel)
      ..lineTo(x + w, y + h - bevel)
      ..lineTo(x + w / 2, y + h)
      ..lineTo(x, y + h - bevel)
      ..close();
  }

  // Colon: two small dots centered in colonWidth:
  void _drawColon(Canvas canvas, double x, double w, Paint paint) {
    final cx = x + w / 2;
    final r  = segmentThickness * 0.55;
    // Upper dot at 1/3 height, lower dot at 2/3 height:
    canvas.drawCircle(Offset(cx, digitHeight / 3), r, paint);
    canvas.drawCircle(Offset(cx, digitHeight * 2 / 3), r, paint);
  }

  // AM/PM indicator: two stacked labels, active one lit, other dim:
  void _drawAmPm(Canvas canvas, double x, bool isPm,
      Paint litPaint, Paint dimPaint) {
    final amColor = isPm ? color.withAlpha(28) : color;
    final pmColor = isPm ? color : color.withAlpha(28);

    // Use small horizontal segments to draw 'AM' and 'PM' as simple
    // indicator bars (like classic clock radio indicators):
    // Upper half = AM, lower half = PM
    final amPaint = Paint()
      ..color = amColor
      ..style = PaintingStyle.fill;
    final pmPaint = Paint()
      ..color = pmColor
      ..style = PaintingStyle.fill;

    // Draw as small rectangles with rounded ends:
    final barW = amPmWidth - 4;
    final barH = segmentThickness * 0.8;
    final rr = const Radius.circular(2);

    // AM bar:
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 2, digitHeight * 0.25 - barH / 2, barW, barH),
        rr,
      ),
      amPaint,
    );

    // PM bar:
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 2, digitHeight * 0.75 - barH / 2, barW, barH),
        rr,
      ),
      pmPaint,
    );
  }

  @override
  bool shouldRepaint(_SevenSegmentPainter old) =>
      old.digits != digits ||
          old.color != color ||
          old.showAmPm != showAmPm ||
          old.isPm != isPm;
}