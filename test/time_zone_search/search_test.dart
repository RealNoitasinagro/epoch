import 'package:epoch/time/zone_rules.dart';
import 'package:epoch/time_zone_search/generated/iana_links_snapshot.g.dart';
import 'package:epoch/time_zone_search/search.dart';
import 'package:epoch/time_zone_search/zones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

void main() {
  // Must run at declaration time: the tests below are generated from the data.
  tzd.initializeTimeZones();

  List<String> findIds(String query) =>
      searchTimezones(query, tzDatabase).map((e) => e.ianaZoneId).toList();

  group('IANA Link identifiers are searchable', () {
    for (final entry in ianaLinksSnapshot.entries) {
      test('${entry.key} finds ${entry.value}', () {
        final found = searchTimezones(
          entry.key,
          tzDatabase,
        ).map((e) => e.ianaZoneId);
        expect(found, contains(entry.value));
      });
    }
  });

  group('offset spellings', () {
    Iterable<String> spellings(Duration o) {
      final sign = o.isNegative ? '-' : '+';
      final h = o.inHours.abs(), m = o.inMinutes.abs() % 60;
      final hh = '$h'.padLeft(2, '0'), mm = '$m'.padLeft(2, '0');
      final decimal = '${h + m / 60}';
      return [
        'UTC$sign$hh:$mm',
        '$sign$hh:$mm',
        '$sign$h:$mm',
        if (m == 0) ...['UTC$sign$h', '$sign$h'],
        if (m != 0) ...[
          '$sign$decimal',
          '$sign${decimal.replaceFirst('.', ',')}',
        ],
      ];
    }

    final offsets = {
      for (final e in tzDatabase) ...[
        e.rules.standardOffset,
        e.rules.dstOffset,
      ],
    };
    for (final offset in offsets) {
      for (final q in spellings(offset)) {
        test('$q finds a zone with ${formatUtcOffset(offset)}', () {
          final found = searchTimezones(q, tzDatabase);
          expect(
            found.any(
              (e) =>
                  e.rules.standardOffset == offset ||
                  e.rules.dstOffset == offset,
            ),
            isTrue,
          );
        });
      }
    }
  });

  group('searchTimezonesRanked', () {
    test('searchTimezones returns the same entries, unranked', () {
      final plain = searchTimezones(
        'Berlin',
        tzDatabase,
      ).map((e) => e.ianaZoneId).toSet();
      final ranked = searchTimezonesRanked(
        'Berlin',
        tzDatabase,
        locale: 'en',
      ).map((r) => r.entry.ianaZoneId).toSet();
      expect(plain, equals(ranked));
    });

    test('own zone ranks before zones that merely share the capital', () {
      final ids = searchTimezonesRanked(
        'Berlin',
        tzDatabase,
        locale: 'en',
      ).map((r) => r.entry.ianaZoneId).toList();
      expect(ids.first, 'Europe/Berlin');
      expect(ids, contains('Europe/Zurich')); // Büsingen
    });

    test('empty query lists every zone', () {
      expect(
        searchTimezonesRanked('', tzDatabase, locale: 'de').length,
        tzDatabase.length,
      );
    });

    test('Etc zones are ordered by offset, not alphabetically', () {
      final ids = searchTimezonesRanked(
        'Etc/GMT',
        tzDatabase,
        locale: 'en',
      ).map((r) => r.entry.ianaZoneId).toList();
      expect(ids.indexOf('Etc/GMT+12'), lessThan(ids.indexOf('Etc/GMT+2')));
      expect(ids.indexOf('Etc/GMT+2'), lessThan(ids.indexOf('Etc/GMT')));
      expect(ids.indexOf('Etc/GMT'), lessThan(ids.indexOf('Etc/GMT-2')));
      expect(ids.indexOf('Etc/GMT-2'), lessThan(ids.indexOf('Etc/GMT-14')));
    });
  });

  group('name variants find the zone', () {
    const kathmandu = 'Asia/Kathmandu';
    const nepalVariants = [
      'Nepalesische Normalzeit',
      'Nepalesische Normal-Zeit',
      'Nepalesische Standardzeit',
      'Nepalesische Standard-Zeit',
      'Nepalesische Zeit',
      'Nepal-Normalzeit',
      'Nepal-Normal-Zeit',
      'Nepal Standard Time',
      'Nepal-Standardzeit',
      'Nepal-Standard-Zeit',
      'Nepal Time',
      'Nepal-Zeit',
    ];
    for (final variant in nepalVariants) {
      test('"$variant"', () => expect(findIds(variant), contains(kathmandu)));
    }
  });

  group('match rules', () {
    test('all-caps query matches exactly, not by prefix', () {
      expect(findIds('IST'), isNot(contains('Europe/Istanbul')));
      expect(findIds('ist'), contains('Europe/Istanbul'));
    });
    test('daylight names only for zones that have DST today', () {
      expect(
        findIds('Central European Summer Time'),
        contains('Europe/Berlin'),
      );
      expect(
        findIds('Central European Summer Time'),
        isNot(contains('Africa/Tunis')),
      );
    });
  });

  group('IDs with signs and hyphens', () {
    test(
      'Etc/GMT zones keep IANA sign convention and are found in any case',
      () {
        for (final query in ['Etc/GMT-5', 'etc/gmt-5', 'GMT-5', 'gmt-5']) {
          expect(findIds(query), contains('Etc/GMT-5'), reason: query);
          expect(findIds(query), isNot(contains('Etc/GMT+5')), reason: query);
        }
        for (final query in ['Etc/GMT+5', 'etc/gmt+5', 'GMT+5', 'gmt+5']) {
          expect(findIds(query), contains('Etc/GMT+5'), reason: query);
          expect(findIds(query), isNot(contains('Etc/GMT-5')), reason: query);
        }
      },
    );
    test('hyphenated IDs are found by their full ID', () {
      expect(
        findIds('America/Port-au-Prince'),
        contains('America/Port-au-Prince'),
      );
      expect(findIds('Asia/Ust-Nera'), contains('Asia/Ust-Nera'));
    });
    test('abbreviations still do not match inside IDs', () {
      expect(findIds('IST'), isNot(contains('Europe/Istanbul')));
    });
  });
}
