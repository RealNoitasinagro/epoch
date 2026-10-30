import 'package:epoch/layout_constants.dart';
import 'package:epoch/models/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('night mode ignores the saved focus color and brightness', () async {
    SharedPreferences.setMockInitialValues({
      'focus_color': kColorWhite.toARGB32(),
      'focus_brightness': 1.0,
    });
    expect(await loadFocusColor(true), kFocusDefaultColorNight);
    expect(await loadFocusBrightness(true), kDefaultFocusBrightnessNight);
    expect(await loadFocusColor(false), kColorWhite);
    expect(await loadFocusBrightness(false), 1.0);
  });
}
