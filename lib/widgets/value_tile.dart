// Universal tile with fixed height, three-layer structure.
// Handles text values, graphical clocks, and edit mode uniformly.
import 'package:flutter/material.dart';
import '../main.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final Widget content;      // text field or graphical clock
  final List<Widget?> actionSlots; // always 3 slots
  static const double textTileHeight    = 88.0;
  static const double graphicTileHeight = 200.0; // fits 6 bit rows
  final double? height; // null = textTileHeight

  const ValueTile({
    super.key,
    required this.label,
    required this.content,
    required this.actionSlots,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final tileBg  = colorScheme.onSurface.withAlpha(12);

    return Container(
      height: height ?? textTileHeight,
      decoration: BoxDecoration(
        color: tileBg,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.fromLTRB(10, 6, 4, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.5,
                    color: colorScheme.onSurface.withAlpha(150),
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(child: content),
              ],
            ),
          ),
          _ActionArea(slots: actionSlots),
        ],
      ),
    );
  }
}

class TextValueContent extends StatelessWidget {
  final String line1;
  final String line2;

  const TextValueContent({
    super.key,
    required this.line1,
    this.line2 = '',
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withAlpha(30),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            line1,
            style: textTheme.bodyLarge?.copyWith(
              fontFamily: fontFamilyValues,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (line2.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              line2,
              style: textTheme.bodySmall?.copyWith(
                fontFamily: fontFamilyValues,
                color: colorScheme.onSurface.withAlpha(170),
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

class GraphicValueContent extends StatelessWidget {
  final Widget clock;

  const GraphicValueContent({super.key, required this.clock});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(30),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.scaleDown,
        child: clock,
      ),
    );
  }
}

// Fixed-width action area: always 3 slots, some may be invisible.
class _ActionArea extends StatelessWidget {
  final List<Widget?> slots; // null = invisible placeholder

  const _ActionArea({required this.slots});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: slots.map((slot) => SizedBox(
        width: 40,
        height: 40,
        child: slot ?? const SizedBox.shrink(),
      )).toList(),
    );
  }
}