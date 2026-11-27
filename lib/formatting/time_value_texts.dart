import '../l10n/app_localizations.dart';
import '../models/time_value.dart';
import 'fuzzy_time_words.dart';

String localizedValueTypeLabel(ValueType type, AppLocalizations l10n) =>
    switch (type) {
      ValueType.date => l10n.valueTypeDate,
      ValueType.time => l10n.valueTypeTime,
      ValueType.dateTime => l10n.valueTypeDateTime,
      ValueType.daySecond => l10n.valueTypeDaySecond,
      ValueType.dayMinute => l10n.valueTypeDayMinute,
      ValueType.dayPercent => l10n.valueTypeDayPercent,
      ValueType.sevenSegmentClock => l10n.valueTypeSevenSegmentClock,
      ValueType.analogClock12h => l10n.valueTypeAnalogClock12h,
      ValueType.analogClock24h => l10n.valueTypeAnalogClock24h,
      ValueType.fuzzyTime => l10n.valueTypeFuzzyTime,
      ValueType.unixSeconds => l10n.valueTypeUnixSeconds,
      ValueType.tai => l10n.valueTypeTai,
      ValueType.gps => l10n.valueTypeGps,
      ValueType.gmst => l10n.valueTypeGmst,
      ValueType.lmst => l10n.valueTypeLmst,
      ValueType.julianDate => l10n.valueTypeJulianDate,
      ValueType.reducedJulianDate => l10n.valueTypeReducedJulianDate,
      ValueType.modifiedJulianDate => l10n.valueTypeModifiedJulianDate,
      ValueType.dublinJulianDate => l10n.valueTypeDublinJulianDate,
      ValueType.cnesJulianDate => l10n.valueTypeCnesJulianDate,
      ValueType.ccsdsJulianDate => l10n.valueTypeCcsdsJulianDate,
      ValueType.modifiedJulianDate2000 => l10n.valueTypeModifiedJulianDate2000,
      ValueType.decimalTime => l10n.valueTypeDecimalTime,
      ValueType.swatchBeats => l10n.valueTypeSwatchBeats,
      ValueType.newEarthTime => l10n.valueTypeNewEarthTime,
      ValueType.binaryClockBcd => l10n.valueTypeBinaryClockBcd,
      ValueType.binaryClockColumns => l10n.valueTypeBinaryClockColumns,
      ValueType.binaryClockString => l10n.valueTypeBinaryClockString,
      ValueType.octalTime => l10n.valueTypeOctalTime,
      ValueType.hexadecimalTime => l10n.valueTypeHexadecimalTime,
      ValueType.romanNumeralsTime => l10n.valueTypeRomanNumeralsTime,
      ValueType.doomsdayClock => l10n.valueTypeDoomsdayClock,
    };

extension TimeValueTexts on TimeValue {
  // Localized display label shown in the UI.
  String localizedDisplayLabel(AppLocalizations l10n) {
    if (customLabel != null) return customLabel!;
    final remainingSuffix = options.remaining
        ? ' – ${l10n.labelRemaining}'
        : '';
    final levelSuffix = valueType == ValueType.fuzzyTime
        ? ' – ${fuzzyLevelName(options.effectiveFuzzyLevel, l10n)}'
        : '';
    final _localizedTypeLabel = localizedValueTypeLabel(valueType, l10n);
    if (isZoneIndependent) return '$_localizedTypeLabel$remainingSuffix';
    final zoneLabel = switch (zone) {
      ZoneLocal() => l10n.labelLocal.toLowerCase(),
      ZoneUtc() => l10n.actionZoneUtc,
      ZoneNamed(ianaZone: final z) => z.split('/').last.replaceAll('_', ' '),
    };
    return '$_localizedTypeLabel ($zoneLabel)$remainingSuffix$levelSuffix';
  }

  // Localized info text.
  String localizedInfoText(AppLocalizations l10n) => switch (valueType) {
    ValueType.date => l10n.infoTextDate,
    ValueType.time => l10n.infoTextTime,
    ValueType.dateTime => l10n.infoTextDateTime,
    ValueType.daySecond => l10n.infoTextDaySecond,
    ValueType.dayMinute => l10n.infoTextDayMinute,
    ValueType.dayPercent => l10n.infoTextDayPercent,
    ValueType.sevenSegmentClock => l10n.infoTextSevenSegmentClock,
    ValueType.analogClock12h => l10n.infoTextAnalogClock12h,
    ValueType.analogClock24h => l10n.infoTextAnalogClock24h,
    ValueType.fuzzyTime => l10n.infoTextFuzzyTime,
    ValueType.unixSeconds => l10n.infoTextUnixSeconds,
    ValueType.tai => l10n.infoTextTai,
    ValueType.gps => l10n.infoTextGps,
    ValueType.gmst => l10n.infoTextGmst,
    ValueType.lmst => l10n.infoTextLmst,
    ValueType.julianDate => l10n.infoTextJulianDate,
    ValueType.reducedJulianDate => l10n.infoTextReducedJulianDate,
    ValueType.modifiedJulianDate => l10n.infoTextModifiedJulianDate,
    ValueType.dublinJulianDate => l10n.infoTextDublinJulianDate,
    ValueType.cnesJulianDate => l10n.infoTextCnesJulianDate,
    ValueType.ccsdsJulianDate => l10n.infoTextCcsdsJulianDate,
    ValueType.modifiedJulianDate2000 => l10n.infoTextModifiedJulianDate2000,
    ValueType.decimalTime => l10n.infoTextDecimalTime,
    ValueType.swatchBeats => l10n.infoTextSwatchBeats,
    ValueType.newEarthTime => l10n.infoTextNewEarthTime,
    ValueType.binaryClockBcd => l10n.infoTextBinaryClockBcd,
    ValueType.binaryClockColumns => l10n.infoTextBinaryClockColumns,
    ValueType.binaryClockString => l10n.infoTextBinaryClockString,
    ValueType.octalTime => l10n.infoTextOctalTime,
    ValueType.hexadecimalTime => l10n.infoTextHexadecimalTime,
    ValueType.romanNumeralsTime => l10n.infoTextRomanNumeralsTime,
    ValueType.doomsdayClock => l10n.infoTextDoomsdayClock,
  };

  // Returns a URL for further reading, or null if none defined.
  String? localizedInfoLink(AppLocalizations l10n) => switch (valueType) {
    ValueType.unixSeconds => l10n.infoLinkUnixSeconds,
    ValueType.tai => l10n.infoLinkTai,
    ValueType.gps => l10n.infoLinkGps,
    ValueType.gmst => l10n.infoLinkGmst,
    ValueType.lmst => l10n.infoLinkLmst,
    ValueType.julianDate => l10n.infoLinkJulianDate,
    ValueType.reducedJulianDate => l10n.infoLinkReducedJulianDate,
    ValueType.modifiedJulianDate => l10n.infoLinkModifiedJulianDate,
    ValueType.dublinJulianDate => l10n.infoLinkDublinJulianDate,
    ValueType.cnesJulianDate => l10n.infoLinkCnesJulianDate,
    ValueType.ccsdsJulianDate => l10n.infoLinkCcsdsJulianDate,
    ValueType.modifiedJulianDate2000 => l10n.infoLinkModifiedJulianDate2000,
    ValueType.decimalTime => l10n.infoLinkDecimalTime,
    ValueType.swatchBeats => l10n.infoLinkSwatchBeats,
    ValueType.newEarthTime => l10n.infoLinkNewEarthTime,
    ValueType.binaryClockBcd => l10n.infoLinkBinaryClockBcd,
    ValueType.binaryClockColumns => l10n.infoLinkBinaryClockColumns,
    ValueType.binaryClockString => l10n.infoLinkBinaryClockString,
    ValueType.romanNumeralsTime => l10n.infoLinkRomanNumeralsTime,
    ValueType.doomsdayClock => l10n.infoLinkDoomsdayClock,
    _ => null,
  };
}
