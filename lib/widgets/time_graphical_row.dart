import 'package:epoch/widgets/clocks/seven_segment_clock.dart';
import 'package:epoch/widgets/time_value_row.dart';
import 'package:epoch/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/app_settings.dart';
import '../models/time_value.dart';
import '../time_utils.dart';
import 'clocks/binary_coded_decimal_clock.dart';
import 'clocks/binary_columns_clock.dart';

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

    final segmentColor = switch (app.themeMode) {
      AppThemeMode.light  => Colors.black,
      AppThemeMode.dark   => Colors.white,
      AppThemeMode.night  => kColorNightRed,
      AppThemeMode.system => Theme.of(context).brightness == Brightness.dark
          ? Colors.white : Colors.black,
    };

    final Widget clock = switch (timeValue.valueType) {
      ValueType.sevenSegmentClock =>
        SevenSegmentClock(
          now: zonedNow,
          l10n: l10n,
          digitHeight: kGraphicalSegmentClockHeightDefault,
          showSeconds: timeValue.showSeconds,
          hourFormat24: app.hourFormat24,
          color: segmentColor,
        ),
      ValueType.binaryClockColumns =>
        BinaryColumnsClock(
            now: zonedNow,
            l10n: l10n,
            showSeconds: timeValue.showSeconds,
        ),
      ValueType.binaryClockBcd =>
        BinaryCodedDecimalClock(
            now: zonedNow,
            l10n: l10n,
            showSeconds: timeValue.showSeconds,
        ),
      _ => throw StateError(
          'Unhandled graphical ValueType: ${timeValue.valueType}'),
    };

    final ianaZone = switch (timeValue.zone) {
      ZoneLocal()                  => localIanaZone,
      ZoneNamed(ianaZone: final z) => z,
      ZoneUtc()                    => null,
    };

    final Color? dayQuarterColor = app.dayQuarterColor &&
        app.themeMode != AppThemeMode.night &&
        !timeValue.isZoneIndependent
        ? TimeUtils.dayQuarterColor(now.toUtc(), ianaZone)
        : null;

    return ValueTile(
      label: timeValue.localizedDisplayLabel(l10n),
      showZoneIndicator: !timeValue.isZoneIndependent,
      showPinnedIndicator: timeValue.timezoneClockChangeMode != TimezoneClockChangeMode.auto,
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