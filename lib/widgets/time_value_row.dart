import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import '../effective_clock.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/time_value.dart';
import '../models/timezone_abbreviation_localization.dart';
import '../models/zone_rules.dart';
import '../screens/focus_screen.dart';
import '../time_utils.dart';
import '../time_value_formatter.dart';
import 'link_text.dart';

abstract class TimeValueRow extends StatelessWidget {
  final TimeValue timeValue;
  final DateTime now;
  final String? infoLinkOverride;

  const TimeValueRow({
    super.key,
    required this.timeValue,
    required this.now,
    this.infoLinkOverride,
  });

  void showInfo(BuildContext context, AppLocalizations l10n) {
    final localIanaZone = EpochApp.of(context).localIanaZone;
    String? ianaZone = TimeUtils.resolveIanaZone(timeValue, localIanaZone);
    final link = infoLinkOverride ?? timeValue.localizedInfoLink(l10n);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(timeValue.localizedDisplayLabel(l10n)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(timeValue.localizedInfoText(l10n)),
            if (link != null) ...[
              const SizedBox(height: 12),
              LinkText(url: link),
            ],
            if (ianaZone != null &&
                timeValue.timezoneClockChangeMode == TimezoneClockChangeMode.auto)
              ..._buildDstTransitionsSection(ianaZone, ctx, l10n),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void openFocusScreen(BuildContext context, String locale) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FocusScreen(
          timeValue: timeValue,
          locale: locale,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  List<Widget> _buildDstTransitionsSection(
      String ianaZone, BuildContext context, AppLocalizations l10n) {
    final app = EpochApp.of(context);
    final transitions = TimeUtils.nextDstTransitions(
        ianaZone, EffectiveClock.now().toUtc(), count: 4);
    if (transitions.isEmpty) return [];

    final textTheme   = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final locale      = l10n.localeName;

    Widget transitionRow(DateTime utcTime) {
      final DateTime localTime = utcTime.toLocal();  // time in device local time
      final tz.TZDateTime zonedTime = TimeUtils.inZone(utcTime, ianaZone);  // time in the named zone

      final wallClock = TimeUtils.wallClockAroundTransition(ianaZone, utcTime);
      final sameDay = wallClock.before.year == wallClock.after.year &&
          wallClock.before.month == wallClock.after.month &&
          wallClock.before.day == wallClock.after.day;
      final abbrs = TimeUtils.dstTransitionAbbreviations(ianaZone, utcTime);
      final abbrBefore = localizeTimezoneAbbr(abbrs.before, l10n.localeName);
      final abbrAfter  = localizeTimezoneAbbr(abbrs.after,  l10n.localeName);

      // Abbreviation and offset, as in the time zone search: tells apart the
      // two occurrences of a repeated hour even if the abbreviations are unfamiliar.
      String describeWallClock(
          DateTime wall, String abbreviation, Duration offset) {
        final zone = '$abbreviation ${formatUtcOffset(offset, withUtcPrefix: true)}';
        return sameDay
            ? TimeValueFormatter.formatTime(
                app.hourFormat24, wall.hour, wall.minute, wall.second,
                tzSuffix: zone)
            : TimeValueFormatter.formatDateTime(
                app.hourFormat24, locale, wall, zone);
      }
      final zonedStr =
          '${TimeValueFormatter.formatDate(locale, wallClock.after)}\n'
          '  ${describeWallClock(wallClock.before, abbrBefore.padRight(5), wallClock.offsetBefore)}\n'
          '→ ${describeWallClock(wallClock.after, abbrAfter.padRight(5), wallClock.offsetAfter)}';

      final localStr = TimeValueFormatter.formatDateTime(
          app.hourFormat24, locale, localTime, null);
      // Only show local time if it differs from zoned time (different day or hour):
      final showLocal = zonedTime.day != localTime.day ||
          zonedTime.hour != localTime.hour ||
          zonedTime.month != localTime.month;

      final localAbbrAtTransition = () {
        try {
          final localLoc = tz.getLocation(app.localIanaZone);
          final abbr = tz.TZDateTime.from(utcTime, localLoc).timeZone.abbreviation;
          return localizeTimezoneAbbr(abbr, l10n.localeName);
        } catch (_) {
          return '';
        }
      }();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(zonedStr,
            style: textTheme.bodySmall?.copyWith(fontFamily: fontFamilyDefault),
          ),
          if (showLocal)
            Text(
              '(= ${l10n.labelLocal.toLowerCase()}: $localStr $localAbbrAtTransition)',
              style: textTheme.bodySmall?.copyWith(
                fontFamily: fontFamilyDefault,
                color: colorScheme.onSurface.withAlpha(150),
              ),
            ),
        ],
      );
    }

    return [
      const SizedBox(height: 16),
      Text(
        l10n.labelNextClockChanges,
        style: textTheme.labelMedium?.copyWith(
          color: colorScheme.primary,
          letterSpacing: 1.5,
        ),
      ),
      const SizedBox(height: 6),
      for (var index = 0; index < transitions.length; index++) ...[
        if (index > 0) const Divider(height: 16),
        transitionRow(transitions[index]),
      ],
    ];
  }
}
