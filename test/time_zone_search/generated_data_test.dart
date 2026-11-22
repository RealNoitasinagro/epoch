import 'package:epoch/time_zone_search/generated/iana_canonical_zones_snapshot.g.dart';
import 'package:epoch/time_zone_search/generated/iana_links_snapshot.g.dart';
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

      expect(
        added,
        isEmpty,
        reason:
            'New zone identifiers since the last snapshot: $added -- '
            'regenerate with tools/generate_iana_data.py and consider '
            'adding search coverage for anything relevant.',
      );
      expect(
        removed,
        isEmpty,
        reason:
            'Zone identifiers disappeared since the last snapshot: $removed '
            '-- this would be unusual, investigate before regenerating.',
      );
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
}
