import 'dart:convert';
import 'dart:io';
import 'package:epoch/settings/app_settings.dart';
import 'package:epoch/settings/config_validation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

void main() {
  setUpAll(tzd.initializeTimeZones);

  group('findIgnoredConfigKeys: shipped configs', () {
    final configFiles = Directory('example_configs')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'));
    for (final file in configFiles) {
      test('${file.path} is valid JSON without unusable values', () {
        final config =
            jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        expect(findIgnoredConfigKeys(config), isEmpty);
      });
    }
  });

  group('findIgnoredConfigKeys: types and ranges', () {
    test('wrong types are reported, sorted', () {
      expect(
        findIgnoredConfigKeys({
          'focus_color': '4278248959',
          'active_tab': 'one',
          'thousands_sep': 'no',
          'theme_mode': 3,
          'hour_format_24': null,
        }),
        [
          'active_tab',
          'focus_color',
          'hour_format_24',
          'theme_mode',
          'thousands_sep',
        ],
      );
    });

    test('numbers outside their range are reported', () {
      expect(
        findIgnoredConfigKeys({'focus_brightness': 5, 'lmst_longitude': 200}),
        ['focus_brightness', 'lmst_longitude'],
      );
      expect(
        findIgnoredConfigKeys({'focus_brightness': 0.5, 'lmst_longitude': 8}),
        isEmpty,
      );
    });

    test('unknown keys are not reported: renaming is how to comment out', () {
      expect(
        findIgnoredConfigKeys({'focus_colorooo': 'x', 'whatever': 1}),
        isEmpty,
      );
    });
  });

  group('findIgnoredConfigKeys: contents', () {
    test('patterns, names, times and zones', () {
      expect(
        findIgnoredConfigKeys({
          'theme_mode': 'sepia',
          'night_mode_start': '25:00',
          'time_shift_zone': 'Nowhere/Land',
          'locale': 'fr',
        }),
        ['locale', 'night_mode_start', 'theme_mode', 'time_shift_zone'],
      );
    });

    test('startup focus value and time shift moment: empty is deliberate', () {
      expect(
        findIgnoredConfigKeys({
          'startup_focus_value': '',
          'time_shift_moment': '',
        }),
        isEmpty,
      );
      expect(
        findIgnoredConfigKeys({
          'startup_focus_value': 'gps/uc',
          'time_shift_moment': '2040-01-01T00:00:00Z',
        }),
        ['startup_focus_value', 'time_shift_moment'],
      );
    });

    test('tabs: unreadable tabs and entries are reported', () {
      expect(
        findIgnoredConfigKeys({
          'all_tabs': ['1\t\tcivil\t1\ttime/utc'],
        }),
        isEmpty,
      );
      for (final broken in [
        'only\ttwo',
        '1\t\tbogus\t1',
        '1\t\tcivil\t1\tnot an entry',
      ]) {
        expect(
          findIgnoredConfigKeys({
            'all_tabs': [broken],
          }),
          ['all_tabs'],
          reason: broken,
        );
      }
    });
  });

  group('findIgnoredConfigKeys: the loaders agree', () {
    Future<void> expectIgnored(
      String key,
      Object badValue,
      Future<Object?> Function() load,
      Object? defaultValue,
    ) async {
      SharedPreferences.setMockInitialValues({key: badValue});
      expect(findIgnoredConfigKeys({key: badValue}), [
        key,
      ], reason: 'validator');
      expect(await load(), defaultValue, reason: 'loader');
    }

    test('focus_color', () async {
      for (final bad in [-999, 0x1FFFFFFFF]) {
        await expectIgnored(
          'focus_color',
          bad,
          () => loadFocusColor(false),
          kDefaultFocusColorLight,
        );
      }
    });
    test('focus_brightness', () async {
      for (final bad in [5, 0.0]) {
        await expectIgnored(
          'focus_brightness',
          bad,
          () => loadFocusBrightness(false),
          kDefaultFocusBrightness,
        );
      }
    });
    test('lmst_longitude', () async {
      for (final bad in [200, -181]) {
        await expectIgnored('lmst_longitude', bad, loadLmstLongitude, null);
      }
    });
    test('locale', () async {
      await expectIgnored('locale', 'fr', loadLocale, null);
    });
  });
}
