import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeModeKey = 'theme_mode';
const _kThousandsSepKey = 'thousands_sep';
const _kHourFormatKey = 'hour_format_24';

Future<ThemeMode> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString(_kThemeModeKey);
  return switch (value) {
    'light' => ThemeMode.light,
    'dark'  => ThemeMode.dark,
    _       => ThemeMode.system,
  };
}

Future<void> saveThemeMode(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  final value = switch (mode) {
    ThemeMode.light  => 'light',
    ThemeMode.dark   => 'dark',
    ThemeMode.system => 'system',
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