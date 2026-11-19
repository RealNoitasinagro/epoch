import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/layout_constants.dart';
import '../models/time_value.dart';
import '../platform/platform_utils.dart';
import 'night_mode_schedule.dart';
import 'tolerant_prefs.dart';

const _kActiveTabKey = 'active_tab';
const _kDateFormatKey = 'date_format';
const _kDateWithDetails = 'date_cw_doy';
const _kDayQuarterColorKey = 'day_quarter_color';
const _kFocusBrightnessKey = 'focus_brightness';
const _kFocusColorKey = 'focus_color';
const _kFocusColorModeKey = 'focus_color_mode';
const _kFocusPixelShiftKey = 'focus_pixel_shift';
const _kFocusTimeShiftIndicatorKey = 'focus_time_shift_indicator';
const _kHourFormatKey = 'hour_format_24';
const _kLastImportedConfigKey = 'last_imported_config';
const _kLmstLongitudeKey = 'lmst_longitude';
const _kLmstModeKey = 'lmst_mode';
const _kLocaleKey = 'locale';
const _kNightModeEndKey = 'night_mode_end';
const _kNightModeStartKey = 'night_mode_start';
const _kOptionalPartHiddenKey = 'optional_part_hidden';
const _kStartupFocusValueKey = 'startup_focus_value';
const _kThemeModeKey = 'theme_mode';
const _kThousandsSepKey = 'thousands_sep';
const _kTimeFormatKey = 'time_format';
const _kZoneDisplayModeKey = 'zone_display_mode';

const kDefaultDateWithDetails = true;
const kDefaultDayQuarterColor = true;
const kDefaultFocusBrightness = 0.5;
const kDefaultFocusBrightnessNight = 0.1;
const kDefaultFocusColorLight = kColorWhite;
const kDefaultFocusColorNight = kColorNightRed;
const kDefaultFocusTimeShiftIndicator = true;
const kDefaultHourFormat24 = true;
const kDefaultLmstMode = LmstMode.off;
const kDefaultLocale = Locale('en');
const kDefaultThemeMode = AppThemeMode.system;
const kDefaultThousandsSep = true;
const kDefaultZoneDisplayMode = ZoneDisplayMode.full;
final kDefaultFocusPixelShift = !kIsWeb && Platform.isAndroid;

const kDatePatternIso      = 'EEE, YYYY-MM-DD';  // Tue, 2026-07-29
const kDatePatternDe       = 'EEE, DD.MM.YYYY';  // Di., 29.07.2026
const kDatePatternUk       = 'EEE, DD/MM/YYYY';  // Tue, 29/07/2026
const kDatePatternUs       = 'EEE, MM/DD/YYYY';  // Tue, 07/29/2026
const kDatePatternIsoTight = 'YYYY-MM-DD';       // 2026-07-29
const kDatePatternCompact  = 'YYYYMMDD';         // 20260729

const kTimePatternFull          = 'HH:mm:ss';    // 14:05:09
const kTimePatternNoSeconds     = 'HH:mm';       // 14:05
const kTimePatternNoLeadingZero = 'H:mm:ss';     // 9:05:09 -> 14:05:09
const kTimePatternCompact       = 'HHmm';        // 1405

// Extended theme mode including night (red-on-black) mode.
enum AppThemeMode { system, light, dark, night }

enum ZoneDisplayMode {
  full,              // CEST (UTC+02:00)  – default
  abbreviation,      // CEST
  offsetLong,        // UTC+02:00
  offsetShort,       // +02:00
  offsetMini,        // +2
  hidden,            // (empty)
}

enum LmstMode { off, manual, locationAccess }

/// How the Focus screen gets its color: a fixed one, one that follows the
/// quarter of the day, or a random one at every start.
enum FocusColorMode { fixed, dayQuarter, random }


Future<Locale?> loadLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final code = prefs.tolerantString(_kLocaleKey);
  if (code == null) return null;
  return Locale(code);
}

Future<void> saveLocale(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLocaleKey, languageCode);
}

Future<void> clearLocale() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_kLocaleKey);
}

Future<AppThemeMode> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.tolerantString(_kThemeModeKey);
  return switch (value) {
    'light' => AppThemeMode.light,
    'dark'  => AppThemeMode.dark,
    'night' => AppThemeMode.night,
    _       => kDefaultThemeMode,
  };
}

Future<void> saveThemeMode(AppThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  final value = switch (mode) {
    AppThemeMode.light  => 'light',
    AppThemeMode.dark   => 'dark',
    AppThemeMode.night  => 'night',
    AppThemeMode.system => 'system',
  };
  await prefs.setString(_kThemeModeKey, value);
}

Future<NightModeSchedule> loadNightModeSchedule() async {
  final prefs = await SharedPreferences.getInstance();
  // get() and a type check instead of getString(): a hand-edited config may
  // hold something else than a string.
  int? minuteOfDay(String key) {
    final value = prefs.get(key);
    return parseMinuteOfDay(value is String ? value : null);
  }
  return NightModeSchedule(
    startMinute: minuteOfDay(_kNightModeStartKey),
    endMinute: minuteOfDay(_kNightModeEndKey),
  );
}

Future<void> saveNightModeSchedule(NightModeSchedule schedule) async {
  final prefs = await SharedPreferences.getInstance();
  Future<void> save(String key, int? minuteOfDay) => minuteOfDay == null
      ? prefs.remove(key)
      : prefs.setString(key, formatMinuteOfDay(minuteOfDay));
  await save(_kNightModeStartKey, schedule.startMinute);
  await save(_kNightModeEndKey, schedule.endMinute);
}

Future<bool> loadHourFormat24() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantBool(_kHourFormatKey) ?? kDefaultHourFormat24;
}

Future<void> saveHourFormat24(bool use24) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kHourFormatKey, use24);
}

Future<bool> loadThousandsSep() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantBool(_kThousandsSepKey) ?? kDefaultThousandsSep;
}

Future<void> saveThousandsSep(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kThousandsSepKey, enabled);
}

Future<bool> loadDateWithDetails() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantBool(_kDateWithDetails) ?? kDefaultDateWithDetails;
}

Future<void> saveDateWithDetails(bool showDetails) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kDateWithDetails, showDetails);
}

Future<String> loadDateFormat() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantString(_kDateFormatKey) ?? kDatePatternIso;
}

Future<void> saveDateFormat(String pattern) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kDateFormatKey, pattern);
}

Future<String> loadTimeFormat() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantString(_kTimeFormatKey) ?? kTimePatternFull;
}

Future<void> saveTimeFormat(String pattern) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kTimeFormatKey, pattern);
}

Future<ZoneDisplayMode> loadZoneDisplayMode() async {
  final prefs = await SharedPreferences.getInstance();
  return switch (prefs.tolerantString(_kZoneDisplayModeKey)) {
    'abbreviation' => ZoneDisplayMode.abbreviation,
    'offsetLong'   => ZoneDisplayMode.offsetLong,
    'offsetShort'  => ZoneDisplayMode.offsetShort,
    'offsetMini'   => ZoneDisplayMode.offsetMini,
    'hidden'       => ZoneDisplayMode.hidden,
    _              => kDefaultZoneDisplayMode,  // full
  };
}

Future<void> saveZoneDisplayMode(ZoneDisplayMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kZoneDisplayModeKey, mode.name);
}

Future<bool> loadDayQuarterColor() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantBool(_kDayQuarterColorKey) ?? kDefaultDayQuarterColor;
}

Future<void> saveDayQuarterColor(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kDayQuarterColorKey, enabled);
}

Future<LmstMode> loadLmstMode() async {
  final prefs = await SharedPreferences.getInstance();
  LmstMode mode = switch (prefs.tolerantString(_kLmstModeKey)) {
    'manual'         => LmstMode.manual,
    'locationAccess' => LmstMode.locationAccess,
    _                => kDefaultLmstMode,
  };
  // locationAccess has no meaning on desktop platforms (no location API) –
  // silently degrade to manual so the longitude field is at least visible,
  // rather than leaving the radio group with no selection at all:
  if (mode == LmstMode.locationAccess && isDesktopPlatform) {
    mode = LmstMode.manual;
    await saveLmstMode(mode);
  }
  return mode;
}

Future<void> saveLmstMode(LmstMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLmstModeKey, mode.name);
}

Future<double?> loadLmstLongitude() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantDouble(_kLmstLongitudeKey);
}

Future<void> saveLmstLongitude(double lon) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(_kLmstLongitudeKey, lon);
}

Future<int> loadActiveTab() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantInt(_kActiveTabKey) ?? 0;
}

Future<void> saveActiveTab(int index) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_kActiveTabKey, index);
}

/// Night mode starts dim: a saved brightness is ignored there.
Future<double> loadFocusBrightness(bool isNightMode) async {
  if (isNightMode) return kDefaultFocusBrightnessNight;
  final prefs = await SharedPreferences.getInstance();
  // A hand-edited value may be out of range (the slider would assert).
  return (prefs.tolerantDouble(_kFocusBrightnessKey) ?? kDefaultFocusBrightness)
      .clamp(0.01, 1.0)
      .toDouble();
}

Future<void> saveFocusBrightness(double brightness) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(_kFocusBrightnessKey, brightness);
}

/// Night mode always starts with night red: a saved color is ignored there.
Future<Color> loadFocusColor(bool isNightMode) async {
  if (isNightMode) return kDefaultFocusColorNight;
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.tolerantInt(_kFocusColorKey);
  // Always opaque: 0x00FF41 without an alpha byte would be invisible.
  return value != null ? Color(0xFF000000 | value) : kDefaultFocusColorLight;
}

Future<void> saveFocusColor(Color color) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_kFocusColorKey, color.toARGB32());
}

/// Night mode always uses its own color: no mode applies there.
Future<FocusColorMode> loadFocusColorMode(bool isNightMode) async {
  if (isNightMode) return FocusColorMode.fixed;
  final prefs = await SharedPreferences.getInstance();
  final name = prefs.tolerantString(_kFocusColorModeKey);
  return FocusColorMode.values
      .where((mode) => mode.name == name)
      .firstOrNull ??
      FocusColorMode.fixed;
}

Future<void> saveFocusColorMode(FocusColorMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kFocusColorModeKey, mode.name);
}

Future<bool> loadFocusPixelShift() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantBool(_kFocusPixelShiftKey) ?? kDefaultFocusPixelShift;
}

Future<void> saveFocusPixelShift(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kFocusPixelShiftKey, enabled);
}

Future<bool> loadFocusTimeShiftIndicator() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantBool(_kFocusTimeShiftIndicatorKey) ??
      kDefaultFocusTimeShiftIndicator;
}

Future<void> saveFocusTimeShiftIndicator(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kFocusTimeShiftIndicatorKey, enabled);
}

Future<String?> loadLastImportedConfig() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.tolerantString(_kLastImportedConfigKey);
}

Future<void> saveLastImportedConfig(String filename) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLastImportedConfigKey, filename);
}

Future<TimeValue?> loadStartupFocusValue() async {
  final prefs = await SharedPreferences.getInstance();
  final s = prefs.tolerantString(_kStartupFocusValueKey);
  if (s == null || s.isEmpty) return null;
  return TimeValue.fromPrefsString(s);
}

Future<void> saveStartupFocusValue(TimeValue? value) async {
  final prefs = await SharedPreferences.getInstance();
  if (value == null) {
    await prefs.remove(_kStartupFocusValueKey);
  } else {
    await prefs.setString(_kStartupFocusValueKey, value.toPrefsString());
  }
}

Future<Set<ValueType>> loadOptionalPartHiddenTypes() async {
  final prefs = await SharedPreferences.getInstance();
  final names = prefs.tolerantStringList(_kOptionalPartHiddenKey) ?? const [];
  return {
    for (final valueType in ValueType.values)
      if (names.contains(valueType.name) &&
          valueType.optionalPart != OptionalPart.none &&
          !valueType.optionalPartFollowsTimeFormat)
        valueType,
  };
}

Future<void> saveOptionalPartHiddenTypes(Set<ValueType> valueTypes) async {
  final prefs = await SharedPreferences.getInstance();
  // In enum order, so that exported configs are stable.
  final names = [
    for (final valueType in ValueType.values)
      if (valueTypes.contains(valueType)) valueType.name,
  ];
  await prefs.setStringList(_kOptionalPartHiddenKey, names);
}
