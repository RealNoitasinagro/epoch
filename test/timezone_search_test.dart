import 'package:epoch/models/timezone_search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const skip = true;

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

    test('BST', () {
      var searchTerm = 'BST';
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

    test('CST', () {
      var searchTerm = 'CST';
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

    test('HST', () {
      var searchTerm = 'HST';
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

    test('IST', () {
      var searchTerm = 'IST';
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
}