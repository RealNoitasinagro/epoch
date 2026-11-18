import 'dart:io';
import 'dart:ui';
import 'package:epoch/models/app_settings.dart';
import 'package:epoch/models/tab_config.dart';
import 'package:epoch/models/tolerant_prefs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('values of the wrong type count as missing', () async {
    SharedPreferences.setMockInitialValues({
      'a': 'text', 'b': 5, 'c': 1.5, 'd': ['x', 3],
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

  test('every loader survives values of the wrong type', () async {
    SharedPreferences.setMockInitialValues({
      'active_tab': 'one', 'all_tabs': 'not a list', 'date_cw_doy': 'yes',
      'date_format': 5, 'day_quarter_color': 1, 'focus_brightness': 'bright',
      'focus_color': '4278248959', 'focus_color_mode': 3, 'focus_pixel_shift': 'on',
      'focus_time_shift_indicator': 0, 'hour_format_24': 'true',
      'last_imported_config': 7, 'lmst_longitude': 'east', 'lmst_mode': 3,
      'locale': 1, 'optional_part_hidden': 'time', 'startup_focus_value': 9,
      'theme_mode': 2, 'thousands_sep': 'no', 'time_format': true,
      'zone_display_mode': 1.5,
    });
    expect(await loadActiveTab(), 0);
    expect(await loadFocusColor(false), kDefaultFocusColorLight);
    expect(await loadFocusColorMode(false), FocusColorMode.fixed);
    expect(await loadFocusBrightness(false), kDefaultFocusBrightness);
    expect(await loadHourFormat24(), kDefaultHourFormat24);
    expect(await loadLmstLongitude(), isNull);
    expect(await loadLocale(), isNull);
    expect(await loadStartupFocusValue(), isNull);
    expect(await loadOptionalPartHiddenTypes(), isEmpty);
    expect(await loadAllTabs(), isEmpty);
    expect(await loadDateFormat(), kDatePatternIso);
  });

  test('focus values from a config are made usable', () async {
    SharedPreferences.setMockInitialValues({
      'focus_brightness': 5,       // integer, out of range
      'focus_color': 0x00FF41,     // no alpha byte
    });
    expect(await loadFocusBrightness(false), 1.0);
    expect(await loadFocusColor(false), const Color(0xFF00FF41));
  });

  test('lib reads preferences only through the tolerant helpers', () {
    final offenders = [
      for (final file in Directory('lib').listSync(recursive: true))
        if (file is File &&
            file.path.endsWith('.dart') &&
            !file.path.endsWith('tolerant_prefs.dart') &&
            RegExp(r'\.get(Bool|Int|Double|String|StringList)\(')
                .hasMatch(file.readAsStringSync()))
          file.path,
    ];
    expect(offenders, isEmpty);
  });
}
