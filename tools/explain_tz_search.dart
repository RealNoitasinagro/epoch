// Usage:
//   dart run tools/explain_tz_search.dart "Korea Time"
//   dart run tools/explain_tz_search.dart --file names_failing.txt | grep TZ-MISS
//   dart run tools/explain_tz_search.dart --zone Asia/Brunei | grep -i brunei
//   dart run tools/explain_tz_search.dart --redundant
import 'dart:io';

import 'package:epoch/models/generated/iana_links_snapshot.g.dart';
import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/models/timezone_search_zones.dart';

/// Hand-maintained sources. Keep in sync with the labels used in
/// TzEntry.candidatesWithSource.
const manualSources = {
  'terms', 'country_aliases_DE', 'country_aliases_EN', 'metazone_aliases', 'major_cities',
};

bool isManual(String source) =>
    manualSources.contains(source.replaceAll('~', ''));

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

void explainQuery(String query) {
  var hits = 0;
  for (final entry in tzDatabase) {
    final reason = entry.matchReason(query);
    if (reason == null) continue;
    hits++;
    final s = matchingSources(entry, query);
    final all = {...s.exact, ...s.prefix};
    final manualOnly = all.isNotEmpty && all.every(isManual);
    print('TZ-MATCH q="$query" zone=${entry.ianaZoneId} rule=${reason.rule} '
        'exact=${s.exact.join(',')} prefix=${s.prefix.join(',')}'
        '${manualOnly ? ' MANUAL-ONLY' : ''}');
  }
  if (hits == 0) {
    print('TZ-MISS q="$query" norm="${normalize(query)}"');
  }
}

void dumpZone(String zoneId) {
  final entry = findEntry(zoneId);
  if (entry == null) {
    print('TZ-NOZONE zone=$zoneId');
    return;
  }
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
      final manual = sources.where(isManual).toSet();
      final generated = sources.where((s) => !isManual(s)).toSet();
      if (manual.isNotEmpty && generated.isNotEmpty) {
        print('TZ-REDUNDANT zone=${entry.ianaZoneId} term="$term" '
            'manual=${manual.join(',')} also=${generated.join(',')}');
      }
    });
  }
}

void main(List<String> args) {
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
