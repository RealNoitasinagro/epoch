import 'generated/cldr_country_names_de.g.dart';
import 'generated/cldr_country_names_en.g.dart';
import 'generated/cldr_exemplar_cities_de.g.dart';
import 'generated/cldr_exemplar_cities_en.g.dart';
import 'generated/cldr_metazone_names_de.g.dart';
import 'generated/cldr_metazone_names_en.g.dart';
import 'generated/cldr_windows_zone_names.g.dart';
import 'generated/cldr_zone_metazone.g.dart';
import 'generated/iana_links_snapshot.g.dart';
import 'generated/iso3166_country_names_en.g.dart';
import 'generated/wikidata_capitals_de.g.dart';
import 'generated/wikidata_capitals_en.g.dart';
import 'generated/zone1970_countries.g.dart';
import 'timezone_search_country_aliases.dart';
import 'timezone_search_major_cities.dart';
import 'timezone_search_metazone_aliases.dart';

const _diacriticsFoldMap = {
  'á':'a','à':'a','â':'a','ã':'a','ä':'a','å':'a',
  'ç':'c',
  'é':'e','è':'e','ê':'e','ë':'e',
  'í':'i','ì':'i','î':'i','ï':'i',
  'ñ':'n',
  'ó':'o','ò':'o','ô':'o','õ':'o','ö':'o',
  'ú':'u','ù':'u','û':'u','ü':'u',
  'ý':'y','ÿ':'y',
  'ß':'ss',
};

String foldDiacritics(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    final ch = String.fromCharCode(rune);
    buffer.write(_diacriticsFoldMap[ch] ?? ch);
  }
  return buffer.toString();
}

String stripCombiningMarks(String input) =>
    input.replaceAll(RegExp(r'\p{Mn}', unicode: true), '');

String foldApostrophes(String input) => input.replaceAll(
    RegExp('[\u2018\u2019\u201B\u02B9\u02BC\u02BB\u02BD\u0060\u00B4]'), "'");

String foldHyphens(String input) =>
    input.replaceAll('-', ' ');

String foldPunctuation(String input) =>
    input.replaceAll(RegExp(r'[,.]'), '');

String foldSaintAbbreviation(String input) => input
    .replaceAll(RegExp(r'\bsankt\b', caseSensitive: false), 'st')
    .replaceAll(RegExp(r'\bsaint\b', caseSensitive: false), 'st')
    .replaceAll(RegExp(r'\bst\.', caseSensitive: false), 'st');

String _normalize(String s) {
  var result = s.toLowerCase();
  result = foldDiacritics(result);
  result = stripCombiningMarks(result);
  result = foldApostrophes(result);
  result = foldSaintAbbreviation(result);
  result = foldHyphens(result);
  result = foldPunctuation(result);
  return result;
}

/// Time-zone-name-specific spelling variants (not general text
/// normalization) -- lets alias/metazone data store ONE canonical form
/// per concept instead of every colloquial suffix variant by hand.
Iterable<String> _expandTimeZoneNameVariants(String term) {
  final lower = term.toLowerCase();
  final variants = <String>{term};
  if (lower.endsWith('normalzeit')) {
    variants.add(
        '${term.substring(0, term.length - 'normalzeit'.length)}Normal-Zeit'
    );
    variants.add(
        '${term.substring(0, term.length - 'normalzeit'.length)}Standardzeit'
    );
    variants.add(
        '${term.substring(0, term.length - 'normalzeit'.length)}Standard-Zeit'
    );
    variants.add(
        '${term.substring(0, term.length - 'normalzeit'.length)}Winterzeit'
    );
    variants.add(
        '${term.substring(0, term.length - 'normalzeit'.length)}Winter-Zeit'
    );
  }
  else if (lower.endsWith('sommerzeit')) {
    variants.add(
        '${term.substring(0, term.length - 'sommerzeit'.length)}Sommer-Zeit'
    );
  }
  else if (lower.endsWith('daylight time')) {
    final stem = term.substring(0, term.length - 'daylight time'.length);
    variants.add('${stem}Daylight Saving Time');
    variants.add('${stem}Daylight Savings Time');
    variants.add('${stem}Summer Time');
  }
  else if (lower.endsWith('summer time')) {
    final stem = term.substring(0, term.length - 'summer time'.length);
    variants.add('${stem}Daylight Time');
    variants.add('${stem}Daylight Saving Time');
    variants.add('${stem}Daylight Savings Time');
  }
  return variants;
}

class TzEntry {
  /// The identifier for this zone -- almost always a canonical IANA tz
  /// identifier (e.g. "Europe/Berlin"). A small number of curated
  /// exceptions use a synthetic, non-IANA identifier instead, when no
  /// IANA zone captures the concept precisely (e.g. "Anywhere on Earth").
  final String ianaZoneId;
  final String offsetWinter;
  final String offsetSummer;
  final String abbrWinter;
  final String abbrSummer;
  final List<String> terms;  // legacy escape hatch for rare hand-curated cases

  const TzEntry({
    required this.ianaZoneId,
    required this.offsetWinter,
    required this.offsetSummer,
    required this.abbrWinter,
    required this.abbrSummer,
    this.terms = const [],
  });

  bool get hasDst => offsetWinter != offsetSummer;

  String get offsetLabel => hasDst
      ? '$abbrWinter/$abbrSummer  UTC$offsetWinter/UTC$offsetSummer'
      : '$abbrWinter  UTC$offsetWinter';

  String get cityName =>
      ianaZoneId.split('/').last.replaceAll('_', ' ');

  /// City-style names derived from deprecated/alias IANA identifiers
  /// (Links) that point at this zone, e.g. "Africa/Accra" -> "Accra"
  /// for the canonical Africa/Abidjan.
  Iterable<String> get linkCityNames => ianaLinksSnapshot.entries
      .where((e) => e.value == ianaZoneId)
      .map((e) => e.key.split('/').last.replaceAll('_', ' '));

  /// English and German country names for the countries assigned to this
  /// zone (via zone1970.tab / ISO 3166-1 / CLDR). Computed on demand
  /// rather than stored, to avoid duplicating the generated country data
  /// per entry.
  Iterable<String> get countryNames {
    final codes = zoneCountryCodes[ianaZoneId] ?? const [];
    return codes.expand((code) => [
      if (countryNamesEn[code] != null) countryNamesEn[code]!,
      if (cldrCountryNamesEn[code] != null) cldrCountryNamesEn[code]!,
      if (cldrCountryNamesDe[code] != null) cldrCountryNamesDe[code]!,
      if (countryNameAliasesEn[code] != null) ...countryNameAliasesEn[code]!,
      if (countryNameAliasesDe[code] != null) ...countryNameAliasesDe[code]!,
    ]);
  }

  /// English and German country names for the countries assigned to this
  /// zone (potentially more than pne per county, e.g. South Africa).
  Iterable<String> get capitalNames {
    final codes = zoneCountryCodes[ianaZoneId] ?? const [];
    return codes.expand((code) => [
      ...?wikidataCapitalsEn[code],
      ...?wikidataCapitalsDe[code],
    ]);
  }

  /// Megacities for this zone (EN + DE), where available -- and not part of the
  /// zone identifier.
  Iterable<String> get megacityNames => [
    if (megacityNamesEn[ianaZoneId] != null) ...megacityNamesEn[ianaZoneId]!,
    if (megacityNamesDe[ianaZoneId] != null) ...megacityNamesDe[ianaZoneId]!,
  ];

  /// CLDR exemplar city for this zone (EN + DE), where available.
  Iterable<String> get exemplarCityNames => [
    if (cldrCityNamesEn[ianaZoneId] != null) cldrCityNamesEn[ianaZoneId]!,
    if (cldrCityNamesDe[ianaZoneId] != null) cldrCityNamesDe[ianaZoneId]!,
  ];

  /// Windows-style display name(s) (English only, per CLDR).
  Iterable<String> get windowsNames => windowsZoneNames[ianaZoneId] ?? const [];

  /// Localized metazone names (generic/standard always; daylight only if
  /// THIS zone currently observes DST -- metazone membership alone does
  /// not imply that. E.g. Africa/Tunis shares the "Europe_Central"
  /// metazone with Europe/Berlin but no longer observes DST itself, so
  /// it must not match "CEST"/"Sommerzeit"-style daylight terms.
  Iterable<String> get metazoneTerms {
    final metaId = cldrZoneMetaZone[ianaZoneId];
    if (metaId == null) return const [];
    final en = cldrMetazoneNamesEn[metaId];
    final de = cldrMetazoneNamesDe[metaId];
    final enAliases = metazoneNameAliasesEn[metaId];
    final deAliases = metazoneNameAliasesDe[metaId];

    final rawTerms = [
      if (en?.generic != null) en!.generic!,
      if (en?.standard != null) en!.standard!,
      if (de?.generic != null) de!.generic!,
      if (de?.standard != null) de!.standard!,
      ...?enAliases?.generic,
      ...?enAliases?.standard,
      ...?deAliases?.generic,
      ...?deAliases?.standard,
      if (hasDst) ...[
        if (en?.daylight != null) en!.daylight!,
        if (de?.daylight != null) de!.daylight!,
        ...?enAliases?.daylight,
        ...?deAliases?.daylight,
      ],
    ];
    return rawTerms.expand(_expandTimeZoneNameVariants);
  }

  bool matches(String query) {
    final query_orig = query.trim();
    if (query_orig.isEmpty) return true;
    final query_plain = query_orig.toLowerCase();  // for offsets, not normalised
    final query_norm = _normalize(query_orig);

    // offsets, fixed format: [+-]\d\d:\d\d
    if (offsetWinter.contains(query_plain) ||
        offsetSummer.contains(query_plain) ||
        offsetWinter.replaceAll(':', '').contains(query_plain) ||
        offsetSummer.replaceAll(':', '').contains(query_plain)) {
      return true;
    }
    // (IANA) abbreviations (letters-only or offset numbers)
    if (abbrWinter == query_orig || abbrSummer == query_orig) {
      return true;
    }

    final candidates = [
      ...terms,
      ...linkCityNames,
      ...countryNames,
      ...capitalNames,
      ...megacityNames,
      ...exemplarCityNames,
      ...windowsNames,
      ...metazoneTerms,
    ];

    // uppercase-only: (non-IANA) zone abbreviations in terms
    if (query_orig == query_orig.toUpperCase()) {
      // All-caps query: require an exact match (after normalization) rather
      // than startsWith, to avoid short/ambiguous abbreviations incorrectly
      // matching as a prefix of an unrelated longer word.
      return candidates.any((t) => _normalize(t) == query_norm);
    }
    // locations or whole area/location identifiers
    if (ianaZoneId.toLowerCase().contains(query_norm) ||
        ianaZoneId.toLowerCase().contains(query_norm.replaceAll(' ', '_'))) {
      return true;
    }
    // cities, countries, zone names, zone abbreviations, ...
    return candidates.any(
        (t) => _normalize(t).startsWith(query_norm));
  }
}

// Parses UTC offset queries like "UTC+05:30", "+5:30", "-3", "+5.5", "+9,75"
List<TzEntry> _searchByOffset(String query, List<TzEntry> db) {
  final q = query.trim().toUpperCase().replaceAll(' ', '');

  final decimalMatch = RegExp(r'^(?:UTC)?([+-])(\d{1,2})[.,](50?|75|25)$').firstMatch(q);
  final String target;
  if (decimalMatch != null) {
    final sign = decimalMatch.group(1)!;
    final hours = int.parse(decimalMatch.group(2)!);
    final minutes = switch (decimalMatch.group(3)!) {
      '5' || '50' => 30,
      '75' => 45,
      '25' => 15,
      _ => 0,  // unreachable given the current regex
    };
    target = '$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  } else {
    final hoursMinutesMatch = RegExp(r'^(?:UTC)?([+-])(\d{1,2})(?::?(\d{2}))?$').firstMatch(q);
    if (hoursMinutesMatch == null) return [];
    final sign = hoursMinutesMatch.group(1)!;
    final hours = int.parse(hoursMinutesMatch.group(2)!);
    final minutes = int.parse(hoursMinutesMatch.group(3) ?? '0');
    target = '$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  return db.where((e) => e.offsetWinter == target || e.offsetSummer == target).toList();
}

List<TzEntry> searchTimezones(String query, List<TzEntry> db) {
  final byOffset = _searchByOffset(query, db);
  if (byOffset.isNotEmpty) return byOffset;
  return db.where((e) => e.matches(query)).toList();
}
