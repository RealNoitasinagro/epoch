import 'package:epoch/models/generated/iana_canonical_zones_snapshot.g.dart';
import 'package:epoch/models/generated/iana_links_snapshot.g.dart';
import 'package:epoch/models/timezone_search_zones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(() => tzd.initializeTimeZones());

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

  group('TzEntry search terms round-trip', () {
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
  });
}
