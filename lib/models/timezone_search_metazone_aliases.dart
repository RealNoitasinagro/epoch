const Map<String, ({List<String>? generic, List<String>? standard, List<String>? daylight})> metazoneNameAliasesEn = {
  'Africa_Southern': (
    generic: null,
    standard: ['South African Standard Time'],
    daylight: null
  ),
  'America_Central': (  // CST/CDT
    generic: null,
    standard: ['North American Central Standard Time'],
    daylight: ['North American Central Daylight Time'],
  ),
  'America_Eastern': (  // EST/EDT
    generic: null,
    standard: ['North American Eastern Standard Time'],
    daylight: ['North American Eastern Daylight Time'],
  ),
  'America_Mountain': (  // MST/MDT
    generic: null,
    standard: ['North American Mountain Standard Time'],
    daylight: ['North American Mountain Daylight Time'],
  ),
  'America_Pacific': (  // PST/PDT
    generic: null,
    standard: ['North American Pacific Standard Time'],
    daylight: ['North American Pacific Daylight Time'],
  ),
  'Apia': (
    generic: null,
    standard: ['West Samoa Time'],
    daylight: null
  ),
  // 'Arabian': (
  //   generic: ['Arabia Time', 'Arabic Time', 'Arab Time'],
  //   standard: ['Arabia Standard Time', 'Arabic Standard Time', 'Arab Standard Time', 'Al Manamah Standard Time'],
  //   daylight: ['Arabia Daylight Time', 'Arabic Daylight Time', 'Arab daylight Time']
  // ),
  'Arabian': (
    generic: ['Arabia Time', 'Arabic Time', 'Arab Time'],
    standard: ['Al Manamah Standard Time'],
    daylight: null
  ),
  'Australia_Western': (
    generic: null,
    standard: ['Western Australia Time', 'Western Standard Time'],
    daylight: null,
  ),
  'Brasilia': (
    generic: null,
    standard: ['Brazilian Time',],
    daylight: null,
  ),
  // 'Europe_Central':  (  // CET/CEST
  //   generic: ['Central Europe Time', 'European Central Time', 'European Middle Time', 'Europe Central Time', 'Europe Middle Time', 'Middle European Time', 'Middle Europe Time', 'MET',],
  //   standard: ['Central Europe Standard Time', 'European Central Standard Time', 'European Middle Standard Time', 'Europe Central Standard Time', 'Europe Middle Standard Time', 'Middle European Standard Time', 'Middle Europe Standard Time',],
  //   daylight: ['Central European Daylight Time', 'Central Europe Daylight Time', 'European Central Daylight Time', 'European Middle Daylight Time', 'Europe Central Daylight Time', 'Europe Middle Daylight Time', 'Middle European Daylight Time', 'Middle Europe Daylight Time', 'CEDT', 'MEST']
  // ),
  'Europe_Central':  (  // CET/CEST
    generic: ['Central Europe Time', 'European Central Time', 'Europe Central Time', 'European Middle Time', 'Europe Middle Time', 'Middle European Time', 'Middle Europe Time'],
    standard: [],
    daylight: ['Central Europe Daylight Time', 'European Central Summer Time', 'European Middle Daylight Time', 'Europe Central Daylight Time', 'Europe Middle Daylight Time', 'Middle European Daylight Time', 'Middle Europe Daylight Time', 'CEDT', 'MEST']
  ),
  'French_Southern': (
    generic: null,
    standard: ['Kerguelen (Islands) Time'],
    daylight: null
  ),
  'Gambier': (
    generic: null,
    standard: ['Gambier Islands Time'],
    daylight: null
  ),
  'India': (
    generic: null,
    standard: ['Indian Standard Time'],
    daylight: null
  ),
  'Indian_Ocean': (
    generic: null,
    standard: ['Indian Chagos Time'],
    daylight: null
  ),
  'Indonesia_Central': (
    generic: null,
    standard: ['Central Indonesian Time'],
    daylight: null
  ),
  'Indonesia_Eastern': (
    generic: null,
    standard: ['Eastern Indonesian Time'],
    daylight: null
  ),
  'Indonesia_Western': (
    generic: null,
    standard: ['Western Indonesian Time'],
    daylight: null
  ),
  'Kamchatka': (
    generic: null,
    standard: ['Petropavlovsk-Kamchatski Time', 'Petropavlovsk-Kamchatsky Time'],
    daylight: null
  ),
  'Malaysia': (
    generic: null,
    standard: ['Malaysian Standard Time'],
    daylight: null
  ),
  'Magadan': (
    generic: null,
    standard: ['Magadan Island Time'],
    daylight: null
  ),
  'Pierre_Miquelon': (
    generic: ['Pierre & Miquelon Time'],
    standard: ['Pierre & Miquelon Standard Time'],
    daylight: ['Pierre & Miquelon Daylight Time']
  ),
  'Venezuela': (
    generic: null,
    standard: ['Venezuelan Standard Time'],
    daylight: null
  ),
};

const Map<String, ({List<String>? generic, List<String>? standard, List<String>? daylight})> metazoneNameAliasesDe = {
  'Brasilia': (generic: null, standard: ['Brasilianische Zeit'], daylight: null),
  'Europe_Central': (generic: null, standard: ['MEZ'], daylight: ['MESZ']),
  'Europe_Eastern': (generic: null, standard: ['OEZ'], daylight: ['OESZ']),
  'Europe_Western': (generic: null, standard: ['WEZ'], daylight: ['WESZ']),
  'Kamchatka': (generic: null, standard: ['Petropawlowsk-Kamtschatski-Zeit'], daylight: null),
  'Nepal': (generic: null, standard: ['Nepalesische Normalzeit'], daylight: null),
};
