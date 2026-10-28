import 'dart:ui';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/time_value_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimeValue.key', () {
    test('local zone key', () {
      const e = TimeValue(valueType: ValueType.time, zone: ZoneLocal());
      expect(e.key, equals('time/local'));
    });

    test('utc zone key', () {
      const e = TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc());
      expect(e.key, equals('unixSeconds/utc'));
    });

    test('named zone key', () {
      const e = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      expect(e.key, equals('time/named:Europe/Berlin'));
    });
  });

  group('TimeValue serialization', () {
    test('roundtrip without label', () {
      const e = TimeValue(valueType: ValueType.time, zone: ZoneLocal());
      final s = e.toPrefsString();
      final e2 = TimeValue.fromPrefsString(s);
      expect(e2, isNotNull);
      expect(e2!.key, equals(e.key));
      expect(e2.customLabel, isNull);
    });

    test('roundtrip with label', () {
      const e = TimeValue(
          valueType: ValueType.time,
          zone: ZoneLocal(),
          customLabel: 'My Time');
      final s = e.toPrefsString();
      final e2 = TimeValue.fromPrefsString(s);
      expect(e2!.customLabel, equals('My Time'));
    });

    test('invalid string returns null', () {
      expect(TimeValue.fromPrefsString('garbage'), isNull);
    });

    test('empty label slot (||) means no custom label', () {
      final tv = TimeValue.fromPrefsString('time/named:Europe/Kiev||dst:forceStandard')!;
      expect(tv.customLabel, isNull);
      expect(tv.timezoneClockChangeMode, TimezoneClockChangeMode.forceStandard);
    });

    test('UTC aliases collapse to ZoneUtc, everything else stays', () {
      expect(canonicalZoneSpec(const ZoneNamed('Etc/UTC')), isA<ZoneUtc>());
      expect(canonicalZoneSpec(const ZoneNamed('Zulu')), isA<ZoneUtc>());
      expect(canonicalZoneSpec(const ZoneNamed('Europe/Berlin')), isA<ZoneNamed>());
      expect(canonicalZoneSpec(const ZoneLocal()), isA<ZoneLocal>());
    });
  });

  group('TimeValue.isZoneIndependent', () {
    test('unixSeconds is zone-independent', () {
      const e = TimeValue(valueType: ValueType.unixSeconds, zone: ZoneUtc());
      expect(e.isZoneIndependent, isTrue);
    });

    test('time is zone-dependent', () {
      const e = TimeValue(valueType: ValueType.time, zone: ZoneLocal());
      expect(e.isZoneIndependent, isFalse);
    });

    test('zones without clock change are treated as unpinned', () {
      const e = TimeValue(valueType: ValueType.time, zone: ZoneNamed('Asia/Tokyo'),
          timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard);
      expect(e.isPinned(DateTime.utc(2026), 'UTC'), isFalse);
    });
  });

  group('TimeValueFormatter.hoursToHms', () {
    test('0.0 hours = 00:00:00', () {
      expect(TimeValueFormatter.hoursToHms(0.0), equals('00:00:00'));
    });

    test('12.5 hours = 12:30:00', () {
      expect(TimeValueFormatter.hoursToHms(12.5), equals('12:30:00'));
    });

    test('23.0 hours = 23:00:00', () {
      expect(TimeValueFormatter.hoursToHms(23.0), equals('23:00:00'));
    });
  });

  group('TimeValueFormatter.hmsToHours', () {
    test('00:00:00 = 0.0', () {
      expect(TimeValueFormatter.hmsToHours('00:00:00'), equals(0.0));
    });

    test('12:00:00 = 12.0', () {
      expect(TimeValueFormatter.hmsToHours('12:00:00'), equals(12.0));
    });

    test('invalid format returns null', () {
      expect(TimeValueFormatter.hmsToHours('not-a-time'), isNull);
      expect(TimeValueFormatter.hmsToHours('12:00'), isNull);
    });
  });

  group('TimeValueFormatter.formatTime 12h', () {
    bool hourFormat24 = false;

    test('midnight = 12:00:00 AM', () {
      expect(TimeValueFormatter.formatTime(hourFormat24, 0, 0, 0, tzSuffix: null),
          equals('12:00:00 AM'));
    });

    test('noon = 12:00:00 PM', () {
      expect(TimeValueFormatter.formatTime(hourFormat24, 12, 0, 0, tzSuffix: null),
          equals('12:00:00 PM'));
    });

    test('13:30:00 = 01:30:00 PM', () {
      expect(TimeValueFormatter.formatTime(hourFormat24, 13, 30, 0, tzSuffix: null),
          equals('01:30:00 PM'));
    });

    test('with timezone suffix', () {
      expect(TimeValueFormatter.formatTime(hourFormat24, 9, 0, 0, tzSuffix: 'UTC'),
          equals('09:00:00 AM UTC'));
    });
  });

  group('TimeValueFormatter.formatDecimal', () {
    test('decimal with thousands separator EN', () {
      expect(TimeValueFormatter.formatDecimal(2461196.382, 'en', 3),
          equals('2,461,196.382'));
    });
    test('decimal with thousands separator DE', () {
      expect(TimeValueFormatter.formatDecimal(2461196.382, 'de', 3),
          equals('2.461.196,382'));
    });
    test('decimal without thousands separator EN', () {
      expect(
          TimeValueFormatter.formatDecimal(2461196.382, 'en', 3,
              thousandsSep: false),
          equals('2461196.382'));
    });
    test('decimal without thousands separator DE uses comma', () {
      expect(
          TimeValueFormatter.formatDecimal(61195.879, 'de', 3,
              thousandsSep: false),
          equals('61195,879'));
    });
    test('small decimal no thousands needed', () {
      expect(TimeValueFormatter.formatDecimal(96.348, 'en', 3),
          equals('96.348'));
    });
  });

  group('TimeValueFormatter.lmstLabelWithLon', () {
    final l10n = lookupAppLocalizations(const Locale('en'));

    test('null longitude returns base label', () {
      const tv = TimeValue(valueType: ValueType.lmst, zone: ZoneUtc());
      final result = TimeValueFormatter.lmstLabelWithLon(l10n, tv, null);
      expect(result, equals('LMST'));
    });

    test('positive longitude shows E', () {
      const tv = TimeValue(valueType: ValueType.lmst, zone: ZoneUtc());
      final result = TimeValueFormatter.lmstLabelWithLon(l10n, tv, 8.68);
      expect(result, contains('E'));
      expect(result, contains('8.68'));
    });

    test('negative longitude shows W', () {
      const tv = TimeValue(valueType: ValueType.lmst, zone: ZoneUtc());
      final result = TimeValueFormatter.lmstLabelWithLon(l10n, tv, -74.0);
      expect(result, contains('W'));
      expect(result, contains('74'));
    });
  });

  group('ValueType.optionalPart', () {
    test('every graphical type has an optional part', () {
      for (final type in ValueType.values.where((t) => t.isGraphical)) {
        expect(type.optionalPart, isNot(OptionalPart.none), reason: '$type');
      }
    });
    test('decimals for Swatch beats and New Earth Time', () {
      expect(ValueType.swatchBeats.optionalPart, OptionalPart.decimals);
      expect(ValueType.newEarthTime.optionalPart, OptionalPart.decimals);
    });
    test('seconds for string-type values', () {
      expect(ValueType.binaryClockString.optionalPart, OptionalPart.seconds);
      expect(ValueType.romanNumeralsTime.optionalPart, OptionalPart.seconds);
    });
    test('all other types have none', () {
      final withPart = {
        ValueType.swatchBeats, ValueType.newEarthTime, ValueType.sevenSegmentClock,
        ValueType.binaryClockBcd, ValueType.binaryClockColumns,
        ValueType.binaryClockString, ValueType.romanNumeralsTime,
      };
      for (final type in ValueType.values.where((t) => !withPart.contains(t))) {
        expect(type.optionalPart, OptionalPart.none, reason: '$type');
      }
    });
    test('|nosec roundtrip still works after the rename', () {
      const value = TimeValue(
          valueType: ValueType.swatchBeats, zone: ZoneUtc(), showOptionalPart: false);
      expect(value.toPrefsString(), endsWith('|nosec'));
      expect(TimeValue.fromPrefsString(value.toPrefsString())!.showOptionalPart, isFalse);
    });
  });
}
