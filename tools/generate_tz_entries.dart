// Run with: dart run tools/generate_tz_entries.dart
//
// Derives offset/abbreviation pairs (standard + DST) for every zone
// listed in zone1970.tab (via the generated zoneCountryCodes map), using
// LIVE queries against the currently active tzdata rules rather than
// scanning historical Location.zones entries.
//
// WHY LIVE QUERIES, NOT Location.zones:
// Location.zones is a historical record of every rule set a zone has
// ever used. Naively taking "the last entry with isDst == true" finds
// the last DST period a zone EVER observed, even if that zone abolished
// DST decades ago (e.g. Africa/Algiers: DST abolished in 1981, but the
// last historical DST entry from before that would still show up).
//
// WHY A TRANSITION WINDOW, NOT FIXED-DAY SAMPLING:
// A naive "now" + "now + N days" two-point sample can miss a real
// period entirely if the zone's standard-time and DST periods aren't
// roughly symmetric (e.g. current US DST runs ~238 days vs. ~127 days
// standard -- a fixed 183-day offset can land back in the same period
// it started in). Instead, this walks the zone's ACTUAL transitions
// (Location.transitionAt) within a window around "now", which finds
// both periods regardless of how asymmetric or irregular they are (this
// also naturally handles irregular zones like Africa/Casablanca, whose
// DST pauses for Ramadan each year).
//
// CAVEAT (first draft): if the window catches a genuine rule change
// (e.g. a country amending its DST law this year), multiple distinct
// offset/abbreviation pairs may show up within one bucket; this prints
// a "// REVIEW" note on stderr in that case for manual follow-up.
//
// OUTPUT: prints Dart source for TzEntry(...) skeletons (terms: []) to
// stdout.

import 'dart:io';
import 'package:epoch/models/generated/zone1970_countries.g.dart';
import 'package:timezone/data/latest_all.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

// Deliberately duplicated from lib/time_utils.dart rather than importing
// it: that file pulls in Flutter (for the day-quarter-color constants),
// which drags in dart:ui -- unavailable to a plain `dart run` CLI tool.
String _utcOffsetString(Duration offset) {
  final sign = offset.isNegative ? '−' : '+';
  final hh = offset.inHours.abs().toString().padLeft(2, '0');
  final mm = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
  return '$sign$hh:$mm';
}

const _windowDays = 400;

tz.TZDateTime _closestTo(List<tz.TZDateTime> samples, DateTime reference) {
  return samples.reduce((a, b) =>
  a.difference(reference).abs() < b.difference(reference).abs() ? a : b);
}

void main() {
  tzd.initializeTimeZones();

  final zoneIds = zoneCountryCodes.keys.toList()..sort();
  final nowUtc = DateTime.now().toUtc();
  final windowStartMs =
      nowUtc.subtract(const Duration(days: _windowDays)).millisecondsSinceEpoch;
  final windowEndMs =
      nowUtc.add(const Duration(days: _windowDays)).millisecondsSinceEpoch;

  for (final zoneId in zoneIds) {
    late final tz.Location location;
    try {
      location = tz.getLocation(zoneId);
    } catch (_) {
      stderr.writeln('// SKIPPED (not resolvable): $zoneId');
      continue;
    }

    final relevantTransitions = location.transitionAt
        .where((t) => t >= windowStartMs && t <= windowEndMs)
        .toList();

    // Sample the state right after each transition in the window, plus
    // "now" itself (covers the zero-transitions / permanent-state case):
    final sampleTimes = <DateTime>[
      nowUtc,
      ...relevantTransitions.map(
              (t) => DateTime.fromMillisecondsSinceEpoch(t + 1000, isUtc: true)),
    ];
    final samples =
    sampleTimes.map((t) => tz.TZDateTime.from(t, location)).toList();

    final standardSamples = samples.where((s) => !s.timeZone.isDst).toList();
    final dstSamples = samples.where((s) => s.timeZone.isDst).toList();

    final standard = standardSamples.isNotEmpty
        ? _closestTo(standardSamples, nowUtc)
        : tz.TZDateTime.from(nowUtc, location);
    final summer =
    dstSamples.isNotEmpty ? _closestTo(dstSamples, nowUtc) : standard;

    final distinctStandard =
    standardSamples.map((s) => '${s.timeZone.offset}/${s.timeZone.abbreviation}').toSet();
    final distinctDst =
    dstSamples.map((s) => '${s.timeZone.offset}/${s.timeZone.abbreviation}').toSet();
    if (distinctStandard.length > 1 || distinctDst.length > 1) {
      stderr.writeln('// REVIEW (multiple rule variants in window): $zoneId '
          '(standard: $distinctStandard, dst: $distinctDst)');
    }

    final offsetWinter =
    _utcOffsetString(standard.timeZone.offset);
    final offsetSummer =
    _utcOffsetString(summer.timeZone.offset);

    print("  TzEntry(");
    print("    ianaZoneId: '$zoneId',");
    print("    offsetWinter: '$offsetWinter', offsetSummer: '$offsetSummer',");
    print("    abbrWinter: '${standard.timeZone.abbreviation}', "
        "abbrSummer: '${summer.timeZone.abbreviation}',");
    print("    terms: [],");
    print("  ),");
    print("");
  }
}
