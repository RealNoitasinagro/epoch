import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/app_settings.dart';
import '../time_utils.dart';
import '../widgets/time_value_row.dart';
import '../widgets/value_tile.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final localIanaZone = EpochApp.of(context).localIanaZone;
    final zonedNow = TimeUtils.resolveLocalTime(
        timeValue, now.toUtc(), localIanaZone);

    final Widget clock = buildGraphicalClock(
      valueType: timeValue.valueType,
      now: zonedNow,
      l10n: l10n,
      showSeconds: timeValue.showOptionalPart,
      hourFormat24: app.hourFormat24,
      segmentColor: graphicalClockColor(app.themeMode, Theme.of(context).brightness),
    );

    String? ianaZone = TimeUtils.resolveIanaZone(timeValue, localIanaZone);

    final Color? dayQuarterColor = app.dayQuarterColor &&
        app.themeMode != AppThemeMode.night && !timeValue.isZoneIndependent
        ? TimeUtils.dayQuarterColor(now.toUtc(), ianaZone)
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
