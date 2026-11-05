import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/app_settings.dart';
import '../time_utils.dart';
import '../widgets/time_value_row.dart';
import '../widgets/value_tile.dart';
import '../zoned_moment.dart';
import 'clocks/graphical_clock.dart';

class TimeGraphicalRow extends TimeValueRow {
  const TimeGraphicalRow({
    super.key,
    required super.timeValue,
    required super.now,
    super.infoLinkOverride,
  });

  @override
  Widget build(BuildContext context) {
    final app = EpochApp.of(context);
    final settings = app.formatSettings;
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final localIanaZone = EpochApp.of(context).localIanaZone;
    final moment = ZonedMoment.of(timeValue, now, localIanaZone);

    final Widget clock = buildGraphicalClock(
      valueType: timeValue.valueType,
      now: moment.wallClock,
      l10n: l10n,
      showSeconds: settings.showsOptionalPart(timeValue),
      hourFormat24: settings.hourFormat24,
      segmentColor: graphicalClockColor(app.themeMode, Theme.of(context).brightness),
    );

    final Color? dayQuarterColor = app.dayQuarterColor &&
        app.themeMode != AppThemeMode.night && !timeValue.isZoneIndependent
        ? TimeUtils.dayQuarterColor(moment.wallClock.hour)
        : null;

    return ValueTile(
      label: timeValue.localizedDisplayLabel(l10n),
      showZoneIndicator: !timeValue.isZoneIndependent,
      showPinnedIndicator: timeValue.isPinned(now.toUtc(), localIanaZone),
      dstStatusIndicator: timeValue.getDstStatusIndicator(now.toUtc(), localIanaZone),
      height: ValueTile.graphicTileHeight,
      content: Tooltip(
        message: l10n.hintFocusScreenOpen,
        waitDuration: const Duration(milliseconds: 1000),
        child: GraphicValueContent(
          clock: clock,
          dayQuarterColor: dayQuarterColor,
          onDoubleTap: () => openFocusScreen(context, locale),
        ),
      ),
      actionSlots: [
        IconButton(
          icon: const Icon(Icons.info_outline, size: kIconSizeDefault),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.hintAboutThisValue,
          onPressed: () => showInfo(context, l10n),
        ),
        null,
        null,
      ],
    );
  }
}
