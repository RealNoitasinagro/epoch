// Curated timezone database with multilingual search terms.
// Shared term sets avoid redundancy across entries with the same offset/zone.

// ── Data class ────────────────────────────────────────────────────────────────

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
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return true;
    if (offsetWinter.contains(q) || offsetSummer.contains(q)) return true;
    if (ianaZone.toLowerCase().contains(q) ||
        ianaZone.toLowerCase().contains(q.replaceAll(' ', '_'))) {
      return true;
    }
    if (abbrWinter.toLowerCase().contains(q) ||
        abbrSummer.toLowerCase().contains(q)) {
      return true;
    }
    return terms.any((t) => t.contains(q));
  }
}

// Parses UTC offset queries like "UTC+05:30", "+5:30", "-3".
List<TzEntry> searchByOffset(String query, List<TzEntry> db) {
  final q = query.trim().toUpperCase().replaceAll(' ', '');
  final pattern = RegExp(r'^(?:UTC)?([+-])(\d{1,2})(?::?(\d{2}))?$');
  final m = pattern.firstMatch(q);
  if (m == null) return [];
  final sign = m.group(1)!;
  final hours = int.parse(m.group(2)!);
  final minutes = int.parse(m.group(3) ?? '0');
  final target = '$sign${hours.toString().padLeft(2, '0')}:'
      '${minutes.toString().padLeft(2, '0')}';
  return db
      .where((e) => e.offsetWinter == target || e.offsetSummer == target)
      .toList();
}
