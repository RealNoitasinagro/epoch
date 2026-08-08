// ── Shared term sets by zone group ───────────────────────────────────────────

// Europe

const tUTC = [  // not used atm
  ...['coordinated universal time', 'universal time coordinated'],
  ...['koordinierte weltzeit'],
];

const tGMT = [
  ...['greenwich time', 'greenwich mean time'],
  ...['mittlere greenwich-zeit'],
];

const tCET_CEST = [
  ...['central europe time', 'central european time', 'central european summer time',
    'central european daylight time', 'central european daylight saving time', 'CEDT',
    'middle european time', 'middle european summer time', 'MET', 'MEST',
    'european central time', 'european central summer time'],
  ...['mitteleuropäische zeit', 'mitteleuropäische sommerzeit', 'MEZ', 'MESZ'],
];

const tEET_EEST = [
  ...['eastern european time', 'eastern european daylight time', 'eastern european summer time'],
  ...['osteuropäische zeit', 'osteuropäische sommerzeit', 'OEZ', 'OESZ'],
];

const tWET_WEST = [
  ...['western european time', 'western european daylight time', 'western european summer time'],
  ...['westeuropäische zeit', 'westeuropäische sommerzeit', 'WEZ', 'WESZ'],
];


// Americas

const tEST_EDT = [
  ...['eastern time', 'eastern standard time', 'eastern daylight time',
    'eastern daylight saving time', 'eastern daylight savings time', 'ET',
    'north american eastern standard time', 'NAEST',
    'north american eastern daylight time', 'NAEDT'],
  ...['östliche normalzeit', 'östliche sommerzeit'],
];

const tCST_CDT = [
  ...['central time', 'central standard time', 'central daylight time',
    'central daylight saving time', 'central daylight savings time', 'CT',
    'north american central standard time', 'NACST',
    'north american central daylight time', 'NACDT'],
  ...['zentrale normalzeit', 'zentrale sommerzeit'],
];

const tPST_PDT = [
  ...['pacific time', 'pacific standard time', 'pacific daylight time',
    'pacific daylight saving time', 'pacific daylight savings time', 'PT',
    'north american pacific standard time', 'NAPST',
    'north american pacific daylight time', 'NAPDT'],
  ...['pazifische normalzeit', 'pazifische sommerzeit'],
];


// Other

const tAEST_AEDT = [
  ...['australian eastern time', 'australian eastern standard time', 'australian eastern daylight time'],
  ...['ostaustralische normalzeit', 'ostaustralische sommerzeit', 'australische ostzeit'],
];

const tChinaStd = [
  ...['china standard time'],
  ...['chinesische standardzeit'],
];

const tIST = [
  ...['india time', 'indian standard time', 'india standard time'],
  ...['indische standardzeit'],
];
