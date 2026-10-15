// Usage:
//   dart run tools/explain_tz_search.dart "Korea Time"
//   dart run tools/explain_tz_search.dart --file names_failing.txt | grep TZ-MISS
//   dart run tools/explain_tz_search.dart --zone Asia/Brunei | grep -i brunei
//   dart run tools/explain_tz_search.dart --redundant
import 'dart:io';
import 'package:epoch/models/generated/iana_links_snapshot.g.dart';
import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/models/timezone_search_zones.dart';
import 'package:epoch/models/zone_rules.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

/// Hand-maintained sources. Keep in sync with the labels used in
/// TzEntry.candidatesWithSource.
const manualSources = {
  'terms', 'country_aliases_EN', 'country_aliases_DE',
  'metazone_aliases', 'major_cities',
};

bool isManual(String source) =>
    manualSources.contains(source.replaceAll('~', ''));

bool isRule(String s) => s.startsWith('rule:') || s.endsWith('~');


/// Accepts canonical ids and link ids (Asia/Brunei -> Asia/Kuching).
TzEntry? findEntry(String zoneId) {
  final canonical = ianaLinksSnapshot[zoneId] ?? zoneId;
  for (final entry in tzDatabase) {
    if (entry.ianaZoneId == canonical) return entry;
  }
  return null;
}

/// All sources that match [query] for [entry], not only the first one.
({Set<String> exact, Set<String> prefix}) matchingSources(
    TzEntry entry, String query) {
  final queryNorm = normalize(query);
  final allCaps = query.trim() == query.trim().toUpperCase();
  final exact = <String>{}, prefix = <String>{};
  for (final c in entry.candidatesWithSource) {
    final t = normalize(c.term);
    if (t == queryNorm) {
      exact.add(c.source);
    } else if (!allCaps && t.startsWith(queryNorm)) {
      prefix.add(c.source);
    }
  }
  return (exact: exact, prefix: prefix);
}

({String how, List<({String source, String term})> hits}) strongestHits(
    TzEntry entry, String query) {
  final queryNorm = normalize(query);
  final allCaps = query.trim() == query.trim().toUpperCase();
  final exact = <({String source, String term})>[];
  final prefix = <({String source, String term})>[];
  for (final c in entry.candidatesWithSource) {
    final t = normalize(c.term);
    if (t == queryNorm) {
      exact.add(c);
    } else if (!allCaps && t.startsWith(queryNorm)) {
      prefix.add(c);
    }
  }
  return exact.isNotEmpty
      ? (how: 'exact', hits: exact)
      : (how: 'prefix', hits: prefix);
}

void explainQuery(String query) {
  var count = 0;
  for (final entry in tzDatabase) {
    final reason = entry.matchReason(query);
    if (reason == null) continue;
    count++;
    final line = StringBuffer('TZ-MATCH q="$query" zone=${entry.ianaZoneId}');
    final strongest = strongestHits(entry, query);
    if ((reason.rule == 'exact' || reason.rule == 'prefix') &&
        strongest.hits.isNotEmpty) {
      final sources = strongest.hits.map((h) => h.source).toSet();
      line.write(' by=${strongest.how} term="${strongest.hits.first.term}"'
          ' via=${sources.join(',')}');
      if (sources.every(isRule)) line.write(' DERIVED');
      if (sources.every(manualSources.contains)) line.write(' MANUAL-ONLY');
    } else {
      line.write(' by=${reason.rule} term="${reason.term}"');
    }
    print(line);
  }
  if (count == 0) {
    print('TZ-MISS q="$query" norm="${normalize(query)}"');
  }
}

void dumpZone(String zoneId) {
  final entry = findEntry(zoneId);
  if (entry == null) {
    print('TZ-NOZONE zone=$zoneId');
    return;
  }
  final rules = entry.rules;
  print('TZ-RULES zone=${entry.ianaZoneId} hasDst=${rules.hasDst} '
      'std=${rules.standardAbbr}/${formatUtcOffset(rules.standardOffset)} '
      'dst=${rules.dstAbbr}/${formatUtcOffset(rules.dstOffset)}');
  for (final c in entry.candidatesWithSource) {
    print('TZ-CAND zone=${entry.ianaZoneId} src=${c.source} term="${c.term}"');
  }
}

/// Manual entries whose (normalized) term is also produced by a generated
/// source -- candidates for deletion.
void listRedundant() {
  for (final entry in tzDatabase) {
    final sourcesByTerm = <String, Set<String>>{};
    for (final c in entry.candidatesWithSource) {
      sourcesByTerm
          .putIfAbsent(normalize(c.term), () => <String>{})
          .add(c.source);
    }
    sourcesByTerm.forEach((term, sources) {
      final manual = sources.where(manualSources.contains).toSet();
      final generated = sources
          .where((s) => !manualSources.contains(s.replaceAll('~', '')))
          .toSet();
      final shown = generated
          .where((s) =>
      !(s.endsWith('~') && generated.contains(s.substring(0, s.length - 1))))
          .toSet();
      if (manual.isNotEmpty && shown.isNotEmpty) {
        print('TZ-REDUNDANT zone=${entry.ianaZoneId} term="$term" '
            'manual=${manual.join(',')} also=${shown.join(',')}');
      }
    });
  }
}

void main(List<String> args) {
  tzd.initializeTimeZones();
  if (args.isEmpty ||
      (['--zone', '--file'].contains(args.first) && args.length < 2)) {
    stderr.writeln('usage: see header comment');
    exit(64);
  }
  switch (args.first) {
    case '--zone':
      dumpZone(args[1]);
    case '--redundant':
      listRedundant();
    case '--file':
      for (final line in File(args[1]).readAsLinesSync()) {
        if (line.trim().isNotEmpty) explainQuery(line.trim());
      }
    default:
      explainQuery(args.join(' '));
  }
}
