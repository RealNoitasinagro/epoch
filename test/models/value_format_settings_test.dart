import 'package:epoch/models/app_settings.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/models/value_format_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const time = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
  const dayMinute = TimeValue(valueType: ValueType.dayMinute, zone: ZoneUtc());
  const timeShown = TimeValue(
    valueType: ValueType.time,
    zone: ZoneUtc(),
    showOptionalPart: true,
  );
  const swatchBeats = TimeValue(valueType: ValueType.swatchBeats, zone: ZoneUtc());

  test('everything is shown by default', () {
    const settings = ValueFormatSettings();
    expect(settings.showsOptionalPart(time), isTrue);
  });

  test('the global default applies per value type', () {
    const settings = ValueFormatSettings(
      optionalPartHiddenTypes: {ValueType.dayMinute},
    );
    expect(settings.showsOptionalPart(dayMinute), isFalse);
    expect(settings.showsOptionalPart(swatchBeats), isTrue);
  });

  test("a value's own choice wins over the global default", () {
    const settings = ValueFormatSettings(
      optionalPartHiddenTypes: {ValueType.time},
    );
    expect(settings.showsOptionalPart(timeShown), isTrue);
  });

  test('time and date & time follow the time format', () {
    const dateTime = TimeValue(valueType: ValueType.dateTime, zone: ZoneUtc());
    const withSeconds = ValueFormatSettings(timeFormat: 'HH:mm:ss');
    const withoutSeconds = ValueFormatSettings(timeFormat: 'HH:mm');
    expect(withSeconds.showsOptionalPart(time), isTrue);
    expect(withSeconds.showsOptionalPart(dateTime), isTrue);
    expect(withoutSeconds.showsOptionalPart(time), isFalse);
    expect(withoutSeconds.showsOptionalPart(dateTime), isFalse);
  });

  test("a value's own choice wins over the time format", () {
    const withoutSeconds = ValueFormatSettings(timeFormat: 'HH:mm');
    expect(withoutSeconds.showsOptionalPart(timeShown), isTrue);
  });

  test('the global hidden types do not apply to time', () {
    const settings = ValueFormatSettings(
      timeFormat: 'HH:mm:ss',
      optionalPartHiddenTypes: {ValueType.time},
    );
    expect(settings.showsOptionalPart(time), isTrue);
  });

  group('details line', () {
    const time = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
    const timeShown = TimeValue(
      valueType: ValueType.time,
      zone: ZoneUtc(),
      showDetails: true,
    );
    const timeHidden = TimeValue(
      valueType: ValueType.time,
      zone: ZoneUtc(),
      showDetails: false,
    );
    const date = TimeValue(valueType: ValueType.date, zone: ZoneLocal());
    const gmst = TimeValue(valueType: ValueType.gmst, zone: ZoneUtc());

    test('the global settings are the default for each type', () {
      const hiddenZones = ValueFormatSettings(
        zoneDisplayMode: ZoneDisplayMode.hidden,
        dateWithDetails: false,
      );
      expect(hiddenZones.showsDetails(time), isFalse);
      expect(hiddenZones.showsDetails(date), isFalse);
      expect(hiddenZones.showsDetails(gmst), isTrue);

      const shown = ValueFormatSettings();
      expect(shown.showsDetails(time), isTrue);
      expect(shown.showsDetails(date), isTrue);
    });

    test("a value's own choice wins over the global settings", () {
      const hiddenZones = ValueFormatSettings(
        zoneDisplayMode: ZoneDisplayMode.hidden,
      );
      const shownZones = ValueFormatSettings();
      expect(hiddenZones.showsDetails(timeShown), isTrue);
      expect(shownZones.showsDetails(timeHidden), isFalse);
    });

    test('zone display mode: shown details with a hidden mode use the full form', () {
      const hiddenZones = ValueFormatSettings(
        zoneDisplayMode: ZoneDisplayMode.hidden,
      );
      const abbreviations = ValueFormatSettings(
        zoneDisplayMode: ZoneDisplayMode.abbreviation,
      );
      expect(hiddenZones.zoneDisplayModeFor(timeShown), ZoneDisplayMode.full);
      expect(hiddenZones.zoneDisplayModeFor(time), ZoneDisplayMode.hidden);
      expect(abbreviations.zoneDisplayModeFor(time), ZoneDisplayMode.abbreviation);
      expect(abbreviations.zoneDisplayModeFor(timeHidden), ZoneDisplayMode.hidden);
    });
  });
}
