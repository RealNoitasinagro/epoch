/// Rule names of a TzMatch. Plain Dart (no imports): shared with tools/.
abstract final class TzRule {
  static const empty = 'empty';
  static const offset = 'offset';
  static const abbr = 'abbr';
  static const abbrAlias = 'abbrAlias';
  static const zoneId = 'zoneId';
  static const exact = 'exact';
  static const prefix = 'prefix';
}

/// Source labels of search candidates.
abstract final class TzSource {
  static const none = '-';
  static const rulePrefix = 'rule:';
  static const variantSuffix = '~'; // marks terms produced by name-variant expansion
  static const ianaLinks = 'iana_links';
  static const iso3166NamesEn = 'iso3166_names_EN';
  static const cldrCountryNamesEn = 'cldr_country_names_EN';
  static const cldrCountryNamesDe = 'cldr_country_names_DE';
  static const countryAliasesEn = 'country_aliases_EN';
  static const countryAliasesDe = 'country_aliases_DE';
  static const timeSuffixRule = '${rulePrefix}timeSuffix';
  static const cldrWindowsZoneNames = 'cldr_windows_zone_names';
  static const cldrZoneLongNames = 'cldr_zone_long_names';
  static const cldrExemplarCities = 'cldr_exemplar_cities';
  static const wikidataCapitals = 'wikidata_capitals';
  static const majorCities = 'major_cities';
  static const cldrMetazoneNames = 'cldr_metazone_names';
  static const metazoneAliases = 'metazone_aliases';
  static const terms = 'terms';

  /// Hits that name another city / another country of the same zone (hint text).
  static const otherCity = {
    ianaLinks, cldrExemplarCities, wikidataCapitals, majorCities
  };
  static const otherCountry = {
    iso3166NamesEn, cldrCountryNamesEn, cldrCountryNamesDe,
    countryAliasesEn, countryAliasesDe,
  };
}
