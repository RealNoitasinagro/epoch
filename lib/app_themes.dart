import 'package:flutter/material.dart';

/// The dark theme of the app; also used by the screen shown when the app
/// cannot start, so that both look the same.
ThemeData buildDarkTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: Brightness.dark
  ),
  useMaterial3: true,
);
