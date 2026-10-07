const Map<String, ({List<String>? generic, List<String>? standard, List<String>? daylight})> metazoneNameAliasesEn = {
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
  'Arabian': (
    generic: ['Arabia Time', 'Arabic Time', 'Arab Time'],
    standard: ['Arabia Standard Time', 'Arabic Standard Time', 'Arab Standard Time'],
    daylight: ['Arabia Daylight Time', 'Arabic Daylight Time', 'Arab daylight Time']),
  'Brasilia': (
    generic: ['Brazilian Time', 'Brazil Time',],
    standard: null,
    daylight: null,
  ),
  'Chatham':  (
    generic: null,
    standard: ['Chatham Island Standard Time'],
    daylight: ['Chatham Island Daylight Time'],
  ),
  'Europe_Central':  (  // CET/CEST
    generic: ['Central Europe Time', 'European Central Time', 'European Middle Time', 'Europe Central Time', 'Europe Middle Time', 'Middle European Time', 'Middle Europe Time', 'MET',],
    standard: ['Central Europe Standard Time', 'European Central Standard Time', 'European Middle Standard Time', 'Europe Central Standard Time', 'Europe Middle Standard Time', 'Middle European Standard Time', 'Middle Europe Standard Time',],
    daylight: ['Central European Daylight Time', 'Central Europe Daylight Time', 'European Central Daylight Time', 'European Middle Daylight Time', 'Europe Central Daylight Time', 'Europe Middle Daylight Time', 'Middle European Daylight Time', 'Middle Europe Daylight Time', 'CEDT', 'MEST']
  ),
  'Europe_Eastern': (  // EET/EEST
    generic: ['Eastern European Time', 'Eastern Europe Time', 'East European Time', 'East Europe Time',],
    standard: ['Eastern European Standard Time', 'Eastern Europe Standard Time', 'East European Standard Time', 'East Europe Standard Time',],
    daylight: ['Eastern European Daylight Time', 'Eastern Europe Daylight Time', 'East European Daylight Time', 'East Europe Daylight Time',]
  ),
  'Europe_Western': (  // WET/WEST
    generic: ['Western European Time', 'Western Europe Time', 'West European Time', 'West Europe Time',],
    standard: ['Western European Standard Time', 'Western Europe Standard Time', 'West European Standard Time', 'West Europe Standard Time',],
    daylight: ['Western European Daylight Time', 'Western Europe Daylight Time', 'West European Daylight Time', 'West Europe Daylight Time',]
  ),
};

const Map<String, ({List<String>? generic, List<String>? standard, List<String>? daylight})> metazoneNameAliasesDe = {
  'Brasilia': (generic: ['Brasilianische Zeit'], standard: null, daylight: null),
  'Europe_Central': (generic: null, standard: ['MEZ'], daylight: ['MESZ']),
  'Europe_Eastern': (generic: null, standard: ['OEZ'], daylight: ['OESZ']),
  'Europe_Western': (generic: null, standard: ['WEZ'], daylight: ['WESZ']),
};
