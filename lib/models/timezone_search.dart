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
    return [
      en?.generic, en?.standard,
      de?.generic, de?.standard,
      if (hasDst) ...[en?.daylight, de?.daylight],
    ].whereType<String>();
  }

  bool matches(String query) {
    final query_orig = query.trim();
    final query_lower = foldDiacritics(query.toLowerCase().trim());
    if (query_lower.isEmpty) return true;
    // offsets, fixed format: [+-]\d\d:\d\d
    if (offsetWinter.contains(query_lower) ||
        offsetSummer.contains(query_lower) ||
        offsetWinter.replaceAll(':', '').contains(query_lower) ||
        offsetSummer.replaceAll(':', '').contains(query_lower)
    ) {
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
      ...exemplarCityNames,
      ...windowsNames,
      ...metazoneTerms,
    ];

    // uppercase-only: (non-IANA) zone abbreviations in terms
    if (query_orig == query_orig.toUpperCase()) {
      // All-caps: exact match only (case-insensitive), to avoid false
      // positives from short/ambiguous strings matching as a prefix of
      // unrelated longer words.
      return candidates.any((t) => t.toUpperCase() == query_orig);
    }
    // locations or whole area/location identifiers
    if (ianaZoneId.toLowerCase().contains(query_lower) ||
        ianaZoneId.toLowerCase().contains(query_lower.replaceAll(' ', '_'))) {
      return true;
    }
    // cities, countries, zone names, zone abbreviations, ...
    return candidates.any(
        (t) => foldDiacritics(t.toLowerCase()).startsWith(query_lower));
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
