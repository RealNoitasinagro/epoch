import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleKey = 'locale';
const _kThemeModeKey = 'theme_mode';
const _kThousandsSepKey = 'thousands_sep';
const _kHourFormatKey = 'hour_format_24';
const _kDateWithDetails = 'date_cw_doy';
const _kLmstModeKey = 'lmst_mode';       // 'off', 'manual', 'gps'
const _kLmstLongitudeKey = 'lmst_lon';   // double
const _kActiveTabKey = 'active_tab';

const kDefaultLocale = Locale('en');
const kDefaultThemeMode = AppThemeMode.system;
const kDefaultThousandsSep = true;
const kDefaultHourFormat24 = true;
const kDefaultDateWithDetails = true;
const kDefaultLmstMode = LmstMode.off;

// Extended theme mode including night (red-on-black) mode.
enum AppThemeMode { system, light, dark, night }

enum LmstMode { off, manual, gps }

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

Future<bool> loadThousandsSep() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kThousandsSepKey) ?? true;
}

Future<void> saveThousandsSep(bool enabled) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kThousandsSepKey, enabled);
}

Future<bool> loadHourFormat24() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kHourFormatKey) ?? true;
}

Future<void> saveHourFormat24(bool use24) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kHourFormatKey, use24);
}

Future<bool> loadDateWithDetails() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kDateWithDetails) ?? true;
}

Future<void> saveDateWithDetails(bool showDetails) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_kDateWithDetails, showDetails);
}

Future<LmstMode> loadLmstMode() async {
  final prefs = await SharedPreferences.getInstance();
  return switch (prefs.getString(_kLmstModeKey)) {
    'manual' => LmstMode.manual,
    'gps'    => LmstMode.gps,
    _        => LmstMode.off,
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
