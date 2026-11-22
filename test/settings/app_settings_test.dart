import 'package:epoch/app/layout_constants.dart';
import 'package:epoch/models/tab_config.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/settings/app_settings.dart';
import 'package:epoch/settings/night_mode_schedule.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('focus and brightness', () {
    test('night mode ignores the saved focus color and brightness', () async {
      SharedPreferences.setMockInitialValues({
        'focus_color': kColorWhite.toARGB32(),
        'focus_brightness': 1.0,
      });
      expect(await loadFocusColor(true), kDefaultFocusColorNight);
      expect(await loadFocusBrightness(true), kDefaultFocusBrightnessNight);
      expect(await loadFocusColor(false), kColorWhite);
      expect(await loadFocusBrightness(false), 1.0);
    });
  });

  group('focus color mode', () {
    test(
      'focus color mode: default, round trip, night mode, wrong values',
      () async {
        SharedPreferences.setMockInitialValues({});
        expect(await loadFocusColorMode(false), FocusColorMode.fixed);
        await saveFocusColorMode(FocusColorMode.dayQuarter);
        expect(await loadFocusColorMode(false), FocusColorMode.dayQuarter);
        expect(await loadFocusColorMode(true), FocusColorMode.fixed);
        for (final wrong in ['rainbow', 5, true]) {
          SharedPreferences.setMockInitialValues({'focus_color_mode': wrong});
          expect(await loadFocusColorMode(false), FocusColorMode.fixed);
        }
      },
    );
  });

  group('optional part hidden types', () {
    test(
      'hidden optional parts: round trip, unknown names and types without one are dropped',
      () async {
        SharedPreferences.setMockInitialValues({
          'optional_part_hidden': ['time', 'swatchBeats', 'date', 'noSuchType'],
        });
        expect(await loadOptionalPartHiddenTypes(), {ValueType.swatchBeats});

        await saveOptionalPartHiddenTypes({
          ValueType.swatchBeats,
          ValueType.dayMinute,
        });
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getStringList('optional_part_hidden'), [
          'dayMinute',
          'swatchBeats',
        ]);
      },
    );
  });

  group('night mode window', () {
    test(
      'night mode window: round trip, clearing, invalid values are ignored',
      () async {
        SharedPreferences.setMockInitialValues({
          'night_mode_start': '23:00',
          'night_mode_end': 25, // not a string
        });
        var schedule = await loadNightModeSchedule();
        expect(schedule.startMinute, 23 * 60);
        expect(schedule.endMinute, isNull);
        expect(schedule.isActive, isFalse);

        await saveNightModeSchedule(
          const NightModeSchedule(startMinute: 23 * 60, endMinute: 7 * 60),
        );
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('night_mode_end'), '07:00');

        await saveNightModeSchedule(NightModeSchedule.none);
        expect(prefs.containsKey('night_mode_start'), isFalse);
        schedule = await loadNightModeSchedule();
        expect(schedule.isActive, isFalse);
      },
    );
  });

  group('loaders with values of the wrong type', () {
    test('every loader survives values of the wrong type', () async {
      SharedPreferences.setMockInitialValues({
        'active_tab': 'one',
        'all_tabs': 'not a list',
        'date_cw_doy': 'yes',
        'date_format': 5,
        'day_quarter_color': 1,
        'focus_brightness': 'bright',
        'focus_color': '4278248959',
        'focus_color_mode': 3,
        'focus_pixel_shift': 'on',
        'focus_time_shift_indicator': 0,
        'hour_format_24': 'true',
        'last_imported_config': 7,
        'lmst_longitude': 'east',
        'lmst_mode': 3,
        'locale': 1,
        'optional_part_hidden': 'time',
        'startup_focus_value': 9,
        'theme_mode': 2,
        'thousands_sep': 'no',
        'time_format': true,
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
  });
}
