import 'dart:ui';
import 'package:epoch/settings/app_settings.dart';
import 'package:epoch/settings/tolerant_prefs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('values of the wrong type count as missing', () async {
    SharedPreferences.setMockInitialValues({
      'a': 'text',
      'b': 5,
      'c': 1.5,
      'd': ['x', 3],
    });
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.tolerantBool('a'), isNull);
    expect(prefs.tolerantInt('a'), isNull);
    expect(prefs.tolerantString('b'), isNull);
    expect(prefs.tolerantInt('c'), isNull);
    expect(prefs.tolerantStringList('d'), isNull);
    expect(prefs.tolerantStringList('missing'), isNull);
  });

  test('an integer is a valid double', () async {
    SharedPreferences.setMockInitialValues({'x': 1});
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.tolerantDouble('x'), 1.0);
  });

  test('focus values from a config are made usable', () async {
    SharedPreferences.setMockInitialValues({
      'focus_brightness': 5, // integer, out of range
      'focus_color': 0x00FF41, // no alpha byte
    });
    expect(await loadFocusBrightness(false), kDefaultFocusBrightness);
    expect(await loadFocusColor(false), const Color(0xFF00FF41));
  });
}
