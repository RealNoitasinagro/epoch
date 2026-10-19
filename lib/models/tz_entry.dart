import '../time_utils.dart';
import 'generated/cldr_country_names_de.g.dart';
import 'generated/cldr_country_names_en.g.dart';
import 'generated/cldr_exemplar_cities_de.g.dart';
import 'generated/cldr_exemplar_cities_en.g.dart';
import 'generated/cldr_metazone_names_de.g.dart';
import 'generated/cldr_metazone_names_en.g.dart';
import 'generated/cldr_metazone_short_names.g.dart';
import 'generated/cldr_windows_zone_names.g.dart';
import 'generated/cldr_zone_long_names_de.g.dart';
import 'generated/cldr_zone_long_names_en.g.dart';
import 'generated/cldr_zone_metazone.g.dart';
import 'generated/iana_links_snapshot.g.dart';
import 'generated/iso3166_country_names_en.g.dart';
import 'generated/legacy_abbreviations.g.dart';
import 'generated/wikidata_capitals_de.g.dart';
import 'generated/wikidata_capitals_en.g.dart';
import 'generated/zone1970_countries.g.dart';
import 'timezone_abbreviation_localization.dart';
import 'timezone_search.dart';
import 'timezone_search_country_aliases.dart';
import 'timezone_search_major_cities.dart';
import 'timezone_search_metazone_aliases.dart';
import 'timezone_search_normalize.dart';
import 'zone_rules.dart';

/// Resolves `lookup[ianaZoneId]`, falling back to any entry keyed by a
/// deprecated/link identifier that currently resolves to this zone.
/// CLDR data sometimes still uses an identifier IANA has since renamed
/// (e.g. "Asia/Katmandu" instead of today's canonical "Asia/Kathmandu").
T? _resolveViaLinks<T>(Map<String, T> lookup, String ianaZoneId) {
  final direct = lookup[ianaZoneId];
  if (direct != null) return direct;
  for (final entry in ianaLinksSnapshot.entries) {
    if (entry.value == ianaZoneId) {
      final viaLink = lookup[entry.key];
      if (viaLink != null) return viaLink;
    }
  }
  return null;
}

/// Built once: legacy abbreviations of a zone and of every link pointing at it.
final Map<String, Set<String>> _legacyAbbreviationsByCanonical = () {
  final result = <String, Set<String>>{};
  legacyAbbreviationsByZone.forEach((zoneId, abbrs) {
    result.putIfAbsent(ianaLinksSnapshot[zoneId] ?? zoneId, () => {}).addAll(abbrs);
  });
  return result;
}();

class TzEntry {
  const TzEntry({required this.ianaZoneId, this.terms = const []});

  final String ianaZoneId;
  final List<String> terms; // hand-curated rare cases only

  ZoneRules get rules =>
      zoneRulesAt(ianaZoneId, DateTime.now().toUtc()) ??
          (throw StateError('No zone data for $ianaZoneId -- initializeTimeZones() first'));

  bool get hasDst => rules.hasDst;
  String get offsetWinter => TimeUtils.utcOffsetString(rules.standardOffset);
  String get offsetSummer => TimeUtils.utcOffsetString(rules.dstOffset);
  String get abbrWinter => rules.standardAbbr;
  String get abbrSummer => rules.dstAbbr;

  String get offsetLabel {
    if (!hasDst) return '$abbrWinter  UTC$offsetWinter';
    final offsets = offsetWinter == offsetSummer
        ? 'UTC$offsetWinter' : 'UTC$offsetWinter/UTC$offsetSummer';
    return '$abbrWinter/$abbrSummer  $offsets';
  }

  String get cityName =>
      ianaZoneId.split('/').last.replaceAll('_', ' ');

  String displayCity(String locale) =>
      (locale.startsWith('de') ? cldrCityNamesDe : cldrCityNamesEn)[ianaZoneId] ??
          cityName;

  String displayTitle(String locale) {
    final codes = zoneCountryCodes[ianaZoneId];
    if (codes == null || codes.isEmpty) return displayCity(locale);
    final code = codes.first;
    final name = locale.startsWith('de')
        ? cldrCountryNamesDe[code]
        : (cldrCountryNamesEn[code] ?? countryNamesEn[code]);
    final more = codes.length > 1 ? ' +${codes.length - 1}' : '';
    return '${displayCity(locale)} (${name ?? code}, $code$more)';
  }

  /// City-style names derived from deprecated/alias IANA identifiers
  /// (Links) that point at this zone, e.g. "Africa/Accra" -> "Accra"
  /// for the canonical Africa/Abidjan.
  Iterable<String> get linkCityNames => ianaLinksSnapshot.entries
      .where((e) => e.value == ianaZoneId)
      .map((e) => e.key.split('/').last.replaceAll('_', ' '));

  List<String> get _countryCodes => zoneCountryCodes[ianaZoneId] ?? const [];

  Iterable<String> get _countryNamesIsoEn =>
      _countryCodes.expand((c) => [?countryNamesEn[c]]);

  Iterable<String> get _countryNamesCldrEn =>
      _countryCodes.expand((c) => [?cldrCountryNamesEn[c]]);

  Iterable<String> get _countryNamesGeneratedEn => _countryCodes.expand(
          (c) => [..._countryNamesIsoEn, ..._countryNamesCldrEn]);
  Iterable<String> get _countryNamesGeneratedDe =>
      _countryCodes.expand((c) => [?cldrCountryNamesDe[c]]);
  Iterable<String> get _countryAliasesEn =>
      _countryCodes.expand((c) => countryNameAliasesEn[c] ?? const <String>[]);
  Iterable<String> get _countryAliasesDe =>
      _countryCodes.expand((c) => countryNameAliasesDe[c] ?? const <String>[]);

  // labels: country_names / country_aliases
  Iterable<String> get _countryNamesGenerated =>
      [..._countryNamesGeneratedEn, ..._countryNamesGeneratedDe];
  Iterable<String> get _countryNamesAliases =>
      [..._countryAliasesEn, ..._countryAliasesDe];

  // language-separated, aliases included: input for the time-suffix rule
  Iterable<String> get _countryNamesEnOnly =>
      [..._countryNamesGeneratedEn, ..._countryAliasesEn];
  Iterable<String> get _countryNamesDeOnly =>
      [..._countryNamesGeneratedDe, ..._countryAliasesDe];

  Iterable<String> get countryNames =>
      [..._countryNamesGenerated, ..._countryNamesAliases];

  Iterable<String> get timeSuffixTerms {
    final enNames = {
      ..._countryNamesEnOnly.map(stripParenthetical),   // "Korea (South)" -> "Korea"
      cityName, ...linkCityNames, ..._exemplarCityNamesEn,
    };
    final deNames = _countryNamesDeOnly.map(stripParenthetical).toSet();
    return [
      for (final n in enNames) ...['$n Time', if (hasDst) '$n Daylight Time'],
      for (final n in deNames)
        ...['$n-Zeit', '$n-Normalzeit', if (hasDst) '$n-Sommerzeit'],
    ].expand(expandTimeZoneNameVariants);
  }

  /// English and German country names for the countries assigned to this
  /// zone (potentially more than pne per county, e.g. South Africa).
  // Iterable<String> get capitalNames {
  //   final codes = zoneCountryCodes[ianaZoneId] ?? const [];
  //   return codes.expand((code) => [
  //     ...?wikidataCapitalsEn[code],
  //     ...?wikidataCapitalsDe[code],
  //   ]);
  // }

  Iterable<String> get capitalNames =>
      _countryCodes.expand((code) => [
        ...?wikidataCapitalsEn[code],
        ...?wikidataCapitalsDe[code],
      ]);


  /// Megacities for this zone (EN + DE), where available -- and not part of the
  /// zone identifier.
  Iterable<String> get megacityNames => [
    if (megacityNamesEn[ianaZoneId] != null) ...megacityNamesEn[ianaZoneId]!,
    if (megacityNamesDe[ianaZoneId] != null) ...megacityNamesDe[ianaZoneId]!,
  ];

  Iterable<String> get _exemplarCityNamesEn {
    final en = _resolveViaLinks(cldrCityNamesEn, ianaZoneId);
    return [if (en != null) en];
  }

  /// CLDR exemplar city for this zone (EN + DE), where available.
  Iterable<String> get exemplarCityNames {
    final en = _exemplarCityNamesEn;
    final de = _resolveViaLinks(cldrCityNamesDe, ianaZoneId);
    return [...en, if (de != null) de];
  }

  /// Windows-style display name(s) (English only, per CLDR).
  Iterable<String> get windowsNames =>
      _resolveViaLinks(windowsZoneNames, ianaZoneId) ?? const [];

  Set<String> get _metazoneIds => {
    ?cldrZoneMetaZone[ianaZoneId],
    for (final e in ianaLinksSnapshot.entries)
      if (e.value == ianaZoneId) ?cldrZoneMetaZone[e.key],
  };

  Iterable<String> get metazoneTerms => [
    ..._metazoneIds.expand(_generatedBaseTermsFor),
    ..._metazoneIds.expand(_aliasBaseTermsFor),
  ].expand(expandTimeZoneNameVariants);

  Iterable<String> _generatedBaseTermsFor(String metaId) {
    final en = cldrMetazoneNamesEn[metaId];
    final de = cldrMetazoneNamesDe[metaId];
    return [
      en?.generic, en?.standard, de?.generic, de?.standard,
      if (hasDst) ...[en?.daylight, de?.daylight],
    ].whereType<String>();
  }

  Iterable<String> _aliasBaseTermsFor(String metaId) {
    final en = metazoneNameAliasesEn[metaId];
    final de = metazoneNameAliasesDe[metaId];
    return [
      ...?en?.generic, ...?en?.standard, ...?de?.generic, ...?de?.standard,
      if (hasDst) ...[...?en?.daylight, ...?de?.daylight],
    ];
  }

  /// Label '~' marks terms produced by _expandTimeZoneNameVariants.
  Iterable<({String source, String term})> _tagged(
      String source, Iterable<String> bases) =>
      [
        for (final base in bases)
          for (final v in expandTimeZoneNameVariants(base))
            (source: v == base ? source : '$source~', term: v),
      ];

  Iterable<String> get zoneSpecificTerms {
    final en = _resolveViaLinks(cldrZoneLongNamesEn, ianaZoneId);
    final de = _resolveViaLinks(cldrZoneLongNamesDe, ianaZoneId);
    return [
      en?.generic, en?.standard, de?.generic, de?.standard,
      if (hasDst) ...[en?.daylight, de?.daylight],
    ].whereType<String>().expand(expandTimeZoneNameVariants);
  }

  Iterable<String> _shortNames(String metaId) {
    final s = cldrMetazoneShortNames[metaId];
    return [s?.generic, s?.standard, if (hasDst) s?.daylight].whereType<String>();
  }

  /// Exact, case-sensitive matches beyond abbrWinter/abbrSummer. Legacy ones
  /// are deliberately not gated by hasDst (users still type BRST, PYST).
  Set<String> get abbreviationAliases {
    final base = {
      ...?_legacyAbbreviationsByCanonical[ianaZoneId],
      for (final id in _metazoneIds) ..._shortNames(id),
    };
    return {
      ...base,
      for (final abbr in {...base, abbrWinter, abbrSummer})
        localizeTimezoneAbbr(abbr, 'de'),   // CET -> MEZ, CEST -> MESZ, ...
    };
  }

  Iterable<({String source, String term})> get candidatesWithSource => [
    for (final t in linkCityNames) (source: 'iana_links', term: t),
    // for (final t in _countryNamesIsoEn) (source: 'iso3166_names_EN', term: t),
    // for (final t in _countryNamesCldrEn) (source: 'cldr_country_names_EN', term: t),
    for (final t in _countryNamesGeneratedEn) (source: 'country_names_DE', term: t),
    for (final t in _countryNamesGeneratedDe) (source: 'country_names_DE', term: t),
    for (final t in _countryAliasesEn) (source: 'country_aliases_EN', term: t),
    for (final t in _countryAliasesDe) (source: 'country_aliases_DE', term: t),
    for (final t in timeSuffixTerms) (source: 'rule:timeSuffix', term: t),
    for (final t in windowsNames) (source: 'cldr_windows_zone_names', term: t),
    for (final t in zoneSpecificTerms) (source: 'cldr_zone_long_names', term: t),
    for (final t in exemplarCityNames) (source: 'cldr_exemplar_cities', term: t),
    for (final t in capitalNames) (source: 'wikidata_capitals', term: t),
    for (final t in megacityNames) (source: 'major_cities', term: t),
    ..._tagged('cldr_metazone_names', _metazoneIds.expand(_generatedBaseTermsFor)),
    ..._tagged('metazone_aliases', _metazoneIds.expand(_aliasBaseTermsFor)),
    ..._tagged('terms', terms),
    // for (final t in terms) (source: 'terms', term: normalize(t)),
    // for (final t in _metazoneGenerated) (source: 'cldr_metazone_names', term: t),
    // for (final t in _metazoneAliasTerms) (source: 'metazone_aliases', term: t),
  ];

  TzMatch? match(String query) {
    final queryOrig = query.trim();
    if (queryOrig.isEmpty) return (rule: 'empty', source: '-', term: '');
    final queryPlain = queryOrig.toLowerCase();
    final queryNorm = normalize(queryOrig);
    if (offsetWinter.contains(queryPlain) || offsetSummer.contains(queryPlain) ||
        offsetWinter.replaceAll(':', '').contains(queryPlain) ||
        offsetSummer.replaceAll(':', '').contains(queryPlain)) {
      return (rule: 'offset', source: '-', term: '$offsetWinter/$offsetSummer');
    }
    if (abbrWinter == queryOrig || abbrSummer == queryOrig) {
      return (rule: 'abbr', source: '-', term: '$abbrWinter/$abbrSummer');
    }
    if (abbreviationAliases.contains(queryOrig)) {
      return (rule: 'abbrAlias', source: '-', term: queryOrig);
    }
    final allCaps = queryOrig == queryOrig.toUpperCase();
    if (!allCaps &&
        (ianaZoneId.toLowerCase().contains(queryNorm) ||
            ianaZoneId.toLowerCase().contains(queryNorm.replaceAll(' ', '_')))) {
      return (rule: 'zoneId', source: '-', term: ianaZoneId);
    }
    for (final c in candidatesWithSource) {
      final t = normalize(c.term);
      if (allCaps ? t == queryNorm : t.startsWith(queryNorm)) {
        return (rule: allCaps ? 'exact' : 'prefix', source: c.source, term: c.term);
      }
    }
    return null;
  }

  bool matches(q) => match(q) != null;
}
