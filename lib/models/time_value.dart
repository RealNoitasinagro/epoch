import 'package:epoch/models/tab_entry.dart';
import 'package:epoch/models/timezone_search.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../time_utils.dart';

// All displayable value types across all tabs.
enum ValueType {
  // Civil
  date,
  time,
  dateTime,
  daySecond,
  dayPercent,
  // Technical
  unixSeconds,
  tai,
  gps,
  // Astronomical
  gmst,
  lmst,
  julianDate,
  modifiedJulianDate,
  modifiedJulianDate2000,
  // Curiosities
  swatchBeats,
  binaryClockString,
  binaryClockColumns,
  binaryClockBcd,
  doomsdayClock,
}

enum TimezoneDisplayMode { auto, forceDst, forceStandard }

// Zone specification.
sealed class ZoneSpec {
  const ZoneSpec();
}

class ZoneLocal extends ZoneSpec {
  const ZoneLocal();
}

class ZoneUtc extends ZoneSpec {
  const ZoneUtc();
}

class ZoneNamed extends ZoneSpec {
  final String ianaZone;
  const ZoneNamed(this.ianaZone);
}

// A single displayable entry: type + zone + optional custom label.
class TimeValue implements TabEntry {
  final ValueType valueType;
  final ZoneSpec zone;
  final String? customLabel;
  final TimezoneDisplayMode timezoneDisplayMode;

  const TimeValue({
    required this.valueType,
    required this.zone,
    this.customLabel,
    this.timezoneDisplayMode = TimezoneDisplayMode.auto,
  });

  // Unique key for deduplication within a tab.
  // Custom label does not affect the key – same type+zone = duplicate.
  String get key {
    final z = switch (zone) {
      ZoneLocal() => 'local',
      ZoneUtc() => 'utc',
      ZoneNamed(ianaZone: final s) => 'named:$s',
    };
    return '${valueType.name}/$z';
  }

  // Serialisation
  @override
  String toPrefsString() {
    final base = customLabel != null ? '$key|$customLabel' : key;
    if (timezoneDisplayMode == TimezoneDisplayMode.auto) return base;
    return '$base|dst:${timezoneDisplayMode.name}';
  }

  static TimeValue? fromPrefsString(String s) {
    TimezoneDisplayMode timezoneDisplayMode = TimezoneDisplayMode.auto;
    var workStr = s;
    final dstIdx = workStr.lastIndexOf('|dst:');
    if (dstIdx >= 0) {
      final dstStr = workStr.substring(dstIdx + 5);
      timezoneDisplayMode =
          TimezoneDisplayMode.values
              .where((m) => m.name == dstStr)
              .firstOrNull ??
          TimezoneDisplayMode.auto;
      workStr = workStr.substring(0, dstIdx);
    }

    final pipeIdx = workStr.indexOf('|');
    final keyPart = pipeIdx >= 0 ? workStr.substring(0, pipeIdx) : workStr;
    final labelPart = pipeIdx >= 0 ? workStr.substring(pipeIdx + 1) : null;

    final parts = keyPart.split('/');
    if (parts.length < 2) return null;
    final valueType = ValueType.values
        .where((e) => e.name == parts[0])
        .firstOrNull;
    if (valueType == null) return null;
    final zoneStr = parts.sublist(1).join('/');
    final ZoneSpec zone;
    if (zoneStr == 'local')
      zone = const ZoneLocal();
    else if (zoneStr == 'utc')
      zone = const ZoneUtc();
    else if (zoneStr.startsWith('named:'))
      zone = ZoneNamed(zoneStr.substring(6));
    else
      return null;

    return TimeValue(
      valueType: valueType,
      zone: zone,
      customLabel: labelPart,
      timezoneDisplayMode: timezoneDisplayMode,
    );
  }

  // Returns a copy with a different custom label (null to clear).
  TimeValue withCustomLabel(String? label) =>
      TimeValue(valueType: valueType, zone: zone, customLabel: label);

  TimeValue withTimezoneDisplayMode(TimezoneDisplayMode mode) => TimeValue(
    valueType: valueType,
    zone: zone,
    customLabel: customLabel,
    timezoneDisplayMode: mode,
  );

  // Whether this type is zone-independent (Technical/Astronomical/Curiosities).
  bool get isZoneIndependent => valueType.isZoneIndependent;

  // Returns whether DST is currently active for this value's zone,
  // or null if the zone has no DST or is zone-independent.
  // Used to show a summer/winter time indicator icon.
  bool? isDstCurrentlyActive(DateTime nowUtc, String localIanaZone) {
    if (isZoneIndependent) return null;
    final ianaZone = switch (zone) {
      ZoneLocal() => localIanaZone,
      ZoneUtc() => '', // UTC never has DST
      ZoneNamed(ianaZone: final z) => z,
    };
    final entry = tzDatabase.where((e) => e.ianaZone == ianaZone).firstOrNull;
    if (entry == null || !entry.hasDst) return null;
    // Use the timezone package to check the actual current DST status:
    try {
      final tzDt = TimeUtils.inZone(nowUtc, ianaZone);
      return tzDt.timeZone.isDst;
    } catch (_) {
      return null;
    }
  }

  IconData? getDstStatusIndicator(DateTime nowUtc, String localIanaZone) {
    if (timezoneDisplayMode == TimezoneDisplayMode.forceDst) {
      return kIconDstActive;
    }
    if (timezoneDisplayMode == TimezoneDisplayMode.forceStandard) {
      return kIconDstInactive;
    }
    // auto: determine actual current DST status:
    return switch (isDstCurrentlyActive(nowUtc, localIanaZone)) {
      true  => kIconDstActive,
      false => kIconDstInactive,
      null  => null,
    };
  }

  // Localized display label shown in the UI.
  String localizedDisplayLabel(AppLocalizations l10n) {
    if (customLabel != null) return customLabel!;
    final _localizedTypeLabel = localizedTypeLabel(valueType, l10n);
    if (isZoneIndependent) return _localizedTypeLabel;
    final zoneLabel = switch (zone) {
      ZoneLocal() => l10n.labelLocal.toLowerCase(),
      ZoneUtc() => l10n.actionZoneUtc,
      ZoneNamed(ianaZone: final z) => z.split('/').last.replaceAll('_', ' '),
    };
    return '$_localizedTypeLabel ($zoneLabel)';
  }

  static String localizedTypeLabel(ValueType type, AppLocalizations l10n) =>
      switch (type) {
        ValueType.date => l10n.valueTypeDate,
        ValueType.time => l10n.valueTypeTime,
        ValueType.dateTime => l10n.valueTypeDateTime,
        ValueType.daySecond => l10n.valueTypeDaySecond,
        ValueType.dayPercent => l10n.valueTypeDayPercent,
        ValueType.unixSeconds => l10n.valueTypeUnixSeconds,
        ValueType.tai => l10n.valueTypeTai,
        ValueType.gps => l10n.valueTypeGps,
        ValueType.gmst => l10n.valueTypeGmst,
        ValueType.lmst => l10n.valueTypeLmst,
        ValueType.julianDate => l10n.valueTypeJulianDate,
        ValueType.modifiedJulianDate => l10n.valueTypeModifiedJulianDate,
        ValueType.modifiedJulianDate2000 =>
          l10n.valueTypeModifiedJulianDate2000,
        ValueType.swatchBeats => l10n.valueTypeSwatchBeats,
        ValueType.binaryClockColumns => l10n.valueTypeBinaryClockColumns,
        ValueType.binaryClockBcd => l10n.valueTypeBinaryClockBcd,
        ValueType.binaryClockString => l10n.valueTypeBinaryClockString,
        ValueType.doomsdayClock => l10n.valueTypeDoomsdayClock,
      };

  // Localized info text.
  String localizedInfoText(AppLocalizations l10n) => switch (valueType) {
    ValueType.date => l10n.infoTextDate,
    ValueType.time => l10n.infoTextTime,
    ValueType.dateTime => l10n.infoTextDateTime,
    ValueType.daySecond => l10n.infoTextDaySecond,
    ValueType.dayPercent => l10n.infoTextDayPercent,
    ValueType.unixSeconds => l10n.infoTextUnixSeconds,
    ValueType.tai => l10n.infoTextTai,
    ValueType.gps => l10n.infoTextGps,
    ValueType.gmst => l10n.infoTextGmst,
    ValueType.lmst => l10n.infoTextLmst,
    ValueType.julianDate => l10n.infoTextJulianDate,
    ValueType.modifiedJulianDate => l10n.infoTextModifiedJulianDate,
    ValueType.modifiedJulianDate2000 => l10n.infoTextModifiedJulianDate2000,
    ValueType.swatchBeats => l10n.infoTextSwatchBeats,
    ValueType.binaryClockColumns => l10n.infoTextBinaryClockColumns,
    ValueType.binaryClockBcd => l10n.infoTextBinaryClockBcd,
    ValueType.binaryClockString => l10n.infoTextBinaryClockString,
    ValueType.doomsdayClock => l10n.infoTextDoomsdayClock,
  };

  // Returns a URL for further reading, or null if none defined.
  String? localizedInfoLink(AppLocalizations l10n) => switch (valueType) {
    ValueType.unixSeconds => l10n.infoLinkUnixSeconds,
    ValueType.tai => l10n.infoLinkTai,
    ValueType.gps => l10n.infoLinkGps,
    ValueType.gmst => l10n.infoLinkGmst,
    ValueType.lmst => l10n.infoLinkLmst,
    ValueType.julianDate => l10n.infoLinkJulianDate,
    ValueType.modifiedJulianDate => l10n.infoLinkModifiedJulianDate,
    ValueType.modifiedJulianDate2000 => l10n.infoLinkModifiedJulianDate2000,
    ValueType.swatchBeats => l10n.infoLinkSwatchBeats,
    ValueType.binaryClockColumns => l10n.infoLinkBinaryClockColumns,
    ValueType.binaryClockBcd => l10n.infoLinkBinaryClockBcd,
    ValueType.binaryClockString => l10n.infoLinkBinaryClockString,
    ValueType.doomsdayClock => l10n.infoLinkDoomsdayClock,
    _ => null,
  };
}

extension ValueTypeProps on ValueType {
  bool get isZoneIndependent => switch (this) {
    ValueType.date => false,
    ValueType.time => false,
    ValueType.dateTime => false,
    ValueType.daySecond => false,
    ValueType.dayPercent => false,
    ValueType.unixSeconds => true,
    ValueType.tai => true,
    ValueType.gps => true,
    ValueType.gmst => true,
    ValueType.lmst => true,
    ValueType.julianDate => true,
    ValueType.modifiedJulianDate => true,
    ValueType.modifiedJulianDate2000 => true,
    ValueType.swatchBeats => true,
    ValueType.binaryClockString => false,
    ValueType.binaryClockColumns => false,
    ValueType.binaryClockBcd => false,
    ValueType.doomsdayClock => true,
  };

  bool get isGraphical =>
      this == ValueType.binaryClockColumns ||
      this == ValueType.binaryClockBcd;
}
