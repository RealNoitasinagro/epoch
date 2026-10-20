import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/models/timezone_search_zones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

void main() {
  tzd.initializeTimeZones();

  List<String> findIds(String query) =>
      searchTimezones(query, tzDatabase).map((e) => e.ianaZoneId).toList();

  group('name variants find the zone', () {
    const kathmandu = 'Asia/Kathmandu';
    const nepalVariants = [
      'Nepalesische Normalzeit', 'Nepalesische Normal-Zeit',
      'Nepalesische Standardzeit', 'Nepalesische Standard-Zeit',
      'Nepalesische Zeit', 'Nepal-Normalzeit', 'Nepal-Normal-Zeit',
      'Nepal Standard Time', 'Nepal-Standardzeit', 'Nepal-Standard-Zeit',
      'Nepal Time', 'Nepal-Zeit',
    ];
    for (final variant in nepalVariants) {
      test('"$variant"', () => expect(findIds(variant), contains(kathmandu)));
    }
  });

  group('normalization', () {
    const cases = {
      'Asunción': 'America/Asuncion',
      'asuncion': 'America/Asuncion',
      'São Paulo': 'America/Sao_Paulo',
      'Sao Paulo': 'America/Sao_Paulo',
      'St. Petersburg': 'Europe/Moscow',
      'Saint Petersburg': 'Europe/Moscow',
    };
    cases.forEach((query, zoneId) {
      test('"$query" finds $zoneId', () => expect(findIds(query), contains(zoneId)));
    });
  });

  group('match rules', () {
    test('all-caps query matches exactly, not by prefix', () {
      expect(findIds('IST'), isNot(contains('Europe/Istanbul')));
      expect(findIds('ist'), contains('Europe/Istanbul'));
    });
    test('daylight names only for zones that have DST today', () {
      expect(findIds('Central European Summer Time'), contains('Europe/Berlin'));
      expect(findIds('Central European Summer Time'), isNot(contains('Africa/Tunis')));
    });
  });
}
