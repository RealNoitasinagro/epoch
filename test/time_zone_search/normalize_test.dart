import 'package:epoch/time_zone_search/search.dart';
import 'package:epoch/time_zone_search/zones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

main() {
  setUpAll(tzd.initializeTimeZones);

  List<String> findIds(String query) =>
      searchTimezones(query, tzDatabase).map((e) => e.ianaZoneId).toList();

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
      test(
        '"$query" finds $zoneId',
        () => expect(findIds(query), contains(zoneId)),
      );
    });
  });
}
