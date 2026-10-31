import 'package:timezone/timezone.dart' as tz;
import 'timezone_search_normalize.dart';
import 'tz_entry.dart';

typedef TzResult = ({TzEntry entry, TzMatch? match});

// The one place that decides what matches (unordered).
// Normalize the query once per search, not per entry.
List<TzResult> _findHits(String query, List<TzEntry> db) {
  final trimmed = query.trim();
  final byOffset = searchByOffset(trimmed, db);
  if (byOffset.isNotEmpty) {
    return [for (final e in byOffset) (entry: e, match: null)];
  }
  final normalizedQuery = normalize(trimmed);
  return [
    for (final e in db)
      if (e.match(trimmed, normalizedQuery: normalizedQuery)
        case final m?) (entry: e, match: m),
  ];
}

// Parses UTC offset queries like "UTC+05:30", "+5:30", "-3", "+5.5", "+9,75"
List<TzEntry> searchByOffset(String query, List<TzEntry> db) {
  final q = query.trim().toUpperCase().replaceAll(' ', '');

  final decimalMatch = RegExp(r'^(?:UTC)?([+-])(\d{1,2})[.,](50?|75|25)$').firstMatch(q);
  final String target;
  if (decimalMatch != null) {
    final sign = decimalMatch.group(1)!;
    final hours = int.parse(decimalMatch.group(2)!);
    final minutes = switch (decimalMatch.group(3)!) {
      '5' || '50' => 30,
      '75' => 45,
      '25' => 15,
      _ => 0,  // unreachable given the current regex
    };
    target = '$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  } else {
    final hoursMinutesMatch = RegExp(r'^(?:UTC)?([+-])(\d{1,2})(?::?(\d{2}))?$').firstMatch(q);
    if (hoursMinutesMatch == null) return [];
    final sign = hoursMinutesMatch.group(1)!;
    final hours = int.parse(hoursMinutesMatch.group(2)!);
    final minutes = int.parse(hoursMinutesMatch.group(3) ?? '0');
    target = '$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  return db.where((e) => e.offsetWinter == target || e.offsetSummer == target).toList();
}

// Etc zones sort by their real offset, everything else by displayed city.
String _sortKey(TzEntry entry, String locale) {
  if (entry.ianaZoneId.startsWith('Etc/')) {
    final offsetMinutes = tz.TZDateTime.now(tz.getLocation(entry.ianaZoneId))
        .timeZoneOffset.inMinutes;
    return 'etc ${(offsetMinutes + 1000).toString().padLeft(5, '0')}';
  }
  return normalize(entry.displayCity(locale));
}

/// Plain hit list (tests, tools).
List<TzEntry> searchTimezones(String query, List<TzEntry> db) =>
    [for (final hit in _findHits(query, db)) hit.entry];

/// Hit list ordered for people (search screen).
List<TzResult> searchTimezonesRanked(String query, List<TzEntry> db,
    {required String locale}) {
  final keyed = [
    for (final hit in _findHits(query, db))
      (hit: hit, rank: hit.match?.rank ?? 0, key: _sortKey(hit.entry, locale)),
  ];
  keyed.sort((a, b) {
    final byRank = a.rank.compareTo(b.rank);
    return byRank != 0 ? byRank : a.key.compareTo(b.key);
  });
  return [for (final k in keyed) k.hit];
}
