import 'package:epoch/time_zone_search/generated/cldr_metazone_names_de.g.dart';
import 'package:epoch/time_zone_search/generated/cldr_metazone_names_en.g.dart';
import 'package:epoch/time_zone_search/generated/cldr_zone_metazone.g.dart';
import 'package:epoch/time_zone_search/generated/iana_links_snapshot.g.dart';
import 'package:epoch/time_zone_search/generated/legacy_abbreviations.g.dart';
import 'package:epoch/time_zone_search/zones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

void main() {
  // Must run at declaration time: the tests below are generated from the data.
  tzd.initializeTimeZones();

  group('every candidate source resolves to its own entry', () {
    for (final entry in tzDatabase) {
      final firstPerSource = <String, String>{};
      for (final c in entry.candidatesWithSource) {
        firstPerSource.putIfAbsent(c.source, () => c.term);
      }
      firstPerSource.forEach((source, term) {
        test(
          '${entry.ianaZoneId} <- $source "$term"',
          () => expect(entry.match(term), isNotNull),
        );
      });
    }
  });

  group('legacy abbreviations resolve to their zone', () {
    legacyAbbreviationsByZone.forEach((zoneId, abbrs) {
      final canonical = ianaLinksSnapshot[zoneId] ?? zoneId;
      final entry = tzDatabase
          .where((e) => e.ianaZoneId == canonical)
          .firstOrNull;
      if (entry == null) return;
      for (final abbr in abbrs) {
        test(
          '$abbr -> $canonical',
          () => expect(entry.match(abbr) != null, isTrue),
        );
      }
    });
  });

  test('zones without current DST never match a DST-only metazone term', () {
    for (final entry in tzDatabase) {
      if (entry.hasDst) continue;
      final metaId = cldrZoneMetaZone[entry.ianaZoneId];
      if (metaId == null) continue;
      for (final term in [
        cldrMetazoneNamesEn[metaId]?.daylight,
        cldrMetazoneNamesDe[metaId]?.daylight,
      ].whereType<String>()) {
        expect(
          entry.match(term) != null,
          isFalse,
          reason:
              '${entry.ianaZoneId} has no DST but matched daylight term "$term"',
        );
      }
    }
  });

  test('display city never comes from a link (Berlin is not Copenhagen)', () {
    final berlin = tzDatabase.firstWhere(
      (e) => e.ianaZoneId == 'Europe/Berlin',
    );
    expect(berlin.displayCity('de'), 'Berlin');
    expect(berlin.displayCity('en'), 'Berlin');
  });
}
