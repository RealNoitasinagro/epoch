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
}
