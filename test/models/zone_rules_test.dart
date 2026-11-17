import 'package:epoch/models/zone_rules.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_all.dart' as tzd;

void main() {
  setUpAll(tzd.initializeTimeZones);
  final reference = DateTime.utc(2026, 10, 14);

  test('Berlin: CET/CEST', () {
    final r = zoneRulesAt('Europe/Berlin', reference)!;
    expect([r.hasDst, r.standardAbbr, r.dstAbbr], [true, 'CET', 'CEST']);
    expect(r.standardOffset, const Duration(hours: 1));
    expect(r.dstOffset, const Duration(hours: 2));
  });

  test('Tokyo and Algiers: no DST (Algiers had it historically)', () {
    expect(zoneRulesAt('Asia/Tokyo', reference)!.hasDst, isFalse);
    expect(zoneRulesAt('Africa/Algiers', reference)!.hasDst, isFalse);
  });

  // Needs the 2026e data (timezone 0.11.2): from 2026-11-01 Vancouver stays on MST.
  test('Vancouver: PDT -> MST keeps -07:00 but is still a clock change', () {
    final r = zoneRulesAt('America/Vancouver', reference)!;
    expect([r.hasDst, r.standardAbbr, r.dstAbbr], [true, 'MST', 'PDT']);
    expect(r.standardOffset, r.dstOffset);
  });

  test('unknown zone yields null', () {
    expect(zoneRulesAt('Nowhere/Land', reference), isNull);
  });

  test('Vancouver after 2026-11-01: no more clock changes', () {
    final r = zoneRulesAt('America/Vancouver', DateTime.utc(2026, 11, 15))!;
    expect(r.hasDst, isFalse);
    expect([r.standardAbbr, r.dstAbbr], ['MST', 'MST']);
  });

  test('Berlin in November: spring change still ahead', () {
    expect(zoneRulesAt('Europe/Berlin', DateTime.utc(2026, 11, 15))!.hasDst, isTrue);
  });
}
