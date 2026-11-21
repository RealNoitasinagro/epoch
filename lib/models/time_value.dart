import '../time/time_utils.dart';
import '../time/zone_rules.dart';
import '../time_zone_search/generated/iana_links_snapshot.g.dart';
import 'tab_entry.dart';
import 'value_options.dart';
export 'value_options.dart';

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

// A single displayable entry: type, zone and the options of the user.
class TimeValue implements TabEntry {
  final ValueType valueType;
  final ZoneSpec zone;
  final ValueOptions options;

  const TimeValue({
    required this.valueType,
    required this.zone,
    this.options = ValueOptions.none,
  });

  // Shortcuts for the options that are read most often.
  String? get customLabel => options.customLabel;
  TimezoneClockChangeMode get timezoneClockChangeMode =>
      options.timezoneClockChangeMode;
  bool? get showOptionalPart => options.showOptionalPart;
  bool? get showDetails => options.showDetails;
  bool get remaining => options.remaining;

  // Type and zone; the options that make a different value are added in
  // [key]. The label and the display options do not matter here.
  String get _baseKey {
    final z = switch (zone) {
      ZoneLocal() => 'local',
      ZoneUtc() => 'utc',
      ZoneNamed(ianaZone: final s) => 'named:$s',
    };
    return '${valueType.name}/$z';
  }

  // Unique key for deduplication within a tab.
  @override
  String get key => '$_baseKey${options.identitySuffix}';

  bool sameZoneAndType(TimeValue other) => _baseKey == other._baseKey;

  // Serialisation: see ValueOptions.splitPrefsString for the syntax.
  @override
  String toPrefsString() => options.appendTo(_baseKey);

  static TimeValue? fromPrefsString(String s) {
    final (:keyPart, :options) = ValueOptions.splitPrefsString(s);
    final parts = keyPart.split('/');
    if (parts.length < 2) return null;
    final valueType = ValueType.values
        .where((candidate) => candidate.name == parts[0])
        .firstOrNull;
    if (valueType == null) return null;

    final zoneText = parts.sublist(1).join('/');
    final ZoneSpec zone;
    if (zoneText == 'local') {
      zone = const ZoneLocal();
    } else if (zoneText == 'utc') {
      zone = const ZoneUtc();
    } else if (zoneText.startsWith('named:')) {
      zone = ZoneNamed(zoneText.substring('named:'.length));
    } else {
      return null;
    }
    return TimeValue(valueType: valueType, zone: zone, options: options);
  }

  TimeValue withOptions(ValueOptions newOptions) =>
      TimeValue(valueType: valueType, zone: zone, options: newOptions);

  TimeValue withCustomLabel(String? label) =>
      withOptions(options.copyWith(customLabel: NewValue(label)));

  TimeValue withTimezoneClockChangeMode(TimezoneClockChangeMode mode) =>
      withOptions(options.copyWith(timezoneClockChangeMode: mode));

  TimeValue withShowOptionalPart(bool? value) =>
      withOptions(options.copyWith(showOptionalPart: NewValue(value)));

  TimeValue withShowDetails(bool? value) =>
      withOptions(options.copyWith(showDetails: NewValue(value)));

  TimeValue withRemaining(bool value) =>
      withOptions(options.copyWith(remaining: value));

  /// The IANA zone whose rules apply to this value; null for UTC.
  String? ianaZoneFor(String localIanaZone) {
    return switch (zone) {
      ZoneLocal() => localIanaZone,
      ZoneNamed(ianaZone: final zoneName) => zoneName,
      ZoneUtc() => null,
    };
  }

  // Whether this type is zone-independent (Technical/Astronomical/Curiosities).
  bool get isZoneIndependent => valueType.isZoneIndependent;

  TimezoneClockChangeMode effectiveClockChangeMode(
    DateTime nowUtc,
    String localIanaZone,
  ) {
    if (timezoneClockChangeMode == TimezoneClockChangeMode.auto) {
      return TimezoneClockChangeMode.auto;
    }
    final ianaZone = ianaZoneFor(localIanaZone);
    final hasDst =
        ianaZone != null &&
        TimeUtils.hasDaylightSavingTime(ianaZone, referenceUtc: nowUtc);
    return hasDst ? timezoneClockChangeMode : TimezoneClockChangeMode.auto;
  }

  bool isPinned(DateTime nowUtc, String localIanaZone) =>
      effectiveClockChangeMode(nowUtc, localIanaZone) !=
      TimezoneClockChangeMode.auto;

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
}

extension ValueTypeProps on ValueType {
  bool get isZoneIndependent => switch (this) {
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

  OptionalPart get optionalPart => switch (this) {
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
  bool get hasDetailsLine => switch (this) {
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

  /// Values that can show what is left of the day instead of what has elapsed.
  bool get supportsRemaining => switch (this) {
    ValueType.time ||
    ValueType.daySecond ||
    ValueType.dayMinute ||
    ValueType.dayPercent ||
    ValueType.decimalTime ||
    ValueType.swatchBeats ||
    ValueType.newEarthTime ||
    ValueType.doomsdayClock => true,
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
