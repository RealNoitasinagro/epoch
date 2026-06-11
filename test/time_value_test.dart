import 'dart:ui';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/time_value_formatter.dart';
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

  group('TimeValueFormatter.formatTime12h', () {
    test('midnight = 12:00:00 AM', () {
      expect(TimeValueFormatter.formatTime12h(0, '00', '00', null),
          equals('12:00:00 AM'));
    });

    test('noon = 12:00:00 PM', () {
      expect(TimeValueFormatter.formatTime12h(12, '00', '00', null),
          equals('12:00:00 PM'));
    });

    test('13:30:00 = 01:30:00 PM', () {
      expect(TimeValueFormatter.formatTime12h(13, '30', '00', null),
          equals('01:30:00 PM'));
    });

    test('with timezone suffix', () {
      expect(TimeValueFormatter.formatTime12h(9, '00', '00', 'UTC'),
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
      const tv = TimeValue(type: ValueType.lmst, zone: ZoneUtc());
      final result = TimeValueFormatter.lmstLabelWithLon(l10n, tv, null);
      expect(result, equals('LMST'));
    });

    test('positive longitude shows E', () {
      const tv = TimeValue(type: ValueType.lmst, zone: ZoneUtc());
      final result = TimeValueFormatter.lmstLabelWithLon(l10n, tv, 8.68);
      expect(result, contains('E'));
      expect(result, contains('8.68'));
    });

    test('negative longitude shows W', () {
      const tv = TimeValue(type: ValueType.lmst, zone: ZoneUtc());
      final result = TimeValueFormatter.lmstLabelWithLon(l10n, tv, -74.0);
      expect(result, contains('W'));
      expect(result, contains('74'));
    });
  });
}