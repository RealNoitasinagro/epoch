import 'package:epoch/models/tab_entry.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/screens/configurable_tab.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const time = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
  const timeRemaining = TimeValue(
    valueType: ValueType.time,
    zone: ZoneUtc(),
    options: ValueOptions(remaining: true),
  );
  const divider = TabDivider(id: 'a');

  const swatchBeats = TimeValue(
    valueType: ValueType.swatchBeats,
    zone: ZoneUtc(),
  );
  const swatchBeatsRemaining = TimeValue(
    valueType: ValueType.swatchBeats,
    zone: ZoneUtc(),
    options: ValueOptions(remaining: true),
  );

  group('uniqueEntryIds', () {
    test('entries that differ keep their keys', () {
      expect(uniqueEntryIds([time, timeRemaining, divider]), [
        'time/utc',
        'time/utc/rem',
        'divider:a',
      ]);

      expect(uniqueEntryIds([swatchBeats, swatchBeatsRemaining]), [
        'swatchBeats/utc',
        'swatchBeats/utc/rem',
      ]);
    });

    test('repeated entries get a counter, the first keeps its key', () {
      expect(uniqueEntryIds([time, time, divider, time]), [
        'time/utc',
        'time/utc#1',
        'divider:a',
        'time/utc#2',
      ]);
    });
  });

  group('firstDuplicateValue', () {
    test('a value and its remaining time are no duplicates', () {
      expect(firstDuplicateValue([time, timeRemaining]), isNull);
    });

    test('dividers and section headers are never duplicates', () {
      expect(firstDuplicateValue([divider, divider]), isNull);
    });

    test('finds the second occurrence', () {
      expect(firstDuplicateValue([time, timeRemaining, time]), time);
    });
  });
}
