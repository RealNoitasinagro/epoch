import 'package:epoch/models/time_value.dart';
import 'package:epoch/models/value_format_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const time = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
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
      optionalPartHiddenTypes: {ValueType.time},
    );
    expect(settings.showsOptionalPart(time), isFalse);
    expect(settings.showsOptionalPart(swatchBeats), isTrue);
  });

  test("a value's own choice wins over the global default", () {
    const settings = ValueFormatSettings(
      optionalPartHiddenTypes: {ValueType.time},
    );
    expect(settings.showsOptionalPart(timeShown), isTrue);
  });
}
