// ── Database ──────────────────────────────────────────────────────────────────

// For details, cf. https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

import 'timezone_search.dart';
import 'timezone_search_terms.dart';

const List<TzEntry> tzDatabase = [          // 127 entries in total
  ...tzEntries_Africa,                      //  8 entries
  ...tzEntries_Americas,                    // 17 entries
  ...tzEntries_Asia,                        // 36 entries
  ...tzEntries_Atlantic_Arctic_Antarctica,  //  6 entries
  ...tzEntries_Australia_Pacific,           // 31 entries
  ...tzEntries_Europe,                      // 29 entries
];

// ── Africa ───────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Africa = [
  TzEntry(
    ianaZoneId: 'Africa/Abidjan',
    offsetWinter: '+00:00', offsetSummer: '+00:00',
    abbrWinter: 'GMT', abbrSummer: 'GMT',
    terms: [...tGMT,
      ...['ivory coast', "côte d'ivoire", 'iceland', 'reykjavik', 'reykjavík',
        'accra', 'bamako', 'banjul', 'conakry', 'dakar', 'freetown', 'lome', 'nouakchott', 'ouagadougou', 'timbuktu'],
      ...['elfenbeinküste', 'island'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Africa/Cairo',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['egypt', 'misr', 'alexandria'],
      ...['ägypten', 'kairo'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Africa/Casablanca',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: '+01', abbrSummer: '+01',
    terms: [...tWET_WEST,
      ...['morocco', 'maroc', 'rabat'],
      ...['marokko'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Africa/Johannesburg',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'SAST', abbrSummer: 'SAST',
    terms: [
      ...['south african standard time', 'south africa standard time', 'cape town',
        'maseru', 'mbabane'],
      ...['südafrikanische zeit', 'kapstadt'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Africa/Lagos',
    offsetWinter: '+01:00', offsetSummer: '+01:00',
    abbrWinter: 'WAT', abbrSummer: 'WAT',
    terms: [
      ...['west africa time',
        'angola', 'luanda',
        'benin', 'porto-novo',
        'cameroon', 'yaoundé', 'yaounde',
        'central african republic', 'bangui',
        'chad', "n'djamena",
        'equatorial guinea', 'ciudad de la paz',
        'gabon', 'libreville',
        'niger', 'niamey',
        'nigeria', 'abuja',
        'republic of the congo', 'brazzaville',
        'douala', 'kinshasa', 'malabo'
        ],
      ...['westafrikanische zeit', 'kongo', 'gabun', 'tschad'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Africa/Maputo',
    offsetWinter: '+02:00', offsetSummer: '+02:00',
    abbrWinter: 'CAT', abbrSummer: 'CAT',
    terms: [
      ...['central africa time', 'mozambique', 'nampula',
        'blantyre', 'bujumbura', 'gaborone', 'harare', 'kigali', 'lubumbashi', 'lusaka'],
      ...['zentralafrikanische zeit', 'mosambik'],
    ]
  ),
  TzEntry(
    ianaZoneId: 'Africa/Nairobi',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'EAT', abbrSummer: 'EAT',
    terms: [
      ...['eastern africa time', 'east africa time',
        'comoros', 'djibouti', 'eritrea', 'ethiopia', 'kenya', 'madagascar',
        'somalia', 'tanzania', 'uganda',
        'moroni', 'djibouti city', 'asmara', 'addis ababa', 'antananarivo',
        'mogadishu', 'dar es salaam', 'kampala',
        'asmera', 'antananarivo', 'comoro', 'mayotte'],
      ...['ostafrikanische zeit',
        'komoren', 'äthiopien', 'kenia', 'madagaskar', 'addis abeba', 'daressalam'],
    ],
  ),

  TzEntry(
    ianaZoneId: 'Africa/Tunis',
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
    ianaZoneId: 'America/Anchorage',
    offsetWinter: '-09:00', offsetSummer: '-08:00',
    abbrWinter: 'AKST', abbrSummer: 'AKDT',
    terms: [
      ...['alaska time', 'alaska standard time', 'alaska daylight time',
        'alaska daylight saving time', 'anchorage', 'fairbanks'],
      ...['alaska-zeit', 'alaska-normalzeit', 'alaska-sommerzeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Argentina/Buenos_Aires',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: '-03', abbrSummer: '-03',
    terms: [
      ...['argentina time', 'ART'],
      ...['argentinische zeit', 'argentinien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Bogota',
    offsetWinter: '-05:00', offsetSummer: '-05:00',
    abbrWinter: '-05', abbrSummer: '-05',
    terms: [
      ...['colombia time', 'COT'],
      ...['kolumbianische zeit', 'kolumbien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Cayenne',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: '-03', abbrSummer: '-03',
    terms: [
      ...['french guiana time', 'GFT', 'guyane', 'kourou'],
      ...['französisch-guayana'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Chicago',
    offsetWinter: '-06:00', offsetSummer: '-05:00',
    abbrWinter: 'CST', abbrSummer: 'CDT',
    terms: [...tCST_CDT,
      ...['dallas', 'houston', 'minneapolis', 'united states of america', 'usa'],
      ...['vereinigte staaten von amerika'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Denver',
    offsetWinter: '-07:00', offsetSummer: '-06:00',
    abbrWinter: 'MST', abbrSummer: 'MDT',
    terms: [
      ...['mountain time', 'mountain standard time', 'mountain daylight time',
        'mountain daylight saving time', 'phoenix', 'salt lake city', 'MT',
        'north american mountain standard time', 'NAMST',
        'north american mountain daylight time', 'NAMDT',
        'shiprock', 'united states of america', 'usa'],
      ...['rocky-mountain-normalzeit', 'rocky-mountain-sommerzeit',
        'vereinigte staaten von amerika'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Halifax',
    offsetWinter: '-04:00', offsetSummer: '-03:00',
    abbrWinter: 'AST', abbrSummer: 'ADT',
    terms: [
      ...['atlantic time', 'atlantic standard time', 'atlantic daylight time',
        'atlantic daylight saving time', 'atlantic summer time', 'AT',
        'canada east', 'nova scotia', 'new brunswick'],
      ...['atlantik-zeit', 'atlantik-normalzeit', 'atlantik-sommerzeit',
        'kanada ost', 'neubraunschweig'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Lima',
    offsetWinter: '-05:00', offsetSummer: '-05:00',
    abbrWinter: '-05', abbrSummer: '-05',
    terms: [
      ...['peru time', 'peru standard time', 'PET'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Los_Angeles',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [...tPST_PDT,
      ...['las vegas', 'portland', 'san francisco', 'seattle',
        'united states of america', 'usa west'],
      ...['vereinigte staaten von amerika', 'westküste usa'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Mexico_City',
    offsetWinter: '-06:00', offsetSummer: '-06:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: [...tCST_CDT,
      ...['guadalajara'],
      ...['mexiko'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/New_York',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: [...tEST_EDT,
      ...['usa east', 'new york city', 'atlanta', 'boston', 'miami',
        'philadelphia', 'washington, d.c.', 'washington dc', 'washington',
        'united states of america'],
      ...['ostküste usa', 'vereinigte staaten von america'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Panama',
    offsetWinter: '-05:00', offsetSummer: '-05:00',
    abbrWinter: 'EST', abbrSummer: 'EST',
    terms: [
      ...['atikokan', 'cayman', 'coral harbour'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Puerto_Rico',
    offsetWinter: '-04:00', offsetSummer: '-04:00',
    abbrWinter: 'AST', abbrSummer: 'AST',
    terms: [
      ...['san juan', 'anguilla', 'antigua', 'aruba', 'blanc-sablon', 'curacao', 'dominica', 'grenada',
        'guadeloupe', 'kralendijk', 'lower princes', 'marigot', 'montserrat', 'port of spain',
        'saint barthelemy', 'saint barthélemy', 'saint christopher', 'saint kitts', 'saint lucia',
        'saint thomas', 'st barthelemy', 'st kitts', 'st lucia', 'st thomas', 'st vincent',
        'tortola', 'virgin'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Sao_Paulo',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: '-03', abbrSummer: '-03',
    terms: [
      ...['brasília time', 'brasilia time', 'brasilia standard time',
        'brazil time', 'brazilian time',
        'rio de janeiro', 'são paulo', 'BRT', 'BT'],
      ...['brasilianische zeit', 'brasilien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/St_Johns',
    offsetWinter: '-03:30', offsetSummer: '-02:30',
    abbrWinter: 'NST', abbrSummer: 'NDT',
    terms: [
      ...['newfoundland standard time', 'newfoundland daylight time',
        "saint john's", "st. john's", 'canada east',
        'newfoundland and labrador'],
      ...['neufundland-normalzeit', 'neufundland-sommerzeit', 'kanada ost',
        'neufundland und labrador'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Toronto',
    offsetWinter: '-05:00', offsetSummer: '-04:00',
    abbrWinter: 'EST', abbrSummer: 'EDT',
    terms: [...tEST_EDT,
      ...['canada east', 'ontario', 'montreal', 'ottawa', 'nassau', 'nipigon',
        'thunder bay'],
      ...['kanada ost'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'America/Vancouver',
    offsetWinter: '-08:00', offsetSummer: '-07:00',
    abbrWinter: 'PST', abbrSummer: 'PDT',
    terms: [...tPST_PDT,
      ...['canada west', 'british columbia'],
      ...['kanada west'],
    ],
  ),
];

// ── Asia ─────────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Asia = [
  TzEntry(
    ianaZoneId: 'Asia/Ashgabat',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: '+05', abbrSummer: '+05',
    terms: [
      ...['turkmenistan time', 'TMT'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Baghdad',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: '+03', abbrSummer: '+03',
    terms: [
      ...['arabian standard time', 'arabia standard time', 'arabic standard time', 'AST',
        'bahrain', 'iraq', 'jordan', 'kuwait', 'qatar', 'saudi arabia', 'syria', 'yemen',
        'manama', 'baghdad', 'amman', 'kuwait city', 'doha', 'riyadh', 'damascus', 'sanaa', 'aden'],
      ...['arabische normalzeit', 'irak', 'bagdad', 'jordanien', 'katar',
        'saudi-arabien', 'syrien', 'riad'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Baku',
    offsetWinter: '+04:00', offsetSummer: '+04:00',
    abbrWinter: '+04', abbrSummer: '+04',
    terms: [
      ...['azerbaijan time', 'AZT'],
      ...['aserbaidschan'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Bangkok',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: '+07', abbrSummer: '+07',
    terms: [
      ...['indochina time', 'ICT', 'thailand',
        'cambodia', 'phnom penh',
        'vietnam', 'dong nai', 'hanoi', 'ho chi minh city', 'saigon',
        'laos', 'vientiane'],
      ...['indochina-zeit', 'kambodscha', 'ho-chi-minh-stadt'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Bishkek',
    offsetWinter: '+06:00', offsetSummer: '+06:00',
    abbrWinter: '+06', abbrSummer: '+06',
    terms: [
      ...['kyrgyzstan time', 'KGT'],
      ...['kirgisistan', 'kirgistan', 'kirgisien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Colombo',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: '+0530', abbrSummer: '+0530',
    terms: [...tIST,
      ...['sri lanka standard time', 'SLST'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Dhaka',
    offsetWinter: '+06:00', offsetSummer: '+06:00',
    abbrWinter: '+06', abbrSummer: '+06',
    terms: [
       ...['bangladesh standard time', 'BST', 'dacca'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Dubai',
    offsetWinter: '+04:00', offsetSummer: '+04:00',
    abbrWinter: '+04', abbrSummer: '+04',
    terms: [
      ...['united arab emirates standard time', 'gulf standard time', 'GST',
        'uae', 'abu dhabi', 'sharjah', 'muscat', 'mahe', 'reunion'],
      ...['golf-zeit', 'vereinigte arabische emirate', 'vae', 'schardscha'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Dushanbe',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: '+05', abbrSummer: '+05',
    terms: [
      ...['tajikistan time', 'TJT'],
      ...['tadschikistan'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Hong_Kong',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'HKT', abbrSummer: 'HKT',
    terms: [
      ...['hong kong standard time' ,'hong kong time'],
      ...['hongkong-normalzeit', 'hongkong-zeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Irkutsk',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: '+08', abbrSummer: '+08',
    terms: [
      ...['russia', 'irkutsk time', 'IRKT'],
      ...['russland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Jakarta',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: 'WIB', abbrSummer: 'WIB',
    terms: [
      ...['western indonesian time', 'western indonesia time',
        'waktu indonesia barat'],
      ...['westindonesische zeit', 'indonesien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Jerusalem',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'IST', abbrSummer: 'IDT',
    terms: [
      ...['israel standard time', 'israel daylight time', 'israel summer time',
        'tel aviv'],
      ...['israelische normalzeit', 'israelische sommerzeit'],
    ]
  ),
  TzEntry(
    ianaZoneId: 'Asia/Kabul',
    offsetWinter: '+04:30', offsetSummer: '+04:30',
    abbrWinter: '+0430', abbrSummer: '+0430',
    terms: [
      ...['afghanistan time', 'AFT'],
      ...['afghanistan-zeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Kamchatka',
    offsetWinter: '+12:00', offsetSummer: '+12:00',
    abbrWinter: '+12', abbrSummer: '+12',
    terms: [
      ...['russia', 'kamchatka time', 'petropavlovsk time', 'PETT', 'anadyr time', 'ANAT'],
      ...['russland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Karachi',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: 'PKT', abbrSummer: 'PKT',
    terms: [
      ...['pakistan time', 'pakistan standard time', 'pakistan', 'islamabad', 'lahore'],
      ...['pakistanische normalzeit'],
    ],
  ),
    TzEntry(
    ianaZoneId: 'Asia/Kathmandu',
    offsetWinter: '+05:45', offsetSummer: '+05:45',
    abbrWinter: '+0545', abbrSummer: '+0545',
    terms: [
      ...['nepal time', 'NPT', 'nepal standard time', 'katmandu'],
      ...['nepalesische zeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Kolkata',
    offsetWinter: '+05:30', offsetSummer: '+05:30',
    abbrWinter: 'IST', abbrSummer: 'IST',
    terms: [...tIST,
      ...['ahmedabad', 'calcutta', 'bangalore', 'bengaluru', 'bombay', 'chennai',
        'delhi', 'hyderabad', 'madras', 'mumbai', 'new delhi'],
      ...['kalkutta', 'indien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Krasnoyarsk',
    offsetWinter: '+07:00', offsetSummer: '+07:00',
    abbrWinter: '+07', abbrSummer: '+07',
    terms: [
      ...['russia', 'krasnoyarsk time', 'KRAT'],
      ...['russland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Magadan',
    offsetWinter: '+11:00', offsetSummer: '+11:00',
    abbrWinter: '+11', abbrSummer: '+11',
    terms: [
      ...['russia', 'magadan time', 'MAGT', 'sakhalin time', 'SAKT'],
      ...['russland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Manila',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'PST', abbrSummer: 'PST',
    terms: [
      ...['philippine time', 'philippine standard time', 'philippines', 'PHT'],
      ...['philippinische normalzeit', 'philippinen'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Nicosia',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['cyprus'],
      ...['zypern'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Omsk',
    offsetWinter: '+06:00', offsetSummer: '+06:00',
    abbrWinter: '+06', abbrSummer: '+06',
    terms: [
      ...['russia', 'omsk time', 'OMST'],
      ...['russland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Oral',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: '+05', abbrSummer: '+05',
    terms: [
      ...['oral time', 'kazakhstan', 'ORAT', 'astana',
        'qyzylorda time', 'QYZT'],
      ...['kasachstan'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Seoul',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'KST', abbrSummer: 'KST',
    terms: [
       ...['korea time', 'korean standard time', 'korea standard time',
         'south korea', 'busan', 'KT'],
      ...['koreanische standardzeit', 'koreanische normalzeit', 'südkorea'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Shanghai',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: [...tChinaStd,
      ...['china standard time', 'beijing time', 'beijing',
        "bijie", "changchun", "changde", "changsha", "changzhou", "chengchow",
        "chengdu", "chongqing", "chungking", "dalian", "dongguan", "foshan", "fuzhou",
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
    ianaZoneId: 'Asia/Singapore',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: '+08', abbrSummer: '+08',
    terms: [
      ...['singapore standard time', 'singapore time', 'SGT',
        'malaysia time', 'malaysian time', 'malaysian standard time', 'MST', 'MYT', 'malaysia', 'kuala lumpur'],
      ...['singapurische normalzeit', 'malaysische normalzeit', 'malaysische zeit', 'singapur'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Taipei',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'CST', abbrSummer: 'CST',
    terms: [...tChinaStd,
      ...['taipei standard time', 'taiwan'],
      ...['taipeh-normalzeit', 'taipeh'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Tashkent',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: '+05', abbrSummer: '+05',
    terms: [
      ...['uzbekistan time', 'UZT', 'samarkand'],
      ...['usbekistan'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Tbilisi',
    offsetWinter: '+04:00', offsetSummer: '+04:00',
    abbrWinter: '+04', abbrSummer: '+04',
    terms: [
      ...['georgia time', 'GET'],
      ...['georgien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Tehran',
    offsetWinter: '+03:30', offsetSummer: '+03:30',
    abbrWinter: '+0330', abbrSummer: '+0330',
    terms: [
      ...['iran time', 'iran standard time', 'tehran', 'IRST'],
      ...['iranische normalzeit', 'teheran'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Tokyo',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: 'JST', abbrSummer: 'JST',
    terms: [
      ...['japan standard time', 'kyoto', 'osaka'],
      ...['japanische standardzeit', 'japanische normalzeit', 'tokio'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Vladivostok',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: '+10', abbrSummer: '+10',
    terms: [
      ...['russia', 'vladivostok time', 'VLAT'],
      ...['russland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Yakutsk',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: '+09', abbrSummer: '+09',
    terms: [
      ...['russia', 'yakutsk time', 'YAKT'],
      ...['russland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Yangon',
    offsetWinter: '+06:30', offsetSummer: '+06:30',
    abbrWinter: '+0630', abbrSummer: '+0630',
    terms: [
      ...['myanmar standard time', 'myanmar time', 'MMT', 'burma standard time', 'rangoon'],
      ...['myanmar-zeit', 'birmanische zeit', 'rangun'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Asia/Yekaterinburg',
    offsetWinter: '+05:00', offsetSummer: '+05:00',
    abbrWinter: '+05', abbrSummer: '+05',
    terms: [
      ...['russia', 'yekaterinburg time', 'YEKT', 'ekaterinburg', 'sverdlovsk'],
      ...['russland', 'jekaterinburg'],
    ],
  ),
];

// ── Atlantic / Arctic / Antarctica ───────────────────────────────────
const List<TzEntry> tzEntries_Atlantic_Arctic_Antarctica = [
  TzEntry(
    ianaZoneId: 'Antarctica/Palmer',
    offsetWinter: '-03:00', offsetSummer: '-03:00',
    abbrWinter: '-03', abbrSummer: '-03',
    terms: [
      ...['antarctica', 'chile', 'magallanes and chilean antarctica', 'CLT'],
      ...['antarktis'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Antarctica/Troll',
    offsetWinter: '+00:00', offsetSummer: '+02:00',
    abbrWinter: '+00', abbrSummer: '+02',
    terms: [...tGMT, ...tCET_CEST,
      ...['antarctica', 'norway'],
      ...['antarktis', 'norwegen'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Atlantic/Azores',
    offsetWinter: '-01:00', offsetSummer: '+00:00',
    abbrWinter: '-01', abbrSummer: '+00',
    terms: [
      ...['azores standard time', 'azores daylight time', 'azores summer time',
        'azores daysaving time', 'AZOT', 'AZODT', 'AZOST'],
      ...['azoren-normalzeit', 'azoren-sommerzeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Atlantic/Canary',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: [...tWET_WEST,
      ...['fuerteventura', 'gran canaria', 'lanzarote', 'tenerife'],
      ...['kanaren', 'teneriffa'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Atlantic/Cape_Verde',
    offsetWinter: '-01:00', offsetSummer: '-01:00',
    abbrWinter: '-01', abbrSummer: '-01',
    terms: [
      ...['cape verde time', 'cabo verde', 'praia', 'CVT'],
      ...['kap verde'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Atlantic/South_Georgia',
    offsetWinter: '-02:00', offsetSummer: '-02:00',
    abbrWinter: '-02', abbrSummer: '-02',
    terms: [
      ...['south georgia time', 'GST'],
      ...['südgeorgien'],
    ],
  ),
];

// ── Australia / Pacific ──────────────────────────────────────────────
const List<TzEntry> tzEntries_Australia_Pacific = [
  TzEntry(
    ianaZoneId: 'Anywhere on Earth',  // not in IANA DB
    offsetWinter: '-12:00', offsetSummer: '-12:00',
    abbrWinter: 'AoE', abbrSummer: 'AoE',
    terms: [
      ...['baker island time', 'BIT', 'international date line west', 'IDLW'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Australia/Adelaide',
    offsetWinter: '+09:30', offsetSummer: '+10:30',
    abbrWinter: 'ACST', abbrSummer: 'ACDT',
    terms: [
      ...['australian central standard time', 'australian central daylight saving time',
        'australian central time', 'australian central daylight time', 'south australia'],
      ...['zentralaustralische normalzeit', 'zentralaustralische sommerzeit', 'südaustralien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Australia/Brisbane',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'AEST', abbrSummer: 'AEST',
    terms: [...tAEST_AEDT,
      ...['queensland'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Australia/Darwin',
    offsetWinter: '+09:30', offsetSummer: '+09:30',
    abbrWinter: 'ACST', abbrSummer: 'ACST',
    terms: [
      ...['australian central standard time', 'northern territory'],
      ...['zentralaustralische normalzeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Australia/Eucla',
    offsetWinter: '+08:45', offsetSummer: '+08:45',
    abbrWinter: '+0845', abbrSummer: '+0845',
    terms: [
      ...['australian central western standard time', 'ACWST', 'central western time', 'CWT'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Australia/Hobart',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: [...tAEST_AEDT,
      ...['tasmania', 'currie'],
      ...['tasmanien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Australia/Lord_Howe',
    offsetWinter: '+10:30', offsetSummer: '+11:00',
    abbrWinter: '+1030', abbrSummer: '+11',
    terms: [
      ...['lord howe standard time', 'lord howe daylight time', 'lord howe time', 'LHST', 'LHDT'],
      ...['lord-howe-normalzeit', 'lord-howe-sommerzeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Australia/Perth',
    offsetWinter: '+08:00', offsetSummer: '+08:00',
    abbrWinter: 'AWST', abbrSummer: 'AWST',
    terms: [
      ...['australian western standard time', 'western australia time'],
      ...['westaustralische normalzeit', 'australische westzeit', 'westaustralien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Australia/Sydney',
    offsetWinter: '+10:00', offsetSummer: '+11:00',
    abbrWinter: 'AEST', abbrSummer: 'AEDT',
    terms: [...tAEST_AEDT,
      ...['australia', 'victoria', 'new south wales', 'melbourne', 'canberra'],
      ...['australien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Auckland',
    offsetWinter: '+12:00', offsetSummer: '+13:00',
    abbrWinter: 'NZST', abbrSummer: 'NZDT',
    terms: [
      ...['new zealand standard time', 'new zealand daylight time', 'wellington',
        'christchurch', 'mcmurdo', 'south pole', 'antarctica'],
      ...['neuseeland-normalzeit', 'neuseeland-sommerzeit', 'neuseeland',
        'südpol', 'antarktis'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Chatham',
    offsetWinter: '+12:45', offsetSummer: '+13:45',
    abbrWinter: '+1245', abbrSummer: '+1345',
    terms: [
      ...['chatham standard time', 'chatham daylight time', 'CHAST', 'CHADT',
        'chatham island standard time', 'chatham island daylight time'],
      ...['chatham-normalzeit', 'chatham-sommerzeit '],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Efate',
    offsetWinter: '+11:00', offsetSummer: '+11:00',
    abbrWinter: '+11', abbrSummer: '+11',
    terms: [
      ...['vanuatu time', 'VUT', 'port vila'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Fakaofo',
    offsetWinter: '+13:00', offsetSummer: '+13:00',
    abbrWinter: '+13', abbrSummer: '+13',
    terms: [
      ...['tokelau time', 'TKT'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Fiji',
    offsetWinter: '+12:00', offsetSummer: '+12:00',
    abbrWinter: '+12', abbrSummer: '+12',
    terms: [
      ...['fiji standard time', 'fiji time', 'FJT'],
      ...['fidschi-normalzeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Guadalcanal',
    offsetWinter: '+11:00', offsetSummer: '+11:00',
    abbrWinter: '+11', abbrSummer: '+11',
    terms: [
      ...['solomon islands time', 'SBT', 'honiara', 'micronesia', 'palikir',
        'pohnpei standard time', 'ponape', 'PONT'],
      ...['salomonen', 'salomoninseln', 'mikronesien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Guam',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: 'ChST', abbrSummer: 'ChST',
    terms: [
      ...['chamorro standard time', 'hagåtña', 'hagatna', 'saipan'],
      ...['chamorro-zeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Honolulu',
    offsetWinter: '-10:00', offsetSummer: '-10:00',
    abbrWinter: 'HST', abbrSummer: 'HST',
    terms: [
      ...['hawaii-aleutian standard time', 'hawaii standard time', 'johnston'],
      ...['hawaii-normalzeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Kanton',
    offsetWinter: '+13:00', offsetSummer: '+13:00',
    abbrWinter: '+13', abbrSummer: '+13',
    terms: [
      ...['phoenix island time', 'PHOT', 'kiribati', 'phoenix islands'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Kiritimati',
    offsetWinter: '+14:00', offsetSummer: '+14:00',
    abbrWinter: '+14', abbrSummer: '+14',
    terms: [
      ...['line islands time', 'LINT', 'kiribati'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Kosrae',
    offsetWinter: '+11:00', offsetSummer: '+11:00',
    abbrWinter: '+11', abbrSummer: '+11',
    terms: [
      ...['kosrae time', 'KOST', 'micronesia', 'tofol'],
      ...['mikronesien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Marquesas',
    offsetWinter: '-09:30', offsetSummer: '-09:30',
    abbrWinter: '-0930', abbrSummer: '-0930',
    terms: [
      ...['marquesas time', 'MART'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Nauru',
    offsetWinter: '+12:00', offsetSummer: '+12:00',
    abbrWinter: '+12', abbrSummer: '+12',
    terms: [
      ...['nauru time', 'NRT', 'yaren'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Niue',
    offsetWinter: '-11:00', offsetSummer: '-11:00',
    abbrWinter: '-11', abbrSummer: '-11',
    terms: [
      ...['niue time', 'NUT', 'alofi'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Norfolk',
    offsetWinter: '+11:00', offsetSummer: '+12:00',
    abbrWinter: '+11', abbrSummer: '+12',
    terms: [
      ...['norfolk time', 'norfolk island time',
        'norfolk daylight time', 'norfolk island daylight time', 'NFT', 'NFDT'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Noumea',
    offsetWinter: '+11:00', offsetSummer: '+11:00',
    abbrWinter: '+11', abbrSummer: '+11',
    terms: [
      ...['new caledonia time', 'NCT', 'nouméa'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Pago_Pago',  // was: Pacific/Midway
    offsetWinter: '-11:00', offsetSummer: '-11:00',
    abbrWinter: 'SST', abbrSummer: 'SST',
    terms: [
      ...['samoa standard time', 'american samoa', 'midway'],
      ...['samoa-normalzeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Palau',
    offsetWinter: '+09:00', offsetSummer: '+09:00',
    abbrWinter: '+09', abbrSummer: '+09',
    terms: [
      ...['palau time', 'PWT', 'ngerulmud'],
      ...[],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Port_Moresby',
    offsetWinter: '+10:00', offsetSummer: '+10:00',
    abbrWinter: '+10', abbrSummer: '+10',
    terms: [
      ...['papua new guinea standard time', 'papua new guinea time', 'PGT',
        'chuuk time', 'CHUT', 'truk', 'yap'],
      ...['papua-neuguinea-zeit'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Tahiti',
    offsetWinter: '-10:00', offsetSummer: '-10:00',
    abbrWinter: '-10', abbrSummer: '-10',
    terms: [
      ...['tahiti time', 'french polynesia', 'TAHT'],
      ...['tahiti-zeit', 'französisch-polynesien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Tarawa',
    offsetWinter: '+12:00', offsetSummer: '+12:00',
    abbrWinter: '+12', abbrSummer: '+12',
    terms: [
      ...['funafuti', 'majuro', 'wake', 'wallis',
        'gilbert island time', 'GILT', 'gilbert islands',
        'marshall island time', 'MHT', 'marshall islands',
        'tuvalu time', 'TVT',
        'wallis and futuna time', 'WFT',
        'kiribati'],
      ...['gilbertinseln', 'marshallinseln'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Pacific/Tongatapu',
    offsetWinter: '+13:00', offsetSummer: '+13:00',
    abbrWinter: '+13', abbrSummer: '+13',
    terms: [
      ...['tonga standard time', 'tonga time', "nuku'alofa", 'TOT'],
      ...['tongaische normalzeit'],
    ],
  ),
];

// ── Europe ───────────────────────────────────────────────────────────
const List<TzEntry> tzEntries_Europe = [
  TzEntry(
    ianaZoneId: 'Europe/Andorra',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['andorra la vella'],
      ...[''],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Athens',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['greece', 'hellas'],
      ...['griechenland', 'athen'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Belgrade',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['serbia', 'ljubljana', 'podgorica', 'sarajevo', 'skopje', 'zagreb',
        'bosnia and herzegovina', 'bosnia-herzegovina', 'croatia', 'montenegro'],
      ...['serbien',
        'bosnien-herzegowina', 'bosnien und herzegowina', 'kroatien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Berlin',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
       ...['germany', 'hamburg', 'cologne', 'munich', 'frankfurt', 'düsseldorf',
        'denmark', 'danmark', 'copenhagen',
        'norway', 'norge', 'oslo', 'bergen', 'longyearbyen', 'spitsbergen', 'svalbard',
        'sweden', 'sverige', 'stockholm', 'gothenburg'],
      ...['deutschland', 'köln', 'münchen',
        'dänemark', 'kopenhagen',
        'norwegen', 'spitzbergen',
        'schweden', 'göteborg'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Brussels',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['belgium', 'belgique', 'bruxelles',
        'luxembourg',
        'netherlands', 'holland', 'amsterdam', 'rotterdam', 'the hague', "'s-gravenhage"],
      ...['belgien', 'brüssel',
        'luxemburg',
        'niederlande', 'den haag'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Bucharest',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['romania', 'bucharest'],
      ...['rumänien', 'bukarest'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Budapest',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['hungary', 'magyarország'],
      ...['ungarn'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Chisinau',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['moldova', 'tiraspol'],
      ...['moldau', 'moldawien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Dublin',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'IST',
    terms: [...tGMT,
      ...['irish standard time', 'irish summer time', 'ireland'],
      ...['irland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Helsinki',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['finland', 'suomi', 'mariehamn'],
      ...['finnland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Istanbul',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: '+03', abbrSummer: '+03',
    terms: [
      ...['turkey time', 'türkiye', 'ankara', 'TRT'],
      ...['türkische zeit', 'türkei'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Kyiv',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['ukraine', 'kiev', 'uzhgorod', 'zaporizhzhia', 'zaporozhye'],
      ...['kiew', 'uschhorod', 'saporischschja'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Lisbon',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'WET', abbrSummer: 'WEST',
    terms: [...tWET_WEST,
      ...['portugal'],
      ...['lissabon'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/London',
    offsetWinter: '+00:00', offsetSummer: '+01:00',
    abbrWinter: 'GMT', abbrSummer: 'BST',
    terms: [...tGMT,
      ...['british standard time', 'british daylight time',
        'british daylight saving time', 'british summer time', 'great britain',
        'united kingdom', 'uk', 'england', 'scotland', 'wales',
        'belfast', 'guernsey', 'isle of man', 'jersey'],
      ...['großbritannien', 'gb', 'vereinigtes königreich', 'schottland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Madrid',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['spain', 'españa', 'espana', 'barcelona', 'seville'],
      ...['spanien', 'sevilla'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Malta',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['valletta'],
      ...[''],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Moscow',
    offsetWinter: '+03:00', offsetSummer: '+03:00',
    abbrWinter: 'MSK', abbrSummer: 'MSK',
    terms: [
      ...['moscow time', 'moscow standard time', 'russia',
        'saint petersburg', 'st petersburg'],
      ...['moskauer zeit', 'russland', 'moskau', 'sankt petersburg'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Paris',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['france', 'lyon', 'marseille', 'monaco', 'monte carlo'],
      ...['frankreich'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Prague',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [
      ...['czechia', 'czech republic', 'slovakia', 'bratislava'],
      ...['tschechien', 'slowakei', 'prag'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Riga',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['latvia'],
      ...['lettland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Rome',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['italy', 'italia', 'mailand', 'milan', 'milano', 'naples', 'san marino', 'vatican'],
      ...['italien', 'rom', 'neapel', 'vatikan'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Samara',
    offsetWinter: '+04:00', offsetSummer: '+04:00',
    abbrWinter: '+04', abbrSummer: '+04',
    terms: [
      ...['russia', 'samara time', 'SAMT'],
      ...['russland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Sofia',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['bulgaria'],
      ...['bulgarien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Tallinn',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['estonia'],
      ...['estland'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Tirane',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [
      ...['albania', 'tirana'],
      ...['albanien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Vienna',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['austria'],
      ...['österreich', 'wien'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Vilnius',
    offsetWinter: '+02:00', offsetSummer: '+03:00',
    abbrWinter: 'EET', abbrSummer: 'EEST',
    terms: [...tEET_EEST,
      ...['lithuania'],
      ...['litauen'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Warsaw',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [
      ...['poland', 'polska'],
      ...['polen', 'warschau'],
    ],
  ),
  TzEntry(
    ianaZoneId: 'Europe/Zurich',
    offsetWinter: '+01:00', offsetSummer: '+02:00',
    abbrWinter: 'CET', abbrSummer: 'CEST',
    terms: [...tCET_CEST,
      ...['switzerland', 'suisse', 'svizzera', 'bern', 'geneva', 'genève',
        'busingen', 'liechtenstein', 'vaduz'],
      ...['schweiz', 'zürich', 'genf', 'büsingen'],
    ],
  ),
];
