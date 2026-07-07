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
    'central european daylight time', 'central european daylight saving time', 'cedt',
    'middle european time', 'middle european summer time', 'met', 'mest',
    'european central time', 'european central summer time'],
  ...['mitteleuropäische zeit', 'mitteleuropäische sommerzeit', 'mez', 'mesz'],
];

const tEET_EEST = [
  ...['eastern european time', 'eastern european daylight time', 'eastern european summer time'],
  ...['osteuropäische zeit', 'osteuropäische sommerzeit', 'oez', 'oesz'],
];

const tWET_WEST = [
  ...['western european time', 'western european daylight time', 'western european summer time'],
  ...['westeuropäische zeit', 'westeuropäische sommerzeit', 'wez', 'wesz'],
];


// Americas

const tEST_EDT = [
  ...['eastern time', 'eastern standard time', 'eastern daylight time',
    'eastern daylight saving time', 'eastern daylight savings time'],
  ...['östliche normalzeit', 'östliche sommerzeit'],
];

const tCST_CDT = [
  ...['central time', 'central standard time', 'central daylight time',
    'central daylight saving time', 'central daylight savings time'],
  ...['zentrale normalzeit', 'zentrale sommerzeit'],
];

const tPST_PDT = [
  ...['pacific time', 'pacific standard time', 'pacific daylight time',
    'pacific daylight saving time', 'pacific daylight savings time'],
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
