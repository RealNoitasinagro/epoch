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
import 'timezone_match_labels.dart';
import 'timezone_search_country_aliases.dart';
import 'timezone_search_major_cities.dart';
import 'timezone_search_metazone_aliases.dart';
import 'timezone_search_normalize.dart';
import 'zone_rules.dart';

/// Why a zone matched a query: which rule fired, which source and term hit.
typedef TzMatch = ({String rule, String source, String term});

extension TzMatchRank on TzMatch {
  int get rank => rule == TzRule.zoneId ? 0 : switch (source) {
    TzSource.cldrExemplarCities || TzSource.ianaLinks => 1,
    TzSource.wikidataCapitals || TzSource.majorCities => 2,
    TzSource.iso3166NamesEn || TzSource.cldrCountryNamesEn || TzSource.cldrCountryNamesDe ||
    TzSource.countryAliasesEn || TzSource.countryAliasesDe => 3,
    _ => 4,
  };
}

/// A searchable term and the source that produced it.
typedef TzCandidate = ({String source, String term});
typedef NormalizedCandidate = ({String source, String term, String normalized});

/// Built once: legacy abbreviations of a zone and of every link pointing at it.
final Map<String, Set<String>> _legacyAbbreviationsByCanonical = () {
  final result = <String, Set<String>>{};
  legacyAbbreviationsByZone.forEach((zoneId, abbrs) {
    result.putIfAbsent(ianaLinksSnapshot[zoneId] ?? zoneId, () => {}).addAll(abbrs);
  });
  return result;
}();

/// Built once: the link identifiers pointing at each canonical zone.
final Map<String, List<String>> _linkIdsByCanonical = () {
  final result = <String, List<String>>{};
  ianaLinksSnapshot.forEach((linkId, canonicalId) {
    result.putIfAbsent(canonicalId, () => []).add(linkId);
  });
  return result;
}();

/// Everything that is expensive to derive but constant for one calendar day
/// (hasDst, and thus the daylight names, can change with the date).
class _DailyData {
  const _DailyData({
    required this.day,
    required this.candidates,
    required this.abbreviationAliases,
    required this.normalizedZoneId,
  });

  final String day; // UTC, yyyy-MM-dd
  final List<NormalizedCandidate> candidates;
  final Set<String> abbreviationAliases;
  final String normalizedZoneId;  // "etc/gmt 5" for Etc/GMT-5
}

final Expando<_DailyData> _dailyDataByEntry = Expando();

class TzEntry {
  const TzEntry({required this.ianaZoneId, this.terms = const []});

  final String ianaZoneId;
  final List<String> terms; // hand-curated rare cases only

  // ── Zone rules (derived from the timezone data, never stored) ─────────────

  ZoneRules get rules =>
      zoneRulesAt(ianaZoneId, DateTime.now().toUtc()) ??
          (throw StateError('No zone data for $ianaZoneId -- initializeTimeZones() first'));

  bool get hasDst => rules.hasDst;
  String get offsetWinter => formatUtcOffset(rules.standardOffset);
  String get offsetSummer => formatUtcOffset(rules.dstOffset);
  String get abbrWinter => rules.standardAbbr;
  String get abbrSummer => rules.dstAbbr;

  String get offsetLabel {
    if (!hasDst) return '$abbrWinter  UTC$offsetWinter';
    final offsets = offsetWinter == offsetSummer
        ? 'UTC$offsetWinter' : 'UTC$offsetWinter/UTC$offsetSummer';
    return '$abbrWinter/$abbrSummer  $offsets';
  }

  // ── Display ───────────────────────────────────────────────────────────────

  /// City part of the zone identifier, e.g. "Los Angeles".
  String get cityName => ianaZoneId.split('/').last.replaceAll('_', ' ');

  /// The zone's own CLDR city, never one found via a link (otherwise Berlin
  /// would be titled "Copenhagen").
  String displayCity(String locale) =>
      (locale.startsWith('de') ? cldrCityNamesDe : cldrCityNamesEn)[ianaZoneId] ??
          cityName;

  String? displayCountry(String locale) {
    if (_countryCodes.isEmpty) return null;
    final code = _countryCodes.first; // zone1970.tab: the location's own country first
    return locale.startsWith('de')
        ? cldrCountryNamesDe[code]
        : (cldrCountryNamesEn[code] ?? countryNamesEn[code]);
  }

  String displayTitle(String locale) {
    final country = displayCountry(locale);
    return country == null
        ? displayCity(locale)
        : '${displayCity(locale)} ($country)';
  }

  /// Names (EN, DE, aliases) of the zone's own country, i.e. the first one
  /// listed in zone1970.tab.
  Iterable<String> get ownCountryNames {
    if (_countryCodes.isEmpty) return const [];
    final code = _countryCodes.first;
    return [
      ?countryNamesEn[code], ?cldrCountryNamesEn[code], ?cldrCountryNamesDe[code],
      ...?countryNameAliasesEn[code], ...?countryNameAliasesDe[code],
    ];
  }

  /// City-style names derived from deprecated/alias IANA identifiers (Links)
  /// that point at this zone, e.g. "Africa/Accra" -> "Accra" for the canonical
  /// Africa/Abidjan.
  Iterable<String> get linkCityNames =>
      _linkIds.map((linkId) => linkId.split('/').last.replaceAll('_', ' '));

  // ── Matching ──────────────────────────────────────────────────────────────

  /// Returns why this zone matches [query], or null if it does not.
  /// [normalizedQuery] saves normalizing the same query once per zone.
  TzMatch? match(String query, {String? normalizedQuery}) {
    final queryOrig = query.trim();
    if (queryOrig.isEmpty) return (rule: TzRule.empty, source: TzSource.none, term: '');
    final queryPlain = queryOrig.toLowerCase();
    final queryNorm = normalizedQuery ?? normalize(queryOrig);

    // Same values as offsetWinter etc., but with one rules lookup in total.
    final zoneRules = rules;
    final winterOffset = formatUtcOffset(zoneRules.standardOffset);
    final summerOffset = formatUtcOffset(zoneRules.dstOffset);
    if (winterOffset.contains(queryPlain) || summerOffset.contains(queryPlain) ||
        winterOffset.replaceAll(':', '').contains(queryPlain) ||
        summerOffset.replaceAll(':', '').contains(queryPlain)) {
      return (rule: TzRule.offset, source: TzSource.none, term: '$winterOffset/$summerOffset');
    }
    if (zoneRules.standardAbbr == queryOrig || zoneRules.dstAbbr == queryOrig) {
      return (
        rule: TzRule.abbr,
        source: TzSource.none,
        term: '${zoneRules.standardAbbr}/${zoneRules.dstAbbr}',
      );
    }

    final dailyData = _dailyData;
    if (dailyData.abbreviationAliases.contains(queryOrig)) {
      return (rule: TzRule.abbrAlias, source: TzSource.none, term: queryOrig);
    }

    final allCaps = queryOrig == queryOrig.toUpperCase();
    // Capital letters only means an abbreviation (IST, CET): it must not match
    // inside zone IDs (Europe/Istanbul). Digits, signs or a slash (GMT-5,
    // Etc/GMT-5) can be part of an ID.
    final looksLikeAbbreviation = RegExp(r'^[A-Z]+$').hasMatch(queryOrig);
    if (!looksLikeAbbreviation &&
        dailyData.normalizedZoneId.contains(queryNorm)) {
      return (rule: TzRule.zoneId, source: TzSource.none, term: ianaZoneId);
    }
    for (final candidate in dailyData.candidates) {
      final isHit = allCaps
          ? candidate.normalized == queryNorm
          : candidate.normalized.startsWith(queryNorm);
      if (isHit) {
        return (
          rule: allCaps ? TzRule.exact : TzRule.prefix,
          source: candidate.source,
          term: candidate.term,
        );
      }
    }
    return null;
  }

  /// All searchable terms with their source label: the single source of truth
  /// for matching and for diagnostics.
  Iterable<TzCandidate> get candidatesWithSource {
    final metazoneIds = _metazoneIds;
    return [
      for (final t in linkCityNames) (source: TzSource.ianaLinks, term: t),
      for (final id in _linkIds) (source: TzSource.ianaLinks, term: id),
      for (final t in _countryNamesIsoEn) (source: TzSource.iso3166NamesEn, term: t),
      for (final t in _countryNamesCldrEn) (source: TzSource.cldrCountryNamesEn, term: t),
      for (final t in _countryNamesCldrDe) (source: TzSource.cldrCountryNamesDe, term: t),
      for (final t in _countryAliasesEn) (source: TzSource.countryAliasesEn, term: t),
      for (final t in _countryAliasesDe) (source: TzSource.countryAliasesDe, term: t),
      for (final t in _timeSuffixTerms) (source: TzSource.timeSuffixRule, term: t),
      for (final t in _windowsNames) (source: TzSource.cldrWindowsZoneNames, term: t),
      for (final t in _zoneSpecificTerms) (source: TzSource.cldrZoneLongNames, term: t),
      for (final t in _exemplarCityNames) (source: TzSource.cldrExemplarCities, term: t),
      for (final t in _capitalNames) (source: TzSource.wikidataCapitals, term: t),
      for (final t in _megacityNames) (source: TzSource.majorCities, term: t),
      ..._tagged(TzSource.cldrMetazoneNames, metazoneIds.expand(_generatedBaseTermsFor)),
      ..._tagged(TzSource.metazoneAliases, metazoneIds.expand(_aliasBaseTermsFor)),
      ..._tagged(TzSource.terms, terms),
    ];
  }

  /// [candidatesWithSource], normalized once per day instead of once per search.
  List<NormalizedCandidate> get normalizedCandidates => _dailyData.candidates;

  /// Exact, case-sensitive matches beyond abbrWinter/abbrSummer. Legacy ones
  /// are deliberately not gated by hasDst (users still type BRST, PYST).
  Set<String> get abbreviationAliases => _dailyData.abbreviationAliases;

  // ── Daily cache ───────────────────────────────────────────────────────────

  _DailyData get _dailyData {
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    final cached = _dailyDataByEntry[this];
    if (cached != null && cached.day == today) return cached;
    final data = _DailyData(
      day: today,
      candidates: [
        for (final c in candidatesWithSource)
          (source: c.source, term: c.term, normalized: normalize(c.term)),
      ],
      abbreviationAliases: _computeAbbreviationAliases(),
      normalizedZoneId: normalize(ianaZoneId),
    );
    _dailyDataByEntry[this] = data;
    return data;
  }

  Set<String> _computeAbbreviationAliases() {
    final base = {
      ...?_legacyAbbreviationsByCanonical[ianaZoneId],
      for (final id in _metazoneIds) ..._shortNames(id),
    };
    return {
      ...base,
      for (final abbr in {...base, abbrWinter, abbrSummer})
        localizeTimezoneAbbr(abbr, 'de'), // CET -> MEZ, CEST -> MESZ, ...
    };
  }

  // ── Lookups ───────────────────────────────────────────────────────────────

  List<String> get _countryCodes => zoneCountryCodes[ianaZoneId] ?? const [];

  /// Link identifiers pointing at this zone.
  List<String> get _linkIds => _linkIdsByCanonical[ianaZoneId] ?? const [];

  /// Metazones of this zone and of all its links (a canonical zone may gather
  /// links with different metazones, e.g. Port_Moresby: Chuuk, Yap, ...).
  Set<String> get _metazoneIds => {
    ?cldrZoneMetaZone[ianaZoneId],
    for (final linkId in _linkIds) ?cldrZoneMetaZone[linkId],
  };

  /// Resolves `lookup[ianaZoneId]`, falling back to any entry keyed by a
  /// deprecated/link identifier that currently resolves to this zone.
  /// CLDR data sometimes still uses an identifier IANA has since renamed
  /// (e.g. "Asia/Katmandu" instead of today's canonical "Asia/Kathmandu").
  T? _resolveViaLinks<T>(Map<String, T> lookup) {
    final direct = lookup[ianaZoneId];
    if (direct != null) return direct;
    for (final linkId in _linkIds) {
      final viaLink = lookup[linkId];
      if (viaLink != null) return viaLink;
    }
    return null;
  }

  // ── Term sources: countries ───────────────────────────────────────────────

  Iterable<String> get _countryNamesIsoEn =>
      _countryCodes.expand((code) => [?countryNamesEn[code]]);
  Iterable<String> get _countryNamesCldrEn =>
      _countryCodes.expand((code) => [?cldrCountryNamesEn[code]]);
  Iterable<String> get _countryNamesCldrDe =>
      _countryCodes.expand((code) => [?cldrCountryNamesDe[code]]);
  Iterable<String> get _countryAliasesEn => _countryCodes
      .expand((code) => countryNameAliasesEn[code] ?? const <String>[]);
  Iterable<String> get _countryAliasesDe => _countryCodes
      .expand((code) => countryNameAliasesDe[code] ?? const <String>[]);

  // Language-separated, aliases included: input for the time-suffix rule.
  Iterable<String> get _countryNamesEn =>
      [..._countryNamesIsoEn, ..._countryNamesCldrEn, ..._countryAliasesEn];
  Iterable<String> get _countryNamesDe =>
      [..._countryNamesCldrDe, ..._countryAliasesDe];

  /// Capital cities (EN + DE) of the countries assigned to this zone; there
  /// can be several (e.g. Zurich: CH, DE, LI).
  Iterable<String> get _capitalNames => _countryCodes.expand((code) => [
    ...?wikidataCapitalsEn[code],
    ...?wikidataCapitalsDe[code],
  ]);

  // ── Term sources: cities ──────────────────────────────────────────────────

  /// Megacities for this zone (EN + DE), where available and not part of the
  /// zone identifier.
  Iterable<String> get _megacityNames => [
    ...?megacityNamesEn[ianaZoneId],
    ...?megacityNamesDe[ianaZoneId],
  ];

  String? get _exemplarCityEn => _resolveViaLinks(cldrCityNamesEn);
  String? get _exemplarCityDe => _resolveViaLinks(cldrCityNamesDe);

  /// CLDR exemplar city for this zone (EN + DE), where available.
  Iterable<String> get _exemplarCityNames =>
      [?_exemplarCityEn, ?_exemplarCityDe];

  // ── Term sources: zone and metazone names ─────────────────────────────────

  /// Windows-style display name(s) (English only, per CLDR).
  Iterable<String> get _windowsNames =>
      _resolveViaLinks(windowsZoneNames) ?? const [];

  Iterable<String> get _zoneSpecificTerms {
    final en = _resolveViaLinks(cldrZoneLongNamesEn);
    final de = _resolveViaLinks(cldrZoneLongNamesDe);
    return [
      en?.generic, en?.standard, de?.generic, de?.standard,
      if (hasDst) ...[en?.daylight, de?.daylight],
    ].whereType<String>().expand(expandTimeZoneNameVariants);
  }

  Iterable<String> _generatedBaseTermsFor(String metazoneId) {
    final en = cldrMetazoneNamesEn[metazoneId];
    final de = cldrMetazoneNamesDe[metazoneId];
    return [
      en?.generic, en?.standard, de?.generic, de?.standard,
      if (hasDst) ...[en?.daylight, de?.daylight],
    ].whereType<String>();
  }

  Iterable<String> _aliasBaseTermsFor(String metazoneId) {
    final en = metazoneNameAliasesEn[metazoneId];
    final de = metazoneNameAliasesDe[metazoneId];
    return [
      ...?en?.generic, ...?en?.standard, ...?de?.generic, ...?de?.standard,
      if (hasDst) ...[...?en?.daylight, ...?de?.daylight],
    ];
  }

  Iterable<String> _shortNames(String metazoneId) {
    final short = cldrMetazoneShortNames[metazoneId];
    return [short?.generic, short?.standard, if (hasDst) short?.daylight]
        .whereType<String>();
  }

  // ── Term sources: rule-based ──────────────────────────────────────────────

  /// "Korea Time", "Deutschland-Zeit" etc., from country and city names.
  Iterable<String> get _timeSuffixTerms {
    final englishNames = {
      ..._countryNamesEn.map(stripParenthetical), // "Korea (South)" -> "Korea"
      cityName, ...linkCityNames, ?_exemplarCityEn,
    };
    final germanNames = _countryNamesDe.map(stripParenthetical).toSet();
    return [
      for (final n in englishNames) ...['$n Time', if (hasDst) '$n Daylight Time'],
      for (final n in germanNames)
        ...['$n-Zeit', '$n-Normalzeit', if (hasDst) '$n-Sommerzeit'],
    ].expand(expandTimeZoneNameVariants);
  }

  /// Expands each base term into its spelling variants. The label gets a '~'
  /// suffix for terms produced by expandTimeZoneNameVariants.
  Iterable<TzCandidate> _tagged(String source, Iterable<String> bases) => [
    for (final base in bases)
      for (final variant in expandTimeZoneNameVariants(base))
        (source: variant == base ? source : '$source${TzSource.variantSuffix}', term: variant),
  ];
}
