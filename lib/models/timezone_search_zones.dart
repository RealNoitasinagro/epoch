// ── Database ──────────────────────────────────────────────────────────────────

// For details, cf. https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/models/timezone_search_terms.dart';

const List<TzEntry> tzDatabase = [          // 84 entries in total
  ...tzEntries_Africa,                      //  7 entries
  ...tzEntries_Americas,                    // 13 entries
  ...tzEntries_Asia,                        // 18 entries
  ...tzEntries_Atlantic_Arctic_Antarctica,  //  6 entries
  ...tzEntries_Australia_Pacific,           // 21 entries
  ...tzEntries_Europe,                      // 19 entries
];

// ── Africa ───────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Africa = [
  TzEntry(
    ianaZone: 'Africa/Casablanca',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WET',
    terms: [...tWet,
      'casablanca', 'morocco', 'marokko', 'maroc', 'rabat',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Cairo',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'EET', abbrSummer: 'EET',
    terms: [...tEet,
      'cairo', 'kairo', 'egypt', 'ägypten', 'misr',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Johannesburg',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'SAST', abbrSummer: 'SAST',
    terms: [
      'johannesburg', 'south africa', 'südafrika', 'cape town', 'kapstadt',
      'sast',
      'south africa standard time', 'südafrikanische standardzeit',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Nairobi',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'EAT', abbrSummer: 'EAT',
    terms: [
      'nairobi', 'kenya', 'kenia',
      'eat',
      'east africa time', 'ostafrikanische zeit',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Lagos',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WAT', abbrSummer: 'WAT',
    terms: [
      'lagos', 'nigeria', 'abuja',
      'wat',
      'west africa time', 'westafrikanische zeit',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Abidjan',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'GMT', abbrSummer: 'GMT',
    terms: [...tGmt,
      'abidjan', 'ivory coast', 'elfenbeinküste', 'cote divoire',
      'reykjavik', 'iceland', 'island',
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Tunis',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'CET', abbrSummer: 'CET',
    terms: [...tCet,
      'tunis', 'tunisia', 'tunesien',
    ],
  ),
];

// ── Americas ─────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Americas = [
  TzEntry(
    ianaZone: 'America/New_York',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: [...tEst,
      'new york', 'usa east', 'ostküste usa',
      'washington', 'boston', 'miami', 'atlanta', 'philadelphia',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Chicago',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: [...tCst,
      'chicago', 'houston', 'dallas', 'minneapolis',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Denver',
    offsetWinter: '-07:00', offsetSummer: '-06:00',
    abbrWinter: 'MST', abbrSummer: 'MDT',
    terms: [
      'denver', 'salt lake city', 'phoenix', 'colorado',
      'mst', 'mdt',
      'mountain', 'mountain standard time', 'mountain daylight time',
      'bergzeit', 'mountain-normalzeit',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Los_Angeles',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [...tPst,
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
    terms: [...tEst,
      'toronto', 'ontario', 'canada east', 'kanada ost',
      'ottawa', 'montreal',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Vancouver',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [...tPst,
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
    terms: [...tCst,
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
];

// ── Asia ─────────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Asia = [
  TzEntry(
    ianaZone: 'Asia/Dubai',
    offsetWinter: '+04:00', offsetSummer: '+04:00',
    abbrWinter: 'GST', abbrSummer: 'GST',
    terms: [
      'dubai', 'uae', 'vae', 'united arab emirates',
      'vereinigte arabische emirate', 'abu dhabi', 'sharjah',
      'gst',
      'gulf standard time', 'Golfzeit',
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
    terms: [...tIst,
      'kolkata', 'calcutta', 'india', 'indien',
      'mumbai', 'bombay', 'delhi', 'new delhi', 'bangalore', 'chennai',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Colombo',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: 'IST', abbrSummer: 'IST',
    terms: [...tIst,
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
    terms: [...tChinaStd,
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
      'myt', 'malaysia time',
      'kuala lumpur', 'malaysia',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Taipei',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: [...tChinaStd,
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
    terms: [
      'seoul', 'korea', 'south korea', 'südkorea', 'busan',
      'kst',
      'korea standard time', 'koreanische standardzeit',
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Tokyo',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'JST', abbrSummer: 'JST',
    terms: [
      'tokyo', 'tokio', 'japan', 'osaka', 'kyoto',
      'jst',
      'japan standard time', 'japanische standardzeit',
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
];

// ── Atlantic / Arctic / Antarctica ───────────────────────────────────
const List<TzEntry> tzEntries_Atlantic_Arctic_Antarctica = [
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
    terms: [...tWet,
      'canary', 'kanaren', 'tenerife', 'teneriffa', 'gran canaria',
      'lanzarote', 'fuerteventura',
    ],
  ),
  TzEntry(
    ianaZone: 'Antarctica/Troll',
    offsetWinter: '+00:00', offsetSummer: '+02:00',
    abbrWinter: 'UTC', abbrSummer: 'CEST',
    terms: [...tUtc, ...tCet,
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

// ── Australia / Pacific ──────────────────────────────────────────────
const List<TzEntry> tzEntries_Australia_Pacific = [
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
    terms: [...tAest,
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
    terms: [...tAest,
      'sydney', 'new south wales', 'australia', 'australien',
      'melbourne', 'victoria', 'canberra',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Hobart',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: [...tAest,
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
      'mcmurdo', 'antarctica', 'antarktis', 'south pole', 'südpol',
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
    ianaZone: 'Pacific/Pago_Pago',  // was: Pacific/Midway
    offsetWinter: '-11:00', offsetSummer: '-11:00',
    abbrWinter: 'SST', abbrSummer: 'SST',
    terms: [
      'sst', 'samoa standard time',
      'midway', 'pago pago', 'samoa', 'american samoa',
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
  TzEntry(
    ianaZone: 'Anywhere on Earth',
    offsetWinter: '-12:00', offsetSummer: '-12:00',
    abbrWinter: 'AoE', abbrSummer: 'AoE',
    terms: [
      'baker island',
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Kiritimati',
    offsetWinter: '+14:00', offsetSummer: '+14:00',
    abbrWinter: 'LINT', abbrSummer: 'LINT',
    terms: [
      'line islands time', 'kiribati'
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Chatham',
    offsetWinter: '+12:45', offsetSummer: '+13:45',
    abbrWinter: 'CHAST', abbrSummer: 'CHADT',
    terms: [
      'chatham standard time', 'chatham daylight time',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Eucla',
    offsetWinter: '+08:45', offsetSummer: '+08:45',
    abbrWinter: 'CWT', abbrSummer: 'CWT',
    terms: [
      'central western time'
    ],
  ),
];

// ── Europe ───────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Europe = [
  TzEntry(
    ianaZone: 'Europe/London',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'BST',
    terms: [...tGmt,
      'bst', 'british summer time', 'british standard time',
      'london', 'uk', 'united kingdom', 'großbritannien', 'england',
      'britain', 'wales', 'scotland', 'schottland',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Dublin',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'IST',
    terms: [...tGmt,
      'ist', 'irish standard time',
      'dublin', 'ireland', 'irland',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Lisbon',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: [...tWet,
      'lisbon', 'lissabon', 'portugal',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Berlin',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'berlin', 'germany', 'deutschland', 'hamburg', 'munich', 'münchen',
      'frankfurt', 'cologne', 'köln', 'düsseldorf',
      'stockholm', 'sweden', 'schweden', 'sverige',
      'gothenburg', 'göteborg',
      'oslo', 'norway', 'norwegen', 'norge', 'bergen',
      'copenhagen', 'kopenhagen', 'denmark', 'dänemark', 'danmark',
      'longyearbyen', 'svalbard', 'spitsbergen', 'spitzbergen',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Vienna',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'vienna', 'wien', 'austria', 'österreich',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Zurich',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'zurich', 'zürich', 'switzerland', 'schweiz', 'suisse', 'svizzera',
      'geneva', 'genf', 'genève', 'bern',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Paris',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'paris', 'france', 'frankreich', 'lyon', 'marseille',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Brussels',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'brussels', 'brüssel', 'bruxelles', 'belgium', 'belgien', 'belgique',
      'amsterdam', 'netherlands', 'niederlande', 'holland', 'rotterdam',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Madrid',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'madrid', 'spain', 'spanien', 'españa', 'espana',
      'barcelona', 'seville', 'sevilla',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Rome',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'rome', 'rom', 'italy', 'italien', 'italia',
      'milan', 'mailand', 'milano', 'naples', 'neapel',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Prague',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'prague', 'prag', 'czech', 'tschechien', 'czechia', 'tschechische',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Warsaw',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'warsaw', 'warschau', 'poland', 'polen', 'polska',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Budapest',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCet,
      'budapest', 'hungary', 'ungarn', 'magyarország',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Helsinki',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEet,
      'helsinki', 'finland', 'finnland', 'suomi',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Athens',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEet,
      'athens', 'athen', 'greece', 'griechenland', 'hellas',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Bucharest',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEet,
      'bucharest', 'bukarest', 'romania', 'rumänien',
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Kyiv',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEet,
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
    terms: [
      'moscow', 'moskau', 'russia', 'russland', 'st petersburg',
      'moscow time', 'moskauer zeit',
    ],
  ),
];
