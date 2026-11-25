import 'dart:ui';

import 'package:epoch/formatting/value_info.dart';
import 'package:epoch/l10n/app_localizations.dart';
import 'package:epoch/models/time_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  List<InfoBlock> blocksOf(ValueType type) => buildInfoBlocks(
      TimeValue(valueType: type, zone: const ZoneUtc()), l10n, null);

  List<String> paragraphsOf(ValueType type) => [
    for (final block in blocksOf(type))
      if (block is InfoParagraph) block.markup,
  ];

  List<String> linksOf(ValueType type) => [
    for (final block in blocksOf(type))
      if (block is InfoLinkBlock) block.url,
  ];

  test('every value type has an info text', () {
    for (final type in ValueType.values) {
      expect(paragraphsOf(type), isNotEmpty, reason: type.name);
    }
  });

  test('display options only where the type has them', () {
    expect(blocksOf(ValueType.unixSeconds).whereType<InfoHeading>(), isEmpty);
    expect(paragraphsOf(ValueType.time), contains(l10n.infoOptionSeconds));
    expect(paragraphsOf(ValueType.swatchBeats), contains(l10n.infoOptionDecimals));
    expect(paragraphsOf(ValueType.date), contains(l10n.infoOptionDetailsDate));
    expect(paragraphsOf(ValueType.gmst), contains(l10n.infoOptionDetailsAngle));
  });

  test('remaining time: general text for all, range text for the type', () {
    for (final type in ValueType.values.where((t) => t.supportsRemaining)) {
      expect(paragraphsOf(type), contains(l10n.infoOptionRemaining), reason: type.name);
    }
    expect(paragraphsOf(ValueType.decimalTime), contains(l10n.infoRemainingDecimalTime));
    expect(paragraphsOf(ValueType.dateTime), isNot(contains(l10n.infoOptionRemaining)));
  });

  test('every remaining-capable type has a range text', () {
    for (final type in ValueType.values.where((t) => t.supportsRemaining)) {
      final rangeTexts = paragraphsOf(type).where((p) => p.startsWith('Remaining:'));
      expect(rangeTexts, hasLength(1), reason: type.name);
    }
  });

  test('leap seconds: text and a second link for the three scales', () {
    for (final type in [ValueType.unixSeconds, ValueType.tai, ValueType.gps]) {
      expect(paragraphsOf(type), contains(l10n.infoLeapSeconds), reason: type.name);
      expect(linksOf(type), contains(l10n.infoLinkLeapSeconds), reason: type.name);
    }
    expect(paragraphsOf(ValueType.julianDate), isNot(contains(l10n.infoLeapSeconds)));
  });
}
