import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/models/timezone_search_zones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzd;

void main() {
  const skip = true;

  group('IANA timezone names', () {
    tzd.initializeTimeZones();

    test('Europe/London', () {
      String ianaZone = 'Europe/London';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Dublin', () {
      String ianaZone = 'Europe/Dublin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Lisbon', () {
      String ianaZone = 'Europe/Lisbon';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Berlin', () {
      String ianaZone = 'Europe/Berlin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Vienna', () {
      String ianaZone = 'Europe/Vienna';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Zurich', () {
      String ianaZone = 'Europe/Zurich';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Paris', () {
      String ianaZone = 'Europe/Paris';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Brussels', () {
      String ianaZone = 'Europe/Brussels';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Madrid', () {
      String ianaZone = 'Europe/Madrid';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Rome', () {
      String ianaZone = 'Europe/Rome';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Prague', () {
      String ianaZone = 'Europe/Prague';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Warsaw', () {
      String ianaZone = 'Europe/Warsaw';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Budapest', () {
      String ianaZone = 'Europe/Budapest';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Helsinki', () {
      String ianaZone = 'Europe/Helsinki';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Athens', () {
      String ianaZone = 'Europe/Athens';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Bucharest', () {
      String ianaZone = 'Europe/Bucharest';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Kyiv', () {
      String ianaZone = 'Europe/Kyiv';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Istanbul', () {
      String ianaZone = 'Europe/Istanbul';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Europe/Moscow', () {
      String ianaZone = 'Europe/Moscow';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Casablanca', () {
      String ianaZone = 'Africa/Casablanca';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Cairo', () {
      String ianaZone = 'Africa/Cairo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Johannesburg', () {
      String ianaZone = 'Africa/Johannesburg';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Nairobi', () {
      String ianaZone = 'Africa/Nairobi';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Lagos', () {
      String ianaZone = 'Africa/Lagos';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Abidjan', () {
      String ianaZone = 'Africa/Abidjan';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Africa/Tunis', () {
      String ianaZone = 'Africa/Tunis';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/New_York', () {
      String ianaZone = 'America/New_York';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Chicago', () {
      String ianaZone = 'America/Chicago';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Denver', () {
      String ianaZone = 'America/Denver';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Los_Angeles', () {
      String ianaZone = 'America/Los_Angeles';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Anchorage', () {
      String ianaZone = 'America/Anchorage';
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

    test('America/Halifax', () {
      String ianaZone = 'America/Halifax';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/St_Johns', () {
      String ianaZone = 'America/St_Johns';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Mexico_City', () {
      String ianaZone = 'America/Mexico_City';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Bogota', () {
      String ianaZone = 'America/Bogota';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Sao_Paulo', () {
      String ianaZone = 'America/Sao_Paulo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('America/Argentina/Buenos_Aires', () {
      String ianaZone = 'America/Argentina/Buenos_Aires';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Dubai', () {
      String ianaZone = 'Asia/Dubai';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tehran', () {
      String ianaZone = 'Asia/Tehran';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Karachi', () {
      String ianaZone = 'Asia/Karachi';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kolkata', () {
      String ianaZone = 'Asia/Kolkata';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Colombo', () {
      String ianaZone = 'Asia/Colombo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Kathmandu', () {
      String ianaZone = 'Asia/Kathmandu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Dhaka', () {
      String ianaZone = 'Asia/Dhaka';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Yangon', () {
      String ianaZone = 'Asia/Yangon';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Bangkok', () {
      String ianaZone = 'Asia/Bangkok';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Jakarta', () {
      String ianaZone = 'Asia/Jakarta';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Shanghai', () {
      String ianaZone = 'Asia/Shanghai';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Hong_Kong', () {
      String ianaZone = 'Asia/Hong_Kong';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Singapore', () {
      String ianaZone = 'Asia/Singapore';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Taipei', () {
      String ianaZone = 'Asia/Taipei';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Manila', () {
      String ianaZone = 'Asia/Manila';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Seoul', () {
      String ianaZone = 'Asia/Seoul';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Tokyo', () {
      String ianaZone = 'Asia/Tokyo';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Asia/Baghdad', () {
      String ianaZone = 'Asia/Baghdad';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Perth', () {
      String ianaZone = 'Australia/Perth';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Darwin', () {
      String ianaZone = 'Australia/Darwin';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Brisbane', () {
      String ianaZone = 'Australia/Brisbane';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Adelaide', () {
      String ianaZone = 'Australia/Adelaide';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Sydney', () {
      String ianaZone = 'Australia/Sydney';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Hobart', () {
      String ianaZone = 'Australia/Hobart';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Australia/Lord_Howe', () {
      String ianaZone = 'Australia/Lord_Howe';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Auckland', () {
      String ianaZone = 'Pacific/Auckland';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Honolulu', () {
      String ianaZone = 'Pacific/Honolulu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Fiji', () {
      String ianaZone = 'Pacific/Fiji';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Guam', () {
      String ianaZone = 'Pacific/Guam';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Tongatapu', () {
      String ianaZone = 'Pacific/Tongatapu';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Tahiti', () {
      String ianaZone = 'Pacific/Tahiti';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Marquesas', () {
      String ianaZone = 'Pacific/Marquesas';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Pago_Pago', () {
      String ianaZone = 'Pacific/Pago_Pago';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Norfolk', () {
      String ianaZone = 'Pacific/Norfolk';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Pacific/Port_Moresby', () {
      String ianaZone = 'Pacific/Port_Moresby';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Azores', () {
      String ianaZone = 'Atlantic/Azores';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Cape_Verde', () {
      String ianaZone = 'Atlantic/Cape_Verde';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/South_Georgia', () {
      String ianaZone = 'Atlantic/South_Georgia';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Atlantic/Canary', () {
      String ianaZone = 'Atlantic/Canary';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Troll', () {
      String ianaZone = 'Antarctica/Troll';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });

    test('Antarctica/Palmer', () {
      String ianaZone = 'Antarctica/Palmer';
      var loc = tz.getLocation(ianaZone);
      expect(loc.name, equals(ianaZone));
    });
  }, skip: false);

  group('IANA timezone names deprecated', () {
    test('Amsterdam', () {
      String ianaZone = 'Europe/Brussels';
      var searchTerm = 'amsterdam';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Copenhagen', () {
      String ianaZone = 'Europe/Berlin';
      var searchTerm = 'copenhagen';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Kiev', () {
      String ianaZone = 'Europe/Kyiv';
      var searchTerm = 'kiev';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Kuala Lumpur', () {
      String ianaZone = 'Asia/Singapore';
      var searchTerm = 'kuala lumpur';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Longyearbyen', () {
      String ianaZone = 'Europe/Berlin';
      var searchTerm = 'longyearbyen';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Luxembourg', () {
      String ianaZone = 'Europe/Brussels';
      var searchTerm = 'luxembourg';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('McMurdo', () {
      String ianaZone = 'Pacific/Auckland';
      var searchTerm = 'mcmurdo';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Midway', () {
      String ianaZone = 'Pacific/Pago_Pago';
      var searchTerm = 'midway';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Oslo', () {
      String ianaZone = 'Europe/Berlin';
      var searchTerm = 'oslo';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Reykjavik', () {
      String ianaZone = 'Africa/Abidjan';
      var searchTerm = 'reykjavik';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });

    test('Stockholm', () {
      String ianaZone = 'Europe/Berlin';
      var searchTerm = 'stockholm';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, equals(1));
      expect(loc[0].ianaZone, equals(ianaZone));
    });
  }, skip: false);

  group('timezone search abbreviations', () {
    test('ACDT', () {
      var searchTerm = 'ACDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ACST', () {
      var searchTerm = 'ACST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ACT', () {
      var searchTerm = 'ACT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ACWST', () {
      var searchTerm = 'ACWST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ADT', () {
      var searchTerm = 'ADT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AEDT', () {
      var searchTerm = 'AEDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AEST', () {
      var searchTerm = 'AEST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AET', () {
      var searchTerm = 'AET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AFT', () {
      var searchTerm = 'AFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AKDT', () {
      var searchTerm = 'AKDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AKST', () {
      var searchTerm = 'AKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ALMT', () {
      var searchTerm = 'ALMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AMST', () {
      var searchTerm = 'AMST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AMT', () {
      var searchTerm = 'AMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ANAST', () {
      var searchTerm = 'ANAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ANAT', () {
      var searchTerm = 'ANAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AoE', () {
      var searchTerm = 'AoE';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AQTT', () {
      var searchTerm = 'AQTT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ART', () {
      var searchTerm = 'ART';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AST', () {
      var searchTerm = 'AST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AT', () {
      var searchTerm = 'AT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AWDT', () {
      var searchTerm = 'AWDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AWST', () {
      var searchTerm = 'AWST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AZOST', () {
      var searchTerm = 'AZOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AZOT', () {
      var searchTerm = 'AZOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AZST', () {
      var searchTerm = 'AZST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('AZT', () {
      var searchTerm = 'AZT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('BNT', () {
      var searchTerm = 'BNT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('BOT', () {
      var searchTerm = 'BOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('BRST', () {
      var searchTerm = 'BRST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('BRT', () {
      var searchTerm = 'BRT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('BST', () {
      var searchTerm = 'BST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('BTT', () {
      var searchTerm = 'BTT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CAST', () {
      var searchTerm = 'CAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CAT', () {
      var searchTerm = 'CAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CCT', () {
      var searchTerm = 'CCT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CDT', () {
      var searchTerm = 'CDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CEST', () {
      var searchTerm = 'CEST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CET', () {
      var searchTerm = 'CET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CHADT', () {
      var searchTerm = 'CHADT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CHAST', () {
      var searchTerm = 'CHAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CHOST', () {
      var searchTerm = 'CHOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CHOT', () {
      var searchTerm = 'CHOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ChST', () {
      var searchTerm = 'ChST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CHUT', () {
      var searchTerm = 'CHUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CIDST', () {
      var searchTerm = 'CIDST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CIST', () {
      var searchTerm = 'CIST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CKT', () {
      var searchTerm = 'CKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CLST', () {
      var searchTerm = 'CLST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CLT', () {
      var searchTerm = 'CLT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('COT', () {
      var searchTerm = 'COT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CST', () {
      var searchTerm = 'CST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CT', () {
      var searchTerm = 'CT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CVT', () {
      var searchTerm = 'CVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('CXT', () {
      var searchTerm = 'CXT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('DAVT', () {
      var searchTerm = 'DAVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('DDUT', () {
      var searchTerm = 'DDUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EASST', () {
      var searchTerm = 'EASST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EAST', () {
      var searchTerm = 'EAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EAT', () {
      var searchTerm = 'EAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ECT', () {
      var searchTerm = 'ECT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EDT', () {
      var searchTerm = 'EDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EEST', () {
      var searchTerm = 'EEST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EET', () {
      var searchTerm = 'EET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EGST', () {
      var searchTerm = 'EGST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EGT', () {
      var searchTerm = 'EGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('EST', () {
      var searchTerm = 'EST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ET', () {
      var searchTerm = 'ET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('FET', () {
      var searchTerm = 'FET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('FJST', () {
      var searchTerm = 'FJST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('FJT', () {
      var searchTerm = 'FJT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('FKST', () {
      var searchTerm = 'FKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('FKT', () {
      var searchTerm = 'FKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('FNT', () {
      var searchTerm = 'FNT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('GALT', () {
      var searchTerm = 'GALT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('GAMT', () {
      var searchTerm = 'GAMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('GET', () {
      var searchTerm = 'GET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('GFT', () {
      var searchTerm = 'GFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('GILT', () {
      var searchTerm = 'GILT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('GMT', () {
      var searchTerm = 'GMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('GST', () {
      var searchTerm = 'GST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('GYT', () {
      var searchTerm = 'GYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('HDT', () {
      var searchTerm = 'HDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('HKT', () {
      var searchTerm = 'HKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('HOVST', () {
      var searchTerm = 'HOVST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('HOVT', () {
      var searchTerm = 'HOVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('HST', () {
      var searchTerm = 'HST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ICT', () {
      var searchTerm = 'ICT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('IDT', () {
      var searchTerm = 'IDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('IOT', () {
      var searchTerm = 'IOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('IRDT', () {
      var searchTerm = 'IRDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('IRKST', () {
      var searchTerm = 'IRKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('IRKT', () {
      var searchTerm = 'IRKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('IRST', () {
      var searchTerm = 'IRST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('IST', () {
      var searchTerm = 'IST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('JST', () {
      var searchTerm = 'JST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('KGT', () {
      var searchTerm = 'KGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('KOST', () {
      var searchTerm = 'KOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('KRAST', () {
      var searchTerm = 'KRAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('KRAT', () {
      var searchTerm = 'KRAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('KST', () {
      var searchTerm = 'KST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('KUYT', () {
      var searchTerm = 'KUYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('LHDT', () {
      var searchTerm = 'LHDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('LHST', () {
      var searchTerm = 'LHST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('LINT', () {
      var searchTerm = 'LINT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MAGST', () {
      var searchTerm = 'MAGST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MAGT', () {
      var searchTerm = 'MAGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MART', () {
      var searchTerm = 'MART';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MAWT', () {
      var searchTerm = 'MAWT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MDT', () {
      var searchTerm = 'MDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MHT', () {
      var searchTerm = 'MHT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MMT', () {
      var searchTerm = 'MMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MSD', () {
      var searchTerm = 'MSD';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MSK', () {
      var searchTerm = 'MSK';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MST', () {
      var searchTerm = 'MST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MT', () {
      var searchTerm = 'MT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MUT', () {
      var searchTerm = 'MUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MVT', () {
      var searchTerm = 'MVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('MYT', () {
      var searchTerm = 'MYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NCT', () {
      var searchTerm = 'NCT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NDT', () {
      var searchTerm = 'NDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NFDT', () {
      var searchTerm = 'NFDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NFT', () {
      var searchTerm = 'NFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NOVST', () {
      var searchTerm = 'NOVST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NOVT', () {
      var searchTerm = 'NOVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NPT', () {
      var searchTerm = 'NPT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NRT', () {
      var searchTerm = 'NRT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NST', () {
      var searchTerm = 'NST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NUT', () {
      var searchTerm = 'NUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NZDT', () {
      var searchTerm = 'NZDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('NZST', () {
      var searchTerm = 'NZST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('OMSST', () {
      var searchTerm = 'OMSST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('OMST', () {
      var searchTerm = 'OMST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ORAT', () {
      var searchTerm = 'ORAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PDT', () {
      var searchTerm = 'PDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PET', () {
      var searchTerm = 'PET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PETST', () {
      var searchTerm = 'PETST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PETT', () {
      var searchTerm = 'PETT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PGT', () {
      var searchTerm = 'PGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PHOT', () {
      var searchTerm = 'PHOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PHT', () {
      var searchTerm = 'PHT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PKT', () {
      var searchTerm = 'PKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PMDT', () {
      var searchTerm = 'PMDT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PMST', () {
      var searchTerm = 'PMST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PONT', () {
      var searchTerm = 'PONT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PST', () {
      var searchTerm = 'PST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PT', () {
      var searchTerm = 'PT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PWT', () {
      var searchTerm = 'PWT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PYST', () {
      var searchTerm = 'PYST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('PYT', () {
      var searchTerm = 'PYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('QYZT', () {
      var searchTerm = 'QYZT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('RET', () {
      var searchTerm = 'RET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SAKT', () {
      var searchTerm = 'SAKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SAMT', () {
      var searchTerm = 'SAMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SAST', () {
      var searchTerm = 'SAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SBT', () {
      var searchTerm = 'SBT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SCT', () {
      var searchTerm = 'SCT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SGT', () {
      var searchTerm = 'SGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SRET', () {
      var searchTerm = 'SRET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SRT', () {
      var searchTerm = 'SRT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SST', () {
      var searchTerm = 'SST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('SYOT', () {
      var searchTerm = 'SYOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TAHT', () {
      var searchTerm = 'TAHT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TFT', () {
      var searchTerm = 'TFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TJT', () {
      var searchTerm = 'TJT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TKT', () {
      var searchTerm = 'TKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TLT', () {
      var searchTerm = 'TLT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TMT', () {
      var searchTerm = 'TMT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TOST', () {
      var searchTerm = 'TOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TOT', () {
      var searchTerm = 'TOT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TRT', () {
      var searchTerm = 'TRT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('TVT', () {
      var searchTerm = 'TVT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ULAST', () {
      var searchTerm = 'ULAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('ULAT', () {
      var searchTerm = 'ULAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('UTC', () {
      var searchTerm = 'UTC';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('UYST', () {
      var searchTerm = 'UYST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('UYT', () {
      var searchTerm = 'UYT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('UZT', () {
      var searchTerm = 'UZT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('VET', () {
      var searchTerm = 'VET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('VLAST', () {
      var searchTerm = 'VLAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('VLAT', () {
      var searchTerm = 'VLAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('VOST', () {
      var searchTerm = 'VOST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('VUT', () {
      var searchTerm = 'VUT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WAKT', () {
      var searchTerm = 'WAKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WARST', () {
      var searchTerm = 'WARST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WAST', () {
      var searchTerm = 'WAST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WAT', () {
      var searchTerm = 'WAT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WEST', () {
      var searchTerm = 'WEST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WET', () {
      var searchTerm = 'WET';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WFT', () {
      var searchTerm = 'WFT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WGST', () {
      var searchTerm = 'WGST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WGT', () {
      var searchTerm = 'WGT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WIB', () {
      var searchTerm = 'WIB';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WIT', () {
      var searchTerm = 'WIT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WITA', () {
      var searchTerm = 'WITA';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WST', () {
      var searchTerm = 'WST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('WT', () {
      var searchTerm = 'WT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('YAKST', () {
      var searchTerm = 'YAKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('YAKT', () {
      var searchTerm = 'YAKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('YAPT', () {
      var searchTerm = 'YAPT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('YEKST', () {
      var searchTerm = 'YEKST';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('YEKT', () {
      var searchTerm = 'YEKT';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+00', () {
      var searchTerm = '+00';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-00', () {
      var searchTerm = '-00';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+01', () {
      var searchTerm = '+01';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-01', () {
      var searchTerm = '-01';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+02', () {
      var searchTerm = '+02';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-02', () {
      var searchTerm = '-02';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+03', () {
      var searchTerm = '+03';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-03', () {
      var searchTerm = '-03';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+0330', () {
      var searchTerm = '+0330';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+04', () {
      var searchTerm = '+04';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-04', () {
      var searchTerm = '-04';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+0430', () {
      var searchTerm = '+0430';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+05', () {
      var searchTerm = '+05';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-05', () {
      var searchTerm = '-05';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+0530', () {
      var searchTerm = '+0530';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+0545', () {
      var searchTerm = '+0545';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+06', () {
      var searchTerm = '+06';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-06', () {
      var searchTerm = '-06';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+0630', () {
      var searchTerm = '+0630';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+07', () {
      var searchTerm = '+07';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-07', () {
      var searchTerm = '-07';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+08', () {
      var searchTerm = '+08';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-08', () {
      var searchTerm = '-08';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+0845', () {
      var searchTerm = '+0845';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+09', () {
      var searchTerm = '+09';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-09', () {
      var searchTerm = '-09';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-0930', () {
      var searchTerm = '-0930';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+10', () {
      var searchTerm = '+10';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-10', () {
      var searchTerm = '-10';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+1030', () {
      var searchTerm = '+1030';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+11', () {
      var searchTerm = '+11';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-11', () {
      var searchTerm = '-11';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+12', () {
      var searchTerm = '+12';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('-12', () {
      var searchTerm = '-12';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+1245', () {
      var searchTerm = '+1245';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+13', () {
      var searchTerm = '+13';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test('+14', () {
      var searchTerm = '+14';
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });
  }, skip: skip);

  group('timezone search names', () {
    test("Acre Time", () {
      var searchTerm = "Acre Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Afghanistan Time", () {
      var searchTerm = "Afghanistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Alaska Daylight Saving Time", () {
      var searchTerm = "Alaska Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Alaska Daylight Time", () {
      var searchTerm = "Alaska Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Alaska Standard Time", () {
      var searchTerm = "Alaska Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Alaska Time", () {
      var searchTerm = "Alaska Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Alma-Ata Time", () {
      var searchTerm = "Alma-Ata Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Al Manamah Standard Time", () {
      var searchTerm = "Al Manamah Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Amazon Summer Time", () {
      var searchTerm = "Amazon Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Amazon Time", () {
      var searchTerm = "Amazon Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Anadyr Summer Time", () {
      var searchTerm = "Anadyr Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Anadyr Time", () {
      var searchTerm = "Anadyr Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Anywhere on Earth", () {
      var searchTerm = "Anywhere on Earth";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Aqtobe Time", () {
      var searchTerm = "Aqtobe Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Arabia Daylight Time", () {
      var searchTerm = "Arabia Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Arabia Standard Time", () {
      var searchTerm = "Arabia Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Arabia Summer Time", () {
      var searchTerm = "Arabia Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Arabic Standard Time", () {
      var searchTerm = "Arabic Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Argentina Time", () {
      var searchTerm = "Argentina Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Armenia Daylight Time", () {
      var searchTerm = "Armenia Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Armenia Summer Time", () {
      var searchTerm = "Armenia Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Armenia Time", () {
      var searchTerm = "Armenia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Daylight Saving Time", () {
      var searchTerm = "Atlantic Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Daylight Time", () {
      var searchTerm = "Atlantic Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Standard Time", () {
      var searchTerm = "Atlantic Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Summer Time", () {
      var searchTerm = "Atlantic Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Atlantic Time", () {
      var searchTerm = "Atlantic Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Central Daylight Time", () {
      var searchTerm = "Australian Central Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Central Standard Time", () {
      var searchTerm = "Australian Central Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Central Time", () {
      var searchTerm = "Australian Central Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Central Western Standard Time", () {
      var searchTerm = "Australian Central Western Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Eastern Daylight Time", () {
      var searchTerm = "Australian Eastern Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Eastern Standard Time", () {
      var searchTerm = "Australian Eastern Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Eastern Time", () {
      var searchTerm = "Australian Eastern Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Western Daylight Time", () {
      var searchTerm = "Australian Western Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Australian Western Standard Time", () {
      var searchTerm = "Australian Western Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Azerbaijan Summer Time", () {
      var searchTerm = "Azerbaijan Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Azerbaijan Time", () {
      var searchTerm = "Azerbaijan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Azores Daylight Time", () {
      var searchTerm = "Azores Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Azores Standard Time", () {
      var searchTerm = "Azores Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Azores Summer Time", () {
      var searchTerm = "Azores Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Azores Time", () {
      var searchTerm = "Azores Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bangladesh Standard Time", () {
      var searchTerm = "Bangladesh Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bhutan Time", () {
      var searchTerm = "Bhutan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bolivia Time", () {
      var searchTerm = "Bolivia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bougainville Standard Time", () {
      var searchTerm = "Bougainville Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brasília Summer Time", () {
      var searchTerm = "Brasília Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brasília Time", () {
      var searchTerm = "Brasília Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brazilian Summer Time", () {
      var searchTerm = "Brazilian Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brazilian Time", () {
      var searchTerm = "Brazilian Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brazil Summer Time", () {
      var searchTerm = "Brazil Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brazil Time", () {
      var searchTerm = "Brazil Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("British Daylight Saving Time", () {
      var searchTerm = "British Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("British Daylight Time", () {
      var searchTerm = "British Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("British Summer Time", () {
      var searchTerm = "British Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brunei Darussalam Time", () {
      var searchTerm = "Brunei Darussalam Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brunei Time", () {
      var searchTerm = "Brunei Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cape Verde Time", () {
      var searchTerm = "Cape Verde Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Casey Time", () {
      var searchTerm = "Casey Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cayman Islands Daylight Saving Time", () {
      var searchTerm = "Cayman Islands Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cayman Islands Standard Time", () {
      var searchTerm = "Cayman Islands Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cayman Islands Time", () {
      var searchTerm = "Cayman Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Africa Time", () {
      var searchTerm = "Central Africa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Daylight Savings Time", () {
      var searchTerm = "Central Daylight Savings Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Daylight Saving Time", () {
      var searchTerm = "Central Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Daylight Time", () {
      var searchTerm = "Central Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central European Daylight Time", () {
      var searchTerm = "Central European Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central European Summer Time", () {
      var searchTerm = "Central European Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central European Time", () {
      var searchTerm = "Central European Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Europe Time", () {
      var searchTerm = "Central Europe Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Indonesian Time", () {
      var searchTerm = "Central Indonesian Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Standard Time", () {
      var searchTerm = "Central Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Central Time", () {
      var searchTerm = "Central Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chamorro Standard Time", () {
      var searchTerm = "Chamorro Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chatham Daylight Time", () {
      var searchTerm = "Chatham Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chatham Island Daylight Time", () {
      var searchTerm = "Chatham Island Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chatham Island Standard Time", () {
      var searchTerm = "Chatham Island Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chile Daylight Time", () {
      var searchTerm = "Chile Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chile Standard Time", () {
      var searchTerm = "Chile Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chile Summer Time", () {
      var searchTerm = "Chile Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chile Time", () {
      var searchTerm = "Chile Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("China Standard Time", () {
      var searchTerm = "China Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Choibalsan Daylight Saving Time", () {
      var searchTerm = "Choibalsan Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Choibalsan Daylight TimeT", () {
      var searchTerm = "Choibalsan Daylight TimeT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Choibalsan Summer Time", () {
      var searchTerm = "Choibalsan Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Choibalsan Time", () {
      var searchTerm = "Choibalsan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Christmas Island Time", () {
      var searchTerm = "Christmas Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chuuk Time", () {
      var searchTerm = "Chuuk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cocos Islands Time", () {
      var searchTerm = "Cocos Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Colombia Time", () {
      var searchTerm = "Colombia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cook Island Time", () {
      var searchTerm = "Cook Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Coordinated Universal Time", () {
      var searchTerm = "Coordinated Universal Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cuba Daylight Time", () {
      var searchTerm = "Cuba Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cuba Standard Time", () {
      var searchTerm = "Cuba Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Davis Time", () {
      var searchTerm = "Davis Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dumont-d'Urville Time", () {
      var searchTerm = "Dumont-d'Urville Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("East Africa Time", () {
      var searchTerm = "East Africa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Easter Island Daylight Time", () {
      var searchTerm = "Easter Island Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Easter Island Standard Time", () {
      var searchTerm = "Easter Island Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Easter Island Summer Time", () {
      var searchTerm = "Easter Island Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Africa Time", () {
      var searchTerm = "Eastern Africa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Daylight Savings Time", () {
      var searchTerm = "Eastern Daylight Savings Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Daylight Saving Time", () {
      var searchTerm = "Eastern Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Daylight Time", () {
      var searchTerm = "Eastern Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern European Daylight Time", () {
      var searchTerm = "Eastern European Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern European Summer Time", () {
      var searchTerm = "Eastern European Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern European Time", () {
      var searchTerm = "Eastern European Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Greenland Summer Time", () {
      var searchTerm = "Eastern Greenland Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Greenland Time", () {
      var searchTerm = "Eastern Greenland Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Indonesian Time", () {
      var searchTerm = "Eastern Indonesian Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Standard Time", () {
      var searchTerm = "Eastern Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Eastern Time", () {
      var searchTerm = "Eastern Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("East Greenland Summer Time", () {
      var searchTerm = "East Greenland Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("East Greenland Time", () {
      var searchTerm = "East Greenland Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("East Timor Time", () {
      var searchTerm = "East Timor Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ecuador Time", () {
      var searchTerm = "Ecuador Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Efate Time", () {
      var searchTerm = "Efate Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("European Central Summer Time", () {
      var searchTerm = "European Central Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("European Central Time", () {
      var searchTerm = "European Central Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Island Daylight Time", () {
      var searchTerm = "Falkland Island Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Islands Summer Time", () {
      var searchTerm = "Falkland Islands Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Island Standard Time", () {
      var searchTerm = "Falkland Island Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Falkland Island Time", () {
      var searchTerm = "Falkland Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Fernando de Noronha Time", () {
      var searchTerm = "Fernando de Noronha Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Fiji Daylight Time", () {
      var searchTerm = "Fiji Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Fiji Summer Time", () {
      var searchTerm = "Fiji Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Fiji Time", () {
      var searchTerm = "Fiji Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("French Guiana Time", () {
      var searchTerm = "French Guiana Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("French Southern and Antarctic Time", () {
      var searchTerm = "French Southern and Antarctic Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Further-Eastern European Time", () {
      var searchTerm = "Further-Eastern European Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Galapagos Time", () {
      var searchTerm = "Galapagos Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gambier Islands Time", () {
      var searchTerm = "Gambier Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gambier Time", () {
      var searchTerm = "Gambier Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Georgia Standard Time", () {
      var searchTerm = "Georgia Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gilbert Island Time", () {
      var searchTerm = "Gilbert Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Greenwich Mean Time", () {
      var searchTerm = "Greenwich Mean Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Greenwich Time", () {
      var searchTerm = "Greenwich Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guam Standard Time", () {
      var searchTerm = "Guam Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gulf Standard Time", () {
      var searchTerm = "Gulf Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guyana Time", () {
      var searchTerm = "Guyana Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hawaii-Aleutian Daylight Time", () {
      var searchTerm = "Hawaii-Aleutian Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hawaii-Aleutian Standard Time", () {
      var searchTerm = "Hawaii-Aleutian Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hawaii Daylight Time", () {
      var searchTerm = "Hawaii Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hawaii Standard Time", () {
      var searchTerm = "Hawaii Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hong Kong Time", () {
      var searchTerm = "Hong Kong Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hovd Daylight Saving Time", () {
      var searchTerm = "Hovd Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hovd Daylight TimeT", () {
      var searchTerm = "Hovd Daylight TimeT";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hovd Summer Time", () {
      var searchTerm = "Hovd Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hovd Time", () {
      var searchTerm = "Hovd Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Indian Chagos Time", () {
      var searchTerm = "Indian Chagos Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Indian Standard Time", () {
      var searchTerm = "Indian Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("India Standard Time", () {
      var searchTerm = "India Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("India Time", () {
      var searchTerm = "India Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Indochina Time", () {
      var searchTerm = "Indochina Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Iran Daylight Time", () {
      var searchTerm = "Iran Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Iran Standard Time", () {
      var searchTerm = "Iran Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Iran Summer Time", () {
      var searchTerm = "Iran Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Iran Time", () {
      var searchTerm = "Iran Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Irish Standard Time", () {
      var searchTerm = "Irish Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Irish Summer Time", () {
      var searchTerm = "Irish Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Irkutsk Summer Time", () {
      var searchTerm = "Irkutsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Irkutsk Time", () {
      var searchTerm = "Irkutsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Israel Daylight Time", () {
      var searchTerm = "Israel Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Israel Standard Time", () {
      var searchTerm = "Israel Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Japan Standard Time", () {
      var searchTerm = "Japan Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kamchatka Summer Time", () {
      var searchTerm = "Kamchatka Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kamchatka Time", () {
      var searchTerm = "Kamchatka Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kerguelen (Islands) Time", () {
      var searchTerm = "Kerguelen (Islands) Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Korean Standard Time", () {
      var searchTerm = "Korean Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Korea Standard Time", () {
      var searchTerm = "Korea Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Korea Time", () {
      var searchTerm = "Korea Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kosrae Time", () {
      var searchTerm = "Kosrae Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Krasnoyarsk Summer Time", () {
      var searchTerm = "Krasnoyarsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Krasnoyarsk Time", () {
      var searchTerm = "Krasnoyarsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kuybyshev Time", () {
      var searchTerm = "Kuybyshev Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kyrgyzstan Time", () {
      var searchTerm = "Kyrgyzstan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Line Islands Time", () {
      var searchTerm = "Line Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lord Howe Daylight Time", () {
      var searchTerm = "Lord Howe Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lord Howe Standard Time", () {
      var searchTerm = "Lord Howe Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Magadan Island Summer Time", () {
      var searchTerm = "Magadan Island Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Magadan Island Time", () {
      var searchTerm = "Magadan Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Magadan Summer Time", () {
      var searchTerm = "Magadan Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Magadan Time", () {
      var searchTerm = "Magadan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Malaysian Standard Time", () {
      var searchTerm = "Malaysian Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Malaysia Time", () {
      var searchTerm = "Malaysia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Maldives Time", () {
      var searchTerm = "Maldives Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Marquesas Time", () {
      var searchTerm = "Marquesas Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Marshall Islands Time", () {
      var searchTerm = "Marshall Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mauritius Time", () {
      var searchTerm = "Mauritius Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mawson Time", () {
      var searchTerm = "Mawson Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mitteleuropäische Sommerzeit", () {
      var searchTerm = "Mitteleuropäische Sommerzeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mitteleuropäische Zeit", () {
      var searchTerm = "Mitteleuropäische Zeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Moscow Daylight Time Moscow Summer Time", () {
      var searchTerm = "Moscow Daylight Time Moscow Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Moscow Standard Time", () {
      var searchTerm = "Moscow Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Moscow Time", () {
      var searchTerm = "Moscow Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mountain Daylight Saving Time", () {
      var searchTerm = "Mountain Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mountain Daylight Time", () {
      var searchTerm = "Mountain Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mountain Standard Time", () {
      var searchTerm = "Mountain Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mountain Time", () {
      var searchTerm = "Mountain Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Myanmar Time", () {
      var searchTerm = "Myanmar Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nauru Time", () {
      var searchTerm = "Nauru Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nepal Time", () {
      var searchTerm = "Nepal Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("New Caledonia Time", () {
      var searchTerm = "New Caledonia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Newfoundland Daylight Time", () {
      var searchTerm = "Newfoundland Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Newfoundland Standard Time", () {
      var searchTerm = "Newfoundland Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("New Zealand Daylight Time", () {
      var searchTerm = "New Zealand Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("New Zealand Standard Time", () {
      var searchTerm = "New Zealand Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Niue Time", () {
      var searchTerm = "Niue Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Daylight Time", () {
      var searchTerm = "Norfolk Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Island Daylight Time", () {
      var searchTerm = "Norfolk Island Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Island Time", () {
      var searchTerm = "Norfolk Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Norfolk Time", () {
      var searchTerm = "Norfolk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North American Central Daylight Time", () {
      var searchTerm = "North American Central Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North American Central Standard Time", () {
      var searchTerm = "North American Central Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North American Eastern Daylight Time", () {
      var searchTerm = "North American Eastern Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North American Eastern Standard Time", () {
      var searchTerm = "North American Eastern Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North American Mountain Daylight Time", () {
      var searchTerm = "North American Mountain Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North American Mountain Standard Time", () {
      var searchTerm = "North American Mountain Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North American Pacific Daylight Time", () {
      var searchTerm = "North American Pacific Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("North American Pacific Standard Time", () {
      var searchTerm = "North American Pacific Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Novosibirsk Summer Time", () {
      var searchTerm = "Novosibirsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Novosibirsk Time", () {
      var searchTerm = "Novosibirsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Omsk Standard Time", () {
      var searchTerm = "Omsk Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Omsk Summer Time", () {
      var searchTerm = "Omsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Omsk Time", () {
      var searchTerm = "Omsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Oral Time", () {
      var searchTerm = "Oral Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Osteuropäische Sommerzeit", () {
      var searchTerm = "Osteuropäische Sommerzeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Osteuropäische Zeit", () {
      var searchTerm = "Osteuropäische Zeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pacific Daylight Saving Time", () {
      var searchTerm = "Pacific Daylight Saving Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pacific Daylight Time", () {
      var searchTerm = "Pacific Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pacific Standard Time", () {
      var searchTerm = "Pacific Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pacific Time", () {
      var searchTerm = "Pacific Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pakistan Standard Time", () {
      var searchTerm = "Pakistan Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pakistan Time", () {
      var searchTerm = "Pakistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Palau Time", () {
      var searchTerm = "Palau Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Papua New Guinea Time", () {
      var searchTerm = "Papua New Guinea Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Paraguay Summer Time", () {
      var searchTerm = "Paraguay Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Paraguay Time", () {
      var searchTerm = "Paraguay Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Peru Time", () {
      var searchTerm = "Peru Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Petropavlovsk-Kamchatski Time", () {
      var searchTerm = "Petropavlovsk-Kamchatski Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Philippine Standard Time", () {
      var searchTerm = "Philippine Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Philippine Time", () {
      var searchTerm = "Philippine Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Phoenix Island Time", () {
      var searchTerm = "Phoenix Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pierre & Miquelon Daylight Time", () {
      var searchTerm = "Pierre & Miquelon Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pierre & Miquelon Standard Time", () {
      var searchTerm = "Pierre & Miquelon Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pitcairn Standard Time", () {
      var searchTerm = "Pitcairn Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pohnpei Standard Time", () {
      var searchTerm = "Pohnpei Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pyongyang Standard Time", () {
      var searchTerm = "Pyongyang Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pyongyang Time", () {
      var searchTerm = "Pyongyang Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Qyzylorda Time", () {
      var searchTerm = "Qyzylorda Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Reunion Time", () {
      var searchTerm = "Reunion Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sakhalin Time", () {
      var searchTerm = "Sakhalin Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Samara Standard Time", () {
      var searchTerm = "Samara Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Samara Summer Time", () {
      var searchTerm = "Samara Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Samara Time", () {
      var searchTerm = "Samara Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Samoa Standard Time", () {
      var searchTerm = "Samoa Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Samoa Time", () {
      var searchTerm = "Samoa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Seychelles Time", () {
      var searchTerm = "Seychelles Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Singapore Standard Time", () {
      var searchTerm = "Singapore Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Singapore Time", () {
      var searchTerm = "Singapore Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Solomon Islands Time", () {
      var searchTerm = "Solomon Islands Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Solomon Island Time", () {
      var searchTerm = "Solomon Island Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("South African Standard Time", () {
      var searchTerm = "South African Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("South Africa Standard Time", () {
      var searchTerm = "South Africa Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("South Georgia Time", () {
      var searchTerm = "South Georgia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Srednekolymsk Time", () {
      var searchTerm = "Srednekolymsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Suriname Time", () {
      var searchTerm = "Suriname Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Syowa Time", () {
      var searchTerm = "Syowa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tahiti Time", () {
      var searchTerm = "Tahiti Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tajikistan Time", () {
      var searchTerm = "Tajikistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tokelau Time", () {
      var searchTerm = "Tokelau Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tonga Summer Time", () {
      var searchTerm = "Tonga Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tonga Time", () {
      var searchTerm = "Tonga Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Turkey Time", () {
      var searchTerm = "Turkey Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Turkmenistan Time", () {
      var searchTerm = "Turkmenistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tuvalu Time", () {
      var searchTerm = "Tuvalu Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ulaanbaatar Summer Time", () {
      var searchTerm = "Ulaanbaatar Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ulaanbaatar Time", () {
      var searchTerm = "Ulaanbaatar Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ulan Bator Summer Time", () {
      var searchTerm = "Ulan Bator Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ulan Bator Time", () {
      var searchTerm = "Ulan Bator Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Uruguay Summer Time", () {
      var searchTerm = "Uruguay Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Uruguay Time", () {
      var searchTerm = "Uruguay Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Uzbekistan Time", () {
      var searchTerm = "Uzbekistan Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vanuatu Time", () {
      var searchTerm = "Vanuatu Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Venezuelan Standard Time", () {
      var searchTerm = "Venezuelan Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vladivostok Summer Time", () {
      var searchTerm = "Vladivostok Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vladivostok Time", () {
      var searchTerm = "Vladivostok Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vostok Time", () {
      var searchTerm = "Vostok Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Wake Time", () {
      var searchTerm = "Wake Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Waktu Indonesia Barat", () {
      var searchTerm = "Waktu Indonesia Barat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Waktu Indonesia Tengah", () {
      var searchTerm = "Waktu Indonesia Tengah";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Waktu Indonesia Timur", () {
      var searchTerm = "Waktu Indonesia Timur";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Wallis and Futuna Time", () {
      var searchTerm = "Wallis and Futuna Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("West Africa Summer Time", () {
      var searchTerm = "West Africa Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("West Africa Time", () {
      var searchTerm = "West Africa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Argentine Summer Time", () {
      var searchTerm = "Western Argentine Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Australia Time", () {
      var searchTerm = "Western Australia Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Daylight Time", () {
      var searchTerm = "Western Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western European Daylight Time", () {
      var searchTerm = "Western European Daylight Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western European Summer Time", () {
      var searchTerm = "Western European Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western European Time", () {
      var searchTerm = "Western European Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Greenland Summer Time", () {
      var searchTerm = "Western Greenland Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Greenland Time", () {
      var searchTerm = "Western Greenland Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Indonesian Time", () {
      var searchTerm = "Western Indonesian Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Sahara Standard Time", () {
      var searchTerm = "Western Sahara Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Sahara Summer Time", () {
      var searchTerm = "Western Sahara Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Sahara Time", () {
      var searchTerm = "Western Sahara Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Standard Time", () {
      var searchTerm = "Western Standard Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Western Summer Time", () {
      var searchTerm = "Western Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Westeuropäische Sommerzeit", () {
      var searchTerm = "Westeuropäische Sommerzeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Westeuropäische Zeit", () {
      var searchTerm = "Westeuropäische Zeit";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("West Greenland Summer Time", () {
      var searchTerm = "West Greenland Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("West Samoa Time", () {
      var searchTerm = "West Samoa Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yakutsk Summer Time", () {
      var searchTerm = "Yakutsk Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yakutsk Time", () {
      var searchTerm = "Yakutsk Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yap Time", () {
      var searchTerm = "Yap Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yekaterinburg Summer Time", () {
      var searchTerm = "Yekaterinburg Summer Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yekaterinburg Time", () {
      var searchTerm = "Yekaterinburg Time";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });
  }, skip: skip);

  group('timezone search offsets', () {
    test('UTC+0', () {
      var searchTerm = 'UTC+0';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+1', () {
      var searchTerm = 'UTC+1';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-1', () {
      var searchTerm = 'UTC-1';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+10', () {
      var searchTerm = 'UTC+10';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-10', () {
      var searchTerm = 'UTC-10';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+10:30', () {
      var searchTerm = 'UTC+10:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+11', () {
      var searchTerm = 'UTC+11';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-11', () {
      var searchTerm = 'UTC-11';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+12', () {
      var searchTerm = 'UTC+12';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-12', () {
      var searchTerm = 'UTC-12';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+12:45', () {
      var searchTerm = 'UTC+12:45';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+13', () {
      var searchTerm = 'UTC+13';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+13:45', () {
      var searchTerm = 'UTC+13:45';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+14', () {
      var searchTerm = 'UTC+14';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+2', () {
      var searchTerm = 'UTC+2';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-2', () {
      var searchTerm = 'UTC-2';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-2:30', () {
      var searchTerm = 'UTC-2:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+3', () {
      var searchTerm = 'UTC+3';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-3', () {
      var searchTerm = 'UTC-3';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+3:30', () {
      var searchTerm = 'UTC+3:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-3:30', () {
      var searchTerm = 'UTC-3:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+4', () {
      var searchTerm = 'UTC+4';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-4', () {
      var searchTerm = 'UTC-4';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+4:30', () {
      var searchTerm = 'UTC+4:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+5', () {
      var searchTerm = 'UTC+5';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-5', () {
      var searchTerm = 'UTC-5';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+5:30', () {
      var searchTerm = 'UTC+5:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+5:45', () {
      var searchTerm = 'UTC+5:45';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+6', () {
      var searchTerm = 'UTC+6';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-6', () {
      var searchTerm = 'UTC-6';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+6:30', () {
      var searchTerm = 'UTC+6:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+7', () {
      var searchTerm = 'UTC+7';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-7', () {
      var searchTerm = 'UTC-7';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+8', () {
      var searchTerm = 'UTC+8';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-8', () {
      var searchTerm = 'UTC-8';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+8:30 unused', () {  // https://en.wikipedia.org/wiki/UTC%2B08:30
      var searchTerm = 'UTC+8:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, equals(0));  // no longer in use!
    });

    test('UTC+8:45 unofficial', () {  // https://en.wikipedia.org/wiki/UTC%2B08:45
      var searchTerm = 'UTC+8:45';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+9', () {
      var searchTerm = 'UTC+9';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-9', () {
      var searchTerm = 'UTC-9';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC+9:30', () {
      var searchTerm = 'UTC+9:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });

    test('UTC-9:30', () {
      var searchTerm = 'UTC-9:30';
      final loc = searchByOffset(searchTerm, tzDatabase);
      expect(loc.length, greaterThan(0));
    });
  }, skip: false);

  group('timezone search capitals and megacities', () {
    test("Abidjan", () {
      var searchTerm = "Abidjan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Abu Dhabi", () {
      var searchTerm = "Abu Dhabi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Abuja", () {
      var searchTerm = "Abuja";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Accra", () {
      var searchTerm = "Accra";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Adamstown", () {
      var searchTerm = "Adamstown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Addis Ababa", () {
      var searchTerm = "Addis Ababa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ahmedabad", () {
      var searchTerm = "Ahmedabad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Alexandria", () {
      var searchTerm = "Alexandria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Algiers", () {
      var searchTerm = "Algiers";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Alofi", () {
      var searchTerm = "Alofi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Amman", () {
      var searchTerm = "Amman";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Amsterdam", () {
      var searchTerm = "Amsterdam";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Andorra la Vella", () {
      var searchTerm = "Andorra la Vella";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Andorra La Vella", () {
      var searchTerm = "Andorra La Vella";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ankara", () {
      var searchTerm = "Ankara";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Antananarivo", () {
      var searchTerm = "Antananarivo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Apia", () {
      var searchTerm = "Apia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ashgabat", () {
      var searchTerm = "Ashgabat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Asmara", () {
      var searchTerm = "Asmara";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Astana", () {
      var searchTerm = "Astana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Asuncion", () {
      var searchTerm = "Asuncion";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Asunción", () {
      var searchTerm = "Asunción";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Athens", () {
      var searchTerm = "Athens";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Avarua", () {
      var searchTerm = "Avarua";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Baghdad", () {
      var searchTerm = "Baghdad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Baku", () {
      var searchTerm = "Baku";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bamako", () {
      var searchTerm = "Bamako";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bandar Seri Begawan", () {
      var searchTerm = "Bandar Seri Begawan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bangalore", () {
      var searchTerm = "Bangalore";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bangkok", () {
      var searchTerm = "Bangkok";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bangui", () {
      var searchTerm = "Bangui";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Banjul", () {
      var searchTerm = "Banjul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Basseterre", () {
      var searchTerm = "Basseterre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Basse-Terre", () {
      var searchTerm = "Basse-Terre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Beijing", () {
      var searchTerm = "Beijing";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Beirut", () {
      var searchTerm = "Beirut";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Belgrade", () {
      var searchTerm = "Belgrade";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Belmopan", () {
      var searchTerm = "Belmopan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Berlin", () {
      var searchTerm = "Berlin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bern", () {
      var searchTerm = "Bern";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bijie", () {
      var searchTerm = "Bijie";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bishkek", () {
      var searchTerm = "Bishkek";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bissau", () {
      var searchTerm = "Bissau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bogota", () {
      var searchTerm = "Bogota";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brades", () {
      var searchTerm = "Brades";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brasilia", () {
      var searchTerm = "Brasilia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bratislava", () {
      var searchTerm = "Bratislava";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brazzaville", () {
      var searchTerm = "Brazzaville";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bridgetown", () {
      var searchTerm = "Bridgetown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Brussels", () {
      var searchTerm = "Brussels";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Bucharest", () {
      var searchTerm = "Bucharest";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Budapest", () {
      var searchTerm = "Budapest";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Buenos Aires", () {
      var searchTerm = "Buenos Aires";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cairo", () {
      var searchTerm = "Cairo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Canberra", () {
      var searchTerm = "Canberra";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Caracas", () {
      var searchTerm = "Caracas";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Castries", () {
      var searchTerm = "Castries";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cayenne", () {
      var searchTerm = "Cayenne";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Changchun", () {
      var searchTerm = "Changchun";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Changde", () {
      var searchTerm = "Changde";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Changsha", () {
      var searchTerm = "Changsha";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Changzhou", () {
      var searchTerm = "Changzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Charlotte Amalie", () {
      var searchTerm = "Charlotte Amalie";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chengchow", () {
      var searchTerm = "Chengchow";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chengdu", () {
      var searchTerm = "Chengdu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chennai", () {
      var searchTerm = "Chennai";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chisinau", () {
      var searchTerm = "Chisinau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Chongqing", () {
      var searchTerm = "Chongqing";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ciudad de la Paz", () {
      var searchTerm = "Ciudad de la Paz";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Cockburn Town", () {
      var searchTerm = "Cockburn Town";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Colombo", () {
      var searchTerm = "Colombo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Conakry", () {
      var searchTerm = "Conakry";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Concelho de Macau", () {
      var searchTerm = "Concelho de Macau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Copenhagen", () {
      var searchTerm = "Copenhagen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dakar", () {
      var searchTerm = "Dakar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dalian", () {
      var searchTerm = "Dalian";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Damascus", () {
      var searchTerm = "Damascus";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dar es Salaam", () {
      var searchTerm = "Dar es Salaam";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Delhi", () {
      var searchTerm = "Delhi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dhaka", () {
      var searchTerm = "Dhaka";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dili", () {
      var searchTerm = "Dili";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Djibouti City", () {
      var searchTerm = "Djibouti City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dodoma", () {
      var searchTerm = "Dodoma";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Doha", () {
      var searchTerm = "Doha";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dongguan", () {
      var searchTerm = "Dongguan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Douglas", () {
      var searchTerm = "Douglas";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dublin", () {
      var searchTerm = "Dublin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Dushanbe", () {
      var searchTerm = "Dushanbe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("El Aaiún", () {
      var searchTerm = "El Aaiún";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Flying Fish Cove", () {
      var searchTerm = "Flying Fish Cove";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Fort-de-France", () {
      var searchTerm = "Fort-de-France";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Foshan", () {
      var searchTerm = "Foshan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Freetown", () {
      var searchTerm = "Freetown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Funafuti", () {
      var searchTerm = "Funafuti";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Fuzhou", () {
      var searchTerm = "Fuzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gaborone", () {
      var searchTerm = "Gaborone";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Georgetown", () {
      var searchTerm = "Georgetown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("George Town", () {
      var searchTerm = "George Town";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gibraltar", () {
      var searchTerm = "Gibraltar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gitega", () {
      var searchTerm = "Gitega";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guangzhou", () {
      var searchTerm = "Guangzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guatemala City", () {
      var searchTerm = "Guatemala City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Guiyang", () {
      var searchTerm = "Guiyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Gustavia", () {
      var searchTerm = "Gustavia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hagåtña", () {
      var searchTerm = "Hagåtña";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hamilton", () {
      var searchTerm = "Hamilton";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hangzhou", () {
      var searchTerm = "Hangzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hanoi", () {
      var searchTerm = "Hanoi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Harare", () {
      var searchTerm = "Harare";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Harbin", () {
      var searchTerm = "Harbin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Havana", () {
      var searchTerm = "Havana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hefei", () {
      var searchTerm = "Hefei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Helsinki", () {
      var searchTerm = "Helsinki";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Heze", () {
      var searchTerm = "Heze";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ho Chi Minh City", () {
      var searchTerm = "Ho Chi Minh City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hong Kong", () {
      var searchTerm = "Hong Kong";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Honiara", () {
      var searchTerm = "Honiara";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Hyderabad", () {
      var searchTerm = "Hyderabad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Islamabad", () {
      var searchTerm = "Islamabad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Istanbul", () {
      var searchTerm = "Istanbul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jakarta", () {
      var searchTerm = "Jakarta";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jamestown", () {
      var searchTerm = "Jamestown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jerusalem", () {
      var searchTerm = "Jerusalem";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jieyang", () {
      var searchTerm = "Jieyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Jinan", () {
      var searchTerm = "Jinan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Juba", () {
      var searchTerm = "Juba";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kabul", () {
      var searchTerm = "Kabul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kampala", () {
      var searchTerm = "Kampala";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Karachi", () {
      var searchTerm = "Karachi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kathmandu", () {
      var searchTerm = "Kathmandu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Khartoum", () {
      var searchTerm = "Khartoum";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kigali", () {
      var searchTerm = "Kigali";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("King Edward Point", () {
      var searchTerm = "King Edward Point";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kingston", () {
      var searchTerm = "Kingston";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kingstown", () {
      var searchTerm = "Kingstown";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kinshasa", () {
      var searchTerm = "Kinshasa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kolkata", () {
      var searchTerm = "Kolkata";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kuala Lumpur", () {
      var searchTerm = "Kuala Lumpur";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kunming", () {
      var searchTerm = "Kunming";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kuwait City", () {
      var searchTerm = "Kuwait City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Kyiv", () {
      var searchTerm = "Kyiv";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lagos", () {
      var searchTerm = "Lagos";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lahore", () {
      var searchTerm = "Lahore";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Libreville", () {
      var searchTerm = "Libreville";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lilongwe", () {
      var searchTerm = "Lilongwe";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lima", () {
      var searchTerm = "Lima";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Linyi", () {
      var searchTerm = "Linyi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lisbon", () {
      var searchTerm = "Lisbon";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ljubljana", () {
      var searchTerm = "Ljubljana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lomé", () {
      var searchTerm = "Lomé";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("London", () {
      var searchTerm = "London";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Longyearbyen", () {
      var searchTerm = "Longyearbyen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Luanda", () {
      var searchTerm = "Luanda";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Luoyang", () {
      var searchTerm = "Luoyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Lusaka", () {
      var searchTerm = "Lusaka";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Luxembourg", () {
      var searchTerm = "Luxembourg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Madrid", () {
      var searchTerm = "Madrid";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Majuro", () {
      var searchTerm = "Majuro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Malabo", () {
      var searchTerm = "Malabo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Male", () {
      var searchTerm = "Male";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Malé", () {
      var searchTerm = "Malé";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mamoudzou", () {
      var searchTerm = "Mamoudzou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Managua", () {
      var searchTerm = "Managua";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Manama", () {
      var searchTerm = "Manama";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Manila", () {
      var searchTerm = "Manila";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Maputo", () {
      var searchTerm = "Maputo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mariehamn", () {
      var searchTerm = "Mariehamn";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Marigot", () {
      var searchTerm = "Marigot";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Maseru", () {
      var searchTerm = "Maseru";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mata-Utu", () {
      var searchTerm = "Mata-Utu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mbabane", () {
      var searchTerm = "Mbabane";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Megacity", () {
      var searchTerm = "Megacity";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mexico City", () {
      var searchTerm = "Mexico City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Minsk", () {
      var searchTerm = "Minsk";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mogadishu", () {
      var searchTerm = "Mogadishu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Monaco", () {
      var searchTerm = "Monaco";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Monrovia", () {
      var searchTerm = "Monrovia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Montevideo", () {
      var searchTerm = "Montevideo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Moroni", () {
      var searchTerm = "Moroni";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Moscow", () {
      var searchTerm = "Moscow";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Mumbai", () {
      var searchTerm = "Mumbai";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Muscat", () {
      var searchTerm = "Muscat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nairobi", () {
      var searchTerm = "Nairobi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nampula", () {
      var searchTerm = "Nampula";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nanchang", () {
      var searchTerm = "Nanchang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nanking", () {
      var searchTerm = "Nanking";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nanning", () {
      var searchTerm = "Nanning";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nassau", () {
      var searchTerm = "Nassau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Naypyidaw", () {
      var searchTerm = "Naypyidaw";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nay Pyi Taw", () {
      var searchTerm = "Nay Pyi Taw";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("N'Djamena", () {
      var searchTerm = "N'Djamena";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("New Delhi", () {
      var searchTerm = "New Delhi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("New York City", () {
      var searchTerm = "New York City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Niamey", () {
      var searchTerm = "Niamey";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nicosia", () {
      var searchTerm = "Nicosia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nouakchott", () {
      var searchTerm = "Nouakchott";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nouméa", () {
      var searchTerm = "Nouméa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nuku'alofa", () {
      var searchTerm = "Nuku'alofa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Nuuk", () {
      var searchTerm = "Nuuk";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Oranjestad", () {
      var searchTerm = "Oranjestad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Oslo", () {
      var searchTerm = "Oslo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ottawa", () {
      var searchTerm = "Ottawa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ouagadougou", () {
      var searchTerm = "Ouagadougou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pago Pago", () {
      var searchTerm = "Pago Pago";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Panama City", () {
      var searchTerm = "Panama City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Papeete", () {
      var searchTerm = "Papeete";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Paramaribo", () {
      var searchTerm = "Paramaribo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Paris", () {
      var searchTerm = "Paris";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Philipsburg", () {
      var searchTerm = "Philipsburg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Phnom Penh", () {
      var searchTerm = "Phnom Penh";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Podgorica", () {
      var searchTerm = "Podgorica";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Port-au-Prince", () {
      var searchTerm = "Port-au-Prince";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Port Louis", () {
      var searchTerm = "Port Louis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Port Moresby", () {
      var searchTerm = "Port Moresby";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Port of Spain", () {
      var searchTerm = "Port of Spain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Port-of-Spain", () {
      var searchTerm = "Port-of-Spain";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Porto Novo", () {
      var searchTerm = "Porto Novo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Porto-Novo", () {
      var searchTerm = "Porto-Novo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Port Vila", () {
      var searchTerm = "Port Vila";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Port-Vila", () {
      var searchTerm = "Port-Vila";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Prague", () {
      var searchTerm = "Prague";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Praia", () {
      var searchTerm = "Praia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pretoria", () {
      var searchTerm = "Pretoria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pristina", () {
      var searchTerm = "Pristina";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Pyongyang", () {
      var searchTerm = "Pyongyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Qingdao", () {
      var searchTerm = "Qingdao";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Quito", () {
      var searchTerm = "Quito";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Rabat", () {
      var searchTerm = "Rabat";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ramallah", () {
      var searchTerm = "Ramallah";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Reykjavik", () {
      var searchTerm = "Reykjavik";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Reykjavík", () {
      var searchTerm = "Reykjavík";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Riga", () {
      var searchTerm = "Riga";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Rio de Janeiro", () {
      var searchTerm = "Rio de Janeiro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Riyadh", () {
      var searchTerm = "Riyadh";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Road Town", () {
      var searchTerm = "Road Town";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Rome", () {
      var searchTerm = "Rome";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Roseau", () {
      var searchTerm = "Roseau";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint-Denis", () {
      var searchTerm = "Saint-Denis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint George's", () {
      var searchTerm = "Saint George's";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Helier", () {
      var searchTerm = "Saint Helier";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint John's", () {
      var searchTerm = "Saint John's";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Peter Port", () {
      var searchTerm = "Saint Peter Port";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint Petersburg", () {
      var searchTerm = "Saint Petersburg";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saint-Pierre", () {
      var searchTerm = "Saint-Pierre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Saipan", () {
      var searchTerm = "Saipan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sana", () {
      var searchTerm = "Sana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sanaa", () {
      var searchTerm = "Sanaa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("San Jose", () {
      var searchTerm = "San Jose";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("San José", () {
      var searchTerm = "San José";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("San Juan", () {
      var searchTerm = "San Juan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("San Marino", () {
      var searchTerm = "San Marino";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("San Salvador", () {
      var searchTerm = "San Salvador";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Santiago", () {
      var searchTerm = "Santiago";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Santo Domingo", () {
      var searchTerm = "Santo Domingo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("São Paulo", () {
      var searchTerm = "São Paulo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("São Tomé", () {
      var searchTerm = "São Tomé";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sarajevo", () {
      var searchTerm = "Sarajevo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Seoul", () {
      var searchTerm = "Seoul";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Shanghai", () {
      var searchTerm = "Shanghai";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Shangqiu", () {
      var searchTerm = "Shangqiu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Shantou", () {
      var searchTerm = "Shantou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Shenyang", () {
      var searchTerm = "Shenyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Shenzhen", () {
      var searchTerm = "Shenzhen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Shijiazhuang", () {
      var searchTerm = "Shijiazhuang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Singapore", () {
      var searchTerm = "Singapore";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Skopje", () {
      var searchTerm = "Skopje";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sofia", () {
      var searchTerm = "Sofia";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Stanley", () {
      var searchTerm = "Stanley";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Stockholm", () {
      var searchTerm = "Stockholm";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Sucre", () {
      var searchTerm = "Sucre";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Suva", () {
      var searchTerm = "Suva";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Suzhou", () {
      var searchTerm = "Suzhou";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tai'an", () {
      var searchTerm = "Tai'an";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Taipei", () {
      var searchTerm = "Taipei";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Taiyuan", () {
      var searchTerm = "Taiyuan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tallinn", () {
      var searchTerm = "Tallinn";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tangshan", () {
      var searchTerm = "Tangshan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tarawa", () {
      var searchTerm = "Tarawa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tashkent", () {
      var searchTerm = "Tashkent";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tbilisi", () {
      var searchTerm = "Tbilisi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tegucigalpa", () {
      var searchTerm = "Tegucigalpa";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tehran", () {
      var searchTerm = "Tehran";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tel Aviv", () {
      var searchTerm = "Tel Aviv";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("The Valley", () {
      var searchTerm = "The Valley";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Thimphu", () {
      var searchTerm = "Thimphu";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tianjin", () {
      var searchTerm = "Tianjin";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tirana", () {
      var searchTerm = "Tirana";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tokyo", () {
      var searchTerm = "Tokyo";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tórshavn", () {
      var searchTerm = "Tórshavn";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tripoli", () {
      var searchTerm = "Tripoli";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Tunis", () {
      var searchTerm = "Tunis";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Ulaanbaatar", () {
      var searchTerm = "Ulaanbaatar";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vaduz", () {
      var searchTerm = "Vaduz";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Valletta", () {
      var searchTerm = "Valletta";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vatican City", () {
      var searchTerm = "Vatican City";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Victoria", () {
      var searchTerm = "Victoria";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vienna", () {
      var searchTerm = "Vienna";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vientiane", () {
      var searchTerm = "Vientiane";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Vilnius", () {
      var searchTerm = "Vilnius";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Warsaw", () {
      var searchTerm = "Warsaw";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Washington, D.C.", () {
      var searchTerm = "Washington, D.C.";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Washington, DC", () {
      var searchTerm = "Washington, DC";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Weifang", () {
      var searchTerm = "Weifang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Wellington", () {
      var searchTerm = "Wellington";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("West Island", () {
      var searchTerm = "West Island";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Willemstad", () {
      var searchTerm = "Willemstad";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Windhoek", () {
      var searchTerm = "Windhoek";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Wuhan", () {
      var searchTerm = "Wuhan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Wuxi", () {
      var searchTerm = "Wuxi";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Xiamen", () {
      var searchTerm = "Xiamen";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Xi'an", () {
      var searchTerm = "Xi'an";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Xinyang", () {
      var searchTerm = "Xinyang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yamoussoukro", () {
      var searchTerm = "Yamoussoukro";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yantai", () {
      var searchTerm = "Yantai";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yaounde", () {
      var searchTerm = "Yaounde";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yaoundé", () {
      var searchTerm = "Yaoundé";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yaren", () {
      var searchTerm = "Yaren";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Yerevan", () {
      var searchTerm = "Yerevan";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Zagreb", () {
      var searchTerm = "Zagreb";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });

    test("Zhanjiang", () {
      var searchTerm = "Zhanjiang";
      var loc = tzDatabase.where( (e) => e.matches(searchTerm) ).toList();
      expect(loc.length, greaterThan(0));
    });
  }, skip: skip);
}