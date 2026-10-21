import 'package:epoch/models/generated/cldr_metazone_names_de.g.dart';
import 'package:epoch/models/generated/cldr_metazone_names_en.g.dart';
import 'package:epoch/models/generated/cldr_zone_metazone.g.dart';
import 'package:epoch/models/generated/iana_canonical_zones_snapshot.g.dart';
import 'package:epoch/models/generated/iana_links_snapshot.g.dart';
import 'package:epoch/models/generated/legacy_abbreviations.g.dart';
import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/models/timezone_search_zones.dart';
import 'package:epoch/time_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tzd.initializeTimeZones();

  group('IANA canonical zone snapshot', () {
    test('live package data matches the last-reviewed snapshot', () {
      final actual = tz.timeZoneDatabase.locations.keys.toSet();
      final expectedCanonical = ianaCanonicalZonesSnapshot.toSet();
      final expectedAll = {...expectedCanonical, ...ianaLinksSnapshot.keys};

      final added = actual.difference(expectedAll);
      final removed = expectedAll.difference(actual);

      expect(added, isEmpty, reason:
          'New zone identifiers since the last snapshot: $added -- '
          'regenerate with tools/generate_iana_data.py and consider '
          'adding search coverage for anything relevant.');
      expect(removed, isEmpty, reason:
          'Zone identifiers disappeared since the last snapshot: $removed '
          '-- this would be unusual, investigate before regenerating.');
    });

    for (final zoneId in ianaCanonicalZonesSnapshot) {
      test('$zoneId resolves as canonical', () {
        expect(tz.getLocation(zoneId).name, equals(zoneId));
      });
    }
  });

  group('IANA Link resolution (legacy/deprecated identifiers)', () {
    // Requires the "all" tz package dataset -- these throw
    // LocationNotFoundException under the canonical-only "default" data.
    for (final entry in ianaLinksSnapshot.entries) {
      test('${entry.key} resolves without throwing', () {
        expect(() => tz.getLocation(entry.key), returnsNormally);
      });
    }
  });

/*  group('TzEntry search terms round-trip', () {
    // Every term listed for an entry must actually resolve back to that
    // entry. New terms added to timezone_search_zones.dart get coverage
    // here automatically -- no test file changes needed.
    for (final entry in tzDatabase) {
      for (final term in entry.terms) {
        test('term "$term" resolves to ${entry.ianaZoneId}', () {
          final matches = tzDatabase.where((e) => e.matches(term));
          expect(matches.map((e) => e.ianaZoneId), contains(entry.ianaZoneId));
        });
      }
    }
  });

  group('TzEntry country name matching', () {
    // Generated from zone1970.tab / ISO 3166-1 (English) and CLDR
    // (German) -- covers every country assigned to a zone in tzDatabase
    // without hand-written per-country tests.
    for (final entry in tzDatabase) {
      for (final name in entry.countryNames) {
        test('country name "$name" resolves to ${entry.ianaZoneId}', () {
          final matches = tzDatabase.where((e) => e.matches(name));
          expect(matches.map((e) => e.ianaZoneId), contains(entry.ianaZoneId));
        });
      }
    }
  });*/

  group('every candidate source resolves to its own entry', () {
    for (final entry in tzDatabase) {
      final firstPerSource = <String, String>{};
      for (final c in entry.candidatesWithSource) {
        firstPerSource.putIfAbsent(c.source, () => c.term);
      }
      firstPerSource.forEach((source, term) {
        test('${entry.ianaZoneId} <- $source "$term"',
                () => expect(entry.match(term), isNotNull));
      });
    }
  });

  group('legacy abbreviations resolve to their zone', () {
    legacyAbbreviationsByZone.forEach((zoneId, abbrs) {
      final canonical = ianaLinksSnapshot[zoneId] ?? zoneId;
      final entry = tzDatabase.where((e) => e.ianaZoneId == canonical).firstOrNull;
      if (entry == null) return;
      for (final abbr in abbrs) {
        test('$abbr -> $canonical', () => expect(entry.match(abbr) != null, isTrue));
      }
    });
  });

  group('offset spellings', () {
    Iterable<String> spellings(Duration o) {
      final sign = o.isNegative ? '-' : '+';
      final h = o.inHours.abs(), m = o.inMinutes.abs() % 60;
      final hh = '$h'.padLeft(2, '0'), mm = '$m'.padLeft(2, '0');
      final decimal = '${h + m / 60}';
      return [
        'UTC$sign$hh:$mm', '$sign$hh:$mm', '$sign$h:$mm',
        if (m == 0) ...['UTC$sign$h', '$sign$h'],
        if (m != 0) ...['$sign$decimal', '$sign${decimal.replaceFirst('.', ',')}'],
      ];
    }
    final offsets = {
      for (final e in tzDatabase) ...[e.rules.standardOffset, e.rules.dstOffset],
    };
    for (final offset in offsets) {
      for (final q in spellings(offset)) {
        test('$q finds a zone with ${TimeUtils.utcOffsetString(offset)}', () {
          final found = searchTimezones(q, tzDatabase);
          expect(found.any((e) =>
            e.rules.standardOffset == offset || e.rules.dstOffset == offset),
              isTrue);
        });
      }
    }
  });

  group('searchTimezonesRanked', () {
    test('searchTimezones returns the same entries, unranked', () {
      final plain = searchTimezones('Berlin', tzDatabase).map((e) => e.ianaZoneId).toSet();
      final ranked = searchTimezonesRanked('Berlin', tzDatabase, locale: 'en')
          .map((r) => r.entry.ianaZoneId).toSet();
      expect(plain, equals(ranked));
    });

    test('own zone ranks before zones that merely share the capital', () {
      final ids = searchTimezonesRanked('Berlin', tzDatabase, locale: 'en')
          .map((r) => r.entry.ianaZoneId).toList();
      expect(ids.first, 'Europe/Berlin');
      expect(ids, contains('Europe/Zurich'));  // Büsingen
    });

    test('empty query lists every zone', () {
      expect(searchTimezonesRanked('', tzDatabase, locale: 'de').length,
          tzDatabase.length);
    });

    test('Etc zones are ordered by offset, not alphabetically', () {
      final ids = searchTimezonesRanked('Etc/GMT', tzDatabase, locale: 'en')
          .map((r) => r.entry.ianaZoneId).toList();
      expect(ids.indexOf('Etc/GMT+12'), lessThan(ids.indexOf('Etc/GMT+2')));
      expect(ids.indexOf('Etc/GMT+2'), lessThan(ids.indexOf('Etc/GMT')));
      expect(ids.indexOf('Etc/GMT'), lessThan(ids.indexOf('Etc/GMT-2')));
      expect(ids.indexOf('Etc/GMT-2'), lessThan(ids.indexOf('Etc/GMT-14')));
    });
  });

  test('zones without current DST never match a DST-only metazone term', () {
    for (final entry in tzDatabase) {
      if (entry.hasDst) continue;
      final metaId = cldrZoneMetaZone[entry.ianaZoneId];
      if (metaId == null) continue;
      for (final term in [cldrMetazoneNamesEn[metaId]?.daylight,
        cldrMetazoneNamesDe[metaId]?.daylight].whereType<String>()) {
        expect(entry.match(term) != null, isFalse,
            reason: '${entry.ianaZoneId} has no DST but matched daylight term "$term"');
      }
    }
  });

  test('display city never comes from a link (Berlin is not Copenhagen)', () {
    final berlin = tzDatabase.firstWhere((e) => e.ianaZoneId == 'Europe/Berlin');
    expect(berlin.displayCity('de'), 'Berlin');
    expect(berlin.displayCity('en'), 'Berlin');
  });
}
