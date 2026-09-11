import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/models/timezone_search_zones.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

void _printDetails(String searchTerm, List<TzEntry> loc, showDetails) {
  if (!showDetails) return;
  debugPrint("# $searchTerm: " + loc.length.toString());
  for (final te in loc) {
    debugPrint("    " + te.ianaZone
        + " | oW: " + te.offsetWinter
        + " | oS: " + te.offsetSummer
        + " | aW: " + te.abbrWinter
        + " | aS: " + te.abbrSummer);
  }
  debugPrint("");
}

void main() {
  const skip = true;
  const showDetails = false;

  group('IANA 2025c timezones canonical available', () {
    tzd.initializeTimeZones();

    test('number of canonical entries', () {
      int entries = tz.timeZoneDatabase.locations.entries.length;
      int expectedCanonicals2025c = 341;
      expect(entries, equals(expectedCanonicals2025c));
    });

    test('Africa/Abidjan', () {
      String ianaZone = 'Africa/Abidjan';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Algiers', () {
      String ianaZone = 'Africa/Algiers';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Bissau', () {
      String ianaZone = 'Africa/Bissau';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Cairo', () {
      String ianaZone = 'Africa/Cairo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Casablanca', () {
      String ianaZone = 'Africa/Casablanca';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Ceuta', () {
      String ianaZone = 'Africa/Ceuta';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/El_Aaiun', () {
      String ianaZone = 'Africa/El_Aaiun';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Johannesburg', () {
      String ianaZone = 'Africa/Johannesburg';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Juba', () {
      String ianaZone = 'Africa/Juba';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Khartoum', () {
      String ianaZone = 'Africa/Khartoum';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Lagos', () {
      String ianaZone = 'Africa/Lagos';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Maputo', () {
      String ianaZone = 'Africa/Maputo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Monrovia', () {
      String ianaZone = 'Africa/Monrovia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Nairobi', () {
      String ianaZone = 'Africa/Nairobi';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Ndjamena', () {
      String ianaZone = 'Africa/Ndjamena';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Sao_Tome', () {
      String ianaZone = 'Africa/Sao_Tome';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Tripoli', () {
      String ianaZone = 'Africa/Tripoli';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Tunis', () {
      String ianaZone = 'Africa/Tunis';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Windhoek', () {
      String ianaZone = 'Africa/Windhoek';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Adak', () {
      String ianaZone = 'America/Adak';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Anchorage', () {
      String ianaZone = 'America/Anchorage';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Araguaina', () {
      String ianaZone = 'America/Araguaina';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Buenos_Aires', () {
      String ianaZone = 'America/Argentina/Buenos_Aires';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Catamarca', () {
      String ianaZone = 'America/Argentina/Catamarca';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Cordoba', () {
      String ianaZone = 'America/Argentina/Cordoba';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Jujuy', () {
      String ianaZone = 'America/Argentina/Jujuy';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/La_Rioja', () {
      String ianaZone = 'America/Argentina/La_Rioja';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Mendoza', () {
      String ianaZone = 'America/Argentina/Mendoza';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Rio_Gallegos', () {
      String ianaZone = 'America/Argentina/Rio_Gallegos';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Salta', () {
      String ianaZone = 'America/Argentina/Salta';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/San_Juan', () {
      String ianaZone = 'America/Argentina/San_Juan';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/San_Luis', () {
      String ianaZone = 'America/Argentina/San_Luis';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Tucuman', () {
      String ianaZone = 'America/Argentina/Tucuman';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Ushuaia', () {
      String ianaZone = 'America/Argentina/Ushuaia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Asuncion', () {
      String ianaZone = 'America/Asuncion';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Bahia', () {
      String ianaZone = 'America/Bahia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Bahia_Banderas', () {
      String ianaZone = 'America/Bahia_Banderas';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Barbados', () {
      String ianaZone = 'America/Barbados';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Belem', () {
      String ianaZone = 'America/Belem';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Belize', () {
      String ianaZone = 'America/Belize';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Boa_Vista', () {
      String ianaZone = 'America/Boa_Vista';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Bogota', () {
      String ianaZone = 'America/Bogota';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Boise', () {
      String ianaZone = 'America/Boise';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Cambridge_Bay', () {
      String ianaZone = 'America/Cambridge_Bay';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Campo_Grande', () {
      String ianaZone = 'America/Campo_Grande';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Cancun', () {
      String ianaZone = 'America/Cancun';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Caracas', () {
      String ianaZone = 'America/Caracas';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Cayenne', () {
      String ianaZone = 'America/Cayenne';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Chicago', () {
      String ianaZone = 'America/Chicago';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Chihuahua', () {
      String ianaZone = 'America/Chihuahua';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Ciudad_Juarez', () {
      String ianaZone = 'America/Ciudad_Juarez';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Costa_Rica', () {
      String ianaZone = 'America/Costa_Rica';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Coyhaique', () {
      String ianaZone = 'America/Coyhaique';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Cuiaba', () {
      String ianaZone = 'America/Cuiaba';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Danmarkshavn', () {
      String ianaZone = 'America/Danmarkshavn';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Dawson', () {
      String ianaZone = 'America/Dawson';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Dawson_Creek', () {
      String ianaZone = 'America/Dawson_Creek';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Denver', () {
      String ianaZone = 'America/Denver';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Detroit', () {
      String ianaZone = 'America/Detroit';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Edmonton', () {
      String ianaZone = 'America/Edmonton';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Eirunepe', () {
      String ianaZone = 'America/Eirunepe';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/El_Salvador', () {
      String ianaZone = 'America/El_Salvador';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Fortaleza', () {
      String ianaZone = 'America/Fortaleza';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Fort_Nelson', () {
      String ianaZone = 'America/Fort_Nelson';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Glace_Bay', () {
      String ianaZone = 'America/Glace_Bay';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Goose_Bay', () {
      String ianaZone = 'America/Goose_Bay';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Grand_Turk', () {
      String ianaZone = 'America/Grand_Turk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Guatemala', () {
      String ianaZone = 'America/Guatemala';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Guayaquil', () {
      String ianaZone = 'America/Guayaquil';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Guyana', () {
      String ianaZone = 'America/Guyana';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Halifax', () {
      String ianaZone = 'America/Halifax';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Havana', () {
      String ianaZone = 'America/Havana';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Hermosillo', () {
      String ianaZone = 'America/Hermosillo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Indiana/Indianapolis', () {
      String ianaZone = 'America/Indiana/Indianapolis';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Indiana/Knox', () {
      String ianaZone = 'America/Indiana/Knox';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Indiana/Marengo', () {
      String ianaZone = 'America/Indiana/Marengo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Indiana/Petersburg', () {
      String ianaZone = 'America/Indiana/Petersburg';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Indiana/Tell_City', () {
      String ianaZone = 'America/Indiana/Tell_City';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Indiana/Vevay', () {
      String ianaZone = 'America/Indiana/Vevay';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Indiana/Vincennes', () {
      String ianaZone = 'America/Indiana/Vincennes';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Indiana/Winamac', () {
      String ianaZone = 'America/Indiana/Winamac';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Inuvik', () {
      String ianaZone = 'America/Inuvik';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Iqaluit', () {
      String ianaZone = 'America/Iqaluit';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Jamaica', () {
      String ianaZone = 'America/Jamaica';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Juneau', () {
      String ianaZone = 'America/Juneau';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Kentucky/Louisville', () {
      String ianaZone = 'America/Kentucky/Louisville';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Kentucky/Monticello', () {
      String ianaZone = 'America/Kentucky/Monticello';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/La_Paz', () {
      String ianaZone = 'America/La_Paz';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Lima', () {
      String ianaZone = 'America/Lima';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Los_Angeles', () {
      String ianaZone = 'America/Los_Angeles';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Maceio', () {
      String ianaZone = 'America/Maceio';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Managua', () {
      String ianaZone = 'America/Managua';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Manaus', () {
      String ianaZone = 'America/Manaus';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Martinique', () {
      String ianaZone = 'America/Martinique';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Matamoros', () {
      String ianaZone = 'America/Matamoros';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Mazatlan', () {
      String ianaZone = 'America/Mazatlan';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Menominee', () {
      String ianaZone = 'America/Menominee';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Merida', () {
      String ianaZone = 'America/Merida';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Metlakatla', () {
      String ianaZone = 'America/Metlakatla';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Mexico_City', () {
      String ianaZone = 'America/Mexico_City';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Miquelon', () {
      String ianaZone = 'America/Miquelon';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Moncton', () {
      String ianaZone = 'America/Moncton';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Monterrey', () {
      String ianaZone = 'America/Monterrey';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Montevideo', () {
      String ianaZone = 'America/Montevideo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/New_York', () {
      String ianaZone = 'America/New_York';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Nome', () {
      String ianaZone = 'America/Nome';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Noronha', () {
      String ianaZone = 'America/Noronha';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/North_Dakota/Beulah', () {
      String ianaZone = 'America/North_Dakota/Beulah';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/North_Dakota/Center', () {
      String ianaZone = 'America/North_Dakota/Center';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/North_Dakota/New_Salem', () {
      String ianaZone = 'America/North_Dakota/New_Salem';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Nuuk', () {
      String ianaZone = 'America/Nuuk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Ojinaga', () {
      String ianaZone = 'America/Ojinaga';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Panama', () {
      String ianaZone = 'America/Panama';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Paramaribo', () {
      String ianaZone = 'America/Paramaribo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Phoenix', () {
      String ianaZone = 'America/Phoenix';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Port-au-Prince', () {
      String ianaZone = 'America/Port-au-Prince';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Porto_Velho', () {
      String ianaZone = 'America/Porto_Velho';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Puerto_Rico', () {
      String ianaZone = 'America/Puerto_Rico';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Punta_Arenas', () {
      String ianaZone = 'America/Punta_Arenas';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Rankin_Inlet', () {
      String ianaZone = 'America/Rankin_Inlet';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Recife', () {
      String ianaZone = 'America/Recife';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Regina', () {
      String ianaZone = 'America/Regina';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Resolute', () {
      String ianaZone = 'America/Resolute';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Rio_Branco', () {
      String ianaZone = 'America/Rio_Branco';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Santarem', () {
      String ianaZone = 'America/Santarem';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Santiago', () {
      String ianaZone = 'America/Santiago';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Santo_Domingo', () {
      String ianaZone = 'America/Santo_Domingo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Sao_Paulo', () {
      String ianaZone = 'America/Sao_Paulo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Scoresbysund', () {
      String ianaZone = 'America/Scoresbysund';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Sitka', () {
      String ianaZone = 'America/Sitka';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/St_Johns', () {
      String ianaZone = 'America/St_Johns';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Swift_Current', () {
      String ianaZone = 'America/Swift_Current';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Tegucigalpa', () {
      String ianaZone = 'America/Tegucigalpa';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Thule', () {
      String ianaZone = 'America/Thule';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Tijuana', () {
      String ianaZone = 'America/Tijuana';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Toronto', () {
      String ianaZone = 'America/Toronto';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Vancouver', () {
      String ianaZone = 'America/Vancouver';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Whitehorse', () {
      String ianaZone = 'America/Whitehorse';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Winnipeg', () {
      String ianaZone = 'America/Winnipeg';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Yakutat', () {
      String ianaZone = 'America/Yakutat';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Casey', () {
      String ianaZone = 'Antarctica/Casey';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Davis', () {
      String ianaZone = 'Antarctica/Davis';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Macquarie', () {
      String ianaZone = 'Antarctica/Macquarie';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Mawson', () {
      String ianaZone = 'Antarctica/Mawson';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Palmer', () {
      String ianaZone = 'Antarctica/Palmer';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Rothera', () {
      String ianaZone = 'Antarctica/Rothera';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Troll', () {
      String ianaZone = 'Antarctica/Troll';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Vostok', () {
      String ianaZone = 'Antarctica/Vostok';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Almaty', () {
      String ianaZone = 'Asia/Almaty';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Amman', () {
      String ianaZone = 'Asia/Amman';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Anadyr', () {
      String ianaZone = 'Asia/Anadyr';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Aqtau', () {
      String ianaZone = 'Asia/Aqtau';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Aqtobe', () {
      String ianaZone = 'Asia/Aqtobe';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Ashgabat', () {
      String ianaZone = 'Asia/Ashgabat';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Atyrau', () {
      String ianaZone = 'Asia/Atyrau';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Baghdad', () {
      String ianaZone = 'Asia/Baghdad';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Baku', () {
      String ianaZone = 'Asia/Baku';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Bangkok', () {
      String ianaZone = 'Asia/Bangkok';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Barnaul', () {
      String ianaZone = 'Asia/Barnaul';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Beirut', () {
      String ianaZone = 'Asia/Beirut';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Bishkek', () {
      String ianaZone = 'Asia/Bishkek';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Chita', () {
      String ianaZone = 'Asia/Chita';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Colombo', () {
      String ianaZone = 'Asia/Colombo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Damascus', () {
      String ianaZone = 'Asia/Damascus';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Dhaka', () {
      String ianaZone = 'Asia/Dhaka';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Dili', () {
      String ianaZone = 'Asia/Dili';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Dubai', () {
      String ianaZone = 'Asia/Dubai';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Dushanbe', () {
      String ianaZone = 'Asia/Dushanbe';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Famagusta', () {
      String ianaZone = 'Asia/Famagusta';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Gaza', () {
      String ianaZone = 'Asia/Gaza';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Hebron', () {
      String ianaZone = 'Asia/Hebron';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Ho_Chi_Minh', () {
      String ianaZone = 'Asia/Ho_Chi_Minh';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Hong_Kong', () {
      String ianaZone = 'Asia/Hong_Kong';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Hovd', () {
      String ianaZone = 'Asia/Hovd';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Irkutsk', () {
      String ianaZone = 'Asia/Irkutsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Jakarta', () {
      String ianaZone = 'Asia/Jakarta';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Jayapura', () {
      String ianaZone = 'Asia/Jayapura';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Jerusalem', () {
      String ianaZone = 'Asia/Jerusalem';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kabul', () {
      String ianaZone = 'Asia/Kabul';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kamchatka', () {
      String ianaZone = 'Asia/Kamchatka';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Karachi', () {
      String ianaZone = 'Asia/Karachi';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kathmandu', () {
      String ianaZone = 'Asia/Kathmandu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Khandyga', () {
      String ianaZone = 'Asia/Khandyga';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kolkata', () {
      String ianaZone = 'Asia/Kolkata';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Krasnoyarsk', () {
      String ianaZone = 'Asia/Krasnoyarsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kuching', () {
      String ianaZone = 'Asia/Kuching';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Macau', () {
      String ianaZone = 'Asia/Macau';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Magadan', () {
      String ianaZone = 'Asia/Magadan';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Makassar', () {
      String ianaZone = 'Asia/Makassar';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Manila', () {
      String ianaZone = 'Asia/Manila';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Nicosia', () {
      String ianaZone = 'Asia/Nicosia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Novokuznetsk', () {
      String ianaZone = 'Asia/Novokuznetsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Novosibirsk', () {
      String ianaZone = 'Asia/Novosibirsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Omsk', () {
      String ianaZone = 'Asia/Omsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Oral', () {
      String ianaZone = 'Asia/Oral';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Pontianak', () {
      String ianaZone = 'Asia/Pontianak';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Pyongyang', () {
      String ianaZone = 'Asia/Pyongyang';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Qatar', () {
      String ianaZone = 'Asia/Qatar';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Qostanay', () {
      String ianaZone = 'Asia/Qostanay';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Qyzylorda', () {
      String ianaZone = 'Asia/Qyzylorda';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Riyadh', () {
      String ianaZone = 'Asia/Riyadh';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Sakhalin', () {
      String ianaZone = 'Asia/Sakhalin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Samarkand', () {
      String ianaZone = 'Asia/Samarkand';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Seoul', () {
      String ianaZone = 'Asia/Seoul';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Shanghai', () {
      String ianaZone = 'Asia/Shanghai';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Singapore', () {
      String ianaZone = 'Asia/Singapore';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Srednekolymsk', () {
      String ianaZone = 'Asia/Srednekolymsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Taipei', () {
      String ianaZone = 'Asia/Taipei';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tashkent', () {
      String ianaZone = 'Asia/Tashkent';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tbilisi', () {
      String ianaZone = 'Asia/Tbilisi';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tehran', () {
      String ianaZone = 'Asia/Tehran';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Thimphu', () {
      String ianaZone = 'Asia/Thimphu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tokyo', () {
      String ianaZone = 'Asia/Tokyo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tomsk', () {
      String ianaZone = 'Asia/Tomsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Ulaanbaatar', () {
      String ianaZone = 'Asia/Ulaanbaatar';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Urumqi', () {
      String ianaZone = 'Asia/Urumqi';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Ust-Nera', () {
      String ianaZone = 'Asia/Ust-Nera';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Vladivostok', () {
      String ianaZone = 'Asia/Vladivostok';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Yakutsk', () {
      String ianaZone = 'Asia/Yakutsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Yangon', () {
      String ianaZone = 'Asia/Yangon';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Yekaterinburg', () {
      String ianaZone = 'Asia/Yekaterinburg';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Yerevan', () {
      String ianaZone = 'Asia/Yerevan';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Azores', () {
      String ianaZone = 'Atlantic/Azores';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Bermuda', () {
      String ianaZone = 'Atlantic/Bermuda';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Canary', () {
      String ianaZone = 'Atlantic/Canary';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Cape_Verde', () {
      String ianaZone = 'Atlantic/Cape_Verde';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Faroe', () {
      String ianaZone = 'Atlantic/Faroe';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Madeira', () {
      String ianaZone = 'Atlantic/Madeira';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/South_Georgia', () {
      String ianaZone = 'Atlantic/South_Georgia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Stanley', () {
      String ianaZone = 'Atlantic/Stanley';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Adelaide', () {
      String ianaZone = 'Australia/Adelaide';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Brisbane', () {
      String ianaZone = 'Australia/Brisbane';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Broken_Hill', () {
      String ianaZone = 'Australia/Broken_Hill';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Darwin', () {
      String ianaZone = 'Australia/Darwin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Eucla', () {
      String ianaZone = 'Australia/Eucla';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Hobart', () {
      String ianaZone = 'Australia/Hobart';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Lindeman', () {
      String ianaZone = 'Australia/Lindeman';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Lord_Howe', () {
      String ianaZone = 'Australia/Lord_Howe';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Melbourne', () {
      String ianaZone = 'Australia/Melbourne';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Perth', () {
      String ianaZone = 'Australia/Perth';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Sydney', () {
      String ianaZone = 'Australia/Sydney';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT', () {
      String ianaZone = 'Etc/GMT';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+1', () {
      String ianaZone = 'Etc/GMT+1';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-1', () {
      String ianaZone = 'Etc/GMT-1';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+10', () {
      String ianaZone = 'Etc/GMT+10';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-10', () {
      String ianaZone = 'Etc/GMT-10';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+11', () {
      String ianaZone = 'Etc/GMT+11';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-11', () {
      String ianaZone = 'Etc/GMT-11';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+12', () {
      String ianaZone = 'Etc/GMT+12';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-12', () {
      String ianaZone = 'Etc/GMT-12';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-13', () {
      String ianaZone = 'Etc/GMT-13';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-14', () {
      String ianaZone = 'Etc/GMT-14';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+2', () {
      String ianaZone = 'Etc/GMT+2';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-2', () {
      String ianaZone = 'Etc/GMT-2';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+3', () {
      String ianaZone = 'Etc/GMT+3';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-3', () {
      String ianaZone = 'Etc/GMT-3';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+4', () {
      String ianaZone = 'Etc/GMT+4';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-4', () {
      String ianaZone = 'Etc/GMT-4';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+5', () {
      String ianaZone = 'Etc/GMT+5';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-5', () {
      String ianaZone = 'Etc/GMT-5';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+6', () {
      String ianaZone = 'Etc/GMT+6';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-6', () {
      String ianaZone = 'Etc/GMT-6';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+7', () {
      String ianaZone = 'Etc/GMT+7';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-7', () {
      String ianaZone = 'Etc/GMT-7';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+8', () {
      String ianaZone = 'Etc/GMT+8';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-8', () {
      String ianaZone = 'Etc/GMT-8';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT+9', () {
      String ianaZone = 'Etc/GMT+9';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/GMT-9', () {
      String ianaZone = 'Etc/GMT-9';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Etc/UTC', () {
      String ianaZone = 'Etc/UTC';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Andorra', () {
      String ianaZone = 'Europe/Andorra';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Astrakhan', () {
      String ianaZone = 'Europe/Astrakhan';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Athens', () {
      String ianaZone = 'Europe/Athens';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Belgrade', () {
      String ianaZone = 'Europe/Belgrade';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Berlin', () {
      String ianaZone = 'Europe/Berlin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Brussels', () {
      String ianaZone = 'Europe/Brussels';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Bucharest', () {
      String ianaZone = 'Europe/Bucharest';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Budapest', () {
      String ianaZone = 'Europe/Budapest';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Chisinau', () {
      String ianaZone = 'Europe/Chisinau';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Dublin', () {
      String ianaZone = 'Europe/Dublin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Gibraltar', () {
      String ianaZone = 'Europe/Gibraltar';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Helsinki', () {
      String ianaZone = 'Europe/Helsinki';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Istanbul', () {
      String ianaZone = 'Europe/Istanbul';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Kaliningrad', () {
      String ianaZone = 'Europe/Kaliningrad';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Kirov', () {
      String ianaZone = 'Europe/Kirov';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Kyiv', () {
      String ianaZone = 'Europe/Kyiv';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Lisbon', () {
      String ianaZone = 'Europe/Lisbon';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/London', () {
      String ianaZone = 'Europe/London';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Madrid', () {
      String ianaZone = 'Europe/Madrid';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Malta', () {
      String ianaZone = 'Europe/Malta';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Minsk', () {
      String ianaZone = 'Europe/Minsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Moscow', () {
      String ianaZone = 'Europe/Moscow';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Paris', () {
      String ianaZone = 'Europe/Paris';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Prague', () {
      String ianaZone = 'Europe/Prague';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Riga', () {
      String ianaZone = 'Europe/Riga';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Rome', () {
      String ianaZone = 'Europe/Rome';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Samara', () {
      String ianaZone = 'Europe/Samara';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Saratov', () {
      String ianaZone = 'Europe/Saratov';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Simferopol', () {
      String ianaZone = 'Europe/Simferopol';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Sofia', () {
      String ianaZone = 'Europe/Sofia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Tallinn', () {
      String ianaZone = 'Europe/Tallinn';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Tirane', () {
      String ianaZone = 'Europe/Tirane';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Ulyanovsk', () {
      String ianaZone = 'Europe/Ulyanovsk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Vienna', () {
      String ianaZone = 'Europe/Vienna';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Vilnius', () {
      String ianaZone = 'Europe/Vilnius';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Volgograd', () {
      String ianaZone = 'Europe/Volgograd';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Warsaw', () {
      String ianaZone = 'Europe/Warsaw';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Zurich', () {
      String ianaZone = 'Europe/Zurich';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Factory', () {
      String ianaZone = 'Factory';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Indian/Chagos', () {
      String ianaZone = 'Indian/Chagos';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Indian/Maldives', () {
      String ianaZone = 'Indian/Maldives';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Indian/Mauritius', () {
      String ianaZone = 'Indian/Mauritius';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Apia', () {
      String ianaZone = 'Pacific/Apia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Auckland', () {
      String ianaZone = 'Pacific/Auckland';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Bougainville', () {
      String ianaZone = 'Pacific/Bougainville';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Chatham', () {
      String ianaZone = 'Pacific/Chatham';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Easter', () {
      String ianaZone = 'Pacific/Easter';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Efate', () {
      String ianaZone = 'Pacific/Efate';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Fakaofo', () {
      String ianaZone = 'Pacific/Fakaofo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Fiji', () {
      String ianaZone = 'Pacific/Fiji';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Galapagos', () {
      String ianaZone = 'Pacific/Galapagos';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Gambier', () {
      String ianaZone = 'Pacific/Gambier';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Guadalcanal', () {
      String ianaZone = 'Pacific/Guadalcanal';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Guam', () {
      String ianaZone = 'Pacific/Guam';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Honolulu', () {
      String ianaZone = 'Pacific/Honolulu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Kanton', () {
      String ianaZone = 'Pacific/Kanton';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Kiritimati', () {
      String ianaZone = 'Pacific/Kiritimati';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Kosrae', () {
      String ianaZone = 'Pacific/Kosrae';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Kwajalein', () {
      String ianaZone = 'Pacific/Kwajalein';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Marquesas', () {
      String ianaZone = 'Pacific/Marquesas';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Nauru', () {
      String ianaZone = 'Pacific/Nauru';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Niue', () {
      String ianaZone = 'Pacific/Niue';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Norfolk', () {
      String ianaZone = 'Pacific/Norfolk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Noumea', () {
      String ianaZone = 'Pacific/Noumea';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Pago_Pago', () {
      String ianaZone = 'Pacific/Pago_Pago';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Palau', () {
      String ianaZone = 'Pacific/Palau';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Pitcairn', () {
      String ianaZone = 'Pacific/Pitcairn';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Port_Moresby', () {
      String ianaZone = 'Pacific/Port_Moresby';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Rarotonga', () {
      String ianaZone = 'Pacific/Rarotonga';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Tahiti', () {
      String ianaZone = 'Pacific/Tahiti';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Tarawa', () {
      String ianaZone = 'Pacific/Tarawa';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Tongatapu', () {
      String ianaZone = 'Pacific/Tongatapu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });
  }, skip: false);

  group('IANA 2025c timezones canonical supported', () {

  }, skip: skip);

  group('IANA 2025c timezone links supported', () {
    test("Accra", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Accra";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Addis Ababa", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Addis Ababa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Asmara", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Asmara";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Asmera", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Asmera";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Bamako", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Bamako";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Bangui", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Bangui";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Banjul", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Banjul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Blantyre", () {
      String ianaZone = "Africa/Maputo";
      var searchTerm = "Blantyre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Brazzaville", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Brazzaville";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Bujumbura", () {
      String ianaZone = "Africa/Maputo";
      var searchTerm = "Bujumbura";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Conakry", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Conakry";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Dakar", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Dakar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Dar es Salaam", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Dar es Salaam";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Djibouti", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Djibouti";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Douala", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Douala";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Freetown", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Freetown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Gaborone", () {
      String ianaZone = "Africa/Maputo";
      var searchTerm = "Gaborone";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Harare", () {
      String ianaZone = "Africa/Maputo";
      var searchTerm = "Harare";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kampala", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Kampala";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kigali", () {
      String ianaZone = "Africa/Maputo";
      var searchTerm = "Kigali";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kinshasa", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Kinshasa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Libreville", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Libreville";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Lome", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Lome";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Luanda", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Luanda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Lubumbashi", () {
      String ianaZone = "Africa/Maputo";
      var searchTerm = "Lubumbashi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Lusaka", () {
      String ianaZone = "Africa/Maputo";
      var searchTerm = "Lusaka";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Malabo", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Malabo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Maseru", () {
      String ianaZone = "Africa/Johannesburg";
      var searchTerm = "Maseru";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Mbabane", () {
      String ianaZone = "Africa/Johannesburg";
      var searchTerm = "Mbabane";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Mogadishu", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Mogadishu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Niamey", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Niamey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Nouakchott", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Nouakchott";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Ouagadougou", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Ouagadougou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Porto-Novo", () {
      String ianaZone = "Africa/Lagos";
      var searchTerm = "Porto-Novo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Timbuktu", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Timbuktu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Anguilla", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Anguilla";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Antigua", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Antigua";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("ComodRivadavia", () {
      String ianaZone = "America/Argentina/Catamarca";
      var searchTerm = "ComodRivadavia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Aruba", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Aruba";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Atikokan", () {
      String ianaZone = "America/Panama";
      var searchTerm = "Atikokan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Atka", () {
      String ianaZone = "America/Adak";
      var searchTerm = "Atka";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Blanc-Sablon", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Blanc-Sablon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Buenos Aires", () {
      String ianaZone = "America/Argentina/Buenos_Aires";
      var searchTerm = "Buenos Aires";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Catamarca", () {
      String ianaZone = "America/Argentina/Catamarca";
      var searchTerm = "Catamarca";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Cayman", () {
      String ianaZone = "America/Panama";
      var searchTerm = "Cayman";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Coral Harbour", () {
      String ianaZone = "America/Panama";
      var searchTerm = "Coral Harbour";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Cordoba", () {
      String ianaZone = "America/Argentina/Cordoba";
      var searchTerm = "Cordoba";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Creston", () {
      String ianaZone = "America/Phoenix";
      var searchTerm = "Creston";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Curacao", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Curacao";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Dominica", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Dominica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Ensenada", () {
      String ianaZone = "America/Tijuana";
      var searchTerm = "Ensenada";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Fort Wayne", () {
      String ianaZone = "America/Indiana/Indianapolis";
      var searchTerm = "Fort Wayne";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Godthab", () {
      String ianaZone = "America/Nuuk";
      var searchTerm = "Godthab";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Grenada", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Grenada";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Guadeloupe", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Guadeloupe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Indianapolis", () {
      String ianaZone = "America/Indiana/Indianapolis";
      var searchTerm = "Indianapolis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Jujuy", () {
      String ianaZone = "America/Argentina/Jujuy";
      var searchTerm = "Jujuy";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Knox IN", () {
      String ianaZone = "America/Indiana/Knox";
      var searchTerm = "Knox IN";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kralendijk", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Kralendijk";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Louisville", () {
      String ianaZone = "America/Kentucky/Louisville";
      var searchTerm = "Louisville";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Lower Princes", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Lower Princes";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Marigot", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Marigot";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Mendoza", () {
      String ianaZone = "America/Argentina/Mendoza";
      var searchTerm = "Mendoza";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Montreal", () {
      String ianaZone = "America/Toronto";
      var searchTerm = "Montreal";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Montserrat", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Montserrat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Nassau", () {
      String ianaZone = "America/Toronto";
      var searchTerm = "Nassau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Nipigon", () {
      String ianaZone = "America/Toronto";
      var searchTerm = "Nipigon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Pangnirtung", () {
      String ianaZone = "America/Iqaluit";
      var searchTerm = "Pangnirtung";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Porto Acre", () {
      String ianaZone = "America/Rio_Branco";
      var searchTerm = "Porto Acre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Port of Spain", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Port of Spain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Rainy River", () {
      String ianaZone = "America/Winnipeg";
      var searchTerm = "Rainy River";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Rosario", () {
      String ianaZone = "America/Argentina/Cordoba";
      var searchTerm = "Rosario";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Santa Isabel", () {
      String ianaZone = "America/Tijuana";
      var searchTerm = "Santa Isabel";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Shiprock", () {
      String ianaZone = "America/Denver";
      var searchTerm = "Shiprock";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("St Barthelemy", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "St Barthelemy";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("St Kitts", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "St Kitts";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("St Lucia", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "St Lucia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("St Thomas", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "St Thomas";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("St Vincent", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "St Vincent";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Thunder Bay", () {
      String ianaZone = "America/Toronto";
      var searchTerm = "Thunder Bay";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Tortola", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Tortola";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Virgin", () {
      String ianaZone = "America/Puerto_Rico";
      var searchTerm = "Virgin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Yellowknife", () {
      String ianaZone = "America/Edmonton";
      var searchTerm = "Yellowknife";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("DumontDUrville", () {
      String ianaZone = "Pacific/Port_Moresby";
      var searchTerm = "DumontDUrville";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("McMurdo", () {
      String ianaZone = "Pacific/Auckland";
      var searchTerm = "McMurdo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("South Pole", () {
      String ianaZone = "Pacific/Auckland";
      var searchTerm = "South Pole";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Syowa", () {
      String ianaZone = "Asia/Riyadh";
      var searchTerm = "Syowa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Longyearbyen", () {
      String ianaZone = "Europe/Berlin";
      var searchTerm = "Longyearbyen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Aden", () {
      String ianaZone = "Asia/Riyadh";
      var searchTerm = "Aden";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Ashkhabad", () {
      String ianaZone = "Asia/Ashgabat";
      var searchTerm = "Ashkhabad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Bahrain", () {
      String ianaZone = "Asia/Qatar";
      var searchTerm = "Bahrain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Brunei", () {
      String ianaZone = "Asia/Kuching";
      var searchTerm = "Brunei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Calcutta", () {
      String ianaZone = "Asia/Kolkata";
      var searchTerm = "Calcutta";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Choibalsan", () {
      String ianaZone = "Asia/Ulaanbaatar";
      var searchTerm = "Choibalsan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Chongqing", () {
      String ianaZone = "Asia/Shanghai";
      var searchTerm = "Chongqing";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Chungking", () {
      String ianaZone = "Asia/Shanghai";
      var searchTerm = "Chungking";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Dacca", () {
      String ianaZone = "Asia/Dhaka";
      var searchTerm = "Dacca";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Harbin", () {
      String ianaZone = "Asia/Shanghai";
      var searchTerm = "Harbin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Istanbul", () {
      String ianaZone = "Europe/Istanbul";
      var searchTerm = "Istanbul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kashgar", () {
      String ianaZone = "Asia/Urumqi";
      var searchTerm = "Kashgar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Katmandu", () {
      String ianaZone = "Asia/Kathmandu";
      var searchTerm = "Katmandu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kuala Lumpur", () {
      String ianaZone = "Asia/Singapore";
      var searchTerm = "Kuala Lumpur";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kuwait", () {
      String ianaZone = "Asia/Riyadh";
      var searchTerm = "Kuwait";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Macao", () {
      String ianaZone = "Asia/Macau";
      var searchTerm = "Macao";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Muscat", () {
      String ianaZone = "Asia/Dubai";
      var searchTerm = "Muscat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Phnom Penh", () {
      String ianaZone = "Asia/Bangkok";
      var searchTerm = "Phnom Penh";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Rangoon", () {
      String ianaZone = "Asia/Yangon";
      var searchTerm = "Rangoon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Saigon", () {
      String ianaZone = "Asia/Ho_Chi_Minh";
      var searchTerm = "Saigon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Tel Aviv", () {
      String ianaZone = "Asia/Jerusalem";
      var searchTerm = "Tel Aviv";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Thimbu", () {
      String ianaZone = "Asia/Thimphu";
      var searchTerm = "Thimbu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Ujung Pandang", () {
      String ianaZone = "Asia/Makassar";
      var searchTerm = "Ujung Pandang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Ulan Bator", () {
      String ianaZone = "Asia/Ulaanbaatar";
      var searchTerm = "Ulan Bator";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Vientiane", () {
      String ianaZone = "Asia/Bangkok";
      var searchTerm = "Vientiane";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Faeroe", () {
      String ianaZone = "Atlantic/Faroe";
      var searchTerm = "Faeroe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Jan Mayen", () {
      String ianaZone = "Europe/Berlin";
      var searchTerm = "Jan Mayen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Reykjavik", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Reykjavik";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("St Helena", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "St Helena";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("ACT", () {
      String ianaZone = "Australia/Sydney";
      var searchTerm = "ACT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Canberra", () {
      String ianaZone = "Australia/Sydney";
      var searchTerm = "Canberra";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Currie", () {
      String ianaZone = "Australia/Hobart";
      var searchTerm = "Currie";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("LHI", () {
      String ianaZone = "Australia/Lord_Howe";
      var searchTerm = "LHI";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("North", () {
      String ianaZone = "Australia/Darwin";
      var searchTerm = "North";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("NSW", () {
      String ianaZone = "Australia/Sydney";
      var searchTerm = "NSW";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Queensland", () {
      String ianaZone = "Australia/Brisbane";
      var searchTerm = "Queensland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("South", () {
      String ianaZone = "Australia/Adelaide";
      var searchTerm = "South";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Tasmania", () {
      String ianaZone = "Australia/Hobart";
      var searchTerm = "Tasmania";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Victoria", () {
      String ianaZone = "Australia/Melbourne";
      var searchTerm = "Victoria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("West", () {
      String ianaZone = "Australia/Perth";
      var searchTerm = "West";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Yancowinna", () {
      String ianaZone = "Australia/Broken_Hill";
      var searchTerm = "Yancowinna";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Acre", () {
      String ianaZone = "America/Rio_Branco";
      var searchTerm = "Acre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("DeNoronha", () {
      String ianaZone = "America/Noronha";
      var searchTerm = "DeNoronha";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("East", () {
      String ianaZone = "America/Sao_Paulo";
      var searchTerm = "East";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("West", () {
      String ianaZone = "America/Manaus";
      var searchTerm = "West";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Atlantic", () {
      String ianaZone = "America/Halifax";
      var searchTerm = "Atlantic";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Central", () {
      String ianaZone = "America/Winnipeg";
      var searchTerm = "Central";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Eastern", () {
      String ianaZone = "America/Toronto";
      var searchTerm = "Eastern";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Mountain", () {
      String ianaZone = "America/Edmonton";
      var searchTerm = "Mountain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Newfoundland", () {
      String ianaZone = "America/St_Johns";
      var searchTerm = "Newfoundland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Pacific", () {
      String ianaZone = "America/Vancouver";
      var searchTerm = "Pacific";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Saskatchewan", () {
      String ianaZone = "America/Regina";
      var searchTerm = "Saskatchewan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Yukon", () {
      String ianaZone = "America/Whitehorse";
      var searchTerm = "Yukon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("CET", () {
      String ianaZone = "Europe/Brussels";
      var searchTerm = "CET";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Continental", () {
      String ianaZone = "America/Santiago";
      var searchTerm = "Continental";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("EasterIsland", () {
      String ianaZone = "Pacific/Easter";
      var searchTerm = "EasterIsland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("CST6CDT", () {
      String ianaZone = "America/Chicago";
      var searchTerm = "CST6CDT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Cuba", () {
      String ianaZone = "America/Havana";
      var searchTerm = "Cuba";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("EET", () {
      String ianaZone = "Europe/Athens";
      var searchTerm = "EET";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Egypt", () {
      String ianaZone = "Africa/Cairo";
      var searchTerm = "Egypt";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Eire", () {
      String ianaZone = "Europe/Dublin";
      var searchTerm = "Eire";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("EST5EDT", () {
      String ianaZone = "America/New_York";
      var searchTerm = "EST5EDT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("EST", () {
      String ianaZone = "America/Panama";
      var searchTerm = "EST";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GMT+0", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "GMT+0";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GMT-0", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "GMT-0";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GMT0", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "GMT0";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Greenwich", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "Greenwich";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("UCT", () {
      String ianaZone = "Etc/UTC";
      var searchTerm = "UCT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Universal", () {
      String ianaZone = "Etc/UTC";
      var searchTerm = "Universal";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Zulu", () {
      String ianaZone = "Etc/UTC";
      var searchTerm = "Zulu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Amsterdam", () {
      String ianaZone = "Europe/Brussels";
      var searchTerm = "Amsterdam";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Belfast", () {
      String ianaZone = "Europe/London";
      var searchTerm = "Belfast";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Bratislava", () {
      String ianaZone = "Europe/Prague";
      var searchTerm = "Bratislava";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Busingen", () {
      String ianaZone = "Europe/Zurich";
      var searchTerm = "Busingen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Copenhagen", () {
      String ianaZone = "Europe/Berlin";
      var searchTerm = "Copenhagen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Guernsey", () {
      String ianaZone = "Europe/London";
      var searchTerm = "Guernsey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Isle of Man", () {
      String ianaZone = "Europe/London";
      var searchTerm = "Isle of Man";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Jersey", () {
      String ianaZone = "Europe/London";
      var searchTerm = "Jersey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kiev", () {
      String ianaZone = "Europe/Kyiv";
      var searchTerm = "Kiev";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Ljubljana", () {
      String ianaZone = "Europe/Belgrade";
      var searchTerm = "Ljubljana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Luxembourg", () {
      String ianaZone = "Europe/Brussels";
      var searchTerm = "Luxembourg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Mariehamn", () {
      String ianaZone = "Europe/Helsinki";
      var searchTerm = "Mariehamn";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Monaco", () {
      String ianaZone = "Europe/Paris";
      var searchTerm = "Monaco";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Nicosia", () {
      String ianaZone = "Asia/Nicosia";
      var searchTerm = "Nicosia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Oslo", () {
      String ianaZone = "Europe/Berlin";
      var searchTerm = "Oslo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Podgorica", () {
      String ianaZone = "Europe/Belgrade";
      var searchTerm = "Podgorica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("San Marino", () {
      String ianaZone = "Europe/Rome";
      var searchTerm = "San Marino";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Sarajevo", () {
      String ianaZone = "Europe/Belgrade";
      var searchTerm = "Sarajevo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Skopje", () {
      String ianaZone = "Europe/Belgrade";
      var searchTerm = "Skopje";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Stockholm", () {
      String ianaZone = "Europe/Berlin";
      var searchTerm = "Stockholm";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Tiraspol", () {
      String ianaZone = "Europe/Chisinau";
      var searchTerm = "Tiraspol";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Uzhgorod", () {
      String ianaZone = "Europe/Kyiv";
      var searchTerm = "Uzhgorod";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Vaduz", () {
      String ianaZone = "Europe/Zurich";
      var searchTerm = "Vaduz";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Vatican", () {
      String ianaZone = "Europe/Rome";
      var searchTerm = "Vatican";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Zagreb", () {
      String ianaZone = "Europe/Belgrade";
      var searchTerm = "Zagreb";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Zaporozhye", () {
      String ianaZone = "Europe/Kyiv";
      var searchTerm = "Zaporozhye";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GB-Eire", () {
      String ianaZone = "Europe/London";
      var searchTerm = "GB-Eire";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GB", () {
      String ianaZone = "Europe/London";
      var searchTerm = "GB";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GMT+0", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "GMT+0";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GMT-0", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "GMT-0";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GMT0", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "GMT0";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("GMT", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "GMT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Greenwich", () {
      String ianaZone = "Etc/GMT";
      var searchTerm = "Greenwich";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Hongkong", () {
      String ianaZone = "Asia/Hong_Kong";
      var searchTerm = "Hongkong";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("HST", () {
      String ianaZone = "Pacific/Honolulu";
      var searchTerm = "HST";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Iceland", () {
      String ianaZone = "Africa/Abidjan";
      var searchTerm = "Iceland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Antananarivo", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Antananarivo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Christmas", () {
      String ianaZone = "Asia/Bangkok";
      var searchTerm = "Christmas";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Cocos", () {
      String ianaZone = "Asia/Yangon";
      var searchTerm = "Cocos";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Comoro", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Comoro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kerguelen", () {
      String ianaZone = "Indian/Maldives";
      var searchTerm = "Kerguelen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Mahe", () {
      String ianaZone = "Asia/Dubai";
      var searchTerm = "Mahe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Mayotte", () {
      String ianaZone = "Africa/Nairobi";
      var searchTerm = "Mayotte";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Reunion", () {
      String ianaZone = "Asia/Dubai";
      var searchTerm = "Reunion";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Iran", () {
      String ianaZone = "Asia/Tehran";
      var searchTerm = "Iran";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Israel", () {
      String ianaZone = "Asia/Jerusalem";
      var searchTerm = "Israel";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Jamaica", () {
      String ianaZone = "America/Jamaica";
      var searchTerm = "Jamaica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Japan", () {
      String ianaZone = "Asia/Tokyo";
      var searchTerm = "Japan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Kwajalein", () {
      String ianaZone = "Pacific/Kwajalein";
      var searchTerm = "Kwajalein";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Libya", () {
      String ianaZone = "Africa/Tripoli";
      var searchTerm = "Libya";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("MET", () {
      String ianaZone = "Europe/Brussels";
      var searchTerm = "MET";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("BajaNorte", () {
      String ianaZone = "America/Tijuana";
      var searchTerm = "BajaNorte";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("BajaSur", () {
      String ianaZone = "America/Mazatlan";
      var searchTerm = "BajaSur";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("General", () {
      String ianaZone = "America/Mexico_City";
      var searchTerm = "General";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("MST7MDT", () {
      String ianaZone = "America/Denver";
      var searchTerm = "MST7MDT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("MST", () {
      String ianaZone = "America/Phoenix";
      var searchTerm = "MST";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Navajo", () {
      String ianaZone = "America/Denver";
      var searchTerm = "Navajo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("NZ-CHAT", () {
      String ianaZone = "Pacific/Chatham";
      var searchTerm = "NZ-CHAT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("NZ", () {
      String ianaZone = "Pacific/Auckland";
      var searchTerm = "NZ";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Chuuk", () {
      String ianaZone = "Pacific/Port_Moresby";
      var searchTerm = "Chuuk";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Enderbury", () {
      String ianaZone = "Pacific/Kanton";
      var searchTerm = "Enderbury";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Funafuti", () {
      String ianaZone = "Pacific/Tarawa";
      var searchTerm = "Funafuti";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Johnston", () {
      String ianaZone = "Pacific/Honolulu";
      var searchTerm = "Johnston";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Majuro", () {
      String ianaZone = "Pacific/Tarawa";
      var searchTerm = "Majuro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Midway", () {
      String ianaZone = "Pacific/Pago_Pago";
      var searchTerm = "Midway";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Pohnpei", () {
      String ianaZone = "Pacific/Guadalcanal";
      var searchTerm = "Pohnpei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Ponape", () {
      String ianaZone = "Pacific/Guadalcanal";
      var searchTerm = "Ponape";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Saipan", () {
      String ianaZone = "Pacific/Guam";
      var searchTerm = "Saipan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Samoa", () {
      String ianaZone = "Pacific/Pago_Pago";
      var searchTerm = "Samoa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Truk", () {
      String ianaZone = "Pacific/Port_Moresby";
      var searchTerm = "Truk";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Wake", () {
      String ianaZone = "Pacific/Tarawa";
      var searchTerm = "Wake";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Wallis", () {
      String ianaZone = "Pacific/Tarawa";
      var searchTerm = "Wallis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Yap", () {
      String ianaZone = "Pacific/Port_Moresby";
      var searchTerm = "Yap";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Poland", () {
      String ianaZone = "Europe/Warsaw";
      var searchTerm = "Poland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Portugal", () {
      String ianaZone = "Europe/Lisbon";
      var searchTerm = "Portugal";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("PRC", () {
      String ianaZone = "Asia/Shanghai";
      var searchTerm = "PRC";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("PST8PDT", () {
      String ianaZone = "America/Los_Angeles";
      var searchTerm = "PST8PDT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("ROC", () {
      String ianaZone = "Asia/Taipei";
      var searchTerm = "ROC";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("ROK", () {
      String ianaZone = "Asia/Seoul";
      var searchTerm = "ROK";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Singapore", () {
      String ianaZone = "Asia/Singapore";
      var searchTerm = "Singapore";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Turkey", () {
      String ianaZone = "Europe/Istanbul";
      var searchTerm = "Turkey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("UCT", () {
      String ianaZone = "Etc/UTC";
      var searchTerm = "UCT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Universal", () {
      String ianaZone = "Etc/UTC";
      var searchTerm = "Universal";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Alaska", () {
      String ianaZone = "America/Anchorage";
      var searchTerm = "Alaska";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Aleutian", () {
      String ianaZone = "America/Adak";
      var searchTerm = "Aleutian";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Arizona", () {
      String ianaZone = "America/Phoenix";
      var searchTerm = "Arizona";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Central", () {
      String ianaZone = "America/Chicago";
      var searchTerm = "Central";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Eastern", () {
      String ianaZone = "America/New_York";
      var searchTerm = "Eastern";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("East-Indiana", () {
      String ianaZone = "America/Indiana/Indianapolis";
      var searchTerm = "East-Indiana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Hawaii", () {
      String ianaZone = "Pacific/Honolulu";
      var searchTerm = "Hawaii";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Indiana-Starke", () {
      String ianaZone = "America/Indiana/Knox";
      var searchTerm = "Indiana-Starke";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Michigan", () {
      String ianaZone = "America/Detroit";
      var searchTerm = "Michigan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Mountain", () {
      String ianaZone = "America/Denver";
      var searchTerm = "Mountain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Pacific", () {
      String ianaZone = "America/Los_Angeles";
      var searchTerm = "Pacific";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Samoa", () {
      String ianaZone = "Pacific/Pago_Pago";
      var searchTerm = "Samoa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("UTC", () {
      String ianaZone = "Etc/UTC";
      var searchTerm = "UTC";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("WET", () {
      String ianaZone = "Europe/Lisbon";
      var searchTerm = "WET";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("W-SU", () {
      String ianaZone = "Europe/Moscow";
      var searchTerm = "W-SU";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test("Zulu", () {
      String ianaZone = "Etc/UTC";
      var searchTerm = "Zulu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });
  }, skip: skip);

  group('timezone search offsets', () {

    test('UTC+0', () {
      var searchTerm = 'UTC+0';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+1', () {
      var searchTerm = 'UTC+1';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-1', () {
      var searchTerm = 'UTC-1';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+10', () {
      var searchTerm = 'UTC+10';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-10', () {
      var searchTerm = 'UTC-10';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+10:30', () {
      var searchTerm = 'UTC+10:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+11', () {
      var searchTerm = 'UTC+11';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-11', () {
      var searchTerm = 'UTC-11';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+12', () {
      var searchTerm = 'UTC+12';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-12', () {
      var searchTerm = 'UTC-12';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+12:45', () {
      var searchTerm = 'UTC+12:45';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+13', () {
      var searchTerm = 'UTC+13';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+13:45', () {
      var searchTerm = 'UTC+13:45';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+14', () {
      var searchTerm = 'UTC+14';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+2', () {
      var searchTerm = 'UTC+2';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-2', () {
      var searchTerm = 'UTC-2';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-2:30', () {
      var searchTerm = 'UTC-2:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+3', () {
      var searchTerm = 'UTC+3';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-3', () {
      var searchTerm = 'UTC-3';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+3:30', () {
      var searchTerm = 'UTC+3:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-3:30', () {
      var searchTerm = 'UTC-3:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+4', () {
      var searchTerm = 'UTC+4';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-4', () {
      var searchTerm = 'UTC-4';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+4:30', () {
      var searchTerm = 'UTC+4:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+5', () {
      var searchTerm = 'UTC+5';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-5', () {
      var searchTerm = 'UTC-5';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+5:30', () {
      var searchTerm = 'UTC+5:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+5:45', () {
      var searchTerm = 'UTC+5:45';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+6', () {
      var searchTerm = 'UTC+6';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-6', () {
      var searchTerm = 'UTC-6';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+6:30', () {
      var searchTerm = 'UTC+6:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+7', () {
      var searchTerm = 'UTC+7';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-7', () {
      var searchTerm = 'UTC-7';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+8', () {
      var searchTerm = 'UTC+8';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-8', () {
      var searchTerm = 'UTC-8';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+8:30 -- unused', () {  // https://en.wikipedia.org/wiki/UTC%2B08:30
      var searchTerm = 'UTC+8:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));  // no longer in use!
    });

    test('UTC+8:45 -- unofficial', () {  // https://en.wikipedia.org/wiki/UTC%2B08:45
      var searchTerm = 'UTC+8:45';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+9', () {
      var searchTerm = 'UTC+9';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-9', () {
      var searchTerm = 'UTC-9';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+9:30', () {
      var searchTerm = 'UTC+9:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-9:30', () {
      var searchTerm = 'UTC-9:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+10.50', () {
      var searchTerm = 'UTC+10.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+12.75', () {
      var searchTerm = 'UTC+12.75';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+13.75', () {
      var searchTerm = 'UTC+13.75';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-2.50', () {
      var searchTerm = 'UTC-2.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+3.50', () {
      var searchTerm = 'UTC+3.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-3.50', () {
      var searchTerm = 'UTC-3.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+4.50', () {
      var searchTerm = 'UTC+4.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+5.50', () {
      var searchTerm = 'UTC+5.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+5.75', () {
      var searchTerm = 'UTC+5.75';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+6.50', () {
      var searchTerm = 'UTC+6.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+8.75', () {
      var searchTerm = 'UTC+8.75';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+9.50', () {
      var searchTerm = 'UTC+9.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-9.50', () {
      var searchTerm = 'UTC-9.50';
      var loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      searchTerm = searchTerm.replaceFirst('.', ',');
      loc = searchByOffset(searchTerm, tzDatabase);
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });
  }, skip: false);

  group('timezone search abbreviations', () {
    test('ACDT', () {
      var searchTerm = 'ACDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ACST', () {
      var searchTerm = 'ACST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ACT', () {
      var searchTerm = 'ACT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ACWST', () {
      var searchTerm = 'ACWST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ADT', () {
      var searchTerm = 'ADT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AEDT', () {
      var searchTerm = 'AEDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AEST', () {
      var searchTerm = 'AEST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AET', () {
      var searchTerm = 'AET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AFT', () {
      var searchTerm = 'AFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AKDT', () {
      var searchTerm = 'AKDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AKST', () {
      var searchTerm = 'AKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ALMT', () {
      var searchTerm = 'ALMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AMST', () {
      var searchTerm = 'AMST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AMT', () {
      var searchTerm = 'AMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ANAST -- unused', () {
      var searchTerm = 'ANAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('ANAT', () {
      var searchTerm = 'ANAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AoE', () {
      var searchTerm = 'AoE';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AQTT', () {
      var searchTerm = 'AQTT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ART', () {
      var searchTerm = 'ART';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AST', () {
      var searchTerm = 'AST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AT', () {
      var searchTerm = 'AT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AWDT -- unused', () {
      var searchTerm = 'AWDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('AWST', () {
      var searchTerm = 'AWST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AZOST', () {
      var searchTerm = 'AZOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AZOT', () {
      var searchTerm = 'AZOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('AZST -- unused', () {
      var searchTerm = 'AZST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('AZT', () {
      var searchTerm = 'AZT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('BNT', () {
      var searchTerm = 'BNT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('BOT', () {
      var searchTerm = 'BOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('BRST', () {
      var searchTerm = 'BRST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('BRT', () {
      var searchTerm = 'BRT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('BST', () {
      var searchTerm = 'BST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('BTT', () {
      var searchTerm = 'BTT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CAST', () {
      var searchTerm = 'CAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CAT', () {
      var searchTerm = 'CAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CCT', () {
      var searchTerm = 'CCT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CDT', () {
      var searchTerm = 'CDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CEST', () {
      var searchTerm = 'CEST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CET', () {
      var searchTerm = 'CET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CHADT', () {
      var searchTerm = 'CHADT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CHAST', () {
      var searchTerm = 'CHAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CHOST', () {
      var searchTerm = 'CHOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CHOT', () {
      var searchTerm = 'CHOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ChST', () {
      var searchTerm = 'ChST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CHUT', () {
      var searchTerm = 'CHUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CIDST', () {
      var searchTerm = 'CIDST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CIST', () {
      var searchTerm = 'CIST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CKT', () {
      var searchTerm = 'CKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CLST', () {
      var searchTerm = 'CLST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CLT', () {
      var searchTerm = 'CLT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('COT', () {
      var searchTerm = 'COT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CST', () {
      var searchTerm = 'CST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CT', () {
      var searchTerm = 'CT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CVT', () {
      var searchTerm = 'CVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('CXT', () {
      var searchTerm = 'CXT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('DAVT', () {
      var searchTerm = 'DAVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('DDUT', () {
      var searchTerm = 'DDUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EASST', () {
      var searchTerm = 'EASST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EAST', () {
      var searchTerm = 'EAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EAT', () {
      var searchTerm = 'EAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ECT', () {
      var searchTerm = 'ECT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EDT', () {
      var searchTerm = 'EDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EEST', () {
      var searchTerm = 'EEST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EET', () {
      var searchTerm = 'EET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EGST', () {
      var searchTerm = 'EGST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EGT', () {
      var searchTerm = 'EGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('EST', () {
      var searchTerm = 'EST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ET', () {
      var searchTerm = 'ET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('FET', () {
      var searchTerm = 'FET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('FJST -- unused', () {
      var searchTerm = 'FJST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('FJT', () {
      var searchTerm = 'FJT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('FKST', () {
      var searchTerm = 'FKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('FKT', () {
      var searchTerm = 'FKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('FNT', () {
      var searchTerm = 'FNT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('GALT', () {
      var searchTerm = 'GALT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('GAMT', () {
      var searchTerm = 'GAMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('GET', () {
      var searchTerm = 'GET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('GFT', () {
      var searchTerm = 'GFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('GILT', () {
      var searchTerm = 'GILT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('GMT', () {
      var searchTerm = 'GMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('GST', () {
      var searchTerm = 'GST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('GYT', () {
      var searchTerm = 'GYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('HDT', () {
      var searchTerm = 'HDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('HKT', () {
      var searchTerm = 'HKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('HOVST', () {
      var searchTerm = 'HOVST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('HOVT', () {
      var searchTerm = 'HOVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('HST', () {
      var searchTerm = 'HST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ICT', () {
      var searchTerm = 'ICT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('IDT', () {
      var searchTerm = 'IDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('IOT', () {
      var searchTerm = 'IOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('IRDT -- unused', () {  // Iran Daylight Time
      var searchTerm = 'IRDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('IRKST -- unused', () {
      var searchTerm = 'IRKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('IRKT', () {
      var searchTerm = 'IRKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('IRST', () {
      var searchTerm = 'IRST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('IST', () {
      var searchTerm = 'IST';  // This should not match Istanbul.
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(3));
      expect(loc.any((tzE) => tzE.ianaZone == 'Asia/Jerusalem'), isTrue); // israel standard time
      expect(loc.any((tzE) => tzE.ianaZone == 'Asia/Kolkata'), isTrue);   // india standard time
      expect(loc.any((tzE) => tzE.ianaZone == 'Europe/Dublin'), isTrue);  // irish standard time
      expect(loc.any((tzE) => tzE.ianaZone == 'Europe/Istanbul'), isFalse);

      searchTerm = 'ist';  // This should match Istanbul.
      loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
      expect(loc.any((tzE) => tzE.ianaZone == 'Europe/Istanbul'), isTrue);
    });

    test('JST', () {
      var searchTerm = 'JST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('KGT', () {
      var searchTerm = 'KGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('KOST', () {
      var searchTerm = 'KOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('KRAST -- unused', () {
      var searchTerm = 'KRAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('KRAT', () {
      var searchTerm = 'KRAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('KST', () {
      var searchTerm = 'KST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('KUYT', () {
      var searchTerm = 'KUYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('LHDT', () {
      var searchTerm = 'LHDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('LHST', () {
      var searchTerm = 'LHST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('LINT', () {
      var searchTerm = 'LINT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MAGST -- unused', () {
      var searchTerm = 'MAGST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('MAGT', () {
      var searchTerm = 'MAGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MART', () {
      var searchTerm = 'MART';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MAWT', () {
      var searchTerm = 'MAWT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MDT', () {
      var searchTerm = 'MDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MHT', () {
      var searchTerm = 'MHT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MMT', () {
      var searchTerm = 'MMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MSD', () {
      var searchTerm = 'MSD';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MSK', () {
      var searchTerm = 'MSK';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MST', () {
      var searchTerm = 'MST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("MT", () {
      var searchTerm = 'MT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MUT', () {
      var searchTerm = 'MUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MVT', () {
      var searchTerm = 'MVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('MYT', () {
      var searchTerm = 'MYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NCT', () {
      var searchTerm = 'NCT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NDT', () {
      var searchTerm = 'NDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NFDT', () {
      var searchTerm = 'NFDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NFT', () {
      var searchTerm = 'NFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NOVST', () {
      var searchTerm = 'NOVST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NOVT', () {
      var searchTerm = 'NOVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NPT', () {
      var searchTerm = 'NPT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NRT', () {
      var searchTerm = 'NRT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NST', () {
      var searchTerm = 'NST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NUT', () {
      var searchTerm = 'NUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NZDT', () {
      var searchTerm = 'NZDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('NZST', () {
      var searchTerm = 'NZST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('OMSST -- unused', () {
      var searchTerm = 'OMSST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('OMST', () {
      var searchTerm = 'OMST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ORAT', () {
      var searchTerm = 'ORAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PDT', () {
      var searchTerm = 'PDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PET', () {
      var searchTerm = 'PET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PETST -- unused', () {
      var searchTerm = 'PETST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('PETT', () {
      var searchTerm = 'PETT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PGT', () {
      var searchTerm = 'PGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PHOT', () {
      var searchTerm = 'PHOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PHT', () {
      var searchTerm = 'PHT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PKT', () {
      var searchTerm = 'PKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PMDT', () {
      var searchTerm = 'PMDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PMST', () {
      var searchTerm = 'PMST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PONT', () {
      var searchTerm = 'PONT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PST', () {
      var searchTerm = 'PST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PT', () {
      var searchTerm = 'PT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PWT', () {
      var searchTerm = 'PWT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PYST', () {
      var searchTerm = 'PYST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('PYT', () {
      var searchTerm = 'PYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('QYZT', () {
      var searchTerm = 'QYZT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('RET', () {
      var searchTerm = 'RET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SAKT', () {
      var searchTerm = 'SAKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SAMT', () {
      var searchTerm = 'SAMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SAST', () {
      var searchTerm = 'SAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SBT', () {
      var searchTerm = 'SBT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SCT', () {
      var searchTerm = 'SCT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SGT', () {
      var searchTerm = 'SGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SRET -- unused', () {
      var searchTerm = 'SRET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('SRT', () {
      var searchTerm = 'SRT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SST', () {
      var searchTerm = 'SST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('SYOT', () {
      var searchTerm = 'SYOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TAHT', () {
      var searchTerm = 'TAHT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TFT', () {
      var searchTerm = 'TFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TJT', () {
      var searchTerm = 'TJT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TKT', () {
      var searchTerm = 'TKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TLT', () {
      var searchTerm = 'TLT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TMT', () {
      var searchTerm = 'TMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TOST', () {
      var searchTerm = 'TOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TOT', () {
      var searchTerm = 'TOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TRT', () {
      var searchTerm = 'TRT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('TVT', () {
      var searchTerm = 'TVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ULAST', () {
      var searchTerm = 'ULAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('ULAT', () {
      var searchTerm = 'ULAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UTC -- not needed', () {    // No need to handle this in the search.
      var searchTerm = 'UTC';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('UYST', () {
      var searchTerm = 'UYST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UYT', () {
      var searchTerm = 'UYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('UZT', () {
      var searchTerm = 'UZT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('VET', () {
      var searchTerm = 'VET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('VLAST -- unused', () {
      var searchTerm = 'VLAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('VLAT', () {
      var searchTerm = 'VLAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('VOST', () {
      var searchTerm = 'VOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('VUT', () {
      var searchTerm = 'VUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WAKT', () {
      var searchTerm = 'WAKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WARST', () {
      var searchTerm = 'WARST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WAST -- unused', () {
      var searchTerm = 'WAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('WAT', () {
      var searchTerm = 'WAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WEST', () {
      var searchTerm = 'WEST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WET', () {
      var searchTerm = 'WET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WFT', () {
      var searchTerm = 'WFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WGST', () {
      var searchTerm = 'WGST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WGT', () {
      var searchTerm = 'WGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WIB', () {
      var searchTerm = 'WIB';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WIT', () {
      var searchTerm = 'WIT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WITA', () {
      var searchTerm = 'WITA';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WST', () {
      var searchTerm = 'WST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('WT', () {
      var searchTerm = 'WT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('YAKST -- unused', () {
      var searchTerm = 'YAKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('YAKT', () {
      var searchTerm = 'YAKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('YAPT', () {
      var searchTerm = 'YAPT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('YEKST -- unused', () {
      var searchTerm = 'YEKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('YEKT', () {
      var searchTerm = 'YEKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+00', () {
      var searchTerm = '+00';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-00 -- not needed', () {  // Why this test? No result expected.
      var searchTerm = '-00';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test('+01', () {
      var searchTerm = '+01';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-01', () {
      var searchTerm = '-01';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+02', () {
      var searchTerm = '+02';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-02', () {
      var searchTerm = '-02';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+03', () {
      var searchTerm = '+03';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-03', () {
      var searchTerm = '-03';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+0330', () {
      var searchTerm = '+0330';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+04', () {
      var searchTerm = '+04';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-04', () {
      var searchTerm = '-04';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+0430', () {
      var searchTerm = '+0430';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+05', () {
      var searchTerm = '+05';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-05', () {
      var searchTerm = '-05';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+0530', () {
      var searchTerm = '+0530';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+0545', () {
      var searchTerm = '+0545';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+06', () {
      var searchTerm = '+06';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-06', () {
      var searchTerm = '-06';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+0630', () {
      var searchTerm = '+0630';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+07', () {
      var searchTerm = '+07';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-07', () {
      var searchTerm = '-07';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+08', () {
      var searchTerm = '+08';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-08', () {
      var searchTerm = '-08';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+0845', () {
      var searchTerm = '+0845';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+09', () {
      var searchTerm = '+09';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-09', () {
      var searchTerm = '-09';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-0930', () {
      var searchTerm = '-0930';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+10', () {
      var searchTerm = '+10';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-10', () {
      var searchTerm = '-10';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+1030', () {
      var searchTerm = '+1030';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+11', () {
      var searchTerm = '+11';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-11', () {
      var searchTerm = '-11';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+12', () {
      var searchTerm = '+12';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('-12', () {
      var searchTerm = '-12';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+1245', () {
      var searchTerm = '+1245';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+13', () {
      var searchTerm = '+13';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test('+14', () {
      var searchTerm = '+14';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });
  }, skip: skip);

  group('timezone search names', () {
    test("Acre Time", () {
      var searchTerm = "Acre Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Afghanistan Time", () {
      var searchTerm = "Afghanistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Alaska Daylight Saving Time", () {
      var searchTerm = "Alaska Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Alaska Daylight Time", () {
      var searchTerm = "Alaska Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Alaska Standard Time", () {
      var searchTerm = "Alaska Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Alaska Time", () {
      var searchTerm = "Alaska Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Alma-Ata Time", () {
      var searchTerm = "Alma-Ata Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Al Manamah Standard Time", () {
      var searchTerm = "Al Manamah Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Amazon Summer Time", () {
      var searchTerm = "Amazon Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Amazon Time", () {
      var searchTerm = "Amazon Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Anadyr Summer Time -- unused", () {
      var searchTerm = "Anadyr Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Anadyr Time", () {
      var searchTerm = "Anadyr Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Anywhere on Earth", () {
      var searchTerm = "Anywhere on Earth";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Aqtobe Time", () {
      var searchTerm = "Aqtobe Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Arabia Daylight Time", () {
      var searchTerm = "Arabia Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Arabia Standard Time", () {
      var searchTerm = "Arabia Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Arabia Summer Time", () {
      var searchTerm = "Arabia Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Arabic Standard Time", () {
      var searchTerm = "Arabic Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Argentina Time", () {
      var searchTerm = "Argentina Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Armenia Daylight Time", () {
      var searchTerm = "Armenia Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Armenia Summer Time", () {
      var searchTerm = "Armenia Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Armenia Time", () {
      var searchTerm = "Armenia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Daylight Saving Time", () {
      var searchTerm = "Atlantic Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Daylight Time", () {
      var searchTerm = "Atlantic Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Standard Time", () {
      var searchTerm = "Atlantic Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Summer Time", () {
      var searchTerm = "Atlantic Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Time", () {
      var searchTerm = "Atlantic Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Australian Central Daylight Time", () {
      var searchTerm = "Australian Central Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Australian Central Standard Time", () {
      var searchTerm = "Australian Central Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Australian Central Time", () {
      var searchTerm = "Australian Central Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Australian Central Western Standard Time", () {
      var searchTerm = "Australian Central Western Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Australian Eastern Daylight Time", () {
      var searchTerm = "Australian Eastern Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Australian Eastern Standard Time", () {
      var searchTerm = "Australian Eastern Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Australian Eastern Time", () {
      var searchTerm = "Australian Eastern Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Australian Western Daylight Time -- unused", () {
      var searchTerm = "Australian Western Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));  // no longer in use!
    });

    test("Australian Western Standard Time", () {
      var searchTerm = "Australian Western Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Azerbaijan Summer Time -- unused", () {
      var searchTerm = "Azerbaijan Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Azerbaijan Time", () {
      var searchTerm = "Azerbaijan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Azores Daylight Time", () {
      var searchTerm = "Azores Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Azores Standard Time", () {
      var searchTerm = "Azores Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Azores Summer Time", () {
      var searchTerm = "Azores Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Azores Time", () {
      var searchTerm = "Azores Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Bangladesh Standard Time", () {
      var searchTerm = "Bangladesh Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Bhutan Time", () {
      var searchTerm = "Bhutan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Bolivia Time", () {
      var searchTerm = "Bolivia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Bougainville Standard Time", () {
      var searchTerm = "Bougainville Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Brasilia Summer Time -- unused", () {
      var searchTerm = "Brasilia Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Brasilia Time", () {
      var searchTerm = "Brasilia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Brazilian Summer Time -- unused", () {
      var searchTerm = "Brazilian Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Brazilian Time", () {
      var searchTerm = "Brazilian Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Brazil Summer Time -- unused", () {
      var searchTerm = "Brazil Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Brazil Time", () {
      var searchTerm = "Brazil Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("British Daylight Saving Time", () {
      var searchTerm = "British Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("British Daylight Time", () {
      var searchTerm = "British Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("British Summer Time", () {
      var searchTerm = "British Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Brunei Darussalam Time", () {
      var searchTerm = "Brunei Darussalam Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Brunei Time", () {
      var searchTerm = "Brunei Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Cape Verde Time", () {
      var searchTerm = "Cape Verde Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Casey Time", () {
      var searchTerm = "Casey Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Cayman Islands Daylight Saving Time", () {
      var searchTerm = "Cayman Islands Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Cayman Islands Standard Time", () {
      var searchTerm = "Cayman Islands Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Cayman Islands Time", () {
      var searchTerm = "Cayman Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central Africa Time", () {
      var searchTerm = "Central Africa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central Daylight Savings Time", () {
      var searchTerm = "Central Daylight Savings Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central Daylight Saving Time", () {
      var searchTerm = "Central Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central Daylight Time", () {
      var searchTerm = "Central Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central European Daylight Time", () {
      var searchTerm = "Central European Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central European Summer Time", () {
      var searchTerm = "Central European Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central European Time", () {
      var searchTerm = "Central European Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central Europe Time", () {
      var searchTerm = "Central Europe Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central Indonesian Time", () {
      var searchTerm = "Central Indonesian Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central Standard Time", () {
      var searchTerm = "Central Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Central Time", () {
      var searchTerm = "Central Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chamorro Standard Time", () {
      var searchTerm = "Chamorro Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chatham Daylight Time", () {
      var searchTerm = "Chatham Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chatham Island Daylight Time", () {
      var searchTerm = "Chatham Island Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chatham Island Standard Time", () {
      var searchTerm = "Chatham Island Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chile Daylight Time", () {
      var searchTerm = "Chile Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chile Standard Time", () {
      var searchTerm = "Chile Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chile Summer Time", () {
      var searchTerm = "Chile Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chile Time", () {
      var searchTerm = "Chile Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("China Standard Time", () {
      var searchTerm = "China Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Choibalsan Daylight Saving Time", () {
      var searchTerm = "Choibalsan Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Choibalsan Daylight Time", () {
      var searchTerm = "Choibalsan Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Choibalsan Summer Time", () {
      var searchTerm = "Choibalsan Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Choibalsan Time", () {
      var searchTerm = "Choibalsan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Christmas Island Time", () {
      var searchTerm = "Christmas Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Chuuk Time", () {
      var searchTerm = "Chuuk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Cocos Islands Time", () {
      var searchTerm = "Cocos Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Colombia Time", () {
      var searchTerm = "Colombia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Cook Island Time", () {
      var searchTerm = "Cook Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Coordinated Universal Time -- not needed", () {  // No need to handle this in the search.
      var searchTerm = "Coordinated Universal Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));

      searchTerm = "Universal Time Coordinated";
      loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Cuba Daylight Time", () {
      var searchTerm = "Cuba Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Cuba Standard Time", () {
      var searchTerm = "Cuba Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Davis Time", () {
      var searchTerm = "Davis Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Dumont-d'Urville Time", () {
      var searchTerm = "Dumont-d'Urville Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("East Africa Time", () {
      var searchTerm = "East Africa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Easter Island Daylight Time", () {
      var searchTerm = "Easter Island Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Easter Island Standard Time", () {
      var searchTerm = "Easter Island Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Easter Island Summer Time", () {
      var searchTerm = "Easter Island Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Africa Time", () {
      var searchTerm = "Eastern Africa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Daylight Savings Time", () {
      var searchTerm = "Eastern Daylight Savings Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Daylight Saving Time", () {
      var searchTerm = "Eastern Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Daylight Time", () {
      var searchTerm = "Eastern Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern European Daylight Time", () {
      var searchTerm = "Eastern European Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern European Summer Time", () {
      var searchTerm = "Eastern European Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern European Time", () {
      var searchTerm = "Eastern European Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Greenland Summer Time", () {
      var searchTerm = "Eastern Greenland Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Greenland Time", () {
      var searchTerm = "Eastern Greenland Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Indonesian Time", () {
      var searchTerm = "Eastern Indonesian Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Standard Time", () {
      var searchTerm = "Eastern Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Time", () {
      var searchTerm = "Eastern Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("East Greenland Summer Time", () {
      var searchTerm = "East Greenland Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("East Greenland Time", () {
      var searchTerm = "East Greenland Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("East Timor Time", () {
      var searchTerm = "East Timor Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Ecuador Time", () {
      var searchTerm = "Ecuador Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Efate Time", () {
      var searchTerm = "Efate Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("European Central Summer Time", () {
      var searchTerm = "European Central Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("European Central Time", () {
      var searchTerm = "European Central Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Island Daylight Time", () {
      var searchTerm = "Falkland Island Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Islands Summer Time", () {
      var searchTerm = "Falkland Islands Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Island Standard Time", () {
      var searchTerm = "Falkland Island Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Island Time", () {
      var searchTerm = "Falkland Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Fernando de Noronha Time", () {
      var searchTerm = "Fernando de Noronha Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Fiji Daylight Time -- unused", () {
      var searchTerm = "Fiji Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));  // no longer in use!
    });

    test("Fiji Summer Time -- unused", () {
      var searchTerm = "Fiji Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));  // no longer in use!
    });

    test("Fiji Time", () {
      var searchTerm = "Fiji Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("French Guiana Time", () {
      var searchTerm = "French Guiana Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("French Southern and Antarctic Time", () {
      var searchTerm = "French Southern and Antarctic Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Further-Eastern European Time", () {
      var searchTerm = "Further-Eastern European Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Galapagos Time", () {
      var searchTerm = "Galapagos Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Gambier Islands Time", () {
      var searchTerm = "Gambier Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Gambier Time", () {
      var searchTerm = "Gambier Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Georgia Standard Time", () {
      var searchTerm = "Georgia Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Gilbert Island Time", () {
      var searchTerm = "Gilbert Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Greenwich Mean Time", () {
      var searchTerm = "Greenwich Mean Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Greenwich Time", () {
      var searchTerm = "Greenwich Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Guam Standard Time", () {
      var searchTerm = "Guam Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Gulf Standard Time", () {
      var searchTerm = "Gulf Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Guyana Time", () {
      var searchTerm = "Guyana Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Hawaii-Aleutian Daylight Time", () {
      var searchTerm = "Hawaii-Aleutian Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Hawaii-Aleutian Standard Time", () {
      var searchTerm = "Hawaii-Aleutian Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Hawaii Daylight Time -- unused", () {  // https://en.wikipedia.org/wiki/Hawaii%E2%80%93Aleutian_Time_Zone
      var searchTerm = "Hawaii Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(0));  // "Hawaii stays on standard time"
    });

    test("Hawaii Standard Time", () {
      var searchTerm = "Hawaii Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Hong Kong Time", () {
      var searchTerm = "Hong Kong Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Hovd Daylight Saving Time", () {
      var searchTerm = "Hovd Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Hovd Daylight TimeT", () {
      var searchTerm = "Hovd Daylight TimeT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Hovd Summer Time", () {
      var searchTerm = "Hovd Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Hovd Time", () {
      var searchTerm = "Hovd Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Indian Chagos Time", () {
      var searchTerm = "Indian Chagos Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Indian Standard Time", () {
      var searchTerm = "Indian Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("India Standard Time", () {
      var searchTerm = "India Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("India Time", () {
      var searchTerm = "India Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Indochina Time", () {
      var searchTerm = "Indochina Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Iran Daylight Time -- unused", () {
      var searchTerm = "Iran Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Iran Standard Time", () {
      var searchTerm = "Iran Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Iran Summer Time -- unused", () {
      var searchTerm = "Iran Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));  // no DST
    });

    test("Iran Time", () {
      var searchTerm = "Iran Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Irish Standard Time", () {
      var searchTerm = "Irish Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Irish Summer Time", () {
      var searchTerm = "Irish Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Irkutsk Summer Time -- unused", () {
      var searchTerm = "Irkutsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Irkutsk Time", () {
      var searchTerm = "Irkutsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Israel Daylight Time", () {
      var searchTerm = "Israel Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Israel Standard Time", () {
      var searchTerm = "Israel Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Japan Standard Time", () {
      var searchTerm = "Japan Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Kamchatka Summer Time -- unused", () {
      var searchTerm = "Kamchatka Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Kamchatka Time", () {
      var searchTerm = "Kamchatka Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Kerguelen (Islands) Time", () {
      var searchTerm = "Kerguelen (Islands) Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Korean Standard Time", () {
      var searchTerm = "Korean Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Korea Standard Time", () {
      var searchTerm = "Korea Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Korea Time", () {
      var searchTerm = "Korea Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Kosrae Time", () {
      var searchTerm = "Kosrae Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Krasnoyarsk Summer Time -- unused", () {
      var searchTerm = "Krasnoyarsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Krasnoyarsk Time", () {
      var searchTerm = "Krasnoyarsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Kuybyshev Time", () {
      var searchTerm = "Kuybyshev Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Kyrgyzstan Time", () {
      var searchTerm = "Kyrgyzstan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Line Islands Time", () {
      var searchTerm = "Line Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Lord Howe Daylight Time", () {
      var searchTerm = "Lord Howe Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Lord Howe Standard Time", () {
      var searchTerm = "Lord Howe Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Magadan Island Summer Time -- unused", () {
      var searchTerm = "Magadan Island Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Magadan Island Time", () {
      var searchTerm = "Magadan Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Magadan Summer Time", () {
      var searchTerm = "Magadan Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Magadan Time", () {
      var searchTerm = "Magadan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Malaysian Standard Time", () {
      var searchTerm = "Malaysian Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Malaysia Time", () {
      var searchTerm = "Malaysia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Maldives Time", () {
      var searchTerm = "Maldives Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Marquesas Time", () {
      var searchTerm = "Marquesas Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Marshall Islands Time", () {
      var searchTerm = "Marshall Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Mauritius Time", () {
      var searchTerm = "Mauritius Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Mawson Time", () {
      var searchTerm = "Mawson Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Mitteleuropäische Sommerzeit", () {
      var searchTerm = "Mitteleuropäische Sommerzeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Mitteleuropäische Zeit", () {
      var searchTerm = "Mitteleuropäische Zeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Moscow Daylight Time -- unused", () {
      var searchTerm = "Moscow Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Moscow Summer Time -- unused", () {
      var searchTerm = "Moscow Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Moscow Standard Time", () {
      var searchTerm = "Moscow Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Moscow Time", () {
      var searchTerm = "Moscow Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Mountain Daylight Saving Time", () {
      var searchTerm = "Mountain Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Mountain Daylight Time", () {
      var searchTerm = "Mountain Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Mountain Standard Time", () {
      var searchTerm = "Mountain Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Mountain Time", () {
      var searchTerm = "Mountain Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Myanmar Time", () {
      var searchTerm = "Myanmar Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Nauru Time", () {
      var searchTerm = "Nauru Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Nepal Time", () {
      var searchTerm = "Nepal Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("New Caledonia Time", () {
      var searchTerm = "New Caledonia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Newfoundland Daylight Time", () {
      var searchTerm = "Newfoundland Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Newfoundland Standard Time", () {
      var searchTerm = "Newfoundland Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("New Zealand Daylight Time", () {
      var searchTerm = "New Zealand Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("New Zealand Standard Time", () {
      var searchTerm = "New Zealand Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Niue Time", () {
      var searchTerm = "Niue Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Daylight Time", () {
      var searchTerm = "Norfolk Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Island Daylight Time", () {
      var searchTerm = "Norfolk Island Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Island Time", () {
      var searchTerm = "Norfolk Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Time", () {
      var searchTerm = "Norfolk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("North American Central Daylight Time", () {
      var searchTerm = "North American Central Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("North American Central Standard Time", () {
      var searchTerm = "North American Central Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("North American Eastern Daylight Time", () {
      var searchTerm = "North American Eastern Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("North American Eastern Standard Time", () {
      var searchTerm = "North American Eastern Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("North American Mountain Daylight Time", () {
      var searchTerm = "North American Mountain Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("North American Mountain Standard Time", () {
      var searchTerm = "North American Mountain Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("North American Pacific Daylight Time", () {
      var searchTerm = "North American Pacific Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("North American Pacific Standard Time", () {
      var searchTerm = "North American Pacific Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Novosibirsk Summer Time", () {
      var searchTerm = "Novosibirsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Novosibirsk Time", () {
      var searchTerm = "Novosibirsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Omsk Standard Time", () {
      var searchTerm = "Omsk Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Omsk Summer Time -- unused", () {
      var searchTerm = "Omsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Omsk Time", () {
      var searchTerm = "Omsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Oral Time", () {
      var searchTerm = "Oral Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Osteuropäische Sommerzeit", () {
      var searchTerm = "Osteuropäische Sommerzeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Osteuropäische Zeit", () {
      var searchTerm = "Osteuropäische Zeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pacific Daylight Saving Time", () {
      var searchTerm = "Pacific Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pacific Daylight Time", () {
      var searchTerm = "Pacific Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pacific Standard Time", () {
      var searchTerm = "Pacific Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pacific Time", () {
      var searchTerm = "Pacific Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pakistan Standard Time", () {
      var searchTerm = "Pakistan Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pakistan Time", () {
      var searchTerm = "Pakistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Palau Time", () {
      var searchTerm = "Palau Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Papua New Guinea Time", () {
      var searchTerm = "Papua New Guinea Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Paraguay Summer Time", () {
      var searchTerm = "Paraguay Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Paraguay Time", () {
      var searchTerm = "Paraguay Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Peru Time", () {
      var searchTerm = "Peru Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Petropavlovsk-Kamchatski Time", () {
      var searchTerm = "Petropavlovsk-Kamchatski Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Philippine Standard Time", () {
      var searchTerm = "Philippine Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Philippine Time", () {
      var searchTerm = "Philippine Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Phoenix Island Time", () {
      var searchTerm = "Phoenix Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pierre & Miquelon Daylight Time", () {
      var searchTerm = "Pierre & Miquelon Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pierre & Miquelon Standard Time", () {
      var searchTerm = "Pierre & Miquelon Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pitcairn Standard Time", () {
      var searchTerm = "Pitcairn Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pohnpei Standard Time", () {
      var searchTerm = "Pohnpei Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pyongyang Standard Time", () {
      var searchTerm = "Pyongyang Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Pyongyang Time", () {
      var searchTerm = "Pyongyang Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Qyzylorda Time", () {
      var searchTerm = "Qyzylorda Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Reunion Time", () {
      var searchTerm = "Reunion Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Sakhalin Time", () {
      var searchTerm = "Sakhalin Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Samara Standard Time", () {
      var searchTerm = "Samara Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Samara Summer Time -- unused", () {
      var searchTerm = "Samara Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Samara Time", () {
      var searchTerm = "Samara Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Samoa Standard Time", () {
      var searchTerm = "Samoa Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Samoa Time", () {
      var searchTerm = "Samoa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Seychelles Time", () {
      var searchTerm = "Seychelles Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Singapore Standard Time", () {
      var searchTerm = "Singapore Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Singapore Time", () {
      var searchTerm = "Singapore Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Solomon Islands Time", () {
      var searchTerm = "Solomon Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Solomon Island Time", () {
      var searchTerm = "Solomon Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("South African Standard Time", () {
      var searchTerm = "South African Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("South Africa Standard Time", () {
      var searchTerm = "South Africa Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("South Georgia Time", () {
      var searchTerm = "South Georgia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Srednekolymsk Time -- unused", () {
      var searchTerm = "Srednekolymsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Suriname Time", () {
      var searchTerm = "Suriname Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Syowa Time", () {
      var searchTerm = "Syowa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Tahiti Time", () {
      var searchTerm = "Tahiti Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Tajikistan Time", () {
      var searchTerm = "Tajikistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Tokelau Time", () {
      var searchTerm = "Tokelau Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Tonga Summer Time", () {
      var searchTerm = "Tonga Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Tonga Time", () {
      var searchTerm = "Tonga Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Turkey Time", () {
      var searchTerm = "Turkey Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Turkmenistan Time", () {
      var searchTerm = "Turkmenistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Tuvalu Time", () {
      var searchTerm = "Tuvalu Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Ulaanbaatar Summer Time", () {
      var searchTerm = "Ulaanbaatar Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Ulaanbaatar Time", () {
      var searchTerm = "Ulaanbaatar Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Ulan Bator Summer Time", () {
      var searchTerm = "Ulan Bator Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Ulan Bator Time", () {
      var searchTerm = "Ulan Bator Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Uruguay Summer Time", () {
      var searchTerm = "Uruguay Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Uruguay Time", () {
      var searchTerm = "Uruguay Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Uzbekistan Time", () {
      var searchTerm = "Uzbekistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Vanuatu Time", () {
      var searchTerm = "Vanuatu Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Venezuelan Standard Time", () {
      var searchTerm = "Venezuelan Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Vladivostok Summer Time -- unused", () {
      var searchTerm = "Vladivostok Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Vladivostok Time", () {
      var searchTerm = "Vladivostok Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Vostok Time", () {
      var searchTerm = "Vostok Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Wake Time", () {
      var searchTerm = "Wake Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Waktu Indonesia Barat", () {
      var searchTerm = "Waktu Indonesia Barat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Waktu Indonesia Tengah", () {
      var searchTerm = "Waktu Indonesia Tengah";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Waktu Indonesia Timur", () {
      var searchTerm = "Waktu Indonesia Timur";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Wallis and Futuna Time", () {
      var searchTerm = "Wallis and Futuna Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("West Africa Summer Time -- unused", () {
      var searchTerm = "West Africa Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("West Africa Time", () {
      var searchTerm = "West Africa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Argentine Summer Time", () {
      var searchTerm = "Western Argentine Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Australia Time", () {
      var searchTerm = "Western Australia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Daylight Time", () {
      var searchTerm = "Western Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western European Daylight Time", () {
      var searchTerm = "Western European Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western European Summer Time", () {
      var searchTerm = "Western European Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western European Time", () {
      var searchTerm = "Western European Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Greenland Summer Time", () {
      var searchTerm = "Western Greenland Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Greenland Time", () {
      var searchTerm = "Western Greenland Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Indonesian Time", () {
      var searchTerm = "Western Indonesian Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Sahara Standard Time", () {
      var searchTerm = "Western Sahara Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Sahara Summer Time", () {
      var searchTerm = "Western Sahara Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Sahara Time", () {
      var searchTerm = "Western Sahara Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Standard Time", () {
      var searchTerm = "Western Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Western Summer Time", () {
      var searchTerm = "Western Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Westeuropäische Sommerzeit", () {
      var searchTerm = "Westeuropäische Sommerzeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Westeuropäische Zeit", () {
      var searchTerm = "Westeuropäische Zeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("West Greenland Summer Time", () {
      var searchTerm = "West Greenland Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("West Samoa Time", () {
      var searchTerm = "West Samoa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Yakutsk Summer Time -- unused", () {
      var searchTerm = "Yakutsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Yakutsk Time", () {
      var searchTerm = "Yakutsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Yap Time", () {
      var searchTerm = "Yap Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });

    test("Yekaterinburg Summer Time -- unused", () {
      var searchTerm = "Yekaterinburg Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(0));
    });

    test("Yekaterinburg Time", () {
      var searchTerm = "Yekaterinburg Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, greaterThan(0));
    });
  }, skip: skip);

  group('timezone search capitals and megacities', () {
    test("Abidjan", () {
      var searchTerm = "Abidjan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Abu Dhabi", () {
      var searchTerm = "Abu Dhabi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Abuja", () {
      var searchTerm = "Abuja";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Accra", () {
      var searchTerm = "Accra";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Adamstown", () {
      var searchTerm = "Adamstown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Addis Ababa", () {
      var searchTerm = "Addis Ababa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ahmedabad", () {
      var searchTerm = "Ahmedabad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Alexandria", () {
      var searchTerm = "Alexandria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Algiers", () {
      var searchTerm = "Algiers";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Alofi", () {
      var searchTerm = "Alofi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Amman", () {
      var searchTerm = "Amman";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Amsterdam", () {
      var searchTerm = "Amsterdam";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Andorra la Vella", () {
      var searchTerm = "Andorra la Vella";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Andorra La Vella", () {
      var searchTerm = "Andorra La Vella";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ankara", () {
      var searchTerm = "Ankara";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Antananarivo", () {
      var searchTerm = "Antananarivo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Apia", () {
      var searchTerm = "Apia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ashgabat", () {
      var searchTerm = "Ashgabat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Asmara", () {
      var searchTerm = "Asmara";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Astana", () {
      var searchTerm = "Astana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Asuncion", () {
      var searchTerm = "Asuncion";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Asunción", () {
      var searchTerm = "Asunción";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Athens", () {
      var searchTerm = "Athens";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Avarua", () {
      var searchTerm = "Avarua";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Baghdad", () {
      var searchTerm = "Baghdad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Baku", () {
      var searchTerm = "Baku";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bamako", () {
      var searchTerm = "Bamako";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bandar Seri Begawan", () {
      var searchTerm = "Bandar Seri Begawan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bangalore", () {
      var searchTerm = "Bangalore";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bangkok", () {
      var searchTerm = "Bangkok";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bangui", () {
      var searchTerm = "Bangui";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Banjul", () {
      var searchTerm = "Banjul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Basseterre", () {
      var searchTerm = "Basseterre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Basse-Terre", () {
      var searchTerm = "Basse-Terre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Beijing", () {
      var searchTerm = "Beijing";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Beirut", () {
      var searchTerm = "Beirut";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Belgrade", () {
      var searchTerm = "Belgrade";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Belmopan", () {
      var searchTerm = "Belmopan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Berlin", () {
      var searchTerm = "Berlin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bern", () {
      var searchTerm = "Bern";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bijie", () {
      var searchTerm = "Bijie";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bishkek", () {
      var searchTerm = "Bishkek";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bissau", () {
      var searchTerm = "Bissau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bogota", () {
      var searchTerm = "Bogota";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Brades", () {
      var searchTerm = "Brades";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Brasilia", () {
      var searchTerm = "Brasilia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bratislava", () {
      var searchTerm = "Bratislava";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Brazzaville", () {
      var searchTerm = "Brazzaville";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bridgetown", () {
      var searchTerm = "Bridgetown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Brussels", () {
      var searchTerm = "Brussels";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Bucharest", () {
      var searchTerm = "Bucharest";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Budapest", () {
      var searchTerm = "Budapest";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Buenos Aires", () {
      var searchTerm = "Buenos Aires";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Cairo", () {
      var searchTerm = "Cairo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Canberra", () {
      var searchTerm = "Canberra";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Caracas", () {
      var searchTerm = "Caracas";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Castries", () {
      var searchTerm = "Castries";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Cayenne", () {
      var searchTerm = "Cayenne";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Changchun", () {
      var searchTerm = "Changchun";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Changde", () {
      var searchTerm = "Changde";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Changsha", () {
      var searchTerm = "Changsha";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Changzhou", () {
      var searchTerm = "Changzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Charlotte Amalie", () {
      var searchTerm = "Charlotte Amalie";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Chengchow", () {
      var searchTerm = "Chengchow";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Chengdu", () {
      var searchTerm = "Chengdu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Chennai", () {
      var searchTerm = "Chennai";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Chisinau", () {
      var searchTerm = "Chisinau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Chongqing", () {
      var searchTerm = "Chongqing";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ciudad de la Paz", () {
      var searchTerm = "Ciudad de la Paz";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Cockburn Town", () {
      var searchTerm = "Cockburn Town";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Colombo", () {
      var searchTerm = "Colombo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Conakry", () {
      var searchTerm = "Conakry";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Concelho de Macau", () {
      var searchTerm = "Concelho de Macau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Copenhagen", () {
      var searchTerm = "Copenhagen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dakar", () {
      var searchTerm = "Dakar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dalian", () {
      var searchTerm = "Dalian";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Damascus", () {
      var searchTerm = "Damascus";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dar es Salaam", () {
      var searchTerm = "Dar es Salaam";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Delhi", () {
      var searchTerm = "Delhi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dhaka", () {
      var searchTerm = "Dhaka";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dili", () {
      var searchTerm = "Dili";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Djibouti City", () {
      var searchTerm = "Djibouti City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dodoma", () {
      var searchTerm = "Dodoma";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Doha", () {
      var searchTerm = "Doha";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dongguan", () {
      var searchTerm = "Dongguan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Douglas", () {
      var searchTerm = "Douglas";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dublin", () {
      var searchTerm = "Dublin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Dushanbe", () {
      var searchTerm = "Dushanbe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("El Aaiún", () {
      var searchTerm = "El Aaiún";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Flying Fish Cove", () {
      var searchTerm = "Flying Fish Cove";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Fort-de-France", () {
      var searchTerm = "Fort-de-France";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Foshan", () {
      var searchTerm = "Foshan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Freetown", () {
      var searchTerm = "Freetown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Funafuti", () {
      var searchTerm = "Funafuti";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Fuzhou", () {
      var searchTerm = "Fuzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Gaborone", () {
      var searchTerm = "Gaborone";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Georgetown", () {
      var searchTerm = "Georgetown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("George Town", () {
      var searchTerm = "George Town";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Gibraltar", () {
      var searchTerm = "Gibraltar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Gitega", () {
      var searchTerm = "Gitega";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Guangzhou", () {
      var searchTerm = "Guangzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Guatemala City", () {
      var searchTerm = "Guatemala City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Guiyang", () {
      var searchTerm = "Guiyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Gustavia", () {
      var searchTerm = "Gustavia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Hagåtña", () {
      var searchTerm = "Hagåtña";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Hamilton", () {
      var searchTerm = "Hamilton";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Hangzhou", () {
      var searchTerm = "Hangzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Hanoi", () {
      var searchTerm = "Hanoi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Harare", () {
      var searchTerm = "Harare";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Harbin", () {
      var searchTerm = "Harbin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Havana", () {
      var searchTerm = "Havana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Hefei", () {
      var searchTerm = "Hefei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Helsinki", () {
      var searchTerm = "Helsinki";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Heze", () {
      var searchTerm = "Heze";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ho Chi Minh City", () {
      var searchTerm = "Ho Chi Minh City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Hong Kong", () {
      var searchTerm = "Hong Kong";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Honiara", () {
      var searchTerm = "Honiara";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Hyderabad", () {
      var searchTerm = "Hyderabad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Islamabad", () {
      var searchTerm = "Islamabad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Istanbul", () {
      var searchTerm = "Istanbul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Jakarta", () {
      var searchTerm = "Jakarta";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Jamestown", () {
      var searchTerm = "Jamestown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Jerusalem", () {
      var searchTerm = "Jerusalem";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Jieyang", () {
      var searchTerm = "Jieyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Jinan", () {
      var searchTerm = "Jinan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Juba", () {
      var searchTerm = "Juba";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kabul", () {
      var searchTerm = "Kabul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kampala", () {
      var searchTerm = "Kampala";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Karachi", () {
      var searchTerm = "Karachi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kathmandu", () {
      var searchTerm = "Kathmandu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Khartoum", () {
      var searchTerm = "Khartoum";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kigali", () {
      var searchTerm = "Kigali";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("King Edward Point", () {
      var searchTerm = "King Edward Point";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kingston", () {
      var searchTerm = "Kingston";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kingstown", () {
      var searchTerm = "Kingstown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kinshasa", () {
      var searchTerm = "Kinshasa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kolkata", () {
      var searchTerm = "Kolkata";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kuala Lumpur", () {
      var searchTerm = "Kuala Lumpur";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kunming", () {
      var searchTerm = "Kunming";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kuwait City", () {
      var searchTerm = "Kuwait City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Kyiv", () {
      var searchTerm = "Kyiv";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Lagos", () {
      var searchTerm = "Lagos";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Lahore", () {
      var searchTerm = "Lahore";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Libreville", () {
      var searchTerm = "Libreville";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Lilongwe", () {
      var searchTerm = "Lilongwe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Lima", () {
      var searchTerm = "Lima";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Linyi", () {
      var searchTerm = "Linyi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Lisbon", () {
      var searchTerm = "Lisbon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ljubljana", () {
      var searchTerm = "Ljubljana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Lomé", () {
      var searchTerm = "Lomé";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("London", () {
      var searchTerm = "London";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Longyearbyen", () {
      var searchTerm = "Longyearbyen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Luanda", () {
      var searchTerm = "Luanda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Luoyang", () {
      var searchTerm = "Luoyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Lusaka", () {
      var searchTerm = "Lusaka";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Luxembourg", () {
      var searchTerm = "Luxembourg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Madrid", () {
      var searchTerm = "Madrid";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Majuro", () {
      var searchTerm = "Majuro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Malabo", () {
      var searchTerm = "Malabo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Male", () {
      var searchTerm = "Male";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Malé", () {
      var searchTerm = "Malé";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Mamoudzou", () {
      var searchTerm = "Mamoudzou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Managua", () {
      var searchTerm = "Managua";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Manama", () {
      var searchTerm = "Manama";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Manila", () {
      var searchTerm = "Manila";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Maputo", () {
      var searchTerm = "Maputo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Mariehamn", () {
      var searchTerm = "Mariehamn";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Marigot", () {
      var searchTerm = "Marigot";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Maseru", () {
      var searchTerm = "Maseru";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Mata-Utu", () {
      var searchTerm = "Mata-Utu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Mbabane", () {
      var searchTerm = "Mbabane";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Mexico City", () {
      var searchTerm = "Mexico City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Minsk", () {
      var searchTerm = "Minsk";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Mogadishu", () {
      var searchTerm = "Mogadishu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Monaco", () {
      var searchTerm = "Monaco";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Monrovia", () {
      var searchTerm = "Monrovia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Montevideo", () {
      var searchTerm = "Montevideo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Moroni", () {
      var searchTerm = "Moroni";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Moscow", () {
      var searchTerm = "Moscow";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Mumbai", () {
      var searchTerm = "Mumbai";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Muscat", () {
      var searchTerm = "Muscat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nairobi", () {
      var searchTerm = "Nairobi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nampula", () {
      var searchTerm = "Nampula";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nanchang", () {
      var searchTerm = "Nanchang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nanking", () {
      var searchTerm = "Nanking";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nanning", () {
      var searchTerm = "Nanning";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nassau", () {
      var searchTerm = "Nassau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Naypyidaw", () {
      var searchTerm = "Naypyidaw";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nay Pyi Taw", () {
      var searchTerm = "Nay Pyi Taw";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("N'Djamena", () {
      var searchTerm = "N'Djamena";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("New Delhi", () {
      var searchTerm = "New Delhi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("New York City", () {
      var searchTerm = "New York City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Niamey", () {
      var searchTerm = "Niamey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nicosia", () {
      var searchTerm = "Nicosia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nouakchott", () {
      var searchTerm = "Nouakchott";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nouméa", () {
      var searchTerm = "Nouméa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nuku'alofa", () {
      var searchTerm = "Nuku'alofa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Nuuk", () {
      var searchTerm = "Nuuk";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Oranjestad", () {
      var searchTerm = "Oranjestad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Oslo", () {
      var searchTerm = "Oslo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ottawa", () {
      var searchTerm = "Ottawa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ouagadougou", () {
      var searchTerm = "Ouagadougou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Pago Pago", () {
      var searchTerm = "Pago Pago";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Panama City", () {
      var searchTerm = "Panama City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Papeete", () {
      var searchTerm = "Papeete";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Paramaribo", () {
      var searchTerm = "Paramaribo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Paris", () {
      var searchTerm = "Paris";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Philipsburg", () {
      var searchTerm = "Philipsburg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Phnom Penh", () {
      var searchTerm = "Phnom Penh";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Podgorica", () {
      var searchTerm = "Podgorica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Port-au-Prince", () {
      var searchTerm = "Port-au-Prince";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Port Louis", () {
      var searchTerm = "Port Louis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Port Moresby", () {
      var searchTerm = "Port Moresby";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Port of Spain", () {
      var searchTerm = "Port of Spain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Port-of-Spain", () {
      var searchTerm = "Port-of-Spain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Porto Novo", () {
      var searchTerm = "Porto Novo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Porto-Novo", () {
      var searchTerm = "Porto-Novo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Port Vila", () {
      var searchTerm = "Port Vila";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Port-Vila", () {
      var searchTerm = "Port-Vila";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Prague", () {
      var searchTerm = "Prague";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Praia", () {
      var searchTerm = "Praia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Pretoria", () {
      var searchTerm = "Pretoria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Pristina", () {
      var searchTerm = "Pristina";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Pyongyang", () {
      var searchTerm = "Pyongyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Qingdao", () {
      var searchTerm = "Qingdao";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Quito", () {
      var searchTerm = "Quito";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Rabat", () {
      var searchTerm = "Rabat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ramallah", () {
      var searchTerm = "Ramallah";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Reykjavik", () {
      var searchTerm = "Reykjavik";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Reykjavík", () {
      var searchTerm = "Reykjavík";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Riga", () {
      var searchTerm = "Riga";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Rio de Janeiro", () {
      var searchTerm = "Rio de Janeiro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Riyadh", () {
      var searchTerm = "Riyadh";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Road Town", () {
      var searchTerm = "Road Town";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Rome", () {
      var searchTerm = "Rome";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Roseau", () {
      var searchTerm = "Roseau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Saint-Denis", () {
      var searchTerm = "Saint-Denis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Saint George's", () {
      var searchTerm = "Saint George's";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Saint Helier", () {
      var searchTerm = "Saint Helier";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Saint John's", () {
      var searchTerm = "Saint John's";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Saint Peter Port", () {
      var searchTerm = "Saint Peter Port";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Saint Petersburg", () {
      var searchTerm = "Saint Petersburg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Saint-Pierre", () {
      var searchTerm = "Saint-Pierre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Saipan", () {
      var searchTerm = "Saipan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Sana", () {
      var searchTerm = "Sana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Sanaa", () {
      var searchTerm = "Sanaa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("San Jose", () {
      var searchTerm = "San Jose";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("San José", () {
      var searchTerm = "San José";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("San Juan", () {
      var searchTerm = "San Juan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("San Marino", () {
      var searchTerm = "San Marino";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("San Salvador", () {
      var searchTerm = "San Salvador";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Santiago", () {
      var searchTerm = "Santiago";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Santo Domingo", () {
      var searchTerm = "Santo Domingo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("São Paulo", () {
      var searchTerm = "São Paulo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("São Tomé", () {
      var searchTerm = "São Tomé";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Sarajevo", () {
      var searchTerm = "Sarajevo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Seoul", () {
      var searchTerm = "Seoul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Shanghai", () {
      var searchTerm = "Shanghai";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Shangqiu", () {
      var searchTerm = "Shangqiu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Shantou", () {
      var searchTerm = "Shantou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Shenyang", () {
      var searchTerm = "Shenyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Shenzhen", () {
      var searchTerm = "Shenzhen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Shijiazhuang", () {
      var searchTerm = "Shijiazhuang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Singapore", () {
      var searchTerm = "Singapore";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Skopje", () {
      var searchTerm = "Skopje";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Sofia", () {
      var searchTerm = "Sofia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Stanley", () {
      var searchTerm = "Stanley";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Stockholm", () {
      var searchTerm = "Stockholm";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Sucre", () {
      var searchTerm = "Sucre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Suva", () {
      var searchTerm = "Suva";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Suzhou", () {
      var searchTerm = "Suzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tai'an", () {
      var searchTerm = "Tai'an";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Taipei", () {
      var searchTerm = "Taipei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Taiyuan", () {
      var searchTerm = "Taiyuan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tallinn", () {
      var searchTerm = "Tallinn";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tangshan", () {
      var searchTerm = "Tangshan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tarawa", () {
      var searchTerm = "Tarawa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tashkent", () {
      var searchTerm = "Tashkent";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tbilisi", () {
      var searchTerm = "Tbilisi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tegucigalpa", () {
      var searchTerm = "Tegucigalpa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tehran", () {
      var searchTerm = "Tehran";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tel Aviv", () {
      var searchTerm = "Tel Aviv";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("The Valley", () {
      var searchTerm = "The Valley";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Thimphu", () {
      var searchTerm = "Thimphu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tianjin", () {
      var searchTerm = "Tianjin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tirana", () {
      var searchTerm = "Tirana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tokyo", () {
      var searchTerm = "Tokyo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tórshavn", () {
      var searchTerm = "Tórshavn";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tripoli", () {
      var searchTerm = "Tripoli";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Tunis", () {
      var searchTerm = "Tunis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Ulaanbaatar", () {
      var searchTerm = "Ulaanbaatar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Vaduz", () {
      var searchTerm = "Vaduz";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Valletta", () {
      var searchTerm = "Valletta";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Vatican City", () {
      var searchTerm = "Vatican City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Victoria", () {
      var searchTerm = "Victoria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Vienna", () {
      var searchTerm = "Vienna";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Vientiane", () {
      var searchTerm = "Vientiane";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Vilnius", () {
      var searchTerm = "Vilnius";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Warsaw", () {
      var searchTerm = "Warsaw";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Washington, D.C.", () {
      var searchTerm = "Washington, D.C.";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Washington DC", () {
      var searchTerm = "Washington DC";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Weifang", () {
      var searchTerm = "Weifang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Wellington", () {
      var searchTerm = "Wellington";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("West Island", () {
      var searchTerm = "West Island";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Willemstad", () {
      var searchTerm = "Willemstad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Windhoek", () {
      var searchTerm = "Windhoek";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Wuhan", () {
      var searchTerm = "Wuhan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Wuxi", () {
      var searchTerm = "Wuxi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Xiamen", () {
      var searchTerm = "Xiamen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Xi'an", () {
      var searchTerm = "Xi'an";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Xinyang", () {
      var searchTerm = "Xinyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Yamoussoukro", () {
      var searchTerm = "Yamoussoukro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Yantai", () {
      var searchTerm = "Yantai";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Yaounde", () {
      var searchTerm = "Yaounde";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Yaoundé", () {
      var searchTerm = "Yaoundé";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Yaren", () {
      var searchTerm = "Yaren";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Yerevan", () {
      var searchTerm = "Yerevan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Zagreb", () {
      var searchTerm = "Zagreb";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });

    test("Zhanjiang", () {
      var searchTerm = "Zhanjiang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      _printDetails(searchTerm, loc, showDetails);
      expect(loc.length, equals(1));
    });
  }, skip: skip);

  group('timezone search countries', () {
    test("Abkhazia", () {
      var searchTerm = "Abkhazia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Afghanistan", () {
      var searchTerm = "Afghanistan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Åland", () {
      var searchTerm = "Åland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Albania", () {
      var searchTerm = "Albania";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Algeria", () {
      var searchTerm = "Algeria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("American Samoa", () {
      var searchTerm = "American Samoa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Andorra", () {
      var searchTerm = "Andorra";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Angola", () {
      var searchTerm = "Angola";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Anguilla", () {
      var searchTerm = "Anguilla";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Antarctica", () {
      var searchTerm = "Antarctica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Antigua and Barbuda", () {
      var searchTerm = "Antigua and Barbuda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Argentina", () {
      var searchTerm = "Argentina";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Armenia", () {
      var searchTerm = "Armenia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Aruba", () {
      var searchTerm = "Aruba";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australia", () {
      var searchTerm = "Australia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Austria", () {
      var searchTerm = "Austria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Azerbaijan", () {
      var searchTerm = "Azerbaijan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bahamas", () {
      var searchTerm = "Bahamas";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

     test("Bahrain", () {
      var searchTerm = "Bahrain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bangladesh", () {
      var searchTerm = "Bangladesh";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Barbados", () {
      var searchTerm = "Barbados";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Belarus", () {
      var searchTerm = "Belarus";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Belgium", () {
      var searchTerm = "Belgium";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Belize", () {
      var searchTerm = "Belize";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Benin", () {
      var searchTerm = "Benin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bermuda", () {
      var searchTerm = "Bermuda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bhutan", () {
      var searchTerm = "Bhutan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bolivia", () {
      var searchTerm = "Bolivia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bosnia and Herzegovina", () {
      var searchTerm = "Bosnia and Herzegovina";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Botswana", () {
      var searchTerm = "Botswana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brazil", () {
      var searchTerm = "Brazil";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("British Virgin Islands", () {
      var searchTerm = "British Virgin Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brunei", () {
      var searchTerm = "Brunei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bulgaria", () {
      var searchTerm = "Bulgaria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Burkina Faso", () {
      var searchTerm = "Burkina Faso";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Burundi", () {
      var searchTerm = "Burundi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cambodia", () {
      var searchTerm = "Cambodia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cameroon", () {
      var searchTerm = "Cameroon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Canada", () {
      var searchTerm = "Canada";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cape Verde", () {
      var searchTerm = "Cape Verde";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cayman Islands", () {
      var searchTerm = "Cayman Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Africa", () {
      var searchTerm = "Central Africa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central African Republic", () {
      var searchTerm = "Central African Republic";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chad", () {
      var searchTerm = "Chad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chile", () {
      var searchTerm = "Chile";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("China", () {
      var searchTerm = "China";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Christmas Island", () {
      var searchTerm = "Christmas Island";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cocos Islands", () {
      var searchTerm = "Cocos Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Colombia", () {
      var searchTerm = "Colombia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Comoros", () {
      var searchTerm = "Comoros";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Congo", () {
      var searchTerm = "Congo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cook Islands", () {
      var searchTerm = "Cook Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Costa Rica", () {
      var searchTerm = "Costa Rica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Croatia", () {
      var searchTerm = "Croatia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cuba", () {
      var searchTerm = "Cuba";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Curacao", () {
      var searchTerm = "Curacao";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cyprus", () {
      var searchTerm = "Cyprus";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Czechia", () {
      var searchTerm = "Czechia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Czech Republic", () {
      var searchTerm = "Czech Republic";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Denmark", () {
      var searchTerm = "Denmark";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Djibouti", () {
      var searchTerm = "Djibouti";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dominica", () {
      var searchTerm = "Dominica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dominican Republic", () {
      var searchTerm = "Dominican Republic";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("East Timor", () {
      var searchTerm = "East Timor";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ecuador", () {
      var searchTerm = "Ecuador";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Egypt", () {
      var searchTerm = "Egypt";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("El Salvador", () {
      var searchTerm = "El Salvador";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Equatorial Guinea", () {
      var searchTerm = "Equatorial Guinea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eritrea", () {
      var searchTerm = "Eritrea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Estonia", () {
      var searchTerm = "Estonia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eswatini", () {
      var searchTerm = "Eswatini";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ethiopia", () {
      var searchTerm = "Ethiopia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Islands", () {
      var searchTerm = "Falkland Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Faroe Islands", () {
      var searchTerm = "Faroe Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Federated States of Micronesia", () {
      var searchTerm = "Federated States of Micronesia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Fiji", () {
      var searchTerm = "Fiji";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Finland", () {
      var searchTerm = "Finland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("France", () {
      var searchTerm = "France";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("French Guiana", () {
      var searchTerm = "French Guiana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("French Polynesia", () {
      var searchTerm = "French Polynesia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gabon", () {
      var searchTerm = "Gabon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gambia", () {
      var searchTerm = "Gambia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Georgia", () {
      var searchTerm = "Georgia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Germany", () {
      var searchTerm = "Germany";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ghana", () {
      var searchTerm = "Ghana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gibraltar", () {
      var searchTerm = "Gibraltar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Greece", () {
      var searchTerm = "Greece";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Greenland", () {
      var searchTerm = "Greenland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Grenada", () {
      var searchTerm = "Grenada";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guadeloupe", () {
      var searchTerm = "Guadeloupe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guam", () {
      var searchTerm = "Guam";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guatemala", () {
      var searchTerm = "Guatemala";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guernsey", () {
      var searchTerm = "Guernsey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guinea", () {
      var searchTerm = "Guinea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guinea-Bissau", () {
      var searchTerm = "Guinea-Bissau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guyana", () {
      var searchTerm = "Guyana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Haiti", () {
      var searchTerm = "Haiti";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Honduras", () {
      var searchTerm = "Honduras";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hong Kong", () {
      var searchTerm = "Hong Kong";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hungary", () {
      var searchTerm = "Hungary";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Iceland", () {
      var searchTerm = "Iceland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("India", () {
      var searchTerm = "India";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Indonesia", () {
      var searchTerm = "Indonesia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Iran", () {
      var searchTerm = "Iran";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Iraq", () {
      var searchTerm = "Iraq";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ireland", () {
      var searchTerm = "Ireland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Isle of Man", () {
      var searchTerm = "Isle of Man";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Israel", () {
      var searchTerm = "Israel";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Italy", () {
      var searchTerm = "Italy";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ivory Coast", () {
      var searchTerm = "Ivory Coast";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jamaica", () {
      var searchTerm = "Jamaica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Japan", () {
      var searchTerm = "Japan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jersey", () {
      var searchTerm = "Jersey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jordan", () {
      var searchTerm = "Jordan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kazakhstan", () {
      var searchTerm = "Kazakhstan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kenya", () {
      var searchTerm = "Kenya";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kiribati", () {
      var searchTerm = "Kiribati";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kosovo", () {
      var searchTerm = "Kosovo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kuwait", () {
      var searchTerm = "Kuwait";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kyrgyzstan", () {
      var searchTerm = "Kyrgyzstan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Laos", () {
      var searchTerm = "Laos";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Latvia", () {
      var searchTerm = "Latvia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lebanon", () {
      var searchTerm = "Lebanon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lesotho", () {
      var searchTerm = "Lesotho";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Liberia", () {
      var searchTerm = "Liberia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Libya", () {
      var searchTerm = "Libya";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Liechtenstein", () {
      var searchTerm = "Liechtenstein";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lithuania", () {
      var searchTerm = "Lithuania";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Luxembourg", () {
      var searchTerm = "Luxembourg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Macao", () {
      var searchTerm = "Macao";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Macau", () {
      var searchTerm = "Macau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Madagascar", () {
      var searchTerm = "Madagascar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Malawi", () {
      var searchTerm = "Malawi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Malaysia", () {
      var searchTerm = "Malaysia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Maldives", () {
      var searchTerm = "Maldives";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mali", () {
      var searchTerm = "Mali";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Malta", () {
      var searchTerm = "Malta";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Marshall Islands", () {
      var searchTerm = "Marshall Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Martinique", () {
      var searchTerm = "Martinique";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mauritania", () {
      var searchTerm = "Mauritania";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mauritius", () {
      var searchTerm = "Mauritius";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mayotte", () {
      var searchTerm = "Mayotte";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mexico", () {
      var searchTerm = "Mexico";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Micronesia", () {
      var searchTerm = "Micronesia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Moldova", () {
      var searchTerm = "Moldova";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Monaco", () {
      var searchTerm = "Monaco";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mongolia", () {
      var searchTerm = "Mongolia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Montenegro", () {
      var searchTerm = "Montenegro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Montserrat", () {
      var searchTerm = "Montserrat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Morocco", () {
      var searchTerm = "Morocco";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mozambique", () {
      var searchTerm = "Mozambique";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Myanmar", () {
      var searchTerm = "Myanmar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Namibia", () {
      var searchTerm = "Namibia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nauru", () {
      var searchTerm = "Nauru";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nepal", () {
      var searchTerm = "Nepal";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Netherlands", () {
      var searchTerm = "Netherlands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("New Caledonia", () {
      var searchTerm = "New Caledonia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("New Zealand", () {
      var searchTerm = "New Zealand";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nicaragua", () {
      var searchTerm = "Nicaragua";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Niger", () {
      var searchTerm = "Niger";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nigeria", () {
      var searchTerm = "Nigeria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Niue", () {
      var searchTerm = "Niue";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Island", () {
      var searchTerm = "Norfolk Island";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Northern Cyprus", () {
      var searchTerm = "Northern Cyprus";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Northern Marianas", () {
      var searchTerm = "Northern Marianas";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North Korea", () {
      var searchTerm = "North Korea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North Macedonia", () {
      var searchTerm = "North Macedonia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Norway", () {
      var searchTerm = "Norway";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Oman", () {
      var searchTerm = "Oman";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pakistan", () {
      var searchTerm = "Pakistan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Palau", () {
      var searchTerm = "Palau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Palestine", () {
      var searchTerm = "Palestine";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Panama", () {
      var searchTerm = "Panama";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Papua New Guinea", () {
      var searchTerm = "Papua New Guinea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Paraguay", () {
      var searchTerm = "Paraguay";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Peru", () {
      var searchTerm = "Peru";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Philippines", () {
      var searchTerm = "Philippines";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pitcairn Islands", () {
      var searchTerm = "Pitcairn Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Poland", () {
      var searchTerm = "Poland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Portugal", () {
      var searchTerm = "Portugal";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Puerto Rico", () {
      var searchTerm = "Puerto Rico";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Qatar", () {
      var searchTerm = "Qatar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Republic of the Congo", () {
      var searchTerm = "Republic of the Congo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Reunion", () {
      var searchTerm = "Reunion";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Romania", () {
      var searchTerm = "Romania";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Russia", () {
      var searchTerm = "Russia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Rwanda", () {
      var searchTerm = "Rwanda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sahrawi Arab Democratic Republic", () {
      var searchTerm = "Sahrawi Arab Democratic Republic";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Barthelemy", () {
      var searchTerm = "Saint Barthelemy";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Helena", () {
      var searchTerm = "Saint Helena";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Kitts and Nevis", () {
      var searchTerm = "Saint Kitts and Nevis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Lucia", () {
      var searchTerm = "Saint Lucia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Pierre and Miquelon", () {
      var searchTerm = "Saint Pierre and Miquelon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Vincent and the Grenadines", () {
      var searchTerm = "Saint Vincent and the Grenadines";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Samoa", () {
      var searchTerm = "Samoa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("San Marino", () {
      var searchTerm = "San Marino";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sao Tome and Principe", () {
      var searchTerm = "Sao Tome and Principe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("São Tomé and Príncipe", () {
      var searchTerm = "São Tomé and Príncipe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saudi Arabia", () {
      var searchTerm = "Saudi Arabia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Senegal", () {
      var searchTerm = "Senegal";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Serbia", () {
      var searchTerm = "Serbia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Seychelles", () {
      var searchTerm = "Seychelles";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sierra Leone", () {
      var searchTerm = "Sierra Leone";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Singapore", () {
      var searchTerm = "Singapore";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sint Maarten", () {
      var searchTerm = "Sint Maarten";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Slovakia", () {
      var searchTerm = "Slovakia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Slovenia", () {
      var searchTerm = "Slovenia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Solomon Islands", () {
      var searchTerm = "Solomon Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Somalia", () {
      var searchTerm = "Somalia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Somaliland", () {
      var searchTerm = "Somaliland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("South Africa", () {
      var searchTerm = "South Africa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("South Georgia", () {
      var searchTerm = "South Georgia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("South Korea", () {
      var searchTerm = "South Korea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("South Ossetia", () {
      var searchTerm = "South Ossetia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("South Sudan", () {
      var searchTerm = "South Sudan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Spain", () {
      var searchTerm = "Spain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sri Lanka", () {
      var searchTerm = "Sri Lanka";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("St. Martin", () {
      var searchTerm = "St. Martin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sudan", () {
      var searchTerm = "Sudan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Suriname", () {
      var searchTerm = "Suriname";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Svalbard", () {
      var searchTerm = "Svalbard";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sweden", () {
      var searchTerm = "Sweden";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Switzerland", () {
      var searchTerm = "Switzerland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Syria", () {
      var searchTerm = "Syria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Taiwan", () {
      var searchTerm = "Taiwan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tajikistan", () {
      var searchTerm = "Tajikistan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tanzania", () {
      var searchTerm = "Tanzania";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Thailand", () {
      var searchTerm = "Thailand";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Timor-Leste", () {
      var searchTerm = "Timor-Leste";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Togo", () {
      var searchTerm = "Togo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tonga", () {
      var searchTerm = "Tonga";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Transnistria", () {
      var searchTerm = "Transnistria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Trinidad and Tobago", () {
      var searchTerm = "Trinidad and Tobago";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tunisia", () {
      var searchTerm = "Tunisia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Turkey", () {
      var searchTerm = "Turkey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Turkmenistan", () {
      var searchTerm = "Turkmenistan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Turks and Caicos Islands", () {
      var searchTerm = "Turks and Caicos Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tuvalu", () {
      var searchTerm = "Tuvalu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Uganda", () {
      var searchTerm = "Uganda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ukraine", () {
      var searchTerm = "Ukraine";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("United Arab Emirates", () {
      var searchTerm = "United Arab Emirates";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("United Kingdom", () {
      var searchTerm = "United Kingdom";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("United States", () {
      var searchTerm = "United States";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("United States of America", () {
      var searchTerm = "United States of America";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Uruguay", () {
      var searchTerm = "Uruguay";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Uzbekistan", () {
      var searchTerm = "Uzbekistan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vanuatu", () {
      var searchTerm = "Vanuatu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vatican", () {
      var searchTerm = "Vatican";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vatican City", () {
      var searchTerm = "Vatican City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Venezuela", () {
      var searchTerm = "Venezuela";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vietnam", () {
      var searchTerm = "Vietnam";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Virgin Islands", () {
      var searchTerm = "Virgin Islands";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Wallis and Futuna", () {
      var searchTerm = "Wallis and Futuna";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Sahara", () {
      var searchTerm = "Western Sahara";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yemen", () {
      var searchTerm = "Yemen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Zambia", () {
      var searchTerm = "Zambia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Zimbabwe", () {
      var searchTerm = "Zimbabwe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    // GERMAN
    test("Ägypten", () {
      var searchTerm = "Ägypten";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Albanien", () {
      var searchTerm = "Albanien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Algerien", () {
      var searchTerm = "Algerien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Antigua und Barbuda", () {
      var searchTerm = "Antigua und Barbuda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Äquatorialguinea", () {
      var searchTerm = "Äquatorialguinea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Argentinien", () {
      var searchTerm = "Argentinien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Armenien", () {
      var searchTerm = "Armenien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Aserbaidschan", () {
      var searchTerm = "Aserbaidschan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Äthiopien", () {
      var searchTerm = "Äthiopien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australien", () {
      var searchTerm = "Australien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bangladesch", () {
      var searchTerm = "Bangladesch";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Belgien", () {
      var searchTerm = "Belgien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bolivien", () {
      var searchTerm = "Bolivien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bosnien und Herzegowina", () {
      var searchTerm = "Bosnien und Herzegowina";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brasilien", () {
      var searchTerm = "Brasilien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bulgarien", () {
      var searchTerm = "Bulgarien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("China, Volksrepublik", () {
      var searchTerm = "China, Volksrepublik";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dänemark", () {
      var searchTerm = "Dänemark";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Deutschland", () {
      var searchTerm = "Deutschland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dominikanische Republik", () {
      var searchTerm = "Dominikanische Republik";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dschibuti", () {
      var searchTerm = "Dschibuti";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Elfenbeinküste", () {
      var searchTerm = "Elfenbeinküste";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Estland", () {
      var searchTerm = "Estland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Fidschi", () {
      var searchTerm = "Fidschi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Finnland", () {
      var searchTerm = "Finnland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Frankreich", () {
      var searchTerm = "Frankreich";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gabun", () {
      var searchTerm = "Gabun";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Georgien", () {
      var searchTerm = "Georgien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Griechenland", () {
      var searchTerm = "Griechenland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Indien", () {
      var searchTerm = "Indien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Indonesien", () {
      var searchTerm = "Indonesien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Irak", () {
      var searchTerm = "Irak";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Irland", () {
      var searchTerm = "Irland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Island", () {
      var searchTerm = "Island";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Italien", () {
      var searchTerm = "Italien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jamaika", () {
      var searchTerm = "Jamaika";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jemen", () {
      var searchTerm = "Jemen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jordanien", () {
      var searchTerm = "Jordanien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kambodscha", () {
      var searchTerm = "Kambodscha";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kamerun", () {
      var searchTerm = "Kamerun";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kanada", () {
      var searchTerm = "Kanada";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kap Verde", () {
      var searchTerm = "Kap Verde";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kasachstan", () {
      var searchTerm = "Kasachstan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Katar", () {
      var searchTerm = "Katar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kenia", () {
      var searchTerm = "Kenia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kirgisistan", () {
      var searchTerm = "Kirgisistan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kolumbien", () {
      var searchTerm = "Kolumbien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Komoren", () {
      var searchTerm = "Komoren";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kongo", () {
      var searchTerm = "Kongo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kroatien", () {
      var searchTerm = "Kroatien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kuba", () {
      var searchTerm = "Kuba";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lettland", () {
      var searchTerm = "Lettland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Libanon", () {
      var searchTerm = "Libanon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Libyen", () {
      var searchTerm = "Libyen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Litauen", () {
      var searchTerm = "Litauen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Luxemburg", () {
      var searchTerm = "Luxemburg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Madagaskar", () {
      var searchTerm = "Madagaskar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Malediven", () {
      var searchTerm = "Malediven";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Marokko", () {
      var searchTerm = "Marokko";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Marshallinseln", () {
      var searchTerm = "Marshallinseln";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mauretanien", () {
      var searchTerm = "Mauretanien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mexiko", () {
      var searchTerm = "Mexiko";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mikronesien", () {
      var searchTerm = "Mikronesien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Moldau", () {
      var searchTerm = "Moldau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mongolei", () {
      var searchTerm = "Mongolei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mosambik", () {
      var searchTerm = "Mosambik";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Neuseeland", () {
      var searchTerm = "Neuseeland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Niederlande", () {
      var searchTerm = "Niederlande";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nordkorea", () {
      var searchTerm = "Nordkorea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nordmazedonien", () {
      var searchTerm = "Nordmazedonien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Norwegen", () {
      var searchTerm = "Norwegen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Österreich", () {
      var searchTerm = "Österreich";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Osttimor", () {
      var searchTerm = "Osttimor";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Palästina", () {
      var searchTerm = "Palästina";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Papua-Neuguinea", () {
      var searchTerm = "Papua-Neuguinea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Philippinen", () {
      var searchTerm = "Philippinen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Polen", () {
      var searchTerm = "Polen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ruanda", () {
      var searchTerm = "Ruanda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Rumänien", () {
      var searchTerm = "Rumänien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Russland", () {
      var searchTerm = "Russland";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Salomonen", () {
      var searchTerm = "Salomonen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sambia", () {
      var searchTerm = "Sambia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("São Tomé und Príncipe", () {
      var searchTerm = "São Tomé und Príncipe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saudi-Arabien", () {
      var searchTerm = "Saudi-Arabien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Schweden", () {
      var searchTerm = "Schweden";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Schweiz", () {
      var searchTerm = "Schweiz";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Serbien", () {
      var searchTerm = "Serbien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Seychellen", () {
      var searchTerm = "Seychellen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Simbabwe", () {
      var searchTerm = "Simbabwe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Singapur", () {
      var searchTerm = "Singapur";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Slowakei", () {
      var searchTerm = "Slowakei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Slowenien", () {
      var searchTerm = "Slowenien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Spanien", () {
      var searchTerm = "Spanien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("St. Kitts und Nevis", () {
      var searchTerm = "St. Kitts und Nevis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("St. Lucia", () {
      var searchTerm = "St. Lucia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("St. Vincent und die Grenadinen", () {
      var searchTerm = "St. Vincent und die Grenadinen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Südafrika", () {
      var searchTerm = "Südafrika";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Südkorea", () {
      var searchTerm = "Südkorea";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Südsudan", () {
      var searchTerm = "Südsudan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Syrien", () {
      var searchTerm = "Syrien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tadschikistan", () {
      var searchTerm = "Tadschikistan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tansania", () {
      var searchTerm = "Tansania";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Trinidad und Tobago", () {
      var searchTerm = "Trinidad und Tobago";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tschad", () {
      var searchTerm = "Tschad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tschechien", () {
      var searchTerm = "Tschechien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tunesien", () {
      var searchTerm = "Tunesien";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Türkei", () {
      var searchTerm = "Türkei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ungarn", () {
      var searchTerm = "Ungarn";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Usbekistan", () {
      var searchTerm = "Usbekistan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vatikanstadt", () {
      var searchTerm = "Vatikanstadt";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vereinigte Arabische Emirate", () {
      var searchTerm = "Vereinigte Arabische Emirate";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vereinigtes Königreich", () {
      var searchTerm = "Vereinigtes Königreich";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vereinigte Staaten", () {
      var searchTerm = "Vereinigte Staaten";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Zentralafrikanische Republik", () {
      var searchTerm = "Zentralafrikanische Republik";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Zypern", () {
      var searchTerm = "Zypern";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });
  }, skip: skip);
}
