import '../l10n/app_localizations.dart';
import '../models/time_value.dart';
import 'info_markup.dart';
import 'time_value_texts.dart';

sealed class InfoBlock {
  const InfoBlock();
}

class InfoParagraph extends InfoBlock {
  final String markup;
  const InfoParagraph(this.markup);
}

class InfoHeading extends InfoBlock {
  final String text;
  const InfoHeading(this.text);
}

class InfoLinkBlock extends InfoBlock {
  final String url;
  const InfoLinkBlock(this.url);
}

/// Types whose scale is affected by leap seconds.
const _leapSecondTypes = {ValueType.unixSeconds, ValueType.tai, ValueType.gps};

/// The content of the info dialog of a value (without the clock changes).
List<InfoBlock> buildInfoBlocks(TimeValue timeValue, AppLocalizations l10n) {
  final type = timeValue.valueType;
  final optionTexts = [
    ?_optionalPartText(type, l10n),
    ?_detailsText(type, l10n),
    if (type.supportsRemaining) l10n.infoOptionRemaining,
    ?_remainingRangeText(type, l10n),
  ];
  final links = [
    ?timeValue.localizedInfoLink(l10n),
    if (_leapSecondTypes.contains(type)) l10n.infoLinkLeapSeconds,
  ];
  return [
    for (final paragraph in splitParagraphs(timeValue.localizedInfoText(l10n)))
      InfoParagraph(paragraph),
    if (_leapSecondTypes.contains(type)) InfoParagraph(l10n.infoLeapSeconds),
    if (optionTexts.isNotEmpty) InfoHeading(l10n.labelInfoDisplayOptions),
    for (final text in optionTexts) InfoParagraph(text),
    for (final url in links) InfoLinkBlock(url),
  ];
}

String? _optionalPartText(ValueType type, AppLocalizations l10n) =>
    switch (type.optionalPart) {
      OptionalPart.seconds => l10n.infoOptionSeconds,
      OptionalPart.decimals => l10n.infoOptionDecimals,
      OptionalPart.none => null,
    };

String? _detailsText(ValueType type, AppLocalizations l10n) {
  if (!type.hasDetailsLine) return null;
  return switch (type) {
    ValueType.date => l10n.infoOptionDetailsDate,
    ValueType.gmst || ValueType.lmst => l10n.infoOptionDetailsAngle,
    _ => l10n.infoOptionDetailsZone,
  };
}

/// What the remaining time looks like, where it differs from the usual range.
String? _remainingRangeText(ValueType type, AppLocalizations l10n) =>
    switch (type) {
      ValueType.time => l10n.infoRemainingTime,
      ValueType.daySecond => l10n.infoRemainingDaySecond,
      ValueType.dayMinute => l10n.infoRemainingDayMinute,
      ValueType.dayPercent => l10n.infoRemainingDayPercent,
      ValueType.decimalTime => l10n.infoRemainingDecimalTime,
      ValueType.swatchBeats => l10n.infoRemainingSwatchBeats,
      ValueType.newEarthTime => l10n.infoRemainingNewEarthTime,
      ValueType.doomsdayClock => l10n.infoRemainingDoomsdayClock,
      _ => null,
    };
