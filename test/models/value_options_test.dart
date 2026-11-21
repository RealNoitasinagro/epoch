import 'package:epoch/models/time_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValueOptions.copyWith', () {
    const options = ValueOptions(
      customLabel: 'Home',
      timezoneClockChangeMode: TimezoneClockChangeMode.forceDst,
      showOptionalPart: true,
      showDetails: false,
    );

    test('what is not mentioned stays as it is', () {
      final copy = options.copyWith(showDetails: const NewValue(true));
      expect(copy.customLabel, 'Home');
      expect(copy.timezoneClockChangeMode, TimezoneClockChangeMode.forceDst);
      expect(copy.showOptionalPart, isTrue);
      expect(copy.showDetails, isTrue);
    });

    test('NewValue(null) goes back to the default', () {
      final copy = options.copyWith(
        customLabel: const NewValue(null),
        showOptionalPart: const NewValue(null),
      );
      expect(copy.customLabel, isNull);
      expect(copy.showOptionalPart, isNull);
      expect(copy.showDetails, isFalse);
    });
  });

  group('ValueOptions: writing and reading', () {
    test('suffixes are written in a fixed order, unset ones are left out', () {
      const options = ValueOptions(
        customLabel: 'Home',
        timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard,
        showOptionalPart: false,
        showDetails: true,
      );
      expect(
        options.appendTo('time/utc'),
        'time/utc|Home|dst:forceStandard|nosec|det',
      );
      expect(ValueOptions.none.appendTo('time/utc'), 'time/utc');
    });

    test('suffixes are read in any order', () {
      for (final text in [
        'time/utc|nodet|dst:forceDst|sec',
        'time/utc|dst:forceDst|sec|nodet',
        'time/utc|sec|nodet|dst:forceDst',
      ]) {
        final parsed = ValueOptions.splitPrefsString(text);
        expect(parsed.keyPart, 'time/utc', reason: text);
        expect(
          parsed.options.timezoneClockChangeMode,
          TimezoneClockChangeMode.forceDst,
          reason: text,
        );
        expect(parsed.options.showOptionalPart, isTrue, reason: text);
        expect(parsed.options.showDetails, isFalse, reason: text);
        expect(parsed.options.customLabel, isNull, reason: text);
      }
    });

    test('an empty label slot means no label', () {
      final parsed = ValueOptions.splitPrefsString(
        'time/named:Europe/Kiev||dst:forceStandard',
      );
      expect(parsed.keyPart, 'time/named:Europe/Kiev');
      expect(parsed.options.customLabel, isNull);
    });

    test('a label may contain pipes', () {
      final parsed = ValueOptions.splitPrefsString('time/utc|a|b|nosec');
      expect(parsed.options.customLabel, 'a|b');
      expect(parsed.options.showOptionalPart, isFalse);
    });

    test('an unknown clock change mode counts as automatic', () {
      final parsed = ValueOptions.splitPrefsString('time/utc|dst:sometimes');
      expect(
        parsed.options.timezoneClockChangeMode,
        TimezoneClockChangeMode.auto,
      );
      expect(parsed.options.customLabel, isNull);
    });

    test('every combination of options survives a round trip', () {
      for (final label in [null, 'Home']) {
        for (final mode in TimezoneClockChangeMode.values) {
          for (final optionalPart in [null, true, false]) {
            for (final details in [null, true, false]) {
              for (final remaining in [false, true]) {
                final value = TimeValue(
                  valueType: ValueType.time,
                  zone: const ZoneNamed('Europe/Berlin'),
                  options: ValueOptions(
                    customLabel: label,
                    timezoneClockChangeMode: mode,
                    showOptionalPart: optionalPart,
                    showDetails: details,
                    remaining: remaining,
                  ),
                );
                final parsed = TimeValue.fromPrefsString(
                  value.toPrefsString(),
                )!;
                expect(parsed.toPrefsString(), value.toPrefsString());
                expect(parsed.customLabel, label);
                expect(parsed.timezoneClockChangeMode, mode);
                expect(parsed.showOptionalPart, optionalPart);
                expect(parsed.showDetails, details);
                expect(parsed.remaining, remaining);
              }
            }
          }
        }
      }
    });

    test('the remaining flag is written last and read in any order', () {
      const options = ValueOptions(showDetails: false, remaining: true);
      expect(options.appendTo('time/utc'), 'time/utc|nodet|rem');
      final parsed = ValueOptions.splitPrefsString(
        'time/utc|rem|nosec|dst:forceDst',
      );
      expect(parsed.options.remaining, isTrue);
      expect(parsed.options.showOptionalPart, isFalse);
      expect(
        parsed.options.timezoneClockChangeMode,
        TimezoneClockChangeMode.forceDst,
      );
      expect(parsed.options.customLabel, isNull);
    });
  });

  group('ValueOptions: identity', () {
    test('only the clock change mode makes a different value', () {
      expect(ValueOptions.none.identitySuffix, '');
      expect(
        const ValueOptions(customLabel: 'x', showDetails: true).identitySuffix,
        '',
      );
      expect(
        const ValueOptions(
          timezoneClockChangeMode: TimezoneClockChangeMode.forceDst,
        ).identitySuffix,
        '/dst',
      );
    });

    test('a value and its remaining time are different values', () {
      const rem = ValueOptions(remaining: true);
      const remForcedDst = ValueOptions(
        remaining: true,
        timezoneClockChangeMode: TimezoneClockChangeMode.forceDst,
      );
      expect(rem.identitySuffix, '/rem');
      expect(remForcedDst.identitySuffix, '/dst/rem');
    });
  });
}
