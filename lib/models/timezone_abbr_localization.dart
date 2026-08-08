/// Maps English timezone abbreviations to German equivalents.
/// Only abbreviations that have established German names are included.
const _deAbbreviations = <String, String>{
  'CET'  : 'MEZ',
  'CEST' : 'MESZ',
  'EET'  : 'OEZ',
  'EEST' : 'OESZ',
  'WET'  : 'WEZ',
  'WEST' : 'WESZ',
};

/// Returns the localized timezone abbreviation for the given locale.
/// Falls back to the original abbreviation if no localization exists.
String localizeTimezoneAbbr(String abbr, String locale) {
  if (locale.startsWith('de')) {
    return _deAbbreviations[abbr] ?? abbr;
  }
  return abbr;
}