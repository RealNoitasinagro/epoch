import 'dart:ui';

import 'package:epoch/formatting/time_value_texts.dart';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/models/time_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final english = lookupAppLocalizations(const Locale('en'));
  final german = lookupAppLocalizations(const Locale('de'));
  const remaining = ValueOptions(remaining: true);

  test('the remaining time is marked in the label', () {
    const daySecond = TimeValue(
      valueType: ValueType.daySecond,
      zone: ZoneLocal(),
      options: remaining,
    );
    expect(
      daySecond.localizedDisplayLabel(english),
      'Day second (local) – remaining',
    );
    expect(
      daySecond.localizedDisplayLabel(german),
      'Tagessekunde (lokal) – Rest',
    );
  });

  test('zone-independent values get the mark without a zone', () {
    const swatchBeats = TimeValue(
      valueType: ValueType.swatchBeats,
      zone: ZoneUtc(),
      options: remaining,
    );
    expect(
      swatchBeats.localizedDisplayLabel(english),
      'Swatch Internet Time – remaining',
    );
  });

  test('a custom label is shown as it is', () {
    const custom = TimeValue(
      valueType: ValueType.daySecond,
      zone: ZoneUtc(),
      options: ValueOptions(customLabel: 'Left today', remaining: true),
    );
    expect(custom.localizedDisplayLabel(english), 'Left today');
  });
}
