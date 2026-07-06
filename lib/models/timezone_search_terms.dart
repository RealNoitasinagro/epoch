// ── Shared term sets by zone group ───────────────────────────────────────────

// Europe

const tUTC = [  // not used atm
  ...['coordinated universal time', 'universal time coordinated'],
  ...['koordinierte weltzeit'],
];

const tGMT = [
  ...['greenwich mean time'],
  ...['mittlere greenwich-zeit'],
];

const tCET_CEST = [
  ...['central european time', 'central european summer time',
    'middle european time', 'middle european summer time', 'met', 'mest',
    'central european daylight time', 'central european daylight saving time', 'cedt'],
  ...['mitteleuropäische zeit', 'mitteleuropäische sommerzeit', 'mez', 'mesz'],
];

const tEET_EEST = [
  ...['eastern european time', 'eastern european summer time'],
  ...['osteuropäische zeit', 'osteuropäische sommerzeit', 'oez', 'oesz'],
];

const tWET_WEST = [
  ...['western european time', 'western european summer time'],
  ...['westeuropäische zeit', 'westeuropäische sommerzeit', 'wez', 'wesz'],
];


// Americas

const tEST_EDT = [
  ...['eastern standard time', 'eastern daylight time'],
  ...['östliche normalzeit', 'östliche sommerzeit'],
];

const tCST_CDT = [
  ...['central standard time', 'central daylight time'],
  ...['zentrale normalzeit', 'zentrale sommerzeit'],
];

const tPST_PDT = [
  ...['pacific standard time', 'pacific daylight time'],
  ...['pazifische normalzeit', 'pazifische sommerzeit'],
];


// Other

const tAEST_AEDT = [
  ...['australian eastern standard time', 'australian eastern daylight time'],
  ...['australische ostzeit'],
];

const tChinaStd = [
  ...['china standard time'],
  ...['chinesische standardzeit'],
];

const tIst = [
  ...['india standard time'],
  ...['indische standardzeit'],
];
