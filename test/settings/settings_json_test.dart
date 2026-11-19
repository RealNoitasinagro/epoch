import 'package:epoch/settings/settings_json.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

void main() {
  setUpAll(tzd.initializeTimeZones);

  group('importSettingsJson', () {
    test('a JSON array, or no JSON at all, is not a config', () async {
      SharedPreferences.setMockInitialValues({});
      expect(() => importSettingsJson('[1, 2]'), throwsFormatException);
      expect(() => importSettingsJson('garbage'), throwsFormatException);
    });

    test('everything is replaced, unusable values are reported', () async {
      SharedPreferences.setMockInitialValues({'locale': 'en'});
      final ignored = await importSettingsJson(
          '{"theme_mode": "night", "focus_color": "x", "thousands_sep": false}');
      expect(ignored, ['focus_color']);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.get('theme_mode'), 'night');
      expect(prefs.containsKey('locale'), isFalse);
    });
  });
}
