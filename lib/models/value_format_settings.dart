import 'app_settings.dart';

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

  const ValueFormatSettings({
    this.hourFormat24 = kDefaultHourFormat24,
    this.thousandsSep = kDefaultThousandsSep,
    this.dateFormat = kDatePatternIso,
    this.timeFormat = kTimePatternFull,
    this.zoneDisplayMode = kDefaultZoneDisplayMode,
    this.dateWithDetails = kDefaultDateWithDetails,
    this.localIanaZone = 'UTC',
    this.longitude,
  });
}
