import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import '../l10n/app_localizations.dart';
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
  julianDate,
  modifiedJulianDate,
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
class TimeEntry {
  final ValueType type;
  final ZoneSpec zone;
  final String? customLabel;

  const TimeEntry({
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

  static TimeEntry? fromPrefsString(String s) {
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
    return TimeEntry(type: type, zone: zone, customLabel: labelPart);
  }

  // Returns a copy with a different custom label (null to clear).
  TimeEntry withLabel(String? label) =>
      TimeEntry(type: type, zone: zone, customLabel: label);

  // Whether this type is zone-independent (Technical/Astronomical/Curiosities).
  bool get isZoneIndependent => type.isZoneIndependent;

  // Localized display label shown in the UI.
  String localizedLabel(AppLocalizations l10n) {
    if (customLabel != null) return customLabel!;
    final typeLabel = _typeLabel(l10n);
    if (isZoneIndependent) return typeLabel;
    final zoneLabel = switch (zone) {
      ZoneLocal()                  => l10n.labelLocal.toLowerCase(),
      ZoneUtc()                    => l10n.zoneUtc,
      ZoneNamed(ianaZone: final z) => z.split('/').last.replaceAll('_', ' '),
    };
    return '$typeLabel ($zoneLabel)';
  }

  String _typeLabel(AppLocalizations l10n) => switch (type) {
    ValueType.date               => l10n.valueTypeDate,
    ValueType.time               => l10n.valueTypeTime,
    ValueType.dateTime           => l10n.valueTypeDateTime,
    ValueType.daySecond          => l10n.valueTypeDaySecond,
    ValueType.dayPercent         => l10n.valueTypeDayPercent,
    ValueType.unixSeconds        => l10n.valueTypeUnixSeconds,
    ValueType.tai                => l10n.valueTypeTai,
    ValueType.gps                => l10n.valueTypeGps,
    ValueType.gmst               => l10n.valueTypeGmst,
    ValueType.julianDate         => l10n.valueTypeJulianDate,
    ValueType.modifiedJulianDate => l10n.valueTypeModifiedJulianDate,
    ValueType.swatchBeats        => l10n.valueTypeSwatchBeats,
    ValueType.binaryClockColumns => l10n.valueTypeBinaryClockColumns,
    ValueType.binaryClockBcd     => l10n.valueTypeBinaryClockBcd,
    ValueType.binaryClockString  => l10n.valueTypeBinaryClockString,
    ValueType.doomsdayClock      => l10n.valueTypeDoomsdayClock
  };

  // Localized info text.
  String localizedInfo(AppLocalizations l10n) => switch (type) {
    ValueType.date               => l10n.infoDate,
    ValueType.time               => l10n.infoTime,
    ValueType.dateTime           => l10n.infoDateTime,
    ValueType.daySecond          => l10n.infoDaySecond,
    ValueType.dayPercent         => l10n.infoDayPercent,
    ValueType.unixSeconds        => l10n.infoUnixSeconds,
    ValueType.tai                => l10n.infoTai,
    ValueType.gps                => l10n.infoGps,
    ValueType.gmst               => l10n.infoGmst,
    ValueType.julianDate         => l10n.infoJulianDate,
    ValueType.modifiedJulianDate => l10n.infoModifiedJulianDate,
    ValueType.swatchBeats        => l10n.infoSwatchBeats,
    ValueType.binaryClockColumns => l10n.infoBinaryClockColumns,
    ValueType.binaryClockBcd     => l10n.infoBinaryClockBcd,
    ValueType.binaryClockString  => l10n.infoBinaryClockString,
    ValueType.doomsdayClock      => l10n.infoDoomsdayClock,
  };

  // Returns a URL for further reading, or null if none defined.
  String? localizedInfoLink(AppLocalizations l10n) => switch (type) {
    ValueType.unixSeconds        => l10n.infoLinkUnixSeconds,
    ValueType.tai                => l10n.infoLinkTai,
    ValueType.gps                => l10n.infoLinkGps,
    ValueType.gmst               => l10n.infoLinkGmst,
    ValueType.julianDate         => l10n.infoLinkJulianDate,
    ValueType.modifiedJulianDate => l10n.infoLinkModifiedJulianDate,
    ValueType.swatchBeats        => l10n.infoLinkSwatchBeats,
    ValueType.binaryClockColumns => l10n.infoLinkBinaryClockColumns,
    ValueType.binaryClockBcd     => l10n.infoLinkBinaryClockBcd,
    ValueType.binaryClockString  => l10n.infoLinkBinaryClockString,
    ValueType.doomsdayClock      => l10n.infoLinkDoomsdayClock,
    _                            => null,
  };

  // Computes the display value string.
  String computeValue(
      DateTime now,
      String locale, {
        bool hourFormat24 = true,
        bool thousandsSep = true,
        String localIanaZone = 'UTC', // used for ZoneLocal to get proper abbr
      }) {
    final utcNow = now.toUtc();

    // Zone-independent values.
    switch (type) {
      case ValueType.unixSeconds:
        final v = TimeUtils.unixTimestamp(utcNow);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.tai:
        final v = TimeUtils.taiSeconds(utcNow);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.gps:
        final v = TimeUtils.gpsTime(utcNow);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.gmst:
        return TimeUtils.hoursToHms(TimeUtils.gmst(utcNow));
      case ValueType.julianDate:
        return NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 5)
            .format(TimeUtils.julianDate(utcNow));
      case ValueType.modifiedJulianDate:
        return NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 5)
            .format(TimeUtils.modifiedJulianDate(utcNow));
      case ValueType.swatchBeats:
        return '@${TimeUtils.swatchBeats(utcNow).toStringAsFixed(0)}';
      case ValueType.doomsdayClock:
        return TimeUtils.doomsDayClockString(hourFormat24);
      case ValueType.binaryClockColumns:
      case ValueType.binaryClockBcd:
      default:
        break;
    }

    // Zone-dependent values.
    final DateTime dt;
    String tzLabel;
    final Duration offset;

    switch (zone) {
      case ZoneLocal():
        dt = now;
        // Use the IANA zone to get the correct abbreviation on all platforms,
        // including web where now.timeZoneName may be fully localized.
        try {
          final tzLocation = tz.getLocation(localIanaZone);
          final tzDt = tz.TZDateTime.from(now.toUtc(), tzLocation);
          tzLabel = tzDt.timeZone.abbreviation;
        } catch (_) {
          tzLabel = now.timeZoneName; // fallback
        }
        offset = now.timeZoneOffset;
      case ZoneUtc():
        dt = utcNow;
        tzLabel = 'UTC';
        offset = Duration.zero;
      case ZoneNamed(ianaZone: final z):
        final tzDt = TimeUtils.inZone(utcNow, z);
        dt = tzDt;
        tzLabel = tzDt.timeZone.abbreviation;
        offset = tzDt.timeZoneOffset;
    }

    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    final ss = dt.second.toString().padLeft(2, '0');
    final tzSuffix = '$tzLabel (${TimeUtils.utcOffsetString(offset)})';

    switch (type) {
      case ValueType.date:
        return TimeUtils.formatDate(locale, dt);
      case ValueType.time:
        if (!hourFormat24) {
          String hourFormat12 = TimeUtils.formatTime12h(dt.hour, mm, ss, tzSuffix);
          return hourFormat12;
        }
        return '$hh:$mm:$ss $tzSuffix';
      case ValueType.dateTime:
        final dateStr = TimeUtils.formatDate(locale, dt);
        if (!hourFormat24) {
          String hourFormat12 = TimeUtils.formatTime12h(dt.hour, mm, ss, tzSuffix);
          return '$dateStr $hourFormat12';
        }
        return '$dateStr $hh:$mm:$ss $tzSuffix';
      case ValueType.daySecond:
        final v = TimeUtils.daySecond(dt);
        return thousandsSep
            ? NumberFormat.decimalPattern(locale).format(v)
            : v.toString();
      case ValueType.dayPercent:
        return NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 3)
            .format(TimeUtils.dayPercent(dt));
      case ValueType.binaryClockString:
        return TimeUtils.binaryTimeString(dt);
      default:
        return '';
    }
  }

  bool get useThousands => switch (type) {
    ValueType.daySecond          => true,
    ValueType.unixSeconds        => true,
    ValueType.tai                => true,
    ValueType.gps                => true,
    ValueType.julianDate         => true, // working even without this?
    ValueType.modifiedJulianDate => true, // working even without this?
    _                            => false,
  };
}

// Default entries for the Civil tab.
const defaultCivilEntries = [
  TimeEntry(type: ValueType.date,       zone: ZoneLocal()),
  TimeEntry(type: ValueType.time,       zone: ZoneLocal()),
  TimeEntry(type: ValueType.daySecond,  zone: ZoneLocal()),
  TimeEntry(type: ValueType.dayPercent, zone: ZoneLocal()),
  TimeEntry(type: ValueType.time,       zone: ZoneUtc()),
  TimeEntry(type: ValueType.daySecond,  zone: ZoneUtc()),
];

extension ValueTypeProps on ValueType {
  bool get isZoneIndependent => switch (this) {
    ValueType.date               => false,
    ValueType.time               => false,
    ValueType.dateTime           => false,
    ValueType.daySecond          => false,
    ValueType.dayPercent         => false,
    ValueType.unixSeconds        => true,
    ValueType.tai                => true,
    ValueType.gps                => true,
    ValueType.gmst               => true,
    ValueType.julianDate         => true,
    ValueType.modifiedJulianDate => true,
    ValueType.swatchBeats        => true,
    ValueType.binaryClockString  => false,
    ValueType.binaryClockColumns => false,
    ValueType.binaryClockBcd     => false,
    ValueType.doomsdayClock      => true,
  };
}