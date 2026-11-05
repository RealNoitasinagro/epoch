import 'app_settings.dart';
import 'time_value.dart';

/// The global settings that decide how a value is turned into text.
/// Resolved once by the app and handed down, instead of passing eight
/// parameters from widget to widget.
class ValueFormatSettings {
  final String localIanaZone;
  final String dateFormat;
  final bool dateWithDetails;
  final String timeFormat;
  final bool hourFormat24;
  final bool thousandsSep;
  final ZoneDisplayMode zoneDisplayMode;
  final double? longitude;
  final Set<ValueType> optionalPartHiddenTypes;

  /// Value types whose seconds or decimals are hidden unless the value
  /// itself says otherwise.
  const ValueFormatSettings({
    this.localIanaZone = 'UTC',
    this.dateFormat = kDatePatternIso,
    this.dateWithDetails = kDefaultDateWithDetails,
    this.timeFormat = kTimePatternFull,
    this.hourFormat24 = kDefaultHourFormat24,
    this.thousandsSep = kDefaultThousandsSep,
    this.zoneDisplayMode = kDefaultZoneDisplayMode,
    this.longitude,
    this.optionalPartHiddenTypes = const {},
  });

  /// Whether the optional part (seconds or decimals) of [timeValue] is shown:
  /// its own choice wins, otherwise the global default for its type applies.
  bool showsOptionalPart(TimeValue timeValue) {
    return timeValue.showOptionalPart ??
        !optionalPartHiddenTypes.contains(timeValue.valueType);
  }

  /// Whether the details line of a value of this type is shown when the value
  /// itself does not say otherwise.
  bool showsDetailsByDefault(ValueType valueType) {
    return switch (valueType) {
      ValueType.date => dateWithDetails,
      ValueType.gmst || ValueType.lmst => true,
      _ => zoneDisplayMode != ZoneDisplayMode.hidden,
    };
  }

  /// Whether the details line of [timeValue] is shown: its own choice wins,
  /// otherwise the global settings decide.
  bool showsDetails(TimeValue timeValue) {
    return timeValue.showDetails ?? showsDetailsByDefault(timeValue.valueType);
  }

  /// The time zone display mode that applies to [timeValue]. A value that
  /// shows its details although the global mode is "hidden" gets the full form.
  ZoneDisplayMode zoneDisplayModeFor(TimeValue timeValue) {
    if (!showsDetails(timeValue)) return ZoneDisplayMode.hidden;
    if (zoneDisplayMode == ZoneDisplayMode.hidden) return ZoneDisplayMode.full;
    return zoneDisplayMode;
  }
}
