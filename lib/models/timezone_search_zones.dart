// ── Database ──────────────────────────────────────────────────────────────────

// For details, cf. https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

import 'package:epoch/models/timezone_search.dart';
import 'package:epoch/models/timezone_search_terms.dart';

const List<TzEntry> tzDatabase = [          // 88 entries in total
  ...tzEntries_Africa,                      //  8 entries
  ...tzEntries_Americas,                    // 14 entries
  ...tzEntries_Asia,                        // 20 entries
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
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['egypt', 'misr', 'alexandria'],
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
      ...['south african standard time', 'south africa standard time', 'cape town'],
      ...['südafrikanische zeit', 'kapstadt'],
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Lagos',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WAT', abbrSummer: 'WAT',
    terms: [
      ...['west africa time', 'nigeria', 'abuja', 'congo', 'kinshasa'],
      ...['westafrikanische zeit', 'kongo'],
    ],
  ),
  TzEntry(
    ianaZone: 'Africa/Maputo',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'CAT', abbrSummer: 'CAT',
    terms: [
      ...['central africa time', 'mozambique', 'nampula'],
      ...['zentralafrikanische zeit', 'mosambik'],
    ]
  ),
  TzEntry(
    ianaZone: 'Africa/Nairobi',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'EAT', abbrSummer: 'EAT',
    terms: [
      ...['eastern africa time', 'east africa time',
        'comoros', 'djibouti', 'eritrea', 'ethiopia', 'kenya', 'madagascar',
        'somalia', 'tanzania', 'uganda',
        'moroni', 'djibouti city', 'asmara', 'addis ababa', 'antananarivo',
        'mogadishu', 'dar es salaam', 'kampala'],
      ...['ostafrikanische zeit',
        'komoren', 'äthiopien', 'kenia', 'madagaskar', 'addis abeba', 'daressalam'],
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
    ianaZone: 'America/Anchorage',
    offsetWinter: '-09:00', offsetSummer: '-08:00',
    abbrWinter: 'AKST', abbrSummer: 'AKDT',
    terms: [
      ...['alaska time', 'alaska standard time', 'alaska daylight time',
        'alaska daylight saving time', 'anchorage', 'fairbanks'],
      ...['alaska-zeit', 'alaska-normalzeit', 'alaska-sommerzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Argentina/Buenos_Aires',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: 'ART', abbrSummer: 'ART',
    terms: [
      ...['argentina time'],
      ...['argentinische zeit', 'argentinien'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Bogota',
    offsetWinter: '-05:00', offsetSummer: '-05:00',
    abbrWinter: 'COT', abbrSummer: 'COT',
    terms: [
      ...['colombia time'],
      ...['kolumbianische zeit', 'kolumbien'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Chicago',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: [...tCST_CDT,
      ...['dallas', 'houston', 'minneapolis'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Denver',
    offsetWinter: '-07:00', offsetSummer: '-06:00',
    abbrWinter: 'MST', abbrSummer: 'MDT',
    terms: [
      ...['mountain time', 'mountain standard time', 'mountain daylight time',
        'mountain daylight saving time', 'phoenix', 'salt lake city'],
      ...['rocky-mountain-normalzeit', 'rocky-mountain-sommerzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Halifax',
    offsetWinter: '-04:00', offsetSummer: '-03:00',
    abbrWinter: 'AST', abbrSummer: 'ADT',
    terms: [
      ...['atlantic time', 'atlantic standard time', 'atlantic daylight time',
        'atlantic daylight saving time', 'atlantic summer time'],
      ...['atlantik-zeit', 'atlantik-normalzeit', 'atlantik-sommerzeit'],
    ],
  ),
  TzEntry(
      ianaZone: 'America/Lima',
      offsetWinter: '-05:00', offsetSummer: '-05:00',
      abbrWinter: 'PET', abbrSummer: 'PET',
      terms: [
        ...['peru time', 'peru standard time'],
        ...[],
      ]
  ),
  TzEntry(
    ianaZone: 'America/Los_Angeles',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [...tPST_PDT,
      ...['las vegas', 'portland', 'san francisco', 'seattle', 'usa west'],
      ...['westküste usa'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Mexico_City',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: [...tCST_CDT,
      ...['guadalajara'],
      ...['mexiko'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/New_York',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: [...tEST_EDT,
      ...['usa east', 'new york city', 'atlanta', 'boston', 'miami',
        'philadelphia', 'washington, d.c.', 'washington dc', 'washington'],
      ...['ostküste usa'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Sao_Paulo',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: 'BRT', abbrSummer: 'BRT',
    terms: [
      ...['brasilia standard time', 'brasilia time', 'brazil time', 'brazilian time',
        'rio de janeiro', 'são paulo'],
      ...['brasilianische zeit', 'brasilien'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/St_Johns',
    offsetWinter: '-03:30', offsetSummer: '-02:30',
    abbrWinter: 'NST', abbrSummer: 'NDT',
    terms: [
      ...['newfoundland standard time', 'newfoundland daylight time',
        "saint john's", "st. john's"],
      ...['neufundland-normalzeit', 'neufundland-sommerzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Toronto',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: [...tEST_EDT,
      ...['canada east', 'montreal', 'ottawa'],
      ...['kanada ost', ],
    ],
  ),
  TzEntry(
    ianaZone: 'America/Vancouver',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [...tPST_PDT,
      ...['canada west'],
      ...['kanada west'],
    ],
  ),
];

// ── Asia ─────────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Asia = [
  TzEntry(
    ianaZone: 'Asia/Baghdad',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'AST', abbrSummer: 'AST',
    terms: [
      ...['arabian standard time', 'arabia standard time', 'arabic standard time',
        'bahrain', 'iraq', 'jordan', 'kuwait', 'qatar', 'saudi arabia', 'syria', 'yemen',
        'manama', 'baghdad', 'amman', 'kuwait city', 'doha', 'riyadh', 'damascus', 'sanaa', 'aden'],
      ...['arabische normalzeit', 'irak', 'bagdad', 'jordanien', 'katar',
        'saudi-arabien', 'syrien', 'riad'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Bangkok',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: 'ICT', abbrSummer: 'ICT',
    terms: [
      ...['indochina time', 'thailand', 
        'cambodia' 'phnom penh',
        'vietnam', 'dong nai', 'hanoi', 'ho chi minh city', 'saigon'],
      ...['indochina-zeit', 'kambodscha', 'ho-chi-minh-stadt'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Colombo',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: 'IST', abbrSummer: 'IST',
    terms: [...tIST,
      ...['sri lanka standard time', 'slst'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Dhaka',
    offsetWinter: '+06:00', offsetSummer: '+06:00',
    abbrWinter: 'BST', abbrSummer: 'BST',
    terms: [
       ...['bangladesh standard time'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Dubai',
    offsetWinter: '+04:00', offsetSummer: '+04:00',
    abbrWinter: 'GST', abbrSummer: 'GST',
    terms: [
      ...['united arab emirates standard time', 'gulf standard time', 'uae',
        'abu dhabi', 'sharjah'],
      ...['golf-zeit', 'vereinigte arabische emirate', 'vae', 'schardscha'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Hong_Kong',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'HKT', abbrSummer: 'HKT',
    terms: [
      ...['hong kong standard time' ,'hong kong time'],
      ...['hongkong-normalzeit', 'hongkong-zeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Jakarta',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: 'WIB', abbrSummer: 'WIB',
    terms: [
      ...['western indonesian time', 'western indonesia time',
        'waktu indonesia barat'],
      ...['westindonesische zeit', 'indonesien'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Jerusalem',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'IST', abbrSummer: 'IDT',
    terms: [
      ...['israel standard time', 'israel daylight time', 'israel summer time',
        'tel aviv'],
      ...['israelische normalzeit', 'israelische sommerzeit'],
    ]
  ),
  TzEntry(
    ianaZone: 'Asia/Kabul',
    offsetWinter: '+04:30', offsetSummer: '+04:30',
    abbrWinter: 'AFT', abbrSummer: 'AFT',
    terms: [
      ...['afghanistan time'],
      ...['afghanistan-zeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Karachi',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: 'PKT', abbrSummer: 'PKT',
    terms: [
      ...['pakistan time', 'pakistan standard time', 'pakistan', 'islamabad', 'lahore'],
      ...['pakistanische normalzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Kathmandu',
    offsetWinter: '+05:45', offsetSummer: '+05:45',
    abbrWinter: 'NPT', abbrSummer: 'NPT',
    terms: [
      ...['nepal time'],
      ...['nepalesische zeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Kolkata',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: 'IST', abbrSummer: 'IST',
    terms: [...tIST,
      ...['ahmedabad', 'calcutta', 'bangalore', 'bengaluru', 'bombay', 'chennai',
        'delhi', 'hyderabad', 'madras', 'mumbai', 'new delhi'],
      ...['kalkutta', 'indien'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Manila',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'PST', abbrSummer: 'PST',
    terms: [
      ...['philippine time', 'philippine standard time', 'philippines'],
      ...['philippinische normalzeit', 'philippinen'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Seoul',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'KST', abbrSummer: 'KST',
    terms: [
       ...['korea time', 'korean standard time', 'korea standard time',
         'south korea', 'busan'],
      ...['koreanische standardzeit', 'koreanische normalzeit', 'südkorea'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Shanghai',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: [...tChinaStd,
      ...['china standard time', 'beijing time', 'beijing',
        "bijie", "changchun", "changde", "changsha", "changzhou", "chengchow",
        "chengdu", "chongqing", "dalian", "dongguan", "foshan", "fuzhou",
        "guangzhou", "guiyang", "hangzhou", "harbin", "hefei", "heze",
        "jieyang", "jinan", "kunming", "linyi", "luoyang", "nanchang",
        "nanking", "nanning", "qingdao", "shangqiu", "shantou", "shenyang",
        "shenzhen", "shijiazhuang", "suzhou", "tai'an", "taiyuan", "tangshan",
        "tianjin", "weifang", "wuhan", "wuxi", "xiamen", "xi'an", "xinyang",
        "yantai", "zhanjiang"],
      ...['chinesische standardzeit', 'peking-zeit', 'peking'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Singapore',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'SGT', abbrSummer: 'SGT',
    terms: [
      ...['singapore standard time', 'singapore time',
        'malaysia time', 'malaysian time', 'malaysian standard time', 'mst', 'myt', 'malaysia', 'kuala lumpur'],
      ...['singapurische normalzeit', 'malaysische normalzeit', 'malaysische zeit', 'singapur'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Taipei',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: [...tChinaStd,
      ...['taipei standard time', 'taiwan'],
      ...['taipeh-normalzeit', 'taipeh'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Tehran',
    offsetWinter: '+03:30', offsetSummer: '+03:30',
    abbrWinter: 'IRST', abbrSummer: 'IRST',
    terms: [
      ...['iran time', 'iran standard time', 'tehran'],
      ...['iranische normalzeit', 'teheran'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Tokyo',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'JST', abbrSummer: 'JST',
    terms: [
      ...['japan standard time', 'kyoto', 'osaka'],
      ...['japanische standardzeit', 'japanische normalzeit', 'tokio'],
    ],
  ),
  TzEntry(
    ianaZone: 'Asia/Yangon',
    offsetWinter: '+06:30', offsetSummer: '+06:30',
    abbrWinter: 'MMT', abbrSummer: 'MMT',
    terms: [
      ...['myanmar standard time', 'myanmar time', 'burma standard time', 'rangoon'],
      ...['myanmar-zeit', 'birmanische zeit', 'rangun'],
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
      ...['azores standard time', 'azores daylight time', 'azores summer time',
        'azores daysaving time', 'azodt'],
      ...['azoren-normalzeit', 'azoren-sommerzeit'],
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
    ianaZone: 'Anywhere on Earth',
    offsetWinter: '-12:00', offsetSummer: '-12:00',
    abbrWinter: 'AoE', abbrSummer: 'AoE',
    terms: [
      ...['baker island time', 'bit', 'international date line west', 'idlw'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Adelaide',
    offsetWinter: '+09:30', offsetSummer: '+10:30',
    abbrWinter: 'ACST', abbrSummer: 'ACDT',
    terms: [
      ...['australian central standard time', 'australian central daylight saving time',
        'australian central time', 'australian central daylight time', 'south australia'],
      ...['zentralaustralische normalzeit', 'zentralaustralische sommerzeit', 'südaustralien'],
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Brisbane',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'AEST', abbrSummer: 'AEST',
    terms: [...tAEST_AEDT,
      ...['queensland'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Darwin',
    offsetWinter: '+09:30', offsetSummer: '+09:30',
    abbrWinter: 'ACST', abbrSummer: 'ACST',
    terms: [
      ...['australian central standard time', 'northern territory'],
      ...['zentralaustralische normalzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Eucla',
    offsetWinter: '+08:45', offsetSummer: '+08:45',
    abbrWinter: 'CWT', abbrSummer: 'CWT',
    terms: [
      ...['australian central western standard time', 'acwst', 'central western time'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Hobart',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: [...tAEST_AEDT,
      ...['tasmania'],
      ...['tasmanien'],
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Lord_Howe',
    offsetWinter: '+10:30', offsetSummer: '+11:00',
    abbrWinter: 'LHST', abbrSummer: 'LHDT',
    terms: [
      ...['lord howe standard time', 'lord howe daylight time', 'lord howe time'],
      ...['lord-howe-normalzeit', 'lord-howe-sommerzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Perth',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'AWST', abbrSummer: 'AWST',
    terms: [
      ...['australian western standard time', 'western australia time'],
      ...['westaustralische normalzeit', 'australische westzeit', 'westaustralien'],
    ],
  ),
  TzEntry(
    ianaZone: 'Australia/Sydney',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: [...tAEST_AEDT,
      ...['australia', 'victoria', 'new south wales', 'melbourne', 'canberra'],
      ...['australien'],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Auckland',
    offsetWinter: '+12:00', offsetSummer: '+13:00',
    abbrWinter: 'NZST', abbrSummer: 'NZDT',
    terms: [
      ...['new zealand standard time', 'new zealand daylight time', 'wellington',
        'christchurch' 'mcmurdo', 'south pole', 'antarctica'],
      ...['neuseeland-normalzeit', 'neuseeland-sommerzeit', 'neuseeland',
        'südpol', 'antarktis'],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Chatham',
    offsetWinter: '+12:45', offsetSummer: '+13:45',
    abbrWinter: 'CHAST', abbrSummer: 'CHADT',
    terms: [
      ...['chatham standard time', 'chatham daylight time',
        'chatham island standard time', 'chatham island daylight time'],
      ...['chatham-normalzeit', 'chatham-sommerzeit '],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Fiji',
    offsetWinter: '+12:00', offsetSummer: '+12:00',
    abbrWinter: 'FJT', abbrSummer: 'FJT',
    terms: [
      ...['fiji standard time', 'fiji time'],
      ...['fidschi-normalzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Guam',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'ChST', abbrSummer: 'ChST',
    terms: [
      ...['chamorro standard time', 'hagåtña', 'hagatna', 'saipan'],
      ...['chamorro-zeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Honolulu',
    offsetWinter: '-10:00', offsetSummer: '-10:00',
    abbrWinter: 'HST', abbrSummer: 'HST',
    terms: [
      ...['hawaii-aleutian standard time', 'hawaii standard time'],
      ...['hawaii-normalzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Kiritimati',
    offsetWinter: '+14:00', offsetSummer: '+14:00',
    abbrWinter: 'LINT', abbrSummer: 'LINT',
    terms: [
      ...['line islands time', 'kiribati'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Marquesas',
    offsetWinter: '-09:30', offsetSummer: '-09:30',
    abbrWinter: 'MART', abbrSummer: 'MART',
    terms: [
      ...['marquesas time'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Norfolk',
    offsetWinter: '+11:00', offsetSummer: '+12:00',
    abbrWinter: 'NFT', abbrSummer: 'NFDT',
    terms: [
      ...['norfolk time', 'norfolk island time',
        'norfolk daylight time', 'norfolk island daylight time'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Pago_Pago',  // was: Pacific/Midway
    offsetWinter: '-11:00', offsetSummer: '-11:00',
    abbrWinter: 'SST', abbrSummer: 'SST',
    terms: [
      ...['samoa standard time', 'american samoa', 'midway'],
      ...['samoa-normalzeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Port_Moresby',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'PGT', abbrSummer: 'PGT',
    terms: [
      ...['papua new guinea standard time', 'papua new guinea time'],
      ...['papua-neuguinea-zeit'],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Tahiti',
    offsetWinter: '-10:00', offsetSummer: '-10:00',
    abbrWinter: 'TAHT', abbrSummer: 'TAHT',
    terms: [
      ...['tahiti time', 'french polynesia'],
      ...['tahiti-zeit', 'französisch-polynesien'],
    ],
  ),
  TzEntry(
    ianaZone: 'Pacific/Tongatapu',
    offsetWinter: '+13:00', offsetSummer: '+13:00',
    abbrWinter: 'TOT', abbrSummer: 'TOT',
    terms: [
      ...['tonga standard time', 'tonga time', "nuku'alofa"],
      ...['tongaische normalzeit'],
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
        'luxembourg',
        'netherlands', 'holland', 'amsterdam', 'rotterdam'],
      ...['belgien', 'brüssel',
        'luxemburg'
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
      ...['irish standard time', 'irish summer time', 'ireland'],
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
      ...['british standard time', 'british daylight time',
        'british daylight saving time', 'british summer time', 'great britain',
        'united kingdom', 'uk', 'england', 'scotland', 'wales'],
      ...['großbritannien', 'gb', 'vereinigtes königreich', 'schottland'],
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
      ...['moscow time', 'moscow standard time', 'russia',
        'saint petersburg', 'st petersburg'],
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
