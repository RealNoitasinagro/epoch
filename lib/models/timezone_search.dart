// Curated timezone database with multilingual search terms.
// Each entry maps an IANA zone to searchable terms in EN and DE.
class TzEntry {
  final String ianaZone;
  final String offsetWinter; // e.g. '+01:00'
  final String offsetSummer; // same as winter if no DST
  final String abbrWinter;   // e.g. 'CET'
  final String abbrSummer;   // e.g. 'CEST', same as winter if no DST
  final List<String> terms;  // lowercase search terms EN+DE

  const TzEntry({
    required this.ianaZone,
    required this.offsetWinter,
    required this.offsetSummer,
    required this.abbrWinter,
    required this.abbrSummer,
    required this.terms,
  });

  bool get hasDst => offsetWinter != offsetSummer;

  // Display label: "CET/CEST UTC+01:00/+02:00" or "UTC UTC+00:00"
  String get offsetLabel => hasDst
      ? '$abbrWinter/$abbrSummer  UTC$offsetWinter/UTC$offsetSummer'
      : '$abbrWinter  UTC$offsetWinter';

  // Short city/region name from IANA zone.
  String get cityName =>
      ianaZone.split('/').last.replaceAll('_', ' ');

  // Searches all terms plus ianaZone and offset strings.
  bool matches(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return true;
    if (ianaZone.toLowerCase().contains(q)) return true;
    if (offsetWinter.contains(q) || offsetSummer.contains(q)) return true;
    if (abbrWinter.toLowerCase().contains(q) ||
        abbrSummer.toLowerCase().contains(q)) {
      return true;
    }
    return terms.any((t) => t.contains(q));
  }
}

// Parses a UTC offset query like "UTC+05:30", "+5:30", "UTC-3".
// Returns matching entries by offset.
List<TzEntry> searchByOffset(String query, List<TzEntry> db) {
  final q = query.trim().toUpperCase().replaceAll(' ', '');
  // Match patterns: UTC+5, UTC+05:30, +5, +05:30, UTC-3, -03:00
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

const List<TzEntry> tzDatabase = [
  // ── UTC ──────────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'UTC',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'UTC', abbrSummer: 'UTC',
    terms: ['utc', 'universal', 'koordiniert', 'universal coordinated',
      'koordinierte weltzeit', 'weltzeit'],
  ),
  TzEntry(
    ianaZone: 'Etc/GMT',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'GMT', abbrSummer: 'GMT',
    terms: ['gmt', 'greenwich', 'mean time', 'mittlere greenwich-zeit'],
  ),

  // ── Europe ───────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Europe/London',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'BST',
    terms: ['london', 'uk', 'united kingdom', 'großbritannien', 'england',
      'britain', 'bst', 'british summer time', 'british standard time'],
  ),
  TzEntry(
    ianaZone: 'Europe/Dublin',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'IST',
    terms: ['dublin', 'ireland', 'irland', 'ist', 'irish standard time'],
  ),
  TzEntry(
    ianaZone: 'Europe/Lisbon',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: ['lisbon', 'lissabon', 'portugal', 'wet', 'west',
      'western european', 'westeuropäisch'],
  ),
  TzEntry(
    ianaZone: 'Europe/Berlin',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['berlin', 'germany', 'deutschland', 'cet', 'cest', 'mez', 'mesz',
      'met', 'central european', 'mitteleuropäisch', 'mitteleuropäische',
      'central europe time', 'mitteleuropäische zeit',
      'mitteleuropäische sommerzeit', 'central european summer time'],
  ),
  TzEntry(
    ianaZone: 'Europe/Vienna',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['vienna', 'wien', 'austria', 'österreich', 'cet', 'cest',
      'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Zurich',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['zurich', 'zürich', 'switzerland', 'schweiz', 'suisse',
      'svizzera', 'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Paris',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['paris', 'france', 'frankreich', 'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Brussels',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['brussels', 'brüssel', 'belgium', 'belgien', 'bruxelles',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Amsterdam',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['amsterdam', 'netherlands', 'niederlande', 'holland',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Madrid',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['madrid', 'spain', 'spanien', 'espana', 'españa',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Rome',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['rome', 'rom', 'italy', 'italien', 'italia',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Prague',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['prague', 'prag', 'czech', 'tschechien', 'czechia',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Warsaw',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['warsaw', 'warschau', 'poland', 'polen', 'polska',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Budapest',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['budapest', 'hungary', 'ungarn', 'magyarország',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Stockholm',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['stockholm', 'sweden', 'schweden', 'sverige',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Oslo',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['oslo', 'norway', 'norwegen', 'norge',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Copenhagen',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['copenhagen', 'kopenhagen', 'denmark', 'dänemark', 'danmark',
      'cet', 'cest', 'mez', 'mesz'],
  ),
  TzEntry(
    ianaZone: 'Europe/Helsinki',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: ['helsinki', 'finland', 'finnland', 'suomi', 'eet', 'eest',
      'oz', 'oesz', 'eastern european', 'osteuropäisch'],
  ),
  TzEntry(
    ianaZone: 'Europe/Athens',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: ['athens', 'athen', 'greece', 'griechenland', 'eet', 'eest'],
  ),
  TzEntry(
    ianaZone: 'Europe/Bucharest',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: ['bucharest', 'bukarest', 'romania', 'rumänien', 'eet', 'eest'],
  ),
  TzEntry(
    ianaZone: 'Europe/Kiev',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: ['kiev', 'kyiv', 'kiew', 'ukraine', 'eet', 'eest'],
  ),
  TzEntry(
    ianaZone: 'Europe/Istanbul',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'TRT', abbrSummer: 'TRT',
    terms: ['istanbul', 'turkey', 'türkei', 'türkiye', 'ankara', 'trt',
      'turkey time', 'türkische zeit'],
  ),
  TzEntry(
    ianaZone: 'Europe/Moscow',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'MSK', abbrSummer: 'MSK',
    terms: ['moscow', 'moskau', 'russia', 'russland', 'msk',
      'moscow time', 'moskauer zeit'],
  ),

  // ── Africa ───────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Africa/Casablanca',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WET',
    terms: ['casablanca', 'morocco', 'marokko', 'maroc'],
  ),
  TzEntry(
    ianaZone: 'Africa/Cairo',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'EET', abbrSummer: 'EET',
    terms: ['cairo', 'kairo', 'egypt', 'ägypten', 'misr'],
  ),
  TzEntry(
    ianaZone: 'Africa/Johannesburg',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'SAST', abbrSummer: 'SAST',
    terms: ['johannesburg', 'south africa', 'südafrika', 'sast',
      'south africa standard time'],
  ),
  TzEntry(
    ianaZone: 'Africa/Nairobi',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'EAT', abbrSummer: 'EAT',
    terms: ['nairobi', 'kenya', 'kenia', 'eat',
      'east africa time', 'ostafrikanische zeit'],
  ),
  TzEntry(
    ianaZone: 'Africa/Lagos',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WAT', abbrSummer: 'WAT',
    terms: ['lagos', 'nigeria', 'wat', 'west africa time',
      'westafrikanische zeit'],
  ),
  TzEntry(
    ianaZone: 'Africa/Abidjan',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'GMT', abbrSummer: 'GMT',
    terms: ['abidjan', 'ivory coast', 'elfenbeinküste', 'cote divoire'],
  ),
  TzEntry(
    ianaZone: 'Africa/Tunis',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'CET', abbrSummer: 'CET',
    terms: ['tunis', 'tunisia', 'tunesien'],
  ),

  // ── Americas ─────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'America/New_York',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: ['new york', 'est', 'edt', 'eastern', 'ostküste usa',
      'eastern standard time', 'eastern daylight time',
      'östliche normalzeit', 'östliche sommerzeit',
      'washington', 'boston', 'miami', 'atlanta'],
  ),
  TzEntry(
    ianaZone: 'America/Chicago',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: ['chicago', 'cst', 'cdt', 'central', 'central standard time',
      'central daylight time'],
  ),
  TzEntry(
    ianaZone: 'America/Denver',
    offsetWinter: '-07:00', offsetSummer: '-06:00',
    abbrWinter: 'MST', abbrSummer: 'MDT',
    terms: ['denver', 'mst', 'mdt', 'mountain', 'mountain standard time',
      'mountain daylight time'],
  ),
  TzEntry(
    ianaZone: 'America/Los_Angeles',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: ['los angeles', 'pst', 'pdt', 'pacific', 'westküste usa',
      'pacific standard time', 'pacific daylight time',
      'san francisco', 'seattle', 'las vegas'],
  ),
  TzEntry(
    ianaZone: 'America/Anchorage',
    offsetWinter: '-09:00', offsetSummer: '-08:00',
    abbrWinter: 'AKST', abbrSummer: 'AKDT',
    terms: ['anchorage', 'alaska', 'akst', 'akdt'],
  ),
  TzEntry(
    ianaZone: 'America/Toronto',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: ['toronto', 'canada', 'kanada', 'ontario', 'est', 'edt'],
  ),
  TzEntry(
    ianaZone: 'America/Vancouver',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: ['vancouver', 'british columbia', 'canada', 'kanada',
      'pst', 'pdt'],
  ),
  TzEntry(
    ianaZone: 'America/Halifax',
    offsetWinter: '-04:00', offsetSummer: '-03:00',
    abbrWinter: 'AST', abbrSummer: 'ADT',
    terms: ['halifax', 'nova scotia', 'ast', 'adt', 'atlantic',
      'atlantic standard time'],
  ),
  TzEntry(
    ianaZone: 'America/St_Johns',
    offsetWinter: '-03:30', offsetSummer: '-02:30',
    abbrWinter: 'NST', abbrSummer: 'NDT',
    terms: ['st johns', 'newfoundland', 'neufundland', 'nst', 'ndt'],
  ),
  TzEntry(
    ianaZone: 'America/Mexico_City',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: ['mexico city', 'mexiko', 'mexico', 'cst', 'cdt'],
  ),
  TzEntry(
    ianaZone: 'America/Bogota',
    offsetWinter: '-05:00', offsetSummer: '-05:00',
    abbrWinter: 'COT', abbrSummer: 'COT',
    terms: ['bogota', 'colombia', 'kolumbien', 'cot'],
  ),
  TzEntry(
    ianaZone: 'America/Sao_Paulo',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: 'BRT', abbrSummer: 'BRT',
    terms: ['sao paulo', 'são paulo', 'brazil', 'brasilien', 'brasil',
      'brt', 'brasilia time'],
  ),
  TzEntry(
    ianaZone: 'America/Argentina/Buenos_Aires',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: 'ART', abbrSummer: 'ART',
    terms: ['buenos aires', 'argentina', 'argentinien', 'art'],
  ),

  // ── Asia ─────────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Asia/Dubai',
    offsetWinter: '+04:00', offsetSummer: '+04:00',
    abbrWinter: 'GST', abbrSummer: 'GST',
    terms: ['dubai', 'uae', 'vae', 'united arab emirates',
      'vereinigte arabische emirate', 'abu dhabi', 'gst',
      'gulf standard time'],
  ),
  TzEntry(
    ianaZone: 'Asia/Tehran',
    offsetWinter: '+03:30', offsetSummer: '+04:30',
    abbrWinter: 'IRST', abbrSummer: 'IRDT',
    terms: ['tehran', 'teheran', 'iran', 'irst', 'irdt',
      'iran standard time'],
  ),
  TzEntry(
    ianaZone: 'Asia/Karachi',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: 'PKT', abbrSummer: 'PKT',
    terms: ['karachi', 'pakistan', 'pkt', 'pakistan standard time'],
  ),
  TzEntry(
    ianaZone: 'Asia/Kolkata',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: 'IST', abbrSummer: 'IST',
    terms: ['kolkata', 'calcutta', 'india', 'indien', 'ist', 'mumbai',
      'delhi', 'new delhi', 'india standard time', 'indische zeit'],
  ),
  TzEntry(
    ianaZone: 'Asia/Colombo',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: 'IST', abbrSummer: 'IST',
    terms: ['colombo', 'sri lanka', 'ist', 'slst'],
  ),
  TzEntry(
    ianaZone: 'Asia/Kathmandu',
    offsetWinter: '+05:45', offsetSummer: '+05:45',
    abbrWinter: 'NPT', abbrSummer: 'NPT',
    terms: ['kathmandu', 'nepal', 'npt', 'nepal time'],
  ),
  TzEntry(
    ianaZone: 'Asia/Dhaka',
    offsetWinter: '+06:00', offsetSummer: '+06:00',
    abbrWinter: 'BST', abbrSummer: 'BST',
    terms: ['dhaka', 'bangladesh', 'bst', 'bdt'],
  ),
  TzEntry(
    ianaZone: 'Asia/Yangon',
    offsetWinter: '+06:30', offsetSummer: '+06:30',
    abbrWinter: 'MMT', abbrSummer: 'MMT',
    terms: ['yangon', 'rangoon', 'myanmar', 'burma', 'mmt'],
  ),
  TzEntry(
    ianaZone: 'Asia/Bangkok',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: 'ICT', abbrSummer: 'ICT',
    terms: ['bangkok', 'thailand', 'ict', 'indochina time',
      'jakarta', 'indonesia', 'indonesien', 'hanoi', 'vietnam'],
  ),
  TzEntry(
    ianaZone: 'Asia/Jakarta',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: 'WIB', abbrSummer: 'WIB',
    terms: ['jakarta', 'indonesia', 'indonesien', 'wib'],
  ),
  TzEntry(
    ianaZone: 'Asia/Shanghai',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: ['shanghai', 'china', 'cst', 'beijing', 'peking',
      'china standard time', 'chinesische standardzeit'],
  ),
  TzEntry(
    ianaZone: 'Asia/Hong_Kong',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'HKT', abbrSummer: 'HKT',
    terms: ['hong kong', 'hongkong', 'hkt'],
  ),
  TzEntry(
    ianaZone: 'Asia/Singapore',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'SGT', abbrSummer: 'SGT',
    terms: ['singapore', 'singapur', 'sgt', 'singapore time'],
  ),
  TzEntry(
    ianaZone: 'Asia/Kuala_Lumpur',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'MYT', abbrSummer: 'MYT',
    terms: ['kuala lumpur', 'malaysia', 'myt'],
  ),
  TzEntry(
    ianaZone: 'Asia/Taipei',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: ['taipei', 'taiwan', 'cst'],
  ),
  TzEntry(
    ianaZone: 'Asia/Manila',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'PST', abbrSummer: 'PST',
    terms: ['manila', 'philippines', 'philippinen', 'pst'],
  ),
  TzEntry(
    ianaZone: 'Asia/Seoul',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'KST', abbrSummer: 'KST',
    terms: ['seoul', 'korea', 'south korea', 'südkorea', 'kst',
      'korea standard time'],
  ),
  TzEntry(
    ianaZone: 'Asia/Tokyo',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'JST', abbrSummer: 'JST',
    terms: ['tokyo', 'tokio', 'japan', 'jst', 'japan standard time',
      'japanische standardzeit'],
  ),
  TzEntry(
    ianaZone: 'Asia/Baghdad',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'AST', abbrSummer: 'AST',
    terms: ['baghdad', 'bagdad', 'iraq', 'irak', 'ast'],
  ),

  // ── Australia / Pacific ──────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Australia/Perth',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'AWST', abbrSummer: 'AWST',
    terms: ['perth', 'western australia', 'westaustralien', 'awst'],
  ),
  TzEntry(
    ianaZone: 'Australia/Darwin',
    offsetWinter: '+09:30', offsetSummer: '+09:30',
    abbrWinter: 'ACST', abbrSummer: 'ACST',
    terms: ['darwin', 'northern territory', 'acst'],
  ),
  TzEntry(
    ianaZone: 'Australia/Brisbane',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'AEST', abbrSummer: 'AEST',
    terms: ['brisbane', 'queensland', 'aest'],
  ),
  TzEntry(
    ianaZone: 'Australia/Adelaide',
    offsetWinter: '+09:30', offsetSummer: '+10:30',
    abbrWinter: 'ACST', abbrSummer: 'ACDT',
    terms: ['adelaide', 'south australia', 'südaustralien', 'acst', 'acdt'],
  ),
  TzEntry(
    ianaZone: 'Australia/Sydney',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: ['sydney', 'new south wales', 'australia', 'australien',
      'aest', 'aedt', 'melbourne', 'victoria'],
  ),
  TzEntry(
    ianaZone: 'Australia/Lord_Howe',
    offsetWinter: '+10:30', offsetSummer: '+11:00',
    abbrWinter: 'LHST', abbrSummer: 'LHDT',
    terms: ['lord howe', 'lhst', 'lhdt'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Auckland',
    offsetWinter: '+12:00', offsetSummer: '+13:00',
    abbrWinter: 'NZST', abbrSummer: 'NZDT',
    terms: ['auckland', 'new zealand', 'neuseeland', 'nzst', 'nzdt'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Honolulu',
    offsetWinter: '-10:00', offsetSummer: '-10:00',
    abbrWinter: 'HST', abbrSummer: 'HST',
    terms: ['honolulu', 'hawaii', 'hst', 'hawaii standard time'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Fiji',
    offsetWinter: '+12:00', offsetSummer: '+13:00',
    abbrWinter: 'FJT', abbrSummer: 'FJST',
    terms: ['fiji', 'fidschi', 'fjt', 'fjst'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Guam',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'ChST', abbrSummer: 'ChST',
    terms: ['guam', 'chst', 'chamorro'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Tongatapu',
    offsetWinter: '+13:00', offsetSummer: '+13:00',
    abbrWinter: 'TOT', abbrSummer: 'TOT',
    terms: ['tongatapu', 'tonga', 'tot'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Tahiti',
    offsetWinter: '-10:00', offsetSummer: '-10:00',
    abbrWinter: 'TAHT', abbrSummer: 'TAHT',
    terms: ['tahiti', 'french polynesia', 'französisch-polynesien', 'taht'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Marquesas',
    offsetWinter: '-09:30', offsetSummer: '-09:30',
    abbrWinter: 'MART', abbrSummer: 'MART',
    terms: ['marquesas', 'mart'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Midway',
    offsetWinter: '-11:00', offsetSummer: '-11:00',
    abbrWinter: 'SST', abbrSummer: 'SST',
    terms: ['midway', 'samoa', 'sst'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Norfolk',
    offsetWinter: '+11:00', offsetSummer: '+12:00',
    abbrWinter: 'NFT', abbrSummer: 'NFDT',
    terms: ['norfolk', 'nft', 'nfdt'],
  ),
  TzEntry(
    ianaZone: 'Pacific/Port_Moresby',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'PGT', abbrSummer: 'PGT',
    terms: ['port moresby', 'papua', 'new guinea', 'neuguinea', 'pgt'],
  ),

  // ── Atlantic / Arctic ────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Atlantic/Azores',
    offsetWinter: '-01:00', offsetSummer: '+00:00',
    abbrWinter: 'AZOT', abbrSummer: 'AZOST',
    terms: ['azores', 'azoren', 'azot', 'azost'],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Cape_Verde',
    offsetWinter: '-01:00', offsetSummer: '-01:00',
    abbrWinter: 'CVT', abbrSummer: 'CVT',
    terms: ['cape verde', 'kap verde', 'cabo verde', 'cvt'],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Reykjavik',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'GMT', abbrSummer: 'GMT',
    terms: ['reykjavik', 'iceland', 'island', 'gmt'],
  ),
  TzEntry(
    ianaZone: 'Atlantic/South_Georgia',
    offsetWinter: '-02:00', offsetSummer: '-02:00',
    abbrWinter: 'GST', abbrSummer: 'GST',
    terms: ['south georgia', 'südgeorgien', 'gst'],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Canary',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: ['canary', 'kanaren', 'tenerife', 'gran canaria', 'wet', 'west'],
  ),
  TzEntry(
    ianaZone: 'Arctic/Longyearbyen',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: ['longyearbyen', 'svalbard', 'spitsbergen', 'cet', 'cest'],
  ),

  // ── Antarctica ───────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Antarctica/McMurdo',
    offsetWinter: '+12:00', offsetSummer: '+13:00',
    abbrWinter: 'NZST', abbrSummer: 'NZDT',
    terms: ['mcmurdo', 'antarctica', 'antarktis', 'south pole', 'südpol'],
  ),
  TzEntry(
    ianaZone: 'Antarctica/Troll',
    offsetWinter: '+00:00', offsetSummer: '+02:00',
    abbrWinter: 'UTC', abbrSummer: 'CEST',
    terms: ['troll', 'antarctica', 'antarktis', 'norway', 'norwegen'],
  ),
];