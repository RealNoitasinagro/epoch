import 'package:epoch/time/zone_abbreviations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('German names for the European standard and summer times', () {
    for (final (english, german) in [
      ('CET', 'MEZ'),
      ('CEST', 'MESZ'),
      ('EET', 'OEZ'),
      ('EEST', 'OESZ'),
      ('WET', 'WEZ'),
      ('WEST', 'WESZ'),
    ]) {
      expect(localizeTimezoneAbbr(english, 'de'), german);
    }
  });

  test('other abbreviations and other languages stay as they are', () {
    expect(localizeTimezoneAbbr('EST', 'de'), 'EST');
    expect(localizeTimezoneAbbr('CEST', 'en'), 'CEST');
    expect(localizeTimezoneAbbr('CEST', 'de_AT'), 'MESZ');
  });
}
