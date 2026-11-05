import 'package:flutter/material.dart';
import 'layout_constants.dart';

/// The dark theme of the app; also used by the screen shown when the app
/// cannot start, so that both look the same.
ThemeData buildDarkTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.dark
  ),
  useMaterial3: true,
);


const _nightRed = kColorNightRed;
const _nightRedDim = kColorNightRedDim;

ThemeData buildNightTheme() => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: _nightRed,
    onPrimary: Colors.black,
    secondary: _nightRed,
    onSecondary: Colors.black,
    onSurface: _nightRed,
    outline: _nightRedDim,
    outlineVariant: _nightRedDim,
  ),
  appBarTheme: const AppBarTheme(
    foregroundColor: _nightRed,
    iconTheme: IconThemeData(color: _nightRed),
  ),
  tabBarTheme: const TabBarThemeData(
    labelColor: _nightRed,
    unselectedLabelColor: _nightRedDim,
    indicatorColor: _nightRed,
  ),
  iconTheme: const IconThemeData(color: _nightRed),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: _nightRed, fontFamily: fontFamilyDefault),
    bodyMedium: TextStyle(color: _nightRed),
    bodySmall: TextStyle(color: _nightRedDim),
    labelSmall: TextStyle(color: _nightRedDim),
    labelMedium: TextStyle(color: _nightRed),
  ),
  dividerTheme: const DividerThemeData(color: _nightRedDim),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(_nightRed),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_nightRed),
    trackColor: WidgetStateProperty.all(_nightRedDim),
  ),
  useMaterial3: true,
);
