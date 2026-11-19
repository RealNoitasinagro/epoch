import 'package:flutter/material.dart';
import '../app/day_quarter_color.dart';
import '../l10n/app_localizations.dart';
import '../settings/app_settings.dart';
import '../settings/focus_colors.dart';

const _cellSize = 44.0;
const _cellSpacing = 10.0;
const _cellsPerRow = 6;

/// The color choices of the Focus screen: the solid colors, one field that
/// follows the quarter of the day, one that picks a random color at every
/// start.
class FocusPalette extends StatelessWidget {
  final FocusColorMode mode;
  final Color fixedColor;
  final ValueChanged<Color> onSelectColor;
  final ValueChanged<FocusColorMode> onSelectMode;

  const FocusPalette({
    super.key,
    required this.mode,
    required this.fixedColor,
    required this.onSelectColor,
    required this.onSelectMode,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: Colors.black.withAlpha(230),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth:
                _cellsPerRow * _cellSize + (_cellsPerRow - 1) * _cellSpacing,
          ),
          child: Wrap(
            spacing: _cellSpacing,
            runSpacing: _cellSpacing,
            children: [
              for (final color in focusSolidColors)
                _PaletteCell(
                  content: ColoredBox(color: color),
                  selected: mode == FocusColorMode.fixed && fixedColor == color,
                  glowColor: color,
                  onTap: () => onSelectColor(color),
                ),
              _PaletteCell(
                content: const _DayQuarterSwatch(),
                selected: mode == FocusColorMode.dayQuarter,
                tooltip: l10n.hintFocusScreenColorDayQuarter,
                onTap: () => onSelectMode(FocusColorMode.dayQuarter),
              ),
              _PaletteCell(
                content: const ColoredBox(
                  color: Color(0xFF2A2A2A),
                  child: Center(
                    child: Icon(Icons.shuffle, color: Colors.white70),
                  ),
                ),
                selected: mode == FocusColorMode.random,
                tooltip: l10n.hintFocusScreenColorRandom,
                onTap: () => onSelectMode(FocusColorMode.random),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One field of the palette: a frame, highlighted if selected (with a glow
/// in the color itself, if it has one).
class _PaletteCell extends StatelessWidget {
  final Widget content;
  final bool selected;
  final VoidCallback onTap;
  final String? tooltip;
  final Color? glowColor;

  const _PaletteCell({
    required this.content,
    required this.selected,
    required this.onTap,
    this.tooltip,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    final field = GestureDetector(
      onTap: onTap,
      child: Container(
        width: _cellSize,
        height: _cellSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? Colors.white : Colors.white24,
            width: selected ? 2.5 : 1,
          ),
          boxShadow: selected && glowColor != null
              ? [
                  BoxShadow(
                    color: glowColor!.withAlpha(200),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: content,
        ),
      ),
    );
    return tooltip == null ? field : Tooltip(message: tooltip!, child: field);
  }
}

/// Four fields in the colors of the quarters of the day.
class _DayQuarterSwatch extends StatelessWidget {
  const _DayQuarterSwatch();

  @override
  Widget build(BuildContext context) {
    Widget quarter(int hour) =>
        Expanded(child: ColoredBox(color: dayQuarterColorOfHour(hour)));
    Widget row(int firstHour, int secondHour) => Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [quarter(firstHour), quarter(secondHour)],
      ),
    );
    return Column(children: [row(0, 6), row(12, 18)]);
  }
}
