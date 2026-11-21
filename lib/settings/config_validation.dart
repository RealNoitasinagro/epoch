import 'package:timezone/timezone.dart' as tz;
import '../l10n/app_localizations.dart';
import '../models/tab_config.dart';
import '../models/time_value.dart';
import '../time/effective_clock.dart';
import 'app_settings.dart';
import 'night_mode_schedule.dart';
import 'time_shift_start.dart';

typedef _Check = bool Function(Object? value);

bool _isBool(Object? value) => value is bool;

bool _isString(Object? value) => value is String;

bool _isStringList(Object? value) =>
    value is List && value.every((entry) => entry is String);

_Check _isNumberIn(double min, double max) =>
    (value) => value is num && value >= min && value <= max;

_Check _isOneOf(Iterable<String> names) =>
    (value) => value is String && names.contains(value);

/// Whether every tab string is complete: a tab that cannot be read, or an
/// entry in it that cannot be read, would silently disappear.
bool _areUsableTabs(Object? value) {
  if (!_isStringList(value)) return false;
  return (value as List).cast<String>().every((row) {
    final tab = TabConfig.fromPrefsString(row);
    if (tab == null) return false;
    final builtinKindUnknown =
        row.split('\t')[2].isNotEmpty && tab.builtinKind == null;
    return !builtinKindUnknown &&
        tab.entries.length == row.split('\t').length - 4;
  });
}

bool _isUsableMoment(Object? value) {
  if (value is! String) return false;
  if (value.isEmpty) return true; // deliberate: do not shift the time
  final moment = parseTimeShiftMoment(value);
  return moment != null && EffectiveClock.isSupported(moment);
}

/// How to tell a usable value for each known key. Keys of older app versions
/// (migrated on import) are included.
final Map<String, _Check> _configChecks = {
  'active_tab': (value) => value is int,
  'all_tabs': _areUsableTabs,
  'civil_tab_entries': _isStringList,
  'custom_tabs': _isStringList,
  'date_cw_doy': _isBool,
  'date_format': _isString, // any text is used: nonsense in a config may stay
  'day_quarter_color': _isBool,
  'focus_brightness': _isNumberIn(kMinFocusBrightness, kMaxFocusBrightness),
  'focus_color': (value) =>
      value is int && value >= 0 && value <= kMaxArgbValue,
  'focus_color_mode': _isOneOf(FocusColorMode.values.map((mode) => mode.name)),
  'focus_pixel_shift': _isBool,
  'focus_time_shift_indicator': _isBool,
  'hour_format_24': _isBool,
  'last_export_dir': _isString,
  'last_imported_config': _isString,
  'lmst_lon': _isNumberIn(-kMaxLongitude, kMaxLongitude),
  'lmst_longitude': _isNumberIn(-kMaxLongitude, kMaxLongitude),
  'lmst_mode': _isOneOf(LmstMode.values.map((mode) => mode.name)),
  'locale': (value) =>
      value is String &&
      AppLocalizations.supportedLocales.any(
        (locale) => locale.languageCode == value,
      ),
  'night_mode_end': (value) =>
      value is String && parseMinuteOfDay(value) != null,
  'night_mode_start': (value) =>
      value is String && parseMinuteOfDay(value) != null,
  'optional_part_hidden': _isStringList,
  'startup_focus_value': (value) =>
      value is String &&
      (value.isEmpty || TimeValue.fromPrefsString(value) != null),
  'theme_mode': _isOneOf(AppThemeMode.values.map((mode) => mode.name)),
  'thousands_sep': _isBool,
  'time_format': _isString,
  'time_shift_frozen': _isBool,
  'time_shift_moment': _isUsableMoment,
  'time_shift_zone': (value) =>
      value is String &&
      (value.isEmpty || tz.timeZoneDatabase.locations.containsKey(value)),
  'time_shift_zone_as_local': _isBool,
  'zone_display': _isString,
  'zone_display_mode': _isOneOf(
    ZoneDisplayMode.values.map((mode) => mode.name),
  ),
};

/// The keys of [config] whose value cannot be used (wrong type, out of range,
/// not parsable): the app ignores them and the default applies. Sorted.
/// Unknown keys are not reported: renaming a key is the documented way to
/// "comment out" a setting. Needs the time zone data to be initialized.
List<String> findIgnoredConfigKeys(Map<String, dynamic> config) => [
  for (final entry in config.entries)
    if (_configChecks[entry.key] case final check? when !check(entry.value))
      entry.key,
]..sort();
