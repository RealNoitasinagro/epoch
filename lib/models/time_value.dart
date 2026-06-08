import '../l10n/app_localizations.dart';

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
  julianDate,
  modifiedJulianDate,
  modifiedJulianDate2000,
  // Curiosities
  swatchBeats,
  binaryClockString,
  binaryClockColumns,
  binaryClockBcd,
  doomsdayClock
}

// Zone specification.
sealed class ZoneSpec {
  const ZoneSpec();
}
class ZoneLocal extends ZoneSpec { const ZoneLocal(); }
class ZoneUtc   extends ZoneSpec { const ZoneUtc(); }
class ZoneNamed extends ZoneSpec {
  final String ianaZone;
  const ZoneNamed(this.ianaZone);
}

// A single displayable entry: type + zone + optional custom label.
class TimeValue {
  final ValueType type;
  final ZoneSpec zone;
  final String? customLabel;

  const TimeValue({
    required this.type,
    required this.zone,
    this.customLabel,
  });

  // Unique key for deduplication within a tab.
  // Custom label does not affect the key – same type+zone = duplicate.
  String get key {
    final z = switch (zone) {
      ZoneLocal()                  => 'local',
      ZoneUtc()                    => 'utc',
      ZoneNamed(ianaZone: final s) => 'named:$s',
    };
    return '${type.name}/$z';
  }

  // Serialisation: key + optional custom label separated by '|'.
  String toPrefsString() =>
      customLabel != null ? '$key|$customLabel' : key;

  static TimeValue? fromPrefsString(String s) {
    // Split off optional custom label.
    final pipeIdx = s.indexOf('|');
    final keyPart   = pipeIdx >= 0 ? s.substring(0, pipeIdx) : s;
    final labelPart = pipeIdx >= 0 ? s.substring(pipeIdx + 1) : null;

    final parts = keyPart.split('/');
    if (parts.length < 2) return null;
    final type = ValueType.values.where((e) => e.name == parts[0]).firstOrNull;
    if (type == null) return null;

    final zoneStr = parts.sublist(1).join('/');
    final ZoneSpec zone;
    if (zoneStr == 'local') {
      zone = const ZoneLocal();
    } else if (zoneStr == 'utc') {
      zone = const ZoneUtc();
    } else if (zoneStr.startsWith('named:')) {
      zone = ZoneNamed(zoneStr.substring(6));
    } else {
      return null;
    }
    return TimeValue(type: type, zone: zone, customLabel: labelPart);
  }

  // Returns a copy with a different custom label (null to clear).
  TimeValue withCustomLabel(String? label) =>
      TimeValue(type: type, zone: zone, customLabel: label);

  // Whether this type is zone-independent (Technical/Astronomical/Curiosities).
  bool get isZoneIndependent => type.isZoneIndependent;

  // Localized display label shown in the UI.
  String localizedDisplayLabel(AppLocalizations l10n) {
    if (customLabel != null) return customLabel!;
    final _localizedTypeLabel = localizedTypeLabel(type, l10n);
    if (isZoneIndependent) return _localizedTypeLabel;
    final zoneLabel = switch (zone) {
      ZoneLocal()                  => l10n.labelLocal.toLowerCase(),
      ZoneUtc()                    => l10n.zoneUtc,
      ZoneNamed(ianaZone: final z) => z.split('/').last.replaceAll('_', ' '),
    };
    return '$_localizedTypeLabel ($zoneLabel)';
  }

  static String localizedTypeLabel(ValueType type, AppLocalizations l10n) => switch (type) {
    ValueType.date                   => l10n.valueTypeDate,
    ValueType.time                   => l10n.valueTypeTime,
    ValueType.dateTime               => l10n.valueTypeDateTime,
    ValueType.daySecond              => l10n.valueTypeDaySecond,
    ValueType.dayPercent             => l10n.valueTypeDayPercent,
    ValueType.unixSeconds            => l10n.valueTypeUnixSeconds,
    ValueType.tai                    => l10n.valueTypeTai,
    ValueType.gps                    => l10n.valueTypeGps,
    ValueType.gmst                   => l10n.valueTypeGmst,
    ValueType.julianDate             => l10n.valueTypeJulianDate,
    ValueType.modifiedJulianDate     => l10n.valueTypeModifiedJulianDate,
    ValueType.modifiedJulianDate2000 => l10n.valueTypeModifiedJulianDate2000,
    ValueType.swatchBeats            => l10n.valueTypeSwatchBeats,
    ValueType.binaryClockColumns     => l10n.valueTypeBinaryClockColumns,
    ValueType.binaryClockBcd         => l10n.valueTypeBinaryClockBcd,
    ValueType.binaryClockString      => l10n.valueTypeBinaryClockString,
    ValueType.doomsdayClock          => l10n.valueTypeDoomsdayClock
  };

  // Localized info text.
  String localizedInfoText(AppLocalizations l10n) => switch (type) {
    ValueType.date                   => l10n.infoDate,
    ValueType.time                   => l10n.infoTime,
    ValueType.dateTime               => l10n.infoDateTime,
    ValueType.daySecond              => l10n.infoDaySecond,
    ValueType.dayPercent             => l10n.infoDayPercent,
    ValueType.unixSeconds            => l10n.infoUnixSeconds,
    ValueType.tai                    => l10n.infoTai,
    ValueType.gps                    => l10n.infoGps,
    ValueType.gmst                   => l10n.infoGmst,
    ValueType.julianDate             => l10n.infoJulianDate,
    ValueType.modifiedJulianDate     => l10n.infoModifiedJulianDate,
    ValueType.modifiedJulianDate2000 => l10n.infoModifiedJulianDate2000,
    ValueType.swatchBeats            => l10n.infoSwatchBeats,
    ValueType.binaryClockColumns     => l10n.infoBinaryClockColumns,
    ValueType.binaryClockBcd         => l10n.infoBinaryClockBcd,
    ValueType.binaryClockString      => l10n.infoBinaryClockString,
    ValueType.doomsdayClock          => l10n.infoDoomsdayClock,
  };

  // Returns a URL for further reading, or null if none defined.
  String? localizedInfoLink(AppLocalizations l10n) => switch (type) {
    ValueType.unixSeconds            => l10n.infoLinkUnixSeconds,
    ValueType.tai                    => l10n.infoLinkTai,
    ValueType.gps                    => l10n.infoLinkGps,
    ValueType.gmst                   => l10n.infoLinkGmst,
    ValueType.julianDate             => l10n.infoLinkJulianDate,
    ValueType.modifiedJulianDate     => l10n.infoLinkModifiedJulianDate,
    ValueType.modifiedJulianDate2000 => l10n.infoLinkModifiedJulianDate2000,
    ValueType.swatchBeats            => l10n.infoLinkSwatchBeats,
    ValueType.binaryClockColumns     => l10n.infoLinkBinaryClockColumns,
    ValueType.binaryClockBcd         => l10n.infoLinkBinaryClockBcd,
    ValueType.binaryClockString      => l10n.infoLinkBinaryClockString,
    ValueType.doomsdayClock          => l10n.infoLinkDoomsdayClock,
    _                                => null,
  };
}

extension ValueTypeProps on ValueType {
  bool get isZoneIndependent => switch (this) {
    ValueType.date                   => false,
    ValueType.time                   => false,
    ValueType.dateTime               => false,
    ValueType.daySecond              => false,
    ValueType.dayPercent             => false,
    ValueType.unixSeconds            => true,
    ValueType.tai                    => true,
    ValueType.gps                    => true,
    ValueType.gmst                   => true,
    ValueType.julianDate             => true,
    ValueType.modifiedJulianDate     => true,
    ValueType.modifiedJulianDate2000 => true,
    ValueType.swatchBeats            => true,
    ValueType.binaryClockString      => false,
    ValueType.binaryClockColumns     => false,
    ValueType.binaryClockBcd         => false,
    ValueType.doomsdayClock          => true,
  };

  bool get isGraphical =>
      this == ValueType.binaryClockColumns ||
      this == ValueType.binaryClockBcd;
}