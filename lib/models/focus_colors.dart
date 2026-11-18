import 'dart:math';
import 'package:flutter/painting.dart';
import '../layout_constants.dart';

/// The solid colors of the Focus screen palette, in the order shown.
const focusSolidColors = [
  kColorWhite,
  kColorNightRed,
  kColorOrange,
  kColorAmber,
  kColorMatrixGreen,
  kColorCyan,
  kColorGrey,
  kColorMagenta,
  kColorViolet,
  kColorAzure,
];

/// A random solid color, never [exclude]: every start looks different.
Color pickRandomFocusColor(Random random, {Color? exclude}) {
  final candidates = focusSolidColors.where((color) => color != exclude).toList();
  return candidates[random.nextInt(candidates.length)];
}
