# Third-Party Notices

Epoch is licensed under the GPL-3.0-or-later (see `LICENSE.md`). It contains data
derived from, and assets taken from, the third-party sources listed below.
The licenses of the Dart and Flutter packages used by the app are collected
automatically and can be read in the app (About, then the licenses page).
This file covers data and assets that are not packages. The license texts of
the data and font below are also shipped with the app (`assets/licenses/`) and
shown on that page.

| Material                              | Used for                                                                                                           | License                   |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------|---------------------------|
| IANA Time Zone Database (tz / tzdata) | zone identifiers and links, zone-to-country assignment, English country names (ISO 3166), historical abbreviations | public domain             |
| Unicode CLDR                          | localized (English, German) country names, city names, time zone names, metazone assignments, Windows zone names   | Unicode License v3        |
| Wikidata                              | national capital cities (English, German)                                                                          | CC0 1.0                   |
| JetBrains Mono (font)                 | all monospaced text                                                                                                | SIL Open Font License 1.1 |

## IANA Time Zone Database

Source: https://www.iana.org/time-zones (code and data:
https://github.com/eggert/tz). The tz code and data are in the public domain
([LICENSE](https://github.com/eggert/tz/blob/main/LICENSE)).

Epoch uses the compiled database through the
[timezone](https://pub.dev/packages/timezone) package at runtime. The files
`zone1970.tab`, `iso3166.tab` and the `Zone` / `Link` directives of the tzdata
sources are the basis of `lib/models/generated/zone1970_countries.g.dart`,
`iso3166_country_names_en.g.dart`, `iana_canonical_zones_snapshot.g.dart` and
`iana_links_snapshot.g.dart`. The alphabetic time zone abbreviations that
tzdata dropped in 2016 (such as BRST or ICT) were recovered from tzdata 2016a
(`legacy_abbreviations.g.dart`).

## Unicode CLDR

Source: https://github.com/unicode-org/cldr-json (JSON distribution of the
Unicode Common Locale Data Repository, https://cldr.unicode.org).

Data used: `territories.json` (country names), `timeZoneNames.json` (city and
time zone names, metazone names), `metaZones.json` and `windowsZones.json`.
Epoch extracts and transforms this data into
`lib/models/generated/cldr_*.g.dart`.

Copyright © 1991-2026 Unicode, Inc. Distributed under the Unicode License v3.
The full text is in `assets/licenses/unicode_cldr.txt` and at
https://www.unicode.org/license.txt.

## Wikidata

Source: https://www.wikidata.org. Capital city names were queried with the
Wikidata Query Service (property P36) and stored in
`lib/models/generated/wikidata_capitals_{en,de}.g.dart`. Structured data in
Wikidata is available under
[CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/); no attribution is
required, but it is gratefully given.

## JetBrains Mono

Copyright 2020 The JetBrains Mono Project Authors
(https://github.com/JetBrains/JetBrainsMono). Licensed under the SIL Open Font
License, Version 1.1. The full text is in
`assets/licenses/jetbrains_mono.txt` and at https://openfontlicense.org.

## Facts and names

- Leap second dates (TAI, GPS) and the Doomsday Clock settings over time are
  published facts (IERS Bulletin C, Bulletin of the Atomic Scientists,
  https://thebulletin.org/doomsday-clock/). Epoch is not affiliated with the
  Bulletin of the Atomic Scientists.
- Search aliases, city and country name variants in `lib/models/timezone_search_*.dart`
  and `manualTerms` are maintained by hand as part of Epoch.
- All trademarks and names mentioned belong to their respective owners.

## Regenerating the data

The generated files carry their source and data version in their header
(for example "tzdata 2026e", "CLDR 49.0.0"). They are produced by the scripts
in `tools/` (see `tools/regenerate_data.sh`). When the data is regenerated
from a new release, the license terms of that release apply; check the copyright
line above against the license file shipped with it.
