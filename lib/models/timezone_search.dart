// Curated timezone database with multilingual search terms.
// Shared term sets avoid redundancy across entries with the same offset/zone.

// ── Data class ───────────────────────────────────────────────────────────────

class TzEntry {
  final String ianaZone;
  final String offsetWinter;
  final String offsetSummer;
  final String abbrWinter;
  final String abbrSummer;
  final List<String> terms; // lowercase; includes shared + city-specific

  const TzEntry({
    required this.ianaZone,
    required this.offsetWinter,
    required this.offsetSummer,
    required this.abbrWinter,
    required this.abbrSummer,
    required this.terms,
  });

  bool get hasDst => offsetWinter != offsetSummer;

  String get offsetLabel => hasDst
      ? '$abbrWinter/$abbrSummer  UTC$offsetWinter/UTC$offsetSummer'
      : '$abbrWinter  UTC$offsetWinter';

  String get cityName =>
      ianaZone.split('/').last.replaceAll('_', ' ');

  bool matches(String query) {
    final query_orig = query.trim();
    final query_lower = query.toLowerCase().trim();
    if (query_lower.isEmpty) return true;
    if (offsetWinter.contains(query_lower) ||
        offsetSummer.contains(query_lower) ||
        offsetWinter.replaceAll(':', '').contains(query_lower) ||
        offsetSummer.replaceAll(':', '').contains(query_lower)
    ) {
      return true;
    }
    if (abbrWinter == query_orig || abbrSummer == query_orig) {
      return true;
    }
    if (query_orig == query_orig.toUpperCase()) {
      return terms.any((t) => t == query_orig);
    }
    else {
      if (ianaZone.toLowerCase().contains(query_lower) ||
          ianaZone.toLowerCase().contains(query_lower.replaceAll(' ', '_'))) {
        return true;
      }
      return terms.any((t) => t.startsWith(query_lower));
    }
  }
}

// Parses UTC offset queries like "UTC+05:30", "+5:30", "-3", "+5.5", "+9,75"
List<TzEntry> searchByOffset(String query, List<TzEntry> db) {
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
