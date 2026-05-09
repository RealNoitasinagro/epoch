// Curated timezone database with multilingual search terms.
// Shared term sets avoid redundancy across entries with the same offset/zone.

// ── Shared term sets by zone group ───────────────────────────────────────────

const _tUtc = [
  'utc', 'universal', 'coordinated', 'koordiniert',
  'universal coordinated', 'koordinierte weltzeit', 'weltzeit',
];

const _tGmt = [
  'gmt', 'greenwich', 'mean time', 'mittlere greenwich-zeit',
];

const _tCet = [
  'cet', 'cest', 'mez', 'mesz', 'met',
  'central european', 'mitteleuropäisch', 'mitteleuropäische',
  'central european time', 'central european summer time',
  'mitteleuropäische zeit', 'mitteleuropäische sommerzeit',
];

const _tEet = [
  'eet', 'eest', 'oz', 'oesz',
  'eastern european', 'osteuropäisch',
  'eastern european time', 'eastern european summer time',
  'osteuropäische zeit', 'osteuropäische sommerzeit',
];

const _tWet = [
  'wet', 'west',
  'western european', 'westeuropäisch',
  'western european time', 'western european summer time',
  'westeuropäische zeit', 'westeuropäische sommerzeit',
];

const _tEst = [
  'est', 'edt',
  'eastern', 'eastern standard time', 'eastern daylight time',
  'östliche normalzeit', 'östliche sommerzeit',
];

const _tCst = [
  'cst', 'cdt',
  'central', 'central standard time', 'central daylight time',
  'zentrale normalzeit', 'zentrale sommerzeit',
];

const _tMst = [
  'mst', 'mdt',
  'mountain', 'mountain standard time', 'mountain daylight time',
  'bergzeit', 'mountain-normalzeit',
];

const _tPst = [
  'pst', 'pdt',
  'pacific', 'pacific standard time', 'pacific daylight time',
  'pazifische normalzeit', 'pazifische sommerzeit',
];

const _tAest = [
  'aest', 'aedt',
  'australian eastern', 'australische ostzeit',
  'australian eastern standard time', 'australian eastern daylight time',
];

const _tChinaStd = [
  'cst',
  'china standard time', 'chinesische standardzeit',
];

const _tIst = [
  'ist',
  'india standard time', 'indische standardzeit',
];

const _tJst = [
  'jst',
  'japan standard time', 'japanische standardzeit',
];

const _tKst = [
  'kst',
  'korea standard time', 'koreanische standardzeit',
];

const _tMsk = [
  'msk',
  'moscow time', 'moskauer zeit',
];

const _tSast = [
  'sast',
  'south africa standard time', 'südafrikanische standardzeit',
];

const _tEat = [
  'eat',
  'east africa time', 'ostafrikanische zeit',
];

const _tWat = [
  'wat',
  'west africa time', 'westafrikanische zeit',
];

const _tGst = [
  'gst',
  'gulf standard time', 'Golfzeit',
];

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
    if (ianaZone.toLowerCase().contains(q)) return true;
    if (offsetWinter.contains(q) || offsetSummer.contains(q)) return true;
    if (abbrWinter.toLowerCase().contains(q) ||
        abbrSummer.toLowerCase().contains(q)) return true;
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

// ── Database ──────────────────────────────────────────────────────────────────

const List<TzEntry> tzDatabase = [

  // ── Europe ───────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Europe/London',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'BST',
    terms: [..._tGmt,
      'bst', 'british summer time', 'british standard time',
      'london', 'uk', 'united kingdom', 'großbritannien', 'england',
      'britain', 'wales', 'scotland', 'schottland',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Dublin',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'IST',
    terms: [..._tGmt,
      'ist', 'irish standard time',
      'dublin', 'ireland', 'irland',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Lisbon',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: [..._tWet,
      'lisbon', 'lissabon', 'portugal',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Berlin',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'berlin', 'germany', 'deutschland', 'hamburg', 'munich', 'münchen',
      'frankfurt', 'cologne', 'köln', 'düsseldorf',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Vienna',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'vienna', 'wien', 'austria', 'österreich',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Zurich',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'zurich', 'zürich', 'switzerland', 'schweiz', 'suisse', 'svizzera',
      'geneva', 'genf', 'genève', 'bern',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Paris',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'paris', 'france', 'frankreich', 'lyon', 'marseille',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Brussels',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'brussels', 'brüssel', 'bruxelles', 'belgium', 'belgien', 'belgique',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Amsterdam',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'amsterdam', 'netherlands', 'niederlande', 'holland', 'rotterdam',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Madrid',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'madrid', 'spain', 'spanien', 'españa', 'espana',
      'barcelona', 'seville', 'sevilla',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Rome',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'rome', 'rom', 'italy', 'italien', 'italia',
      'milan', 'mailand', 'milano', 'naples', 'neapel',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Prague',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'prague', 'prag', 'czech', 'tschechien', 'czechia', 'tschechische',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Warsaw',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'warsaw', 'warschau', 'poland', 'polen', 'polska',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Budapest',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'budapest', 'hungary', 'ungarn', 'magyarország',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Stockholm',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'stockholm', 'sweden', 'schweden', 'sverige',
      'gothenburg', 'göteborg',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Oslo',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'oslo', 'norway', 'norwegen', 'norge', 'bergen',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Copenhagen',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'copenhagen', 'kopenhagen', 'denmark', 'dänemark', 'danmark',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Helsinki',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [..._tEet,
      'helsinki', 'finland', 'finnland', 'suomi',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Athens',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [..._tEet,
      'athens', 'athen', 'greece', 'griechenland', 'hellas',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Bucharest',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [..._tEet,
      'bucharest', 'bukarest', 'romania', 'rumänien',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Kiev',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [..._tEet,
      'kiev', 'kyiv', 'kiew', 'ukraine',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Istanbul',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'TRT', abbrSummer: 'TRT',
    terms: [
      'trt', 'turkey time', 'türkische zeit',
      'istanbul', 'turkey', 'türkei', 'türkiye', 'ankara',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Moscow',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'MSK', abbrSummer: 'MSK',
    terms: [..._tMsk,
      'moscow', 'moskau', 'russia', 'russland', 'st petersburg',
    ],
  ),

  // ── Africa ───────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Africa/Casablanca',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WET',
    terms: [..._tWet,
      'casablanca', 'morocco', 'marokko', 'maroc', 'rabat',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Cairo',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'EET', abbrSummer: 'EET',
    terms: [..._tEet,
      'cairo', 'kairo', 'egypt', 'ägypten', 'misr',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Johannesburg',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'SAST', abbrSummer: 'SAST',
    terms: [..._tSast,
      'johannesburg', 'south africa', 'südafrika', 'cape town', 'kapstadt',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Nairobi',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'EAT', abbrSummer: 'EAT',
    terms: [..._tEat,
      'nairobi', 'kenya', 'kenia',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Lagos',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WAT', abbrSummer: 'WAT',
    terms: [..._tWat,
      'lagos', 'nigeria', 'abuja',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Abidjan',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'GMT', abbrSummer: 'GMT',
    terms: [..._tGmt,
      'abidjan', 'ivory coast', 'elfenbeinküste', 'cote divoire',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Tunis',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'CET', abbrSummer: 'CET',
    terms: [..._tCet,
      'tunis', 'tunisia', 'tunesien',
    ],
  ),

  // ── Americas ─────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'America/New_York',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: [..._tEst,
      'new york', 'usa east', 'ostküste usa',
      'washington', 'boston', 'miami', 'atlanta', 'philadelphia',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Chicago',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: [..._tCst,
      'chicago', 'houston', 'dallas', 'minneapolis',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Denver',
    offsetWinter: '-07:00', offsetSummer: '-06:00',
    abbrWinter: 'MST', abbrSummer: 'MDT',
    terms: [..._tMst,
      'denver', 'salt lake city', 'phoenix', 'colorado',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Los_Angeles',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [..._tPst,
      'los angeles', 'westküste usa', 'usa west',
      'san francisco', 'seattle', 'las vegas', 'portland',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Anchorage',
    offsetWinter: '-09:00', offsetSummer: '-08:00',
    abbrWinter: 'AKST', abbrSummer: 'AKDT',
    terms: [
      'akst', 'akdt', 'alaska time', 'alaskazeit',
      'anchorage', 'alaska', 'fairbanks',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Toronto',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: [..._tEst,
      'toronto', 'ontario', 'canada east', 'kanada ost',
      'ottawa', 'montreal',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Vancouver',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [..._tPst,
      'vancouver', 'british columbia', 'canada west', 'kanada west',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Halifax',
    offsetWinter: '-04:00', offsetSummer: '-03:00',
    abbrWinter: 'AST', abbrSummer: 'ADT',
    terms: [
      'ast', 'adt', 'atlantic standard time', 'atlantic daylight time',
      'atlantische normalzeit',
      'halifax', 'nova scotia', 'new brunswick', 'neubraunschweig',
    ],
  ),
  TzEntry(
    ianaZone: 'America/St_Johns',
    offsetWinter: '-03:30', offsetSummer: '-02:30',
    abbrWinter: 'NST', abbrSummer: 'NDT',
    terms: [
      'nst', 'ndt', 'newfoundland standard time', 'newfoundland time',
      'st johns', 'saint johns', 'newfoundland', 'neufundland',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Mexico_City',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: [..._tCst,
      'mexico city', 'mexiko', 'mexico', 'guadalajara',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Bogota',
    offsetWinter: '-05:00', offsetSummer: '-05:00',
    abbrWinter: 'COT', abbrSummer: 'COT',
    terms: [
      'cot', 'colombia time', 'kolumbianische zeit',
      'bogota', 'colombia', 'kolumbien',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Sao_Paulo',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: 'BRT', abbrSummer: 'BRT',
    terms: [
      'brt', 'brasilia time', 'brasilianische zeit',
      'sao paulo', 'são paulo', 'brazil', 'brasilien', 'brasil',
      'rio de janeiro', 'brasilia', 'brasília',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Argentina/Buenos_Aires',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: 'ART', abbrSummer: 'ART',
    terms: [
      'art', 'argentina time', 'argentinische zeit',
      'buenos aires', 'argentina', 'argentinien',
    ],
  ),

  // ── Asia ─────────────────────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Asia/Dubai',
    offsetWinter: '+04:00', offsetSummer: '+04:00',
    abbrWinter: 'GST', abbrSummer: 'GST',
    terms: [..._tGst,
      'dubai', 'uae', 'vae', 'united arab emirates',
      'vereinigte arabische emirate', 'abu dhabi', 'sharjah',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Tehran',
    offsetWinter: '+03:30', offsetSummer: '+04:30',
    abbrWinter: 'IRST', abbrSummer: 'IRDT',
    terms: [
      'irst', 'irdt', 'iran standard time', 'iran daylight time',
      'iranische zeit',
      'tehran', 'teheran', 'iran',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Karachi',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: 'PKT', abbrSummer: 'PKT',
    terms: [
      'pkt', 'pakistan standard time', 'pakistanische zeit',
      'karachi', 'pakistan', 'lahore', 'islamabad',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Kolkata',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: 'IST', abbrSummer: 'IST',
    terms: [..._tIst,
      'kolkata', 'calcutta', 'india', 'indien',
      'mumbai', 'bombay', 'delhi', 'new delhi', 'bangalore', 'chennai',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Colombo',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: 'IST', abbrSummer: 'IST',
    terms: [..._tIst,
      'slst', 'sri lanka standard time',
      'colombo', 'sri lanka',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Kathmandu',
    offsetWinter: '+05:45', offsetSummer: '+05:45',
    abbrWinter: 'NPT', abbrSummer: 'NPT',
    terms: [
      'npt', 'nepal time', 'nepalesische zeit',
      'kathmandu', 'nepal',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Dhaka',
    offsetWinter: '+06:00', offsetSummer: '+06:00',
    abbrWinter: 'BST', abbrSummer: 'BST',
    terms: [
      'bst', 'bdt', 'bangladesh standard time',
      'dhaka', 'bangladesh',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Yangon',
    offsetWinter: '+06:30', offsetSummer: '+06:30',
    abbrWinter: 'MMT', abbrSummer: 'MMT',
    terms: [
      'mmt', 'myanmar time', 'birmanische zeit',
      'yangon', 'rangoon', 'myanmar', 'burma',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Bangkok',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: 'ICT', abbrSummer: 'ICT',
    terms: [
      'ict', 'indochina time', 'indochinazeit',
      'bangkok', 'thailand', 'hanoi', 'vietnam', 'phnom penh', 'cambodia',
      'kambodscha',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Jakarta',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: 'WIB', abbrSummer: 'WIB',
    terms: [
      'wib', 'western indonesian time', 'westindonesische zeit',
      'jakarta', 'indonesia', 'indonesien',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Shanghai',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: [..._tChinaStd,
      'shanghai', 'china', 'beijing', 'peking', 'shenzhen', 'guangzhou',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Hong_Kong',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'HKT', abbrSummer: 'HKT',
    terms: [
      'hkt', 'hong kong time',
      'hong kong', 'hongkong',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Singapore',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'SGT', abbrSummer: 'SGT',
    terms: [
      'sgt', 'singapore time',
      'singapore', 'singapur',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Kuala_Lumpur',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'MYT', abbrSummer: 'MYT',
    terms: [
      'myt', 'malaysia time',
      'kuala lumpur', 'malaysia',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Taipei',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: [..._tChinaStd,
      'taipei', 'taiwan',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Manila',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'PST', abbrSummer: 'PST',
    terms: [
      'pst', 'philippine standard time', 'philippinische zeit',
      'manila', 'philippines', 'philippinen',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Seoul',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'KST', abbrSummer: 'KST',
    terms: [..._tKst,
      'seoul', 'korea', 'south korea', 'südkorea', 'busan',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Tokyo',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'JST', abbrSummer: 'JST',
    terms: [..._tJst,
      'tokyo', 'tokio', 'japan', 'osaka', 'kyoto',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Baghdad',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'AST', abbrSummer: 'AST',
    terms: [
      'ast', 'arabia standard time', 'arabische standardzeit',
      'baghdad', 'bagdad', 'iraq', 'irak',
    ],
  ),

  // ── Australia / Pacific ──────────────────────────────────────────────
  TzEntry(
    ianaZone: 'Australia/Perth',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'AWST', abbrSummer: 'AWST',
    terms: [
      'awst', 'australian western standard time', 'australische westzeit',
      'perth', 'western australia', 'westaustralien',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Darwin',
    offsetWinter: '+09:30', offsetSummer: '+09:30',
    abbrWinter: 'ACST', abbrSummer: 'ACST',
    terms: [
      'acst', 'australian central standard time',
      'darwin', 'northern territory',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Brisbane',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'AEST', abbrSummer: 'AEST',
    terms: [..._tAest,
      'brisbane', 'queensland',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Adelaide',
    offsetWinter: '+09:30', offsetSummer: '+10:30',
    abbrWinter: 'ACST', abbrSummer: 'ACDT',
    terms: [
      'acst', 'acdt', 'australian central time',
      'adelaide', 'south australia', 'südaustralien',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Sydney',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: [..._tAest,
      'sydney', 'new south wales', 'australia', 'australien',
      'melbourne', 'victoria', 'canberra',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Hobart',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: [..._tAest,
      'hobart', 'tasmania', 'tasmanien',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Lord_Howe',
    offsetWinter: '+10:30', offsetSummer: '+11:00',
    abbrWinter: 'LHST', abbrSummer: 'LHDT',
    terms: [
      'lhst', 'lhdt', 'lord howe time',
      'lord howe',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Auckland',
    offsetWinter: '+12:00', offsetSummer: '+13:00',
    abbrWinter: 'NZST', abbrSummer: 'NZDT',
    terms: [
      'nzst', 'nzdt', 'new zealand standard time',
      'auckland', 'new zealand', 'neuseeland', 'wellington',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Honolulu',
    offsetWinter: '-10:00', offsetSummer: '-10:00',
    abbrWinter: 'HST', abbrSummer: 'HST',
    terms: [
      'hst', 'hawaii standard time', 'hawaii-normalzeit',
      'honolulu', 'hawaii',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Fiji',
    offsetWinter: '+12:00', offsetSummer: '+13:00',
    abbrWinter: 'FJT', abbrSummer: 'FJST',
    terms: [
      'fjt', 'fjst', 'fiji time',
      'fiji', 'fidschi',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Guam',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'ChST', abbrSummer: 'ChST',
    terms: [
      'chst', 'chamorro standard time',
      'guam', 'saipan',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Tongatapu',
    offsetWinter: '+13:00', offsetSummer: '+13:00',
    abbrWinter: 'TOT', abbrSummer: 'TOT',
    terms: [
      'tot', 'tonga time',
      'tongatapu', 'tonga',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Tahiti',
    offsetWinter: '-10:00', offsetSummer: '-10:00',
    abbrWinter: 'TAHT', abbrSummer: 'TAHT',
    terms: [
      'taht', 'tahiti time',
      'tahiti', 'french polynesia', 'französisch-polynesien',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Marquesas',
    offsetWinter: '-09:30', offsetSummer: '-09:30',
    abbrWinter: 'MART', abbrSummer: 'MART',
    terms: [
      'mart', 'marquesas time',
      'marquesas',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Midway',
    offsetWinter: '-11:00', offsetSummer: '-11:00',
    abbrWinter: 'SST', abbrSummer: 'SST',
    terms: [
      'sst', 'samoa standard time',
      'midway', 'samoa', 'american samoa',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Norfolk',
    offsetWinter: '+11:00', offsetSummer: '+12:00',
    abbrWinter: 'NFT', abbrSummer: 'NFDT',
    terms: [
      'nft', 'nfdt', 'norfolk time',
      'norfolk',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Port_Moresby',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'PGT', abbrSummer: 'PGT',
    terms: [
      'pgt', 'papua new guinea time',
      'port moresby', 'papua', 'new guinea', 'neuguinea',
    ],
  ),

  // ── Atlantic / Arctic / Antarctica ───────────────────────────────────
  TzEntry(
    ianaZone: 'Atlantic/Azores',
    offsetWinter: '-01:00', offsetSummer: '+00:00',
    abbrWinter: 'AZOT', abbrSummer: 'AZOST',
    terms: [
      'azot', 'azost', 'azores time',
      'azores', 'azoren',
    ],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Cape_Verde',
    offsetWinter: '-01:00', offsetSummer: '-01:00',
    abbrWinter: 'CVT', abbrSummer: 'CVT',
    terms: [
      'cvt', 'cape verde time',
      'cape verde', 'kap verde', 'cabo verde',
    ],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Reykjavik',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'GMT', abbrSummer: 'GMT',
    terms: [..._tGmt,
      'reykjavik', 'iceland', 'island',
    ],
  ),
  TzEntry(
    ianaZone: 'Atlantic/South_Georgia',
    offsetWinter: '-02:00', offsetSummer: '-02:00',
    abbrWinter: 'GST', abbrSummer: 'GST',
    terms: [
      'gst', 'south georgia time',
      'south georgia', 'südgeorgien',
    ],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Canary',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: [..._tWet,
      'canary', 'kanaren', 'tenerife', 'teneriffa', 'gran canaria',
      'lanzarote', 'fuerteventura',
    ],
  ),
  TzEntry(
    ianaZone: 'Arctic/Longyearbyen',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [..._tCet,
      'longyearbyen', 'svalbard', 'spitsbergen', 'spitzbergen',
    ],
  ),
  TzEntry(
    ianaZone: 'Antarctica/McMurdo',
    offsetWinter: '+12:00', offsetSummer: '+13:00',
    abbrWinter: 'NZST', abbrSummer: 'NZDT',
    terms: [
      'nzst', 'nzdt',
      'mcmurdo', 'antarctica', 'antarktis', 'south pole', 'südpol',
    ],
  ),
  TzEntry(
    ianaZone: 'Antarctica/Troll',
    offsetWinter: '+00:00', offsetSummer: '+02:00',
    abbrWinter: 'UTC', abbrSummer: 'CEST',
    terms: [..._tUtc, ..._tCet,
      'troll', 'antarctica', 'antarktis', 'norway', 'norwegen',
    ],
  ),
  TzEntry(
    ianaZone: 'Antarctica/Palmer',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: 'CLT', abbrSummer: 'CLT',
    terms: [
      'clt', 'chile time',
      'palmer', 'antarctica', 'antarktis',
    ],
  ),
];