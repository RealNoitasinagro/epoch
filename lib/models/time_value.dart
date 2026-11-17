import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../time_utils.dart';
import 'generated/iana_links_snapshot.g.dart';
import 'tab_entry.dart';
import 'zone_rules.dart';

// All displayable value types across all tabs.
enum ValueType {
  // Civil
  date,
  time,
  dateTime,
  daySecond,
  dayMinute,
  dayPercent,
  sevenSegmentClock,
  analogClock12h,
  analogClock24h,
  // Technical
  unixSeconds,
  tai,
  gps,
  // Astronomical
  gmst,
  lmst,
  julianDate,
  reducedJulianDate,
  modifiedJulianDate,
  dublinJulianDate,
  cnesJulianDate,
  ccsdsJulianDate,
  modifiedJulianDate2000,
  // Curiosities
  decimalTime,
  swatchBeats,
  newEarthTime,
  binaryClockBcd,
  binaryClockColumns,
  binaryClockString,
  octalTime,
  hexadecimalTime,
  romanNumeralsTime,
  doomsdayClock,
}

// For time zones with DST: automatic changes, or one pinned value.
enum TimezoneClockChangeMode { auto, forceDst, forceStandard }

// How a value type can be shortened by the user: seconds or decimals can be hidden.
enum OptionalPart { none, seconds, decimals }


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

ZoneSpec canonicalZoneSpec(ZoneSpec zone) {
  if (zone is! ZoneNamed) return zone;
  final canonical = ianaLinksSnapshot[zone.ianaZone] ?? zone.ianaZone;
  return canonical == 'Etc/UTC' ? const ZoneUtc() : zone;
}

// A single displayable entry: type + zone + optional custom label.
class TimeValue implements TabEntry {
  final ValueType valueType;
  final ZoneSpec zone;
  final String? customLabel;
  final TimezoneClockChangeMode timezoneClockChangeMode;

  /// Whether the optional part (seconds or decimals, see
  /// [ValueTypeProps.optionalPart]) is shown. Null: the global default for
  /// the value type applies.
  final bool? showOptionalPart;

  /// Whether the details line (time zone, week and day of the year, degrees)
  /// is shown, see [ValueTypeProps.hasDetailsLine]. Null: the global
  /// settings apply.
  final bool? showDetails;

  const TimeValue({
    required this.valueType,
    required this.zone,
    this.customLabel,
    this.timezoneClockChangeMode = TimezoneClockChangeMode.auto,
    this.showOptionalPart,
    this.showDetails,
  });

  // Unique key for deduplication within a tab.
  // Custom label does not affect the key.
  String get _baseKey {
    final z = switch (zone) {
      ZoneLocal()                  => 'local',
      ZoneUtc()                    => 'utc',
      ZoneNamed(ianaZone: final s) => 'named:$s',
    };
    return '${valueType.name}/$z';
  }

  @override
  String get key => switch (timezoneClockChangeMode) {
    TimezoneClockChangeMode.auto          => _baseKey,
    TimezoneClockChangeMode.forceDst      => '${_baseKey}/dst',
    TimezoneClockChangeMode.forceStandard => '${_baseKey}/std',
  };

  bool sameZoneAndType(TimeValue other) => _baseKey == other._baseKey;

  /// The IANA zone whose rules apply to this value; null for UTC.
  String? ianaZoneFor(String localIanaZone) {
    return switch (zone) {
      ZoneLocal() => localIanaZone,
      ZoneNamed(ianaZone: final zoneName) => zoneName,
      ZoneUtc() => null,
    };
  }

  // Serialisation
  @override
  String toPrefsString() {
    var result = customLabel != null ? '$_baseKey|$customLabel' : _baseKey;
    if (timezoneClockChangeMode != TimezoneClockChangeMode.auto) {
      result = '$result|dst:${timezoneClockChangeMode.name}';
    }
    final optionalPartChoice = showOptionalPart;
    if (optionalPartChoice != null) {
      result = '$result|${optionalPartChoice ? 'sec' : 'nosec'}';
    }
    final detailsChoice = showDetails;
    if (detailsChoice != null) {
      result = '$result|${detailsChoice ? 'det' : 'nodet'}';
    }
    return result;
  }

  static TimeValue? fromPrefsString(String s) {
    var workStr = s;

    // The flags are written as "|sec" or "|nosec", then "|det" or "|nodet",
    // but are accepted in any order. They are taken off the end first,
    // then "|dst:<mode>".
    bool? showOptionalPart;
    bool? showDetails;
    while (true) {
      if (workStr.endsWith('|nosec')) {
        showOptionalPart = false;
        workStr = _withoutSuffix(workStr, '|nosec');
      } else if (workStr.endsWith('|sec')) {
        showOptionalPart = true;
        workStr = _withoutSuffix(workStr, '|sec');
      } else if (workStr.endsWith('|nodet')) {
        showDetails = false;
        workStr = _withoutSuffix(workStr, '|nodet');
      } else if (workStr.endsWith('|det')) {
        showDetails = true;
        workStr = _withoutSuffix(workStr, '|det');
      } else {
        break;
      }
    }

    TimezoneClockChangeMode timezoneClockChangeMode =
        TimezoneClockChangeMode.auto;
    final dstIdx = workStr.lastIndexOf('|dst:');
    if (dstIdx >= 0) {
      final dstName = workStr.substring(dstIdx + '|dst:'.length);
      timezoneClockChangeMode = TimezoneClockChangeMode.values
          .where((mode) => mode.name == dstName)
          .firstOrNull ??
          TimezoneClockChangeMode.auto;
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
      customLabel: (labelPart == null || labelPart.isEmpty) ? null : labelPart,
      timezoneClockChangeMode: timezoneClockChangeMode,
      showOptionalPart: showOptionalPart,
      showDetails: showDetails
    );
  }

  static String _withoutSuffix(String text, String suffix) {
    return text.substring(0, text.length - suffix.length);
  }

  TimeValue copyWith({
    String? customLabel,
    bool clearCustomLabel = false,
    TimezoneClockChangeMode? timezoneClockChangeMode,
    bool? showOptionalPart,
    bool clearShowOptionalPart = false,
    bool? showDetails,
    bool clearShowDetails = false,
  }) => TimeValue(
    valueType: valueType,
    zone: zone,
    customLabel: clearCustomLabel ? null : (customLabel ?? this.customLabel),
    timezoneClockChangeMode:
    timezoneClockChangeMode ?? this.timezoneClockChangeMode,
    showOptionalPart: clearShowOptionalPart
        ? null
        : (showOptionalPart ?? this.showOptionalPart),
    showDetails: clearShowDetails ? null : (showDetails ?? this.showDetails),
  );

  TimeValue withCustomLabel(String? label) =>
      copyWith(customLabel: label, clearCustomLabel: label == null);

  TimeValue withTimezoneClockChangeMode(TimezoneClockChangeMode mode) =>
      copyWith(timezoneClockChangeMode: mode);

  TimeValue withShowOptionalPart(bool? value) {
    return copyWith(
      showOptionalPart: value,
      clearShowOptionalPart: value == null,
    );
  }

  TimeValue withShowDetails(bool? value) {
    return copyWith(
      showDetails: value,
      clearShowDetails: value == null,
    );
  }

  // Whether this type is zone-independent (Technical/Astronomical/Curiosities).
  bool get isZoneIndependent => valueType.isZoneIndependent;

  TimezoneClockChangeMode effectiveClockChangeMode(
      DateTime nowUtc, String localIanaZone) {
    if (timezoneClockChangeMode == TimezoneClockChangeMode.auto) {
      return TimezoneClockChangeMode.auto;
    }
    final ianaZone = ianaZoneFor(localIanaZone);
    final hasDst = ianaZone != null &&
        TimeUtils.hasDaylightSavingTime(ianaZone, referenceUtc: nowUtc);
    return hasDst ? timezoneClockChangeMode : TimezoneClockChangeMode.auto;
  }

  bool isPinned(DateTime nowUtc, String localIanaZone) =>
      effectiveClockChangeMode(nowUtc, localIanaZone) != TimezoneClockChangeMode.auto;

  // Returns whether DST is currently active for this value's zone,
  // or null if the zone has no DST or is zone-independent.
  // Used to show a summer/winter time indicator icon.
  bool? isDstCurrentlyActive(DateTime nowUtc, String localIanaZone) {
    if (isZoneIndependent) return null;
    final ianaZone = ianaZoneFor(localIanaZone);
    if (ianaZone == null) return null;
    final rules = zoneRulesAt(ianaZone, nowUtc);
    if (rules == null || !rules.hasDst) return null;
    return TimeUtils.inZone(nowUtc, ianaZone).timeZone.isDst;
  }

  IconData? getDstStatusIndicator(DateTime nowUtc, String localIanaZone) {
    switch (effectiveClockChangeMode(nowUtc, localIanaZone)) {
      case TimezoneClockChangeMode.forceDst: return kIconDstActive;
      case TimezoneClockChangeMode.forceStandard: return kIconDstInactive;
      case TimezoneClockChangeMode.auto: break;
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
        ValueType.dayMinute => l10n.valueTypeDayMinute,
        ValueType.dayPercent => l10n.valueTypeDayPercent,
        ValueType.sevenSegmentClock => l10n.valueTypeSevenSegmentClock,
        ValueType.analogClock12h => l10n.valueTypeAnalogClock12h,
        ValueType.analogClock24h => l10n.valueTypeAnalogClock24h,
        ValueType.unixSeconds => l10n.valueTypeUnixSeconds,
        ValueType.tai => l10n.valueTypeTai,
        ValueType.gps => l10n.valueTypeGps,
        ValueType.gmst => l10n.valueTypeGmst,
        ValueType.lmst => l10n.valueTypeLmst,
        ValueType.julianDate => l10n.valueTypeJulianDate,
        ValueType.reducedJulianDate => l10n.valueTypeReducedJulianDate,
        ValueType.modifiedJulianDate => l10n.valueTypeModifiedJulianDate,
        ValueType.dublinJulianDate => l10n.valueTypeDublinJulianDate,
        ValueType.cnesJulianDate => l10n.valueTypeCnesJulianDate,
        ValueType.ccsdsJulianDate => l10n.valueTypeCcsdsJulianDate,
        ValueType.modifiedJulianDate2000 => l10n.valueTypeModifiedJulianDate2000,
        ValueType.decimalTime => l10n.valueTypeDecimalTime,
        ValueType.swatchBeats => l10n.valueTypeSwatchBeats,
        ValueType.newEarthTime => l10n.valueTypeNewEarthTime,
        ValueType.binaryClockBcd => l10n.valueTypeBinaryClockBcd,
        ValueType.binaryClockColumns => l10n.valueTypeBinaryClockColumns,
        ValueType.binaryClockString => l10n.valueTypeBinaryClockString,
        ValueType.octalTime => l10n.valueTypeOctalTime,
        ValueType.hexadecimalTime => l10n.valueTypeHexadecimalTime,
        ValueType.romanNumeralsTime => l10n.valueTypeRomanNumeralsTime,
        ValueType.doomsdayClock => l10n.valueTypeDoomsdayClock,
      };

  // Localized info text.
  String localizedInfoText(AppLocalizations l10n) =>
      switch (valueType) {
        ValueType.date => l10n.infoTextDate,
        ValueType.time => l10n.infoTextTime,
        ValueType.dateTime => l10n.infoTextDateTime,
        ValueType.daySecond => l10n.infoTextDaySecond,
        ValueType.dayMinute => l10n.infoTextDayMinute,
        ValueType.dayPercent => l10n.infoTextDayPercent,
        ValueType.sevenSegmentClock => l10n.infoTextSevenSegmentClock,
        ValueType.analogClock12h => l10n.infoTextAnalogClock12h,
        ValueType.analogClock24h => l10n.infoTextAnalogClock24h,
        ValueType.unixSeconds => l10n.infoTextUnixSeconds,
        ValueType.tai => l10n.infoTextTai,
        ValueType.gps => l10n.infoTextGps,
        ValueType.gmst => l10n.infoTextGmst,
        ValueType.lmst => l10n.infoTextLmst,
        ValueType.julianDate => l10n.infoTextJulianDate,
        ValueType.reducedJulianDate => l10n.infoTextReducedJulianDate,
        ValueType.modifiedJulianDate => l10n.infoTextModifiedJulianDate,
        ValueType.dublinJulianDate => l10n.infoTextDublinJulianDate,
        ValueType.cnesJulianDate => l10n.infoTextCnesJulianDate,
        ValueType.ccsdsJulianDate => l10n.infoTextCcsdsJulianDate,
        ValueType.modifiedJulianDate2000 => l10n.infoTextModifiedJulianDate2000,
        ValueType.decimalTime => l10n.infoTextDecimalTime,
        ValueType.swatchBeats => l10n.infoTextSwatchBeats,
        ValueType.newEarthTime => l10n.infoTextNewEarthTime,
        ValueType.binaryClockBcd => l10n.infoTextBinaryClockBcd,
        ValueType.binaryClockColumns => l10n.infoTextBinaryClockColumns,
        ValueType.binaryClockString => l10n.infoTextBinaryClockString,
        ValueType.octalTime => l10n.infoTextOctalTime,
        ValueType.hexadecimalTime => l10n.infoTextHexadecimalTime,
        ValueType.romanNumeralsTime => l10n.infoTextRomanNumeralsTime,
        ValueType.doomsdayClock => l10n.infoTextDoomsdayClock,
      };

  // Returns a URL for further reading, or null if none defined.
  String? localizedInfoLink(AppLocalizations l10n) =>
      switch (valueType) {
        ValueType.unixSeconds => l10n.infoLinkUnixSeconds,
        ValueType.tai => l10n.infoLinkTai,
        ValueType.gps => l10n.infoLinkGps,
        ValueType.gmst => l10n.infoLinkGmst,
        ValueType.lmst => l10n.infoLinkLmst,
        ValueType.julianDate => l10n.infoLinkJulianDate,
        ValueType.reducedJulianDate => l10n.infoLinkReducedJulianDate,
        ValueType.modifiedJulianDate => l10n.infoLinkModifiedJulianDate,
        ValueType.dublinJulianDate => l10n.infoLinkDublinJulianDate,
        ValueType.cnesJulianDate => l10n.infoLinkCnesJulianDate,
        ValueType.ccsdsJulianDate => l10n.infoLinkCcsdsJulianDate,
        ValueType.modifiedJulianDate2000 => l10n.infoLinkModifiedJulianDate2000,
        ValueType.decimalTime => l10n.infoLinkDecimalTime,
        ValueType.swatchBeats => l10n.infoLinkSwatchBeats,
        ValueType.newEarthTime => l10n.infoLinkNewEarthTime,
        ValueType.binaryClockBcd => l10n.infoLinkBinaryClockBcd,
        ValueType.binaryClockColumns => l10n.infoLinkBinaryClockColumns,
        ValueType.binaryClockString => l10n.infoLinkBinaryClockString,
        ValueType.romanNumeralsTime => l10n.infoLinkRomanNumeralsTime,
        ValueType.doomsdayClock => l10n.infoLinkDoomsdayClock,
        _ => null,
      };
}

extension ValueTypeProps on ValueType {
  bool get isZoneIndependent =>
      switch (this) {
        ValueType.date => false,
        ValueType.time => false,
        ValueType.dateTime => false,
        ValueType.daySecond => false,
        ValueType.dayMinute => false,
        ValueType.dayPercent => false,
        ValueType.sevenSegmentClock => false,
        ValueType.analogClock12h => false,
        ValueType.analogClock24h => false,
        ValueType.unixSeconds => true,
        ValueType.tai => true,
        ValueType.gps => true,
        ValueType.gmst => true,
        ValueType.lmst => true,
        ValueType.julianDate => true,
        ValueType.reducedJulianDate => true,
        ValueType.modifiedJulianDate => true,
        ValueType.dublinJulianDate => true,
        ValueType.cnesJulianDate => true,
        ValueType.ccsdsJulianDate => true,
        ValueType.modifiedJulianDate2000 => true,
        ValueType.decimalTime => false,
        ValueType.swatchBeats => true,
        ValueType.newEarthTime => true,
        ValueType.binaryClockBcd => false,
        ValueType.binaryClockColumns => false,
        ValueType.binaryClockString => false,
        ValueType.octalTime => false,
        ValueType.hexadecimalTime => false,
        ValueType.romanNumeralsTime => false,
        ValueType.doomsdayClock => true,
      };

  bool get isGraphical =>
      this == ValueType.sevenSegmentClock ||
      this == ValueType.analogClock12h ||
      this == ValueType.analogClock24h ||
      this == ValueType.binaryClockBcd ||
      this == ValueType.binaryClockColumns;

  OptionalPart get optionalPart =>
      switch (this) {
        ValueType.dayPercent ||
        ValueType.swatchBeats ||
        ValueType.newEarthTime => OptionalPart.decimals,
        ValueType.time ||
        ValueType.dateTime ||
        ValueType.dayMinute ||
        ValueType.decimalTime ||
        ValueType.sevenSegmentClock ||
        ValueType.analogClock12h ||
        ValueType.analogClock24h ||
        ValueType.binaryClockBcd ||
        ValueType.binaryClockColumns ||
        ValueType.binaryClockString ||
        ValueType.romanNumeralsTime => OptionalPart.seconds,
        _ => OptionalPart.none,
      };

  /// Time and date & time: whether seconds are shown by default follows the
  /// time format (a pattern with "ss" shows them), not a per-type setting.
  bool get optionalPartFollowsTimeFormat =>
      this == ValueType.time || this == ValueType.dateTime;

  /// Types that can show a details line below the value: the time zone, the
  /// week and day of the year (date), or the angle (sidereal time).
  bool get hasDetailsLine =>
      switch (this) {
        ValueType.date ||
        ValueType.time ||
        ValueType.dateTime ||
        ValueType.daySecond ||
        ValueType.dayPercent ||
        ValueType.dayMinute ||
        ValueType.decimalTime ||
        ValueType.gmst ||
        ValueType.lmst => true,
        _ => false,
      };
}

/// Value types whose seconds or decimals can be hidden by default for all
/// values of the type, in enum order. Time and date & time are not among
/// them: their default follows the time format.
final List<ValueType> globalOptionalPartTypes = [
  for (final valueType in ValueType.values)
    if (valueType.optionalPart != OptionalPart.none &&
        !valueType.optionalPartFollowsTimeFormat)
      valueType,
];
