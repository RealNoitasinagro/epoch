import 'timezone_search_normalize.dart';
import 'timezone_search_zones.dart';
import 'tz_entry.dart';

typedef TzMatch = ({String rule, String source, String term});

// extension TzMatchRank on TzMatch {
//   int get rank => rule == 'zoneId' ? 0 : switch (source) {
//     'cldr_exemplar_cities' || 'iana_links' => 1,
//     'wikidata_capitals' || 'major_cities' => 2,
//     'iso3166_names_EN' || 'cldr_country_names_EN' || 'country_names_DE' ||
//     'country_aliases_EN' || 'country_aliases_DE' => 3,
//     _ => 4,
//   };
// }

// List<TzEntry> rankedResults(String q, String locale) {
//   final scored = <(TzEntry, int)>[
//     for (final e in tzDatabase)
//       if (e.match(q) case final m?) (e, m.rank),
//   ];
//   scored.sort((a, b) {
//     final byRank = a.$2.compareTo(b.$2);
//     return byRank != 0 ? byRank : normalize(a.$1.displayCity(locale))
//         .compareTo(normalize(b.$1.displayCity(locale)));
//   });
//   return [for (final s in scored) s.$1];
// }

// Parses UTC offset queries like "UTC+05:30", "+5:30", "-3", "+5.5", "+9,75"
List<TzEntry> _searchByOffset(String query, List<TzEntry> db) {
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

List<TzEntry> searchTimezones(String query, List<TzEntry> db) {
  final byOffset = _searchByOffset(query, db);
  if (byOffset.isNotEmpty) return byOffset;
  return db.where((e) => e.matches(query)).toList();
}
