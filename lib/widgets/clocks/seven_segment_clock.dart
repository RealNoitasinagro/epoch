import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

// Segment layout based on the Wikipedia 7-segment SVG reference.
// Viewbox coordinates: 10 wide × 18 tall (plus 1-unit border).
// Each segment is a hexagon. The 1-unit gap between segment tips
// ensures they never touch, giving the authentic LED display look.
//
// Segment naming (standard):
//   a = top horizontal
//   b = top-right vertical
//   c = bottom-right vertical
//   d = bottom horizontal
//   e = bottom-left vertical
//   f = top-left vertical
//   g = middle horizontal
//
// Digit segments [a, b, c, d, e, f, g]:
const _digitSegments = <int, List<bool>>{
  0: [true,  true,  true,  true,  true,  true,  false],
  1: [false, true,  true,  false, false, false, false],
  2: [true,  true,  false, true,  true,  false, true ],
  3: [true,  true,  true,  true,  false, false, true ],
  4: [false, true,  true,  false, false, true,  true ],
  5: [true,  false, true,  true,  false, true,  true ],
  6: [true,  false, true,  true,  true,  true,  true ],
  7: [true,  true,  true,  false, false, false, false],
  8: [true,  true,  true,  true,  true,  true,  true ],
  9: [true,  true,  true,  true,  false, true,  true ],
};

class SevenSegmentClock extends StatelessWidget {
  final DateTime now;
  final AppLocalizations l10n;
  final bool showSeconds;
  final bool hourFormat24;
  final Color color;
  /// Base digit height in logical pixels. FittedBox scales this further.
  /// Use a larger value (e.g. 180) for the Focus Screen.
  final double digitHeight;

  const SevenSegmentClock({
    super.key,
    required this.now,
    required this.l10n,
    this.showSeconds = true,
    this.hourFormat24 = true,
    this.color = Colors.white,
    this.digitHeight = 72,
  });

  @override
  Widget build(BuildContext context) {
    // All dimensions derived from digitHeight to keep proportions.
    // Reference SVG: digits are 10 units wide × 18 units tall.
    final double digitWidth  = digitHeight * (10 / 18);
    final double colonWidth  = digitHeight * (3  / 18);
    final double amPmHeight  = digitHeight * (10 / 18);
    final double amPmWidth   = digitHeight * (5  / 18);
    final double gap         = digitHeight * (2  / 18);

    final int h = hourFormat24
        ? now.hour
        : (now.hour % 12 == 0 ? 12 : now.hour % 12);
    final int m = now.minute;
    final int s = now.second;
    final bool isPm   = now.hour >= 12;
    final bool show12 = !hourFormat24;

    // Null = colon separator:
    final List<int?> digits = [
      h ~/ 10,
      h % 10,
      null,
      m ~/ 10,
      m % 10,
      if (showSeconds) ...[null, s ~/ 10, s % 10],
    ];

    double totalWidth = 0;
    for (final d in digits) {
      totalWidth += (d == null ? colonWidth : digitWidth) + gap;
    }
    totalWidth -= gap;
    if (show12) totalWidth += gap + amPmWidth;

    return CustomPaint(
      size: Size(totalWidth, digitHeight),
      painter: _SevenSegmentPainter(
        digits: digits,
        digitWidth: digitWidth,
        digitHeight: digitHeight,
        colonWidth: colonWidth,
        amPmWidth: amPmWidth,
        amPmHeight: amPmHeight,
        gap: gap,
        color: color,
        showAmPm: show12,
        isPm: isPm,
      ),
    );
  }
}

class _SevenSegmentPainter extends CustomPainter {
  final List<int?> digits;
  final double digitWidth;
  final double digitHeight;
  final double colonWidth;
  final double amPmWidth;
  final double amPmHeight;
  final double gap;
  final Color color;
  final bool showAmPm;
  final bool isPm;

  const _SevenSegmentPainter({
    required this.digits,
    required this.digitWidth,
    required this.digitHeight,
    required this.colonWidth,
    required this.amPmWidth,
    required this.amPmHeight,
    required this.gap,
    required this.color,
    required this.showAmPm,
    required this.isPm,
  });

  // Dim alpha for unlit segments – subtle but visible.
  static const int _dimAlpha = 30;

  Paint _paint(bool lit) => Paint()
    ..color = lit ? color : color.withAlpha(_dimAlpha)
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    double x = 0;
    for (final digit in digits) {
      if (digit == null) {
        _drawColon(canvas, x, colonWidth);
        x += colonWidth + gap;
      } else {
        _drawDigit(canvas, x, digit);
        x += digitWidth + gap;
      }
    }
    if (showAmPm) {
      _drawAmPm(canvas, x);
    }
  }

  // Draw all 7 segments of one digit.
  // The geometry exactly mirrors the Wikipedia SVG, scaled to digitWidth × digitHeight.
  // SVG reference viewbox: x in [0,10], y in [0,18].
  // We scale: sx = digitWidth/10, sy = digitHeight/18.
  void _drawDigit(Canvas canvas, double ox, int digit) {
    final segments = _digitSegments[digit]!;
    final sx = digitWidth  / 10;
    final sy = digitHeight / 18;

    // Helper to map SVG coordinates to canvas coordinates:
    Path p(List<List<num>> pts) {
      final path = Path();
      path.moveTo(ox + pts[0][0] * sx, pts[0][1] * sy);
      for (final pt in pts.skip(1)) {
        path.lineTo(ox + pt[0] * sx, pt[1] * sy);
      }
      path.close();
      return path;
    }

    // Segment a – top horizontal:
    canvas.drawPath(p([[1,1],[2,0],[8,0],[9,1],[8,2],[2,2]]), _paint(segments[0]));
    // Segment b – top-right vertical:
    canvas.drawPath(p([[9,1],[10,2],[10,8],[9,9],[8,8],[8,2]]), _paint(segments[1]));
    // Segment c – bottom-right vertical:
    canvas.drawPath(p([[9,9],[10,10],[10,16],[9,17],[8,16],[8,10]]), _paint(segments[2]));
    // Segment d – bottom horizontal:
    canvas.drawPath(p([[9,17],[8,18],[2,18],[1,17],[2,16],[8,16]]), _paint(segments[3]));
    // Segment e – bottom-left vertical:
    canvas.drawPath(p([[1,17],[0,16],[0,10],[1,9],[2,10],[2,16]]), _paint(segments[4]));
    // Segment f – top-left vertical:
    canvas.drawPath(p([[1,9],[0,8],[0,2],[1,1],[2,2],[2,8]]), _paint(segments[5]));
    // Segment g – middle horizontal:
    canvas.drawPath(p([[1,9],[2,8],[8,8],[9,9],[8,10],[2,10]]), _paint(segments[6]));
  }

  // Colon: two circles at 1/3 and 2/3 height, centered in colonWidth.
  void _drawColon(Canvas canvas, double ox, double w) {
    final cx = ox + w / 2;
    // Dot radius proportional to segment thickness (~1 unit in SVG = sy):
    final r  = digitHeight / 18 * 1.1;
    canvas.drawCircle(
        Offset(cx, digitHeight / 3),      r, _paint(true));
    canvas.drawCircle(
        Offset(cx, digitHeight * 2 / 3),  r, _paint(true));
  }

  // AM/PM indicator: two small bars, lit = selected, dim = other.
  // Positioned to the right of the last digit, vertically centered.
  void _drawAmPm(Canvas canvas, double ox) {
    final barW  = amPmWidth  * 0.85;
    final barH  = amPmHeight * 0.08;
    final barX  = ox + (amPmWidth - barW) / 2;
    final rr    = Radius.circular(barH / 2);
    // Center the two bars in the digit height:
    final centerY = digitHeight / 2;
    final spacing = amPmHeight * 0.18;

    // AM bar (upper):
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(barX, centerY - spacing - barH, barW, barH),
        rr,
      ),
      _paint(!isPm),
    );
    // PM bar (lower):
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(barX, centerY + spacing, barW, barH),
        rr,
      ),
      _paint(isPm),
    );
  }

  @override
  bool shouldRepaint(_SevenSegmentPainter old) =>
      old.digits != digits    ||
          old.color  != color     ||
          old.showAmPm != showAmPm ||
          old.isPm   != isPm;
}