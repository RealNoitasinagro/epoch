import 'dart:io';
import 'package:epoch/models/generated/iana_canonical_zones_snapshot.g.dart';
import 'package:timezone/data/latest_all.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

String _utcOffsetString(Duration offset) {
  final sign = offset.isNegative ? '-' : '+';
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

  final zoneIds = List<String>.of(ianaCanonicalZonesSnapshot)..sort();
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

    final distinctStandard = standardSamples
        .map((s) => '${s.timeZone.offset}/${s.timeZone.abbreviation}').toSet();
    final distinctDst = dstSamples
        .map((s) => '${s.timeZone.offset}/${s.timeZone.abbreviation}').toSet();
    if (distinctStandard.length > 1 || distinctDst.length > 1) {
      stderr.writeln('// REVIEW (multiple rule variants in window): $zoneId '
          '(standard: $distinctStandard, dst: $distinctDst)');
    }

    print("  TzEntry(");
    print("    ianaZoneId: '$zoneId',");
    print("    offsetWinter: '${_utcOffsetString(standard.timeZone.offset)}', "
        "offsetSummer: '${_utcOffsetString(summer.timeZone.offset)}',");
    print("    abbrWinter: '${standard.timeZone.abbreviation}', "
        "abbrSummer: '${summer.timeZone.abbreviation}',");
    print("  ),");
  }
}
