import 'package:epoch/widgets/time_value_row.dart';
import 'package:epoch/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final zonedNow = _resolveZone(now, timeValue.zone);

    return ValueTile(
      label: timeValue.localizedDisplayLabel(l10n),
      showZoneIndicator: !timeValue.isZoneIndependent,
      height: ValueTile.graphicTileHeight,
      content: GraphicValueContent(
        clock: timeValue.type == ValueType.binaryClockColumns
            ? BinaryColumnsClock(now: zonedNow, l10n: l10n)
            : BinaryCodedDecimalClock(now: zonedNow, l10n: l10n),
      ),
      actionSlots: [
        IconButton(
          icon: const Icon(Icons.info_outline, size: 20),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.aboutThisValue,
          onPressed: () => showInfo(context, l10n),
        ),
        null,
        null,
      ],
    );
  }

  DateTime _resolveZone(DateTime now, ZoneSpec zone) => switch (zone) {
    ZoneLocal()                  => now,
    ZoneUtc()                    => now.toUtc(),
    ZoneNamed(ianaZone: final z) => TimeUtils.inZone(now.toUtc(), z),
  };
}