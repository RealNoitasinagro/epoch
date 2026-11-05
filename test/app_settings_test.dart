import 'package:epoch/layout_constants.dart';
import 'package:epoch/models/app_settings.dart';
import 'package:epoch/models/time_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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

  test('hidden optional parts: round trip, unknown names and types without one are dropped', () async {
    SharedPreferences.setMockInitialValues({
      'optional_part_hidden': ['time','swatchBeats', 'date', 'noSuchType'],
    });
    expect(
      await loadOptionalPartHiddenTypes(),
      {ValueType.swatchBeats},
    );

    await saveOptionalPartHiddenTypes({ValueType.swatchBeats, ValueType.dayMinute});
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList('optional_part_hidden'), ['dayMinute', 'swatchBeats']);
  });
}
