import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeModeKey = 'theme_mode';
const _kThousandsSepKey = 'thousands_sep';
const _kHourFormatKey = 'hour_format_24';
const _kLocaleKey = 'locale';

// Extended theme mode including night (red-on-black) mode.
enum AppThemeMode { system, light, dark, night }

Future<AppThemeMode> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString(_kThemeModeKey);
  return switch (value) {
    'light' => AppThemeMode.light,
    'dark'  => AppThemeMode.dark,
    'night' => AppThemeMode.night,
    _       => AppThemeMode.system,
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