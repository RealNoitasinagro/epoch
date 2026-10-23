import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';

enum DialScale { hours24, sixty }

const _dialSize = 260.0;
const _outerRingFraction = 0.80;
const _innerRingFraction = 0.52;
const _ringSwitchFraction = (_outerRingFraction + _innerRingFraction) / 2;
const _bubbleRadius = 22.0;

/// Hour (0-23) for a clock position (0-11, 0 = top) on the outer or inner ring.
/// Outer ring: 12, 1..11. Inner ring: 00, 13..23.
int hourFromDialPosition(int clockPosition, {required bool isInnerRing}) {
  if (isInnerRing) return clockPosition == 0 ? 0 : clockPosition + 12;
  return clockPosition == 0 ? 12 : clockPosition;
}

({int clockPosition, bool isInnerRing}) dialPositionOfHour(int hour) =>
    (clockPosition: hour % 12, isInnerRing: hour == 0 || hour > 12);

/// Shows a circular picker; returns the chosen value or null if cancelled.
Future<int?> showDialPicker(
    BuildContext context, {
      required String title,
      required DialScale scale,
      required int initialValue,
    }) {
  return showDialog<int>(
    context: context,
    builder: (_) => _DialPickerDialog(
        title: title, scale: scale, initialValue: initialValue),
  );
}

class _DialPickerDialog extends StatefulWidget {
  final String title;
  final DialScale scale;
  final int initialValue;

  const _DialPickerDialog({
    required this.title,
    required this.scale,
    required this.initialValue,
  });

  @override
  State<_DialPickerDialog> createState() => _DialPickerDialogState();
}

class _DialPickerDialogState extends State<_DialPickerDialog> {
  late int _value = widget.initialValue;

  void _selectAt(Offset localPosition) {
    final fromCenter = localPosition - const Offset(_dialSize / 2, _dialSize / 2);
    // Clockwise angle from the top, in [0, 2π):
    final angle =
        (math.atan2(fromCenter.dx, -fromCenter.dy) + 2 * math.pi) % (2 * math.pi);
    final int newValue;
    switch (widget.scale) {
      case DialScale.hours24:
        newValue = hourFromDialPosition(
          (angle / (math.pi / 6)).round() % 12,
          isInnerRing: fromCenter.distance < _dialSize / 2 * _ringSwitchFraction,
        );
      case DialScale.sixty:
        newValue = (angle / (math.pi / 30)).round() % 60;
    }
    if (newValue != _value) setState(() => _value = newValue);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              style: textTheme.labelMedium
                  ?.copyWith(color: colorScheme.onSurface.withAlpha(150))),
          Text(_value.toString().padLeft(2, '0'),
              style: textTheme.displayMedium
                  ?.copyWith(fontFamily: fontFamilyDefault)),
        ],
      ),
      content: SizedBox(
        width: _dialSize,
        height: _dialSize,
        child: GestureDetector(
          onPanDown: (details) => _selectAt(details.localPosition),
          onPanUpdate: (details) => _selectAt(details.localPosition),
          child: CustomPaint(
            painter: _DialPainter(
              scale: widget.scale,
              value: _value,
              dialColor: colorScheme.onSurface.withAlpha(20),
              accentColor: colorScheme.primary,
              labelColor: colorScheme.onSurface,
              selectedLabelColor: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _value),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _DialPainter extends CustomPainter {
  final DialScale scale;
  final int value;
  final Color dialColor;
  final Color accentColor;
  final Color labelColor;
  final Color selectedLabelColor;

  const _DialPainter({
    required this.scale,
    required this.value,
    required this.dialColor,
    required this.accentColor,
    required this.labelColor,
    required this.selectedLabelColor,
  });

  static Offset _pointOnDial(Offset center, double distance, double angle) =>
      center + Offset(distance * math.sin(angle), -distance * math.cos(angle));

  ({double angle, double radiusFraction}) get _selection => switch (scale) {
    DialScale.hours24 => (
    angle: (value % 12) * math.pi / 6,
    radiusFraction: dialPositionOfHour(value).isInnerRing
        ? _innerRingFraction : _outerRingFraction,
    ),
    DialScale.sixty => (angle: value * math.pi / 30, radiusFraction: _outerRingFraction),
  };

  void _paintText(Canvas canvas, String text, Offset center, Color color) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: color, fontSize: 16)),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, center - Offset(painter.width / 2, painter.height / 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    canvas.drawCircle(center, radius, Paint()..color = dialColor);

    // Labels first, so the selection bubble covers the one below it:
    for (var clockPosition = 0; clockPosition < 12; clockPosition++) {
      final angle = clockPosition * math.pi / 6;
      switch (scale) {
        case DialScale.hours24:
          for (final isInnerRing in [false, true]) {
            final hour = hourFromDialPosition(clockPosition, isInnerRing: isInnerRing);
            _paintText(
              canvas,
              hour.toString().padLeft(2, '0'),
              _pointOnDial(center,
                  radius * (isInnerRing ? _innerRingFraction : _outerRingFraction), angle),
              labelColor,
            );
          }
        case DialScale.sixty:
          _paintText(
            canvas,
            (clockPosition * 5).toString().padLeft(2, '0'),
            _pointOnDial(center, radius * _outerRingFraction, angle),
            labelColor,
          );
      }
    }

    final selection = _selection;
    final bubbleCenter =
    _pointOnDial(center, radius * selection.radiusFraction, selection.angle);
    final accent = Paint()
      ..color = accentColor
      ..strokeWidth = 2;
    canvas.drawLine(center, bubbleCenter, accent);
    canvas.drawCircle(center, 4, accent);
    canvas.drawCircle(bubbleCenter, _bubbleRadius, accent);
    _paintText(canvas, value.toString().padLeft(2, '0'), bubbleCenter, selectedLabelColor);
  }

  @override
  bool shouldRepaint(_DialPainter old) =>
      old.scale != scale || old.value != value ||
          old.dialColor != dialColor || old.accentColor != accentColor ||
          old.labelColor != labelColor || old.selectedLabelColor != selectedLabelColor;
}
