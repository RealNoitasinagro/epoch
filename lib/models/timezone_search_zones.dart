import 'generated/iana_canonical_zones_snapshot.g.dart';
import 'tz_entry.dart';

const Map<String, List<String>> manualTerms = {
  // names
  'Africa/Nairobi': ['Somaliland', 'Hargeisa', 'Hargeysa'],
  'America/Nuuk': ['West Greenland Time', 'West Greenland Summer Time', 'Westgrönland-Zeit', 'Westgrönland-Sommerzeit'],
  'America/Scoresbysund': ['East Greenland Time', 'East Greenland Summer Time', 'Ostgrönland-Zeit', 'Ostgrönland-Sommerzeit'],
  'Asia/Nicosia': ['Northern Cyprus', 'Turkish Republic of Northern Cyprus', 'TRNC', 'Nord-Zypern', 'Türkische Republik Nordzypern', 'TRNZ'],
  'Etc/GMT': ['Greenwich-Zeit'],
  'Etc/GMT+12': ['Anywhere on Earth', 'AOE', 'Datumsgrenze', 'Datumslinie'],
  'Etc/GMT-3': ['Abkhazia', 'Sukhumi', 'South Ossetia', 'Tskhinvali', 'Further-Eastern European Time', 'FET', 'Abchasien', 'Sochumi', 'Südossetien', 'Zchinwali'],
  'Etc/UTC': ['Universal Time Coordinated'],
  'Europe/Belgrade': ['Kosovo', 'Pristina'],
  'Europe/Chisinau': ['Transnistria', 'Pridnestrovian Moldavian Republic', 'PMR', 'Pridnestrovie', 'Transnistrien', 'Transnistrische Moldauische Republik', 'Transnistrische Moldawische Republik', 'Cisnistrische Moldauische Republik', 'Cisnistrien', 'Pridnestrowische Moldauische Republik', 'Pridnestrowische Moldawische Republik', 'Pridnestrowien'],
  'Europe/Dublin': ['Irish Summer Time'],
  // abbreviations
  'Africa/El_Aaiun': ['WST', 'WT'],
  'America/Panama': ['CIST', 'CIDST'],
  'Atlantic/Stanley': ['FKDT'],
  'Australia/Brisbane': ['AET'],
  'Australia/Hobart': ['AET'],
  'Australia/Melbourne': ['AET'],
  'Australia/Perth': ['WST'],
  'Australia/Sydney': ['AET'],
  'Pacific/Apia': ['WST'],
  'Pacific/Norfolk': ['NFDT'],
  'Pacific/Port_Moresby': ['YAPT'],
};

final List<TzEntry> tzDatabase = [
  for (final zoneId in ianaCanonicalZonesSnapshot)
    TzEntry(ianaZoneId: zoneId, terms: manualTerms[zoneId] ?? const []),
];
