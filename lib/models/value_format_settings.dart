import 'app_settings.dart';
import 'time_value.dart';

/// The global settings that decide how a value is turned into text.
/// Resolved once by the app and handed down, instead of passing eight
/// parameters from widget to widget.
class ValueFormatSettings {
  final bool hourFormat24;
  final bool thousandsSep;
  final String dateFormat;
  final String timeFormat;
  final ZoneDisplayMode zoneDisplayMode;
  final bool dateWithDetails;
  final String localIanaZone;
  final double? longitude;

  /// Value types whose seconds or decimals are hidden unless the value
  /// itself says otherwise.
  final Set<ValueType> optionalPartHiddenTypes;

  const ValueFormatSettings({
    this.hourFormat24 = kDefaultHourFormat24,
    this.thousandsSep = kDefaultThousandsSep,
    this.dateFormat = kDatePatternIso,
    this.timeFormat = kTimePatternFull,
    this.zoneDisplayMode = kDefaultZoneDisplayMode,
    this.dateWithDetails = kDefaultDateWithDetails,
    this.localIanaZone = 'UTC',
    this.longitude,
    this.optionalPartHiddenTypes = const {},
  });

  /// Whether the optional part (seconds or decimals) of [timeValue] is shown:
  /// its own choice wins, otherwise the global default for its type applies.
  bool showsOptionalPart(TimeValue timeValue) {
    return timeValue.showOptionalPart ??
        !optionalPartHiddenTypes.contains(timeValue.valueType);
  }
}
