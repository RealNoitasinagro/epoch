import 'package:flutter/material.dart';
import '../effective_clock.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/app_settings.dart';
import '../time_value_formatter.dart';

/// Shown in the title bar while the displayed time deviates from the system
/// time: direction icon plus the real system time (running, never frozen).
/// The tooltip carries the system date; a tap opens the Time Shift page.
class TimeShiftIndicator extends StatelessWidget {
  final VoidCallback onTap;

  /// Longer (custom) patterns could break the title bar layout.
  static const _maxPatternLength = 11;

  const TimeShiftIndicator({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final app = EpochApp.of(context);
    final settings = app.formatSettings;
    final l10n = AppLocalizations.of(context)!;
    final systemTime = EffectiveClock.systemTime();
    final textStyle = DefaultTextStyle.of(context).style.copyWith(
        fontFamily: fontFamilyDefault, fontSize: 14, fontWeight: FontWeight.w500);

    final timePattern = settings.timeFormat.length <= _maxPatternLength
        ? settings.timeFormat : kTimePatternFull;
    final timeText = TimeValueFormatter.formatTime(
        settings.hourFormat24, systemTime.hour, systemTime.minute, systemTime.second,
        pattern: timePattern
    );
    final dateText = TimeValueFormatter.formatDate(
        l10n.localeName, systemTime, pattern: settings.dateFormat);

    final tooltipLines = [
      if (EffectiveClock.isTimeShifted)
        l10n.hintTimeShiftIndicator(
            dateText,
            EffectiveClock.isShiftedIntoPast
                ? l10n.hintTimeShiftPast
                : l10n.hintTimeShiftFuture),
      if (EffectiveClock.hasVirtualLocalZone)
        l10n.hintTimeShiftPlaceIndicator(
            EffectiveClock.virtualLocalIanaZone!, app.systemIanaZone),
      l10n.hintTimeShiftIndicatorTap,
    ];

    return Tooltip(
      message: tooltipLines.join('\n'),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(kTileBorderRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                for (final icon in timeShiftIcons())
                  Icon(icon, size: kIconSizeDefault, color: textStyle.color),
                Text(timeText, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The icons of the Time Shift in effect: the place icon if "local" was
/// redefined (left), the history/update icon if the time deviates (right).
/// Shared by the title bar and the Focus screen.
List<IconData> timeShiftIcons() => [
  if (EffectiveClock.hasVirtualLocalZone) kIconTimeShiftPlace,
  if (EffectiveClock.isTimeShifted)
    EffectiveClock.isShiftedIntoPast ? kIconTimeShiftPast : kIconTimeShiftFuture,
];
