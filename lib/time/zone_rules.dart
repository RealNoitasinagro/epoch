// Standard/DST offsets and abbreviations of a zone, derived from the
// timezone package for a reference time. Replaces the values that used to
// be hard-coded per TzEntry (and went stale with every IANA release).
//
// Pure Dart: depends only on package:timezone.
import 'package:timezone/timezone.dart' as tz;

class ZoneRules {
  const ZoneRules({
    required this.standardOffset,
    required this.dstOffset,
    required this.standardAbbr,
    required this.dstAbbr,
    required this.hasDst,
  });

  final Duration standardOffset;
  final Duration dstOffset;
  final String standardAbbr;
  final String dstAbbr;

  /// A standard AND a DST state occur around the reference time, judged by
  /// the isDst flags, not by offset equality (e.g. Vancouver: PDT -> MST
  /// keeps -07:00 but is still a clock change).
  final bool hasDst;
}

/// "+05:30" / "-07:00" (ASCII sign, as users type it).
String formatUtcOffset(Duration offset,
    {bool withUtcPrefix = false, bool typographicMinus = false}) {
  final sign = offset.isNegative ? (typographicMinus ? '\u2212' : '-') : '+';
  final hh = offset.inHours.abs().toString().padLeft(2, '0');
  final mm = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
  return '${withUtcPrefix ? 'UTC' : ''}$sign$hh:$mm';
}

const _lookaheadDays = 400;
const _maxCacheEntries = 4096;
final _cache = <String, ZoneRules>{};

/// Rules in effect around [referenceUtc]; null if the zone is unknown
/// (e.g. UTC given as '' or time zone data not initialized yet).
///
/// Looks at the zone's actual transitions within +-[_windowDays] instead of
/// sampling fixed dates: standard and DST periods are rarely symmetric, and
/// Location.zones also lists rules the zone abandoned long ago.
ZoneRules? zoneRulesAt(String ianaZoneId, DateTime referenceUtc) {
  final ref = referenceUtc.toUtc();
  final day = ref.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
  final key = '$ianaZoneId|$day';
  final cached = _cache[key];
  if (cached != null) return cached;

  final tz.Location location;
  try {
    location = tz.getLocation(ianaZoneId);
  } on tz.LocationNotFoundException {
    return null;
  }

  final refMs = ref.millisecondsSinceEpoch;
  final endMs =
      ref.add(const Duration(days: _lookaheadDays)).millisecondsSinceEpoch;
  final samples = <tz.TZDateTime>[
    tz.TZDateTime.from(ref, location),
    for (final t in location.transitionAt)
      if (t > refMs && t <= endMs)
        tz.TZDateTime.from(
            DateTime.fromMillisecondsSinceEpoch(t + 1000, isUtc: true), location),
  ];

  tz.TZDateTime closest(Iterable<tz.TZDateTime> list) => list.reduce(
          (a, b) => a.difference(ref).abs() < b.difference(ref).abs() ? a : b);

  final standardSamples = samples.where((s) => !s.timeZone.isDst).toList();
  final dstSamples = samples.where((s) => s.timeZone.isDst).toList();
  final standard = standardSamples.isNotEmpty
      ? closest(standardSamples)
      : tz.TZDateTime.from(ref, location);
  final dst = dstSamples.isNotEmpty ? closest(dstSamples) : standard;

  final rules = ZoneRules(
    standardOffset: standard.timeZone.offset,
    dstOffset: dst.timeZone.offset,
    standardAbbr: standard.timeZone.abbreviation,
    dstAbbr: dst.timeZone.abbreviation,
    hasDst: standardSamples.isNotEmpty && dstSamples.isNotEmpty,
  );
  if (_cache.length >= _maxCacheEntries) _cache.clear();
  return _cache[key] = rules;
}
