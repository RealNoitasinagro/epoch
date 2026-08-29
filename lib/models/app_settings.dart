import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../layout_constants.dart';
import 'time_value.dart';

const _kLocaleKey = 'locale';
const _kThemeModeKey = 'theme_mode';
const _kHourFormatKey = 'hour_format_24';
const _kThousandsSepKey = 'thousands_sep';
const _kDateWithDetails = 'date_cw_doy';
const _kDateFormatKey = 'date_format';
const _kTimeFormatKey = 'time_format';
const _kZoneDisplayModeKey = 'zone_display_mode';
const _kDayQuarterColorKey = 'day_quarter_color';
const _kLmstModeKey = 'lmst_mode';
const _kLmstLongitudeKey = 'lmst_longitude';  // double
const _kActiveTabKey = 'active_tab';
const _kFocusBrightnessKey = 'focus_brightness';
const _kFocusColorKey = 'focus_color';
const _kFocusPixelShiftKey = 'focus_pixel_shift';
const _kLastImportedConfigKey = 'last_imported_config';
const _kStartupFocusValueKey = 'startup_focus_value';

const kDefaultLocale          = Locale('en');
const kDefaultThemeMode       = AppThemeMode.system;
const kDefaultHourFormat24    = true;
const kDefaultThousandsSep    = true;
const kDefaultDateWithDetails = true;
const kDefaultZoneDisplayMode = ZoneDisplayMode.full;
const kDefaultDayQuarterColor = true;
const kDefaultLmstMode        = LmstMode.off;
const kDefaultFocusBrightness = 0.5;
const kFocusDefaultColorLight = kColorWhite;
const kFocusDefaultColorNight = kColorNightRed;
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


Future<Locale?> loadLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final code = prefs.getString(_kLocaleKey);
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
  final value = prefs.getString(_kThemeModeKey);
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

Future<bool> loadHourFormat24() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kHourFormatKey) ?? kDefaultHourFormat24;
}

Future<void> saveHourFormat24(bool use24) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kHourFormatKey, use24);
}

Future<bool> loadThousandsSep() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kThousandsSepKey) ?? kDefaultThousandsSep;
}

Future<void> saveThousandsSep(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kThousandsSepKey, enabled);
}

Future<bool> loadDateWithDetails() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kDateWithDetails) ?? kDefaultDateWithDetails;
}

Future<void> saveDateWithDetails(bool showDetails) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kDateWithDetails, showDetails);
}

Future<String> loadDateFormat() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_kDateFormatKey) ?? kDatePatternIso;
}

Future<void> saveDateFormat(String pattern) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kDateFormatKey, pattern);
}

Future<String> loadTimeFormat() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_kTimeFormatKey) ?? kTimePatternFull;
}

Future<void> saveTimeFormat(String pattern) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kTimeFormatKey, pattern);
}

Future<ZoneDisplayMode> loadZoneDisplayMode() async {
  final prefs = await SharedPreferences.getInstance();
  return switch (prefs.getString(_kZoneDisplayModeKey)) {
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
  return prefs.getBool(_kDayQuarterColorKey) ?? kDefaultDayQuarterColor;
}

Future<void> saveDayQuarterColor(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kDayQuarterColorKey, enabled);
}

Future<LmstMode> loadLmstMode() async {
  final prefs = await SharedPreferences.getInstance();
  return switch (prefs.getString(_kLmstModeKey)) {
    'manual'         => LmstMode.manual,
    'locationAccess' => LmstMode.locationAccess,
    _                => kDefaultLmstMode,
  };
}

Future<void> saveLmstMode(LmstMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLmstModeKey, mode.name);
}

Future<double?> loadLmstLongitude() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(_kLmstLongitudeKey);
}

Future<void> saveLmstLongitude(double lon) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(_kLmstLongitudeKey, lon);
}

Future<int> loadActiveTab() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(_kActiveTabKey) ?? 0;
}

Future<void> saveActiveTab(int index) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_kActiveTabKey, index);
}

Future<double?> loadFocusBrightness() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(_kFocusBrightnessKey) ?? kDefaultFocusBrightness;
}

Future<void> saveFocusBrightness(double brightness) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(_kFocusBrightnessKey, brightness);
}

Future<Color> loadFocusColor(bool isNightMode) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getInt(_kFocusColorKey);
  if (value != null) return Color(value);
  return isNightMode ? kFocusDefaultColorNight : kFocusDefaultColorLight;
}

Future<void> saveFocusColor(Color color) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_kFocusColorKey, color.toARGB32());
}

Future<bool> loadFocusPixelShift() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kFocusPixelShiftKey) ?? kDefaultFocusPixelShift;
}

Future<void> saveFocusPixelShift(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kFocusPixelShiftKey, enabled);
}

Future<String?> loadLastImportedConfig() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_kLastImportedConfigKey);
}

Future<void> saveLastImportedConfig(String filename) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLastImportedConfigKey, filename);
}

Future<TimeValue?> loadStartupFocusValue() async {
  final prefs = await SharedPreferences.getInstance();
  final s = prefs.getString(_kStartupFocusValueKey);
  if (s == null) return null;
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
