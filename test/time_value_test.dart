import 'package:flutter_test/flutter_test.dart';
import 'package:epoch/models/time_value.dart';

void main() {
  group('TimeValue.key', () {
    test('local zone key', () {
      const e = TimeValue(type: ValueType.time, zone: ZoneLocal());
      expect(e.key, equals('time/local'));
    });

    test('utc zone key', () {
      const e = TimeValue(type: ValueType.unixSeconds, zone: ZoneUtc());
      expect(e.key, equals('unixSeconds/utc'));
    });

    test('named zone key', () {
      const e = TimeValue(
          type: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      expect(e.key, equals('time/named:Europe/Berlin'));
    });
  });

  group('TimeValue serialization', () {
    test('roundtrip without label', () {
      const e = TimeValue(type: ValueType.time, zone: ZoneLocal());
      final s = e.toPrefsString();
      final e2 = TimeValue.fromPrefsString(s);
      expect(e2, isNotNull);
      expect(e2!.key, equals(e.key));
      expect(e2.customLabel, isNull);
    });

    test('roundtrip with label', () {
      const e = TimeValue(
          type: ValueType.time,
          zone: ZoneLocal(),
          customLabel: 'My Time');
      final s = e.toPrefsString();
      final e2 = TimeValue.fromPrefsString(s);
      expect(e2!.customLabel, equals('My Time'));
    });

    test('invalid string returns null', () {
      expect(TimeValue.fromPrefsString('garbage'), isNull);
    });
  });

  group('TimeValue.isZoneIndependent', () {
    test('unixSeconds is zone-independent', () {
      const e = TimeValue(type: ValueType.unixSeconds, zone: ZoneUtc());
      expect(e.isZoneIndependent, isTrue);
    });

    test('time is zone-dependent', () {
      const e = TimeValue(type: ValueType.time, zone: ZoneLocal());
      expect(e.isZoneIndependent, isFalse);
    });
  });
}