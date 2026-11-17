import 'package:epoch/layout_constants.dart';
import 'package:epoch/models/app_settings.dart';
import 'package:epoch/models/night_mode_schedule.dart';
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

  test('night mode window: round trip, clearing, invalid values are ignored', () async {
    SharedPreferences.setMockInitialValues({
      'night_mode_start': '23:00',
      'night_mode_end': 25,  // not a string
    });
    var schedule = await loadNightModeSchedule();
    expect(schedule.startMinute, 23 * 60);
    expect(schedule.endMinute, isNull);
    expect(schedule.isActive, isFalse);

    await saveNightModeSchedule(const NightModeSchedule(startMinute: 23 * 60, endMinute: 7 * 60));
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('night_mode_end'), '07:00');

    await saveNightModeSchedule(NightModeSchedule.none);
    expect(prefs.containsKey('night_mode_start'), isFalse);
    schedule = await loadNightModeSchedule();
    expect(schedule.isActive, isFalse);
  });
}
