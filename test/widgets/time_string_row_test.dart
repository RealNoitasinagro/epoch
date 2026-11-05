import 'dart:ui';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/models/app_settings.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/models/value_format_settings.dart';
import 'package:epoch/widgets/time_string_row.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest_all.dart' as tzl;

void main() {
  setUpAll(() async {
    tzl.initializeTimeZones();
    await initializeDateFormatting('en');
    await initializeDateFormatting('de');
  });

  group('TimeStringRow.computeDisplay', () {
    final l10n = lookupAppLocalizations(const Locale('en'));

    final summerUtc = DateTime.utc(2026, 6, 15, 12, 0, 0);
    final winterUtc = DateTime.utc(2026, 1, 15, 12, 0, 0);

    test('time ZoneUtc shows UTC in line2', () {
      const tv = TimeValue(valueType: ValueType.time, zone: ZoneUtc());
      final result = TimeStringRow.computeDisplay(tv, summerUtc, 'en', l10n);
      expect(result.line2, contains('UTC'));
    });

    test('time ZoneNamed summer shows CEST suffix', () {
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(tv, summerUtc, 'en', l10n);
      expect(result.line2, contains('CEST'));
      expect(result.line2, contains('UTC+02:00'));
    });

    test('time ZoneNamed winter shows CET suffix', () {
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(tv, winterUtc, 'en', l10n);
      expect(result.line2, contains('CET'));
      expect(result.line2, contains('UTC+01:00'));
    });

    test('forceStandard in summer shows CET in line2', () {
      const tv = TimeValue(
          valueType: ValueType.time,
          zone: ZoneNamed('Europe/Berlin'),
          timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard);
      final result = TimeStringRow.computeDisplay(tv, summerUtc, 'en', l10n);
      expect(result.line2, contains('CET'));
      expect(result.line2, isNot(contains('CEST')));
    });

    test('gmst has degree subtitle in line2', () {
      const tv = TimeValue(valueType: ValueType.gmst, zone: ZoneUtc());
      final result = TimeStringRow.computeDisplay(tv, summerUtc, 'en', l10n);
      expect(result.line2, contains('°'));
    });

    test('lmst with longitude has degree subtitle', () {
      const tv = TimeValue(valueType: ValueType.lmst, zone: ZoneUtc());
      final result = TimeStringRow.computeDisplay(
        tv, summerUtc, 'en', l10n,
        settings: const ValueFormatSettings(longitude: 13.4),
      );
      expect(result.line2, contains('°'));
    });

    test('date with details shows week and day in line2', () {
      const tv = TimeValue(valueType: ValueType.date, zone: ZoneLocal());
      final result = TimeStringRow.computeDisplay(
        tv, DateTime(2026, 6, 15), 'en', l10n,
        settings: const ValueFormatSettings(dateWithDetails: true),
      );
      expect(result.line2, contains('25'));  // week 25
      expect(result.line2, contains('166')); // day 166
    });

    test('date without details has no line2', () {
      const tv = TimeValue(valueType: ValueType.date, zone: ZoneLocal());
      final result = TimeStringRow.computeDisplay(
        tv, DateTime(2026, 6, 15), 'en', l10n,
        settings: const ValueFormatSettings(dateWithDetails: false),
      );
      expect(result.line2, isEmpty);
    });

    test('DST warning appears 3 days before transition', () {
      // 3 days before Berlin switches CET->CEST in 2027 (28.03.2027 01:00 UTC):
      final before = DateTime.utc(2027, 3, 25, 12, 0, 0);
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(tv, before, 'en', l10n);
      expect(result.line2, contains('CET'));
      expect(result.line2, contains('CEST'));
      expect(result.line2, contains('3'));
    });

    test('DST warning shows "today" on transition day', () {
      // Same calendar day as Berlin CEST->CET transition (25.10.2026):
      final sameDay = DateTime.utc(2026, 10, 25, 0, 0, 0);
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(tv, sameDay, 'en', l10n);
      expect(result.line2, contains('today'));
    });

    test('no DST warning 8 days before transition', () {
      final eightDaysBefore = DateTime.utc(2026, 10, 17, 0, 0, 0);
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(
          tv, eightDaysBefore, 'en', l10n);
      // Normal suffix expected, no arrow:
      expect(result.line2, isNot(contains('→')));
    });

    test('ZoneDisplayMode.abbreviation shows only abbreviation', () {
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(
        tv, summerUtc, 'en', l10n,
        settings: const ValueFormatSettings(zoneDisplayMode: ZoneDisplayMode.abbreviation)
      );
      expect(result.line2, equals('CEST'));
    });

    test('ZoneDisplayMode.offsetLong shows only offsetLong', () {
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(
        tv, summerUtc, 'en', l10n,
        settings: const ValueFormatSettings(zoneDisplayMode: ZoneDisplayMode.offsetLong)
      );
      expect(result.line2, equals('UTC+02:00'));
    });

    test('ZoneDisplayMode.offsetShort shows only offsetShort', () {
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(
        tv, summerUtc, 'en', l10n,
        settings: const ValueFormatSettings(zoneDisplayMode: ZoneDisplayMode.offsetShort)
      );
      expect(result.line2, equals('+02:00'));
    });

    test('ZoneDisplayMode.offsetShort shows only offsetMini', () {
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(
        tv, summerUtc, 'en', l10n,
        settings: const ValueFormatSettings(zoneDisplayMode: ZoneDisplayMode.offsetMini)
      );
      expect(result.line2, equals('+2'));
    });

    test('DST warning shown even with abbreviation mode', () {
      final before = DateTime.utc(2027, 3, 26, 12, 0, 0);
      const tv = TimeValue(
          valueType: ValueType.time, zone: ZoneNamed('Europe/Berlin'));
      final result = TimeStringRow.computeDisplay(
        tv, before, 'en', l10n,
        settings: const ValueFormatSettings(zoneDisplayMode: ZoneDisplayMode.abbreviation),
      );
      // Warning overrides mode:
      expect(result.line2, contains('→'));
    });

    test('details line off hides the zone line', () {
      const timeHidden = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        showDetails: false,
      );
      final result = TimeStringRow.computeDisplay(
        timeHidden,
        summerUtc,
        'en',
        l10n,
      );
      expect(result.line2, isEmpty);
    });

    test('details line on shows the full zone line although the global mode is hidden', () {
      const timeShown = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        showDetails: true,
      );
      final result = TimeStringRow.computeDisplay(
        timeShown,
        summerUtc,
        'en',
        l10n,
        settings: const ValueFormatSettings(
          zoneDisplayMode: ZoneDisplayMode.hidden,
        ),
      );
      expect(result.line2, 'CEST (UTC+02:00)');
    });

    test('details line off hides week and day of the year, and the angle of GMST', () {
      const date = TimeValue(
        valueType: ValueType.date,
        zone: ZoneLocal(),
        showDetails: false,
      );
      const gmst = TimeValue(
        valueType: ValueType.gmst,
        zone: ZoneUtc(),
        showDetails: false,
      );
      expect(
        TimeStringRow.computeDisplay(date, summerUtc, 'en', l10n).line2,
        isEmpty,
      );
      expect(
        TimeStringRow.computeDisplay(gmst, summerUtc, 'en', l10n).line2,
        isEmpty,
      );
    });

    test('a clock change notice stays visible when the details line is off', () {
      const timeHidden = TimeValue(
        valueType: ValueType.time,
        zone: ZoneNamed('Europe/Berlin'),
        showDetails: false,
      );
      final threeDaysBefore = DateTime.utc(2027, 3, 25, 12);
      final result = TimeStringRow.computeDisplay(
        timeHidden,
        threeDaysBefore,
        'en',
        l10n,
      );
      expect(result.line2, contains('→'));
    });

    test('exactly the types with hasDetailsLine get a second line', () {
      const settings = ValueFormatSettings(
        longitude: 8.0,
        dateWithDetails: true,
        zoneDisplayMode: ZoneDisplayMode.full,
      );
      for (final valueType in ValueType.values) {
        final timeValue = TimeValue(valueType: valueType, zone: const ZoneUtc());
        final display = TimeStringRow.computeDisplay(
          timeValue,
          summerUtc,
          'en',
          l10n,
          settings: settings,
        );
        expect(
          display.line2.isNotEmpty,
          valueType.hasDetailsLine,
          reason: valueType.name,
        );
      }
    });
  });
}
