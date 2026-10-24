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

  const TimeShiftIndicator({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final app = EpochApp.of(context);
    final l10n = AppLocalizations.of(context)!;
    final systemTime = EffectiveClock.systemTime();
    final textStyle = DefaultTextStyle.of(context).style.copyWith(
        fontFamily: fontFamilyDefault, fontSize: 14, fontWeight: FontWeight.w500);

    String timePattern = app.timeFormat.length <= 11 ? app.timeFormat : kTimePatternFull;
    final timeText = TimeValueFormatter.formatTime(
        app.hourFormat24, systemTime.hour, systemTime.minute, systemTime.second,
        pattern: timePattern
    );
    final dateText = TimeValueFormatter.formatDate(
        l10n.localeName, systemTime, pattern: app.dateFormat);

    return Tooltip(
      message: l10n.hintTimeShiftIndicator(dateText),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(kTileBorderRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  EffectiveClock.isShiftedIntoPast
                      ? kIconTimeShiftPast : kIconTimeShiftFuture,
                  size: kIconSizeDefault,
                  color: textStyle.color,
                ),
                const SizedBox(width: 6),
                Text(timeText, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
