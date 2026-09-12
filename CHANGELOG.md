# Changelog

## [Unreleased]

---

## [1.5.0] - 2026-09-12

### Added
- new Curiosities time value types: decimal time, octal time, hexadecimal time, New Earth Time (NET)
- all tabs now fully configurable (except rename for built-ins), built-in tabs can be hidden
- tab visibility toggles in Settings; hidden built-in tabs can be restored to their original position
- new popup menu for Settings, About and What's New
- option to start the app in Focus mode
- burn-in protection for Focus screen through regular pixel shift (esp. for newer Android devices)
- import function shows last loaded config in Settings
- splash screen with logo and version info, logo in title bar

### Changed
- LMST no longer shown dynamically based on your longitude, needs to be (re)added explicitly
- JSON config format, with backwards compatibility maintained (cf. [config manual](https://github.com/RealNoitasinagro/epoch/blob/main/example_configs/CONFIG_MANUAL.md));
keys renamed for clarity: `lmst_lon` → `lmst_longitude`, `zone_display` → `zone_display_mode`
- more informative date and time format subtitles and improved layout in Settings
- binaryClockString now allows to turn seconds off (on tabs and Focus screen)
- improved copy-to-clipboard: long-press for value only, without label
- improved timezone search by offset to allow decimals: +5.5/5,5 (= +5:30), +8.75/8,75 (= +8:45) etc.

### Fixed
- Settings not always showing correct state immediately after import (previous fix for reset insufficient) 

---

## [1.4.0] - 2026-08-08

### Added
- display the next four clock changes for configured time values with (unpinned) DST in info
- date and time formats configurable (preset and custom options)
- day quarter indicator in different colors (on/off-switch in Settings)
- support for direct config loading on Linux command line
- `example_configs` and [config manual](https://github.com/RealNoitasinagro/epoch/blob/main/example_configs/CONFIG_MANUAL.md) on GitHub

### Changed
- a few common timezone abbreviations localized for German (MEZ, MESZ, OEZ, OESZ, WEZ, WESZ)
- much better timezone search keyword coverage (still WIP)
- graphical binary clocks now allow to turn seconds off, like seven-segment clock
- Swatch beats now show two decimals by default (with option for no decimals)
- max (time value) entries per configurable tab increased from 20 to 30 (sections, dividers don't count)

### Fixed
- Swatch beats were up to half a .beat off (because of unwanted rounding)
- custom labels were reset to default labels on repeated edits
- Curiosities tab scroll issue after immersive mode (final value was not fully visible)

---

## [1.3.0] - 2026-07-20

### Added
- 🆒 1-value always-on focus screen with text color selection (and brightness adjust for Android)
- new value type seven-segment clock
- 7-day advance notice of DST transitions
- global configuration option for the UTC-offset line of a zoned time value

### Changed
- much improved timezone keyword search, esp. coverage (e. g. support for megacities)
- day second and day percent with UTC-offset line for consistency

### Fixed
- numeric timezone abbreviations (e. g. "+0845") were ripped apart
- slider buttons in Settings not always showing correct state immediately after reset
- slight button misalignment (visible on Android only) for dividers and section headers

---

## [1.2.0] - 2026-07-01

### Added
- options to force standard or summer time for zoned time values all year round
- multiple display mode variants of the same timezone on one tab (e.g. Berlin auto + Berlin always-standard)
- visual indicators for summer time/DST status (active/inactive) and pinned display mode 
- automatic longitude detection for LMST (restored without Google Play Services dependency)
- custom section headers and dividers on configurable tabs
- export, import, and reset all preferences (cross-platform, with automatic backup on reset)

### Changed
- better legibility of time values: font replaced with JetBrains Mono, subtitle text size increased  
- graphical value types shown in italics in the value type picker

### Fixed
- missing timezones UTC-12, UTC+8:45, UTC+12:45, UTC+13:45, UTC+14

---

## [1.1.1] - 2026-06-11

### Removed
- geolocator -- longitude config for LMST only manual for now

---

## [1.1.0] - 2026-06-10

### Added
- value count for each tab
- number of available value types in entry picker (per category and in total)
- visual marker for timezone-dependant values
- option to expand the date value type with ISO calendar week and day of the year
- value type: Modified Julian Date 2000 (MJD2000)
- value type: Local Mean Sidereal Time (LMST)
- "What's New" under Settings (references CHANGELOG.md on GitHub main branch, = this file)

### Changed
- up to 4 custom tabs rather than 3
- GMST (and LMST) expressed in time units/hours as well as angular units/degrees

### Fixed
- JulianDate (was off by 0.5 days)
- value tile reordering (tile dragged to the end of the list jumped back to last but one position)
- crashes for outdated timezone names

---

## [1.0.0] - 2026-05-21
