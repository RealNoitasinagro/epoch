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
    ianaZone: 'Africa/Abidjan',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'GMT', abbrSummer: 'GMT',
    terms: [...tGMT,
      ...['ivory coast', "côte d'ivoire", 'iceland', 'reykjavik', 'reykjavík'],
      ...['elfenbeinküste', 'island'],
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Cairo',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'EET', abbrSummer: 'EET',
    terms: [...tEET_EEST,
      ...['egypt', 'misr'],
      ...['ägypten', 'kairo'],
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Casablanca',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WET',
    terms: [...tWET_WEST,
      ...['morocco', 'maroc', 'rabat'],
      ...['marokko'],
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Johannesburg',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'SAST', abbrSummer: 'SAST',
    terms: [
      ...['south africa standard time', 'cape town'],
      ...['südafrikanische standardzeit', 'kapstadt'],
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Lagos',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WAT', abbrSummer: 'WAT',
    terms: [
      ...['west africa time', 'nigeria', 'abuja'],
      ...['westafrikanische zeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Nairobi',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'EAT', abbrSummer: 'EAT',
    terms: [
      ...['east africa time', 'kenya'],
      ...['ostafrikanische zeit', 'kenia'],
    ],
  ),

  TzEntry(
    ianaZone: 'Africa/Tunis',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'CET', abbrSummer: 'CET',
    terms: [...tCET_CEST,
      ...['tunisia'],
      ...['tunesien'],
    ],
  ),
];

// ── Americas ─────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Americas = [
  TzEntry(
    ianaZone: 'America/New_York',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: [...tEST_EDT,
      'new york', 'usa east', 'ostküste usa',
      'washington', 'boston', 'miami', 'atlanta', 'philadelphia',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Chicago',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: [...tCST_CDT,
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
    terms: [...tPST_PDT,
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
    terms: [...tEST_EDT,
      'toronto', 'ontario', 'canada east', 'kanada ost',
      'ottawa', 'montreal',
    ],
  ),
  TzEntry(
    ianaZone: 'America/Vancouver',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [...tPST_PDT,
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
    terms: [...tCST_CDT,
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
    ianaZone: 'Antarctica/Palmer',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: 'CLT', abbrSummer: 'CLT',
    terms: [
      ...['antarctica', 'chile', 'magallanes and chilean antarctica'],
      ...['antarktis'],
    ],
  ),
  TzEntry(
    ianaZone: 'Antarctica/Troll',
    offsetWinter: '+00:00', offsetSummer: '+02:00',
    abbrWinter: 'GMT', abbrSummer: 'CEST',
    terms: [...tGMT, ...tCET_CEST,
      ...['antarctica', 'norway'],
      ...['antarktis', 'norwegen'],
    ],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Azores',
    offsetWinter: '-01:00', offsetSummer: '+00:00',
    abbrWinter: 'AZOT', abbrSummer: 'AZOST',
    terms: [
      ...['azores standard time', 'azores summer time', 'azores daysaving time', 'azodt'],
      ...['azoren-normalzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Canary',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: [...tWET_WEST,
      ...['fuerteventura', 'gran canaria', 'lanzarote', 'tenerife'],
      ...['kanaren', 'teneriffa'],
    ],
  ),
  TzEntry(
    ianaZone: 'Atlantic/Cape_Verde',
    offsetWinter: '-01:00', offsetSummer: '-01:00',
    abbrWinter: 'CVT', abbrSummer: 'CVT',
    terms: [
      ...['cape verde time', 'cabo verde', 'praia'],
      ...['kap verde'],
    ],
  ),
  TzEntry(
    ianaZone: 'Atlantic/South_Georgia',
    offsetWinter: '-02:00', offsetSummer: '-02:00',
    abbrWinter: 'GST', abbrSummer: 'GST',
    terms: [
      ...['south georgia time'],
      ...['südgeorgien'],
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
    terms: [...tAEST_AEDT,
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
    terms: [...tAEST_AEDT,
      'sydney', 'new south wales', 'australia', 'australien',
      'melbourne', 'victoria', 'canberra',
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Hobart',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: [...tAEST_AEDT,
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
    ianaZone: 'Europe/Athens',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['greece', 'hellas'],
      ...['griechenland', 'athen'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Berlin',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
       ...['germany', 'hamburg', 'cologne', 'munich', 'frankfurt', 'düsseldorf',
        'denmark', 'danmark', 'copenhagen'
        'norway', 'norge', 'oslo', 'bergen', 'longyearbyen', 'spitsbergen', 'svalbard'
        'sweden', 'sverige', 'stockholm', 'gothenburg'],
      ...['deutschland', 'köln', 'münchen',
        'dänemark', 'kopenhagen',
        'norwegen', 'spitzbergen',
        'schweden', 'göteborg'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Brussels',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['belgium', 'belgique', 'bruxelles',
        'netherlands', 'holland', 'amsterdam', 'rotterdam'],
      ...['belgien', 'brüssel',
        'niederlande'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Bucharest',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['romania', 'bucharest'],
      ...['rumänien', 'bukarest'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Budapest',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['hungary', 'magyarország'],
      ...['ungarn'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Dublin',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'IST',
    terms: [...tGMT,
      ...['irish standard time', 'ireland'],
      ...['irland'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Helsinki',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['finland', 'suomi'],
      ...['finnland'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Istanbul',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'TRT', abbrSummer: 'TRT',
    terms: [
      ...['turkey time', 'türkiye', 'ankara'],
      ...['türkische zeit', 'türkei'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Kyiv',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['ukraine', 'kiev'],
      ...['kiew'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Lisbon',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: [...tWET_WEST,
      ...['portugal'],
      ...['lissabon'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/London',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'BST',
    terms: [...tGMT,
      ...['british standard time', 'british summer time', 'great britain',
        'united kingdom', 'uk', 'england', 'scotland', 'wales'],
      ...['großbritannien', 'vereinigtes königreich', 'schottland'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Madrid',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['spain', 'españa', 'espana', 'barcelona', 'seville'],
      ...['spanien', 'sevilla'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Moscow',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'MSK', abbrSummer: 'MSK',
    terms: [
      ...['moscow time', 'russia', 'saint petersberg', 'st petersburg'],
      ...['moskauer zeit', 'russland', 'moskau', 'sankt petersburg'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Paris',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['france', 'lyon', 'marseille'],
      ...['frankreich'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Prague',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [
      ...['czechia'],
      ...['tschechien', 'prag'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Rome',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['italy', 'italia', 'mailand', 'milan', 'milano', 'naples'],
      ...['italien', 'rom', 'neapel'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Vienna',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['austria'],
      ...['österreich', 'wien'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Warsaw',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [
      ...['poland', 'polska'],
      ...['polen', 'warschau'],
    ],
  ),
  TzEntry(
    ianaZone: 'Europe/Zurich',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['switzerland', 'suisse', 'svizzera', 'bern' 'geneva', 'genève'],
      ...['schweiz', 'zürich', 'genf'],
    ],
  ),
];
