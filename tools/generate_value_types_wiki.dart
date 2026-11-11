// Generates the wiki page "Value types" (Markdown) from the code: whatever
// can be derived is derived (category, zone dependence, optional parts,
// examples, links); the rest (time scale, epoch, unit, ...) is editorial and
// lives in [_factsOf]. A new ValueType does not compile until it has its facts.
//
// Run from the repo root. The Flutter test runner is needed because the app
// code used here imports Flutter:
//   flutter test tools/generate_value_types_wiki.dart
// Result: build/wiki/Value-Types.md
import 'dart:io';
import 'dart:ui';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/models/astronomical_tab_config.dart';
import 'package:epoch/models/civil_tab_config.dart';
import 'package:epoch/models/curiosities_tab_config.dart';
import 'package:epoch/models/technical_tab_config.dart';
import 'package:epoch/models/time_value.dart';
import 'package:epoch/models/value_format_settings.dart';
import 'package:epoch/widgets/time_string_row.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

const _outputPath = 'build/wiki/Value-Types.md';

/// Zone-dependent examples are shown in this zone, the moment is fixed.
const _exampleZone = ZoneNamed('Europe/Berlin');
final _exampleMoment = DateTime.utc(2026, 7, 4, 14, 5, 9);
const _exampleSettings = ValueFormatSettings(
  localIanaZone: 'Europe/Berlin',
  longitude: 8.1427,
);

// ── Editorial facts ─────────────────────────────────────────────────────────

typedef ValueTypeFacts = ({
  String timescale,
  String reference,
  String unit,
  String resolution,
});

const _civilScale = 'Civil (UTC + zone offset)';
const _localMidnight = 'local midnight';
const _notApplicable = '–';
const _julianResolution = '0.00001 d (0.864 s)';

ValueTypeFacts _facts({
  required String timescale,
  String reference = _notApplicable,
  required String unit,
  String resolution = '1 s',
}) => (
  timescale: timescale,
  reference: reference,
  unit: unit,
  resolution: resolution,
);

ValueTypeFacts _factsOf(ValueType type) => switch (type) {
// Civil
  ValueType.date => _facts(timescale: _civilScale, unit: 'calendar date',
      resolution: '1 day'),
  ValueType.time || ValueType.sevenSegmentClock =>
      _facts(timescale: _civilScale, unit: 'h:min:s'),
  ValueType.dateTime =>
      _facts(timescale: _civilScale, unit: 'date, h:min:s'),
  ValueType.daySecond => _facts(
      timescale: _civilScale, reference: _localMidnight, unit: 's'),
  ValueType.dayMinute => _facts(
      timescale: _civilScale, reference: _localMidnight, unit: 'min:s'),
  ValueType.dayPercent => _facts(timescale: _civilScale,
      reference: _localMidnight, unit: '% of the day',
      resolution: '0.001 % (0.864 s)[^1]'),
  ValueType.analogClock12h => _facts(
      timescale: _civilScale, unit: 'hands, 12-hour dial'),
  ValueType.analogClock24h => _facts(
      timescale: _civilScale, unit: 'hands, 24-hour dial'),
// Technical
  ValueType.unixSeconds => _facts(
      timescale: 'UTC (POSIX: leap seconds not counted)',
      reference: '1970-01-01 00:00:00 UTC', unit: 's'),
  ValueType.tai => _facts(
      timescale: 'TAI (continuous; TAI − UTC = 37 s since 2017)',
      reference: '1970-01-01 00:00:00 UTC (Unix epoch)', unit: 's'),
  ValueType.gps => _facts(
      timescale: 'GPS time (continuous; TAI − 19 s)',
      reference: '1980-01-06 00:00:00 UTC', unit: 's'),
// Astronomical
  ValueType.gmst || ValueType.lmst => _facts(
      timescale: 'Mean sidereal time (from UTC)', unit: 'sidereal h:min:s'),
  ValueType.julianDate => _facts(timescale: 'UTC',
      reference: '-4712-01-01 12:00:00 UT (Julian calendar)', unit: 'days',
      resolution: _julianResolution),
  ValueType.reducedJulianDate => _facts(timescale: 'UTC',
      reference: '1858-11-16 12:00:00 UT', unit: 'days',
      resolution: _julianResolution),
  ValueType.modifiedJulianDate => _facts(timescale: 'UTC',
      reference: '1858-11-17 00:00:00 UT', unit: 'days',
      resolution: _julianResolution),
  ValueType.dublinJulianDate => _facts(timescale: 'UTC',
      reference: '1899-12-31 12:00:00 UT', unit: 'days',
      resolution: _julianResolution),
  ValueType.cnesJulianDate => _facts(timescale: 'UTC',
      reference: '1950-01-01 00:00:00 UT', unit: 'days',
      resolution: _julianResolution),
  ValueType.ccsdsJulianDate => _facts(timescale: 'UTC',
      reference: '1958-01-01 00:00:00 UT', unit: 'days',
      resolution: _julianResolution),
  ValueType.modifiedJulianDate2000 => _facts(timescale: 'UTC',
      reference: '2000-01-01 00:00:00 UT', unit: 'days',
      resolution: _julianResolution),
// Curiosities
  ValueType.decimalTime => _facts(timescale: _civilScale,
      reference: _localMidnight, unit: 'decimal h, min, s',
      resolution: '1 decimal s (0.864 s)[^1]'),
  ValueType.swatchBeats => _facts(timescale: 'BMT (UTC+1)',
      reference: 'midnight BMT', unit: '.beats (1/1000 day)',
      resolution: '0.01 .beat (0.864 s)'),
  ValueType.newEarthTime => _facts(timescale: 'UTC',
      reference: 'midnight UTC', unit: '° (1/360 day)',
      resolution: '0.01° (2.4 s)'),
  ValueType.binaryClockBcd ||
  ValueType.binaryClockColumns ||
  ValueType.binaryClockString =>
      _facts(timescale: _civilScale, unit: 'binary digits'),
  ValueType.octalTime => _facts(timescale: _civilScale,
      reference: _localMidnight, unit: 's, base 8'),
  ValueType.hexadecimalTime => _facts(timescale: _civilScale,
      reference: _localMidnight, unit: 's, base 16'),
  ValueType.romanNumeralsTime => _facts(
      timescale: _civilScale, unit: 'h:min:s, Roman numerals'),
  ValueType.doomsdayClock => _facts(timescale: 'UTC (table by year)',
      reference: 'midnight', unit: 'h:min:s',
      resolution: 'static (setting by year)'),
};

// ── Derived properties ──────────────────────────────────────────────────────

const _categories = <({String name, List<ValueType> types})>[
  (name: 'Civil', types: civilTypes),
  (name: 'Technical', types: technicalTypes),
  (name: 'Astronomical', types: astronomicalTypes),
  (name: 'Curiosities', types: curiosityTypes),
];

String _yesNo(bool value) => value ? '✓' : '–';

String _optionalPartOf(ValueType type) {
  final part = switch (type.optionalPart) {
    OptionalPart.none => null,
    OptionalPart.seconds => 'seconds',
    OptionalPart.decimals => 'decimals',
  };
  if (part == null) return _notApplicable;
  return type.optionalPartFollowsTimeFormat ? '$part (follows time format)' : part;
}

String _detailsLineOf(ValueType type) {
  if (!type.hasDetailsLine) return _notApplicable;
  return switch (type) {
    ValueType.date => 'ISO week, day of the year',
    ValueType.gmst || ValueType.lmst => 'angle in degrees',
    _ => 'time zone, offset',
  };
}

TimeValue _timeValueOf(ValueType type) => TimeValue(
  valueType: type,
  zone: type.isZoneIndependent ? const ZoneUtc() : _exampleZone,
);

/// What the app shows (as copied to the clipboard), in one line.
String _exampleOf(ValueType type, AppLocalizations l10n) {
  if (type.isGraphical) return '(graphic)';
  final timeValue = _timeValueOf(type);
  final display = TimeStringRow.computeDisplay(
      timeValue, _exampleMoment, 'en', l10n, settings: _exampleSettings);
  final text = TimeStringRow.computeClipboardDisplay(timeValue, display)
      .replaceAll('\n', ' / ');
  return '`$text`';
}

// ── Markdown ────────────────────────────────────────────────────────────────

String _escapeCell(String text) => text.replaceAll('|', r'\|');

String _table(List<String> headers, List<List<String>> rows) => [
  '| ${headers.join(' | ')} |',
  '|${List.filled(headers.length, '---').join('|')}|',
  for (final row in rows) '| ${row.map(_escapeCell).join(' | ')} |',
].join('\n');

String _versionFromPubspec() {
  final match = RegExp(r'^version:\s*([^\s+]+)', multiLine: true)
      .firstMatch(File('pubspec.yaml').readAsStringSync());
  return match?.group(1) ?? 'unknown';
}

String _buildPage() {
  final l10n = lookupAppLocalizations(const Locale('en'));
  final entries = [
    for (final category in _categories)
      for (final type in category.types) (category: category.name, type: type),
  ];
  final uncategorized = ValueType.values
      .where((type) => !entries.any((entry) => entry.type == type));
  if (uncategorized.isNotEmpty) {
    throw StateError('Not in any category list: '
        '${uncategorized.map((type) => type.name).join(', ')}');
  }

  final measuresTable = _table(
    ['ValueType', 'Category', 'Zone-dependent', 'Time scale',
      'Epoch / reference', 'Unit', 'Resolution'],
    [
      for (final (:category, :type) in entries)
            () {
          final facts = _factsOf(type);
          return [
            '`${type.name}`', category, _yesNo(!type.isZoneIndependent),
            facts.timescale, facts.reference, facts.unit, facts.resolution,
          ];
        }(),
    ],
  );

  final displayTable = _table(
    ['ValueType', 'Graphical', 'Optional part', 'Details line', 'Example'],
    [
      for (final (category: _, :type) in entries)
        [
          '`${type.name}`', _yesNo(type.isGraphical), _optionalPartOf(type),
          _detailsLineOf(type), _exampleOf(type, l10n),
        ],
    ],
  );

  final links = [
    for (final (category: _, :type) in entries)
      if (_timeValueOf(type).localizedInfoLink(l10n) case final link?)
        '- `${type.name}`: <$link>',
  ].join('\n');

  final generated = DateTime.now().toUtc().toIso8601String().substring(0, 10);
  return '''
# Value types

Epoch shows ${ValueType.values.length} kinds of values. This page lists how they differ: what they measure, and how they are displayed. The names in the first column are the `valueType` names used in [config files](https://github.com/RealNoitasinagro/epoch/blob/main/example_configs/CONFIG_MANUAL.md).

_Generated from the code of Epoch ${_versionFromPubspec()} on $generated. Do not edit by hand._

## What a value measures

$measuresTable

## How a value is displayed

Examples: ${_exampleMoment.toIso8601String()} (zone-dependent values in ${_exampleZone.ianaZone}).

$displayTable

## Notes

- **Zone-dependent**: ✓ = depends on the chosen time zone (marked with a globe in the app), – = the same everywhere.
- **Resolution**: smallest step of the default display; hidden seconds or decimals make it coarser.
- **Leap seconds**: Epoch takes UTC from the system clock and never shows a second :60. TAI and GPS time are continuous scales without leap seconds; Epoch derives them from UTC with a table of the 27 leap seconds inserted since 1972, also for moments chosen with Time Shift.
- [^1] Steps in seconds assume a day of 86,400 s. On days with a clock change (23 or 25 hours, Lord Howe: 23.5 or 24.5, Troll: 22 or 26), day percent and decimal time relate to the real length of the day, so their steps are slightly different. All other values keep their resolution.

## Further reading

$links
''';
}

void main() {
  setUpAll(() async {
    tzd.initializeTimeZones();
    await initializeDateFormatting('en');
  });

  test('writes the wiki page', () {
    final page = _buildPage();
    File(_outputPath)
      ..createSync(recursive: true)
      ..writeAsStringSync(page);
    // ignore: avoid_print
    print('Written: $_outputPath');
  });
}
