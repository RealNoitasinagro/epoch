import 'package:epoch/models/time_value.dart';
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
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
      );
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
        options: ValueOptions(customLabel: 'My Time'),
      );
      final s = e.toPrefsString();
      final e2 = TimeValue.fromPrefsString(s);
      expect(e2!.customLabel, equals('My Time'));
    });

    test('invalid string returns null', () {
      expect(TimeValue.fromPrefsString('garbage'), isNull);
    });

    test('empty label slot (||) means no custom label', () {
      final tv = TimeValue.fromPrefsString(
        'time/named:Europe/Kiev||dst:forceStandard',
      )!;
      expect(tv.customLabel, isNull);
      expect(tv.timezoneClockChangeMode, TimezoneClockChangeMode.forceStandard);
    });

    test('UTC aliases collapse to ZoneUtc, everything else stays', () {
      expect(canonicalZoneSpec(const ZoneNamed('Etc/UTC')), isA<ZoneUtc>());
      expect(canonicalZoneSpec(const ZoneNamed('Zulu')), isA<ZoneUtc>());
      expect(
        canonicalZoneSpec(const ZoneNamed('Europe/Berlin')),
        isA<ZoneNamed>(),
      );
      expect(canonicalZoneSpec(const ZoneLocal()), isA<ZoneLocal>());
    });

    test('legacy prefs string (no dst suffix) parses as auto', () {
      const legacy = 'time/named:Europe/Berlin';
      final tv = TimeValue.fromPrefsString(legacy);
      expect(tv?.timezoneClockChangeMode, equals(TimezoneClockChangeMode.auto));
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
      const e = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Asia/Tokyo'),
        options: ValueOptions(
          timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard,
        ),
      );
      expect(e.isPinned(DateTime.utc(2026), 'UTC'), isFalse);
    });
  });

  group('clock change mode', () {
    test('creates new instance with updated timezoneClockChangeMode', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        options: ValueOptions(
          timezoneClockChangeMode: TimezoneClockChangeMode.auto,
        ),
      );
      final tv2 = tv.withTimezoneClockChangeMode(
        TimezoneClockChangeMode.forceStandard,
      );
      expect(
        tv2.timezoneClockChangeMode,
        equals(TimezoneClockChangeMode.forceStandard),
      );
      expect(tv2.valueType, equals(tv.valueType));
      expect(tv2.zone, equals(tv.zone));
      expect(tv2.customLabel, equals(tv.customLabel));
    });

    test('key changes when timezoneClockChangeMode changes', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
      );
      final tv2 = tv.withTimezoneClockChangeMode(
        TimezoneClockChangeMode.forceStandard,
      );
      expect(tv2.key, isNot(equals(tv.key)));
      expect(tv2.key, equals('time/named:Europe/Berlin/std'));
    });

    test('key for forceDst has /dst suffix', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        options: ValueOptions(
          timezoneClockChangeMode: TimezoneClockChangeMode.forceDst,
        ),
      );
      expect(tv.key, equals('time/named:Europe/Berlin/dst'));
    });

    test('key for forceStandard has /std suffix', () {
      const tv = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        options: ValueOptions(
          timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard,
        ),
      );
      expect(tv.key, equals('time/named:Europe/Berlin/std'));
    });
  });

  group('ValueType.optionalPart', () {
    test('every graphical type has an optional part', () {
      for (final type in ValueType.values.where((t) => t.isGraphical)) {
        expect(type.optionalPart, isNot(OptionalPart.none), reason: '$type');
      }
    });
    test('decimals for Swatch beats and New Earth Time', () {
      expect(ValueType.dayPercent.optionalPart, OptionalPart.decimals);
      expect(ValueType.swatchBeats.optionalPart, OptionalPart.decimals);
      expect(ValueType.newEarthTime.optionalPart, OptionalPart.decimals);
    });
    test('seconds for string-type values', () {
      expect(ValueType.dayMinute.optionalPart, OptionalPart.seconds);
      expect(ValueType.decimalTime.optionalPart, OptionalPart.seconds);
      expect(ValueType.binaryClockString.optionalPart, OptionalPart.seconds);
      expect(ValueType.romanNumeralsTime.optionalPart, OptionalPart.seconds);
    });
    test('all other types have none', () {
      final withPart = {
        ValueType.time,
        ValueType.dateTime,
        ValueType.dayMinute,
        ValueType.dayPercent,
        ValueType.decimalTime,
        ValueType.swatchBeats,
        ValueType.newEarthTime,
        ValueType.sevenSegmentClock,
        ValueType.analogClock12h,
        ValueType.analogClock24h,
        ValueType.binaryClockBcd,
        ValueType.binaryClockColumns,
        ValueType.binaryClockString,
        ValueType.romanNumeralsTime,
      };
      for (final type in ValueType.values.where((t) => !withPart.contains(t))) {
        expect(type.optionalPart, OptionalPart.none, reason: '$type');
      }
      expect(globalOptionalPartTypes.length, 12);
    });
    test('|nosec roundtrip still works after the rename', () {
      const value = TimeValue(
        valueType: ValueType.swatchBeats,
        zone: ZoneUtc(),
        options: ValueOptions(showOptionalPart: false),
      );
      expect(value.toPrefsString(), endsWith('|nosec'));
      expect(
        TimeValue.fromPrefsString(value.toPrefsString())!.showOptionalPart,
        isFalse,
      );
    });
  });

  group('optional part choice', () {
    const byDefault = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
    const shown = TimeValue(
      valueType: ValueType.time,
      zone: ZoneUtc(),
      options: ValueOptions(showOptionalPart: true),
    );
    const hidden = TimeValue(
      valueType: ValueType.time,
      zone: ZoneUtc(),
      options: ValueOptions(showOptionalPart: false),
    );

    test('serializes default, shown and hidden', () {
      expect(byDefault.toPrefsString(), 'time/utc');
      expect(shown.toPrefsString(), 'time/utc|sec');
      expect(hidden.toPrefsString(), 'time/utc|nosec');
    });

    test('parses the three variants; old configs mean "default"', () {
      expect(TimeValue.fromPrefsString('time/utc')!.showOptionalPart, isNull);
      expect(
        TimeValue.fromPrefsString('time/utc|sec')!.showOptionalPart,
        isTrue,
      );
      expect(
        TimeValue.fromPrefsString('time/utc|nosec')!.showOptionalPart,
        isFalse,
      );
    });

    test('works together with label and clock change mode', () {
      const value = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        options: ValueOptions(
          customLabel: 'Home',
          showOptionalPart: false,
          timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard,
        ),
      );
      final parsed = TimeValue.fromPrefsString(value.toPrefsString())!;
      expect(parsed.customLabel, 'Home');
      expect(
        parsed.timezoneClockChangeMode,
        TimezoneClockChangeMode.forceStandard,
      );
      expect(parsed.showOptionalPart, isFalse);
    });

    test('withShowOptionalPart(null) goes back to the default', () {
      expect(hidden.withShowOptionalPart(null).showOptionalPart, isNull);
    });

    test('combined suffixes are read in the order they are written', () {
      final parsed = TimeValue.fromPrefsString(
        'sevenSegmentClock/named:Europe/Berlin||dst:forceStandard|nosec',
      )!;
      expect(
        parsed.timezoneClockChangeMode,
        TimezoneClockChangeMode.forceStandard,
      );
      expect(parsed.showOptionalPart, isFalse);
      expect(parsed.customLabel, isNull);
    });
  });

  group('details line choice', () {
    test('serializes after the optional part flag', () {
      const shown = TimeValue(
        valueType: ValueType.time,
        zone: ZoneUtc(),
        options: ValueOptions(showDetails: true),
      );
      const hidden = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        options: ValueOptions(
          customLabel: 'Home',
          showOptionalPart: false,
          showDetails: false,
          timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard,
        ),
      );
      expect(shown.toPrefsString(), 'time/utc|det');
      expect(
        hidden.toPrefsString(),
        'time/named:Europe/Berlin|Home|dst:forceStandard|nosec|nodet',
      );
    });

    test('everything survives a round trip', () {
      final parsed = TimeValue.fromPrefsString(
        'time/named:Europe/Berlin|Home|dst:forceStandard|nosec|nodet',
      )!;
      expect(parsed.customLabel, 'Home');
      expect(
        parsed.timezoneClockChangeMode,
        TimezoneClockChangeMode.forceStandard,
      );
      expect(parsed.showOptionalPart, isFalse);
      expect(parsed.showDetails, isFalse);
    });

    test('flags are accepted in any order', () {
      final parsed = TimeValue.fromPrefsString('time/utc|det|nosec')!;
      expect(parsed.showDetails, isTrue);
      expect(parsed.showOptionalPart, isFalse);
    });

    test('without a flag the global settings apply', () {
      final parsed = TimeValue.fromPrefsString('time/utc')!;
      expect(parsed.showDetails, isNull);
    });

    test('withShowDetails(null) goes back to the default', () {
      final value = TimeValue.fromPrefsString('time/utc|nodet')!;
      expect(value.withShowDetails(null).showDetails, isNull);
    });

    test('only the angle of sidereal time has no global details setting', () {
      final withoutGlobal = ValueType.values
          .where(
            (type) => type.hasDetailsLine && !type.detailsLineHasGlobalSetting,
          )
          .toSet();
      expect(withoutGlobal, {ValueType.gmst, ValueType.lmst});
    });
  });

  test('nine types have a details line', () {
    final types = ValueType.values.where((type) => type.hasDetailsLine).toSet();
    expect(types, {
      ValueType.date,
      ValueType.time,
      ValueType.dateTime,
      ValueType.daySecond,
      ValueType.dayPercent,
      ValueType.dayMinute,
      ValueType.decimalTime,
      ValueType.gmst,
      ValueType.lmst,
    });
  });

  test('only fuzzy time shows two equal lines', () {
    expect(ValueType.values.where((t) => t.showsTwoEqualLines), [ValueType.fuzzyTime]);
  });
}
