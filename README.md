[![GitHub Release](https://img.shields.io/github/v/release/RealNoitasinagro/epoch?logo=github)](https://github.com/RealNoitasinagro/epoch/releases/latest)  [![F-Droid](https://img.shields.io/f-droid/v/io.github.RealEarthling.epoch?logo=fdroid)](https://f-droid.org/packages/io.github.RealEarthling.epoch/)  [![Reproducible Build](https://img.shields.io/badge/reproducible%20build-yes-brightgreen?logo=android)](https://verification.f-droid.org/packages/io.github.RealEarthling.epoch/)  [![GPLv3+](https://img.shields.io/badge/license-GPLv3+-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)  [![Android](https://img.shields.io/badge/platform-Android-green?logo=android)](https://f-droid.org/packages/io.github.RealEarthling.epoch/)  [![Flutter](https://img.shields.io/badge/built%20with-Flutter-blue?logo=flutter)](https://flutter.dev)

---

# Epoch

> *A time display app for nerds and amateur astronomers.*

**Epoch** displays the current moment across a wide range of civil,
technical, and astronomical time systems — all in one place,
updating every second.

The name is borrowed from the technical term for a reference point
in time (as in *Unix epoch* or *astronomical epoch*). The letters
also happen to spell out **E**legant **p**resentation **o**f
**ch**ronometers — though the word came first.


## Highlights

- **28 time values in one app** – civil, technical, astronomical and curious:
  from Unix time, TAI and GPS time to sidereal time, Julian Date variants,
  Swatch Internet Time and the Doomsday Clock
- **Your own time zone engine** – every IANA time zone, found by city, country,
  capital, name, abbreviation or UTC offset (English and German), with its own
  IANA database that does not depend on your device's system updates
- **Time Shift** – see any moment between 1970 and 2038 in all time systems,
  running or frozen, without touching your system clock
- **Build your own displays** – combine any values on your own tabs or
  customize the built-in ones; export your setup as a single config file
- **Focus mode and night mode** – full-screen always-on display with burn-in
  protection; red-on-black theme that preserves your dark adaptation
- **Privacy first** – no ads, no tracking, no network requests, no permissions


## Features

### Time systems
- **Civil** – date (with ISO week and day of the year), time, date & time,
  day second, day percent, seven-segment clock; for any time zone
- **Technical** – Unix time, International Atomic Time (TAI), GPS time
  (with historical leap seconds)
- **Astronomical** – Greenwich and Local Mean Sidereal Time (GMST, LMST),
  Julian Date (JD), Modified Julian Date (MJD), MJD2000 and 4 other JD variants
  (Reduced, Dublin, CNES, CCSDS)
- **Curiosities** – decimal time, Swatch Internet Time, New Earth Time,
  3 binary clocks[^1], octal time[^1], hexadecimal time[^1], Roman numerals
  time and the Doomsday Clock
- On days with a clock change, day second, day percent and decimal/octal/hexadecimal
  time use the real length of the day (23 or 25 hours, 23.5 or 24.5 for Lord Howe)

### Time zones
- Search by city, country, capital, zone name or abbreviation (also historical
  ones such as BRST) or UTC offset (e. g. +5:30), in English and German
- Time zone details configurable: abbreviation, UTC offset, both, or hidden
- Daylight saving handled from the zone data itself: the next clock changes
  in a value's info dialog (with the wall-clock time before and after the
  change), a 7-day advance notice on the value itself
- Optionally pin a zone to standard or summer time all year round, or show
  both variants side by side
- Day quarter color: a colored edge shows which quarter of the day it is
  in that zone
- Always up-to-date rules: Epoch ships its own IANA database
  (see [Timeliness of the Timezone Data](#timeliness-of-the-timezone-data))

### Time Shift
- Show any moment from 1970-01-01 to 2038-01-19 (UTC; the limits of Unix time
  and of the available IANA data) in all values – running from there, or frozen
- Date and time are set separately, with calendar and dial pickers
- Your system clock stays untouched; the title bar shows the real system time
  while Time Shift is active, the Focus screen has an optional indicator
- Past values are historically correct: leap seconds for TAI and GPS time,
  the Doomsday Clock's earlier settings, the time zone rules of that time
- Not saved: the app always starts with the system time

### Your layout
- Up to 4 own tabs (Watchlists) with up to 30 values each; all built-in tabs
  (Civil, Technical, Astronomical, Curiosities) are fully editable, can be
  hidden and restored to their original position
- Drag-and-drop reordering, swipe to remove, reset to defaults per tab
- Custom labels for values, custom section headers and dividers
- Copy any value to the clipboard: one tap with label, long press value only

### Formats and display options
- Date and time formats: presets or custom patterns; 12/24-hour format
- Expanded date (ISO week number, day of the year)
- Day quarter color on or off
- Thousands separator switch

### Config files
- Export, import and reset all preferences (cross-platform, with automatic
  backup on reset); plain JSON that you can edit by hand
- Load a config directly from the Linux command line
- Ready-made [example configs](example_configs) and a
  [config manual](example_configs/CONFIG_MANUAL.md)

### Focus mode
- Double-tap any value for a full-screen, always-on display
- Adjustable color (all platforms) and brightness (Android)
- Long press toggles details (seconds, decimals, time zone line)
- Burn-in protection through regular pixel shift (especially on OLED screens)
- Optionally start the app directly in Focus mode

### Look and feel
- Night mode: red on black, preserving your dark adaptation for stargazing
- Light, dark and system themes; monospaced JetBrains Mono font
- Full-screen toggle (double-tap on the app's name or logo in the top-left corner)
- Available in English and German

### Privacy and permissions
- **No ads. No notifications. No tracking. No analytics. No network requests.**
- All settings stored locally on your device
- No permissions required – for LMST you can enter longitude manually, or
  temporarily grant ACCESS_COARSE_LOCATION permission (one-time setup step)
- Free software (GPL), F-Droid reproducible builds

### Planned
- Android widgets, value conversion between time systems, new value types, and more


## What makes Epoch different?

Most clock apps show you one or two time formats.
Epoch shows you 28 different time values simultaneously, lets you pick exactly
which ones you care about, and explains what each one means.

**Epoch is for you if you...**
- are curious about the many ways time is counted and displayed
- want to compare local times across many time zones at a glance (e. g.
  friends or colleagues abroad), including their upcoming clock changes
- need current time zone rules although your phone's system no longer
  receives updates: old devices keep outdated rules, Epoch ships its own
  up-to-date IANA database (e. g. for recent changes in Canada)
- want to see how any moment, past or future, looks in all time systems,
  without touching your system clock
- enjoy unusual time representations like Swatch Internet Time, day seconds,
  Roman numerals or binary clocks
- do amateur astronomy and want a single app for sidereal time, LMST and
  Julian Date – in a night mode that does not ruin your dark adaptation
- want a bedside or desk clock with a seven-segment look and burn-in protection
- keep an eye on the Doomsday Clock (and its history)
- just want to know what Unix time it is right now

Epoch is built around flexibility:
rather than making choices for you, it gives you the building blocks
to assemble exactly the time display you need — and nothing you don't.


## Screenshots

Android screenshots are in `fastlane/metadata/android/{en-US,de-DE}/images/phoneScreenshots/`. \
There are slight differences between the two sets to highlight different aspects and details.

<details>
<summary>Click to expand (English)</summary>

<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/1.png" width="180" alt="en 1">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/2.png" width="180" alt="en 2">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/3.png" width="180" alt="en 3">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/4.png" width="180" alt="en 4">
</p>
<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/5.png" width="180" alt="en 5">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/6.png" width="180" alt="en 6">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/7.png" width="180" alt="en 7">
</p>
<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/8.png" width="350" alt="en 8">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/9.png" width="350" alt="en 9">
</p>

</details>

<details>
<summary>Click to expand (German)</summary>

<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/1.png" width="180" alt="de 1">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/2.png" width="180" alt="de 2">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/3.png" width="180" alt="de 3">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/4.png" width="180" alt="de 4">
</p>
<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/5.png" width="180" alt="de 5">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/6.png" width="180" alt="de 6">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/7.png" width="180" alt="de 7">
</p>
<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/8.png" width="350" alt="de 8">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/9.png" width="350" alt="de 9">
</p>

</details>

Additional screenshots in `example_configs/{de-DE,en-US}/screenshots/`:

<details>
<summary>Click to expand (English)</summary>

<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/en-US/screenshots/epoch_settings_home.png" width="180" alt="en epoch_settings_home.json">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/en-US/screenshots/epoch_settings_spaceflight.png" width="180" alt="en epoch_settings_spaceflight.json">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/en-US/screenshots/epoch_settings_special_timezones.png" width="180" alt="en epoch_settings_special_timezones.json">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/en-US/screenshots/epoch_settings_uno.png" width="180" alt="en epoch_settings_uno.json">
</p>

<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/en-US/screenshots/epoch_settings_world_clock.png" width="180" alt="en epoch_settings_world_clock.json">
</p>

</details>

<details>
<summary>Click to expand (German)</summary>

<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/de-DE/screenshots/epoch_settings_home.png" width="180" alt="de epoch_settings_home.json">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/de-DE/screenshots/epoch_settings_spaceflight.png" width="180" alt="de epoch_settings_spaceflight.json">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/de-DE/screenshots/epoch_settings_special_timezones.png" width="180" alt="de epoch_settings_special_timezones.json">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/de-DE/screenshots/epoch_settings_uno.png" width="180" alt="de epoch_settings_uno.json">
</p>

<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/example_configs/de-DE/screenshots/epoch_settings_world_clock.png" width="180" alt="en epoch_settings_world_clock.json">
</p>

</details>


## Platforms

| Platform | Status           | Distribution                                                                                                                                   |
|----------|------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| Android  | ✅ Supported     | [F-Droid](https://f-droid.org/packages/io.github.RealEarthling.epoch/) · [GitHub Releases](https://github.com/RealNoitasinagro/epoch/releases) |
| Linux    | ✅ Supported     | [GitHub Releases](https://github.com/RealNoitasinagro/epoch/releases)                                                                          |
| Web      | ✅ Supported     | [GitHub Pages](https://RealNoitasinagro.github.io/epoch) (possibly newer than latest release)                                                  |
| iOS      | ❌ Not supported |                                                                                                                                                |
| macOS    | ❌ Not supported |                                                                                                                                                |
| Windows  | ❌ Not supported |                                                                                                                                                |

[<img src="https://f-droid.org/badge/get-it-on.png" alt="Get it on F-Droid" width="24%" align="center">](https://f-droid.org/packages/io.github.RealEarthling.epoch)

### Timeliness of the Timezone Data

> [!NOTE]
> Epoch uses the [timezone](https://pub.dev/packages/timezone) package,
> which bundles the [IANA Time Zone Database](https://www.iana.org/time-zones). \
> The timezone package may not have the latest available IANA database, and politically motivated
> changes may not yet be reflected. \
> For most use cases, this makes no difference. \
> However, if you'd like to build Epoch yourself with an up-to-date IANA db, check out the script
> `update_timezone_to_latest_iana_db.sh` in the repo's root. \
> It's a wrapper around the `tool/refresh.sh` script provided by the timezone package. \
> Current (2026-10) versions:
> - timezone [0.11.2](https://github.com/dart-lang/labs/releases/tag/timezone-v0.11.2),
> - IANA database in timezone: [2026e](https://www.iana.org/time-zones/releases/2026e), latest available: [2026f](https://www.iana.org/time-zones/releases/2026f)

### Linux

Build and run the *Linux app* from source (requires **[Flutter](https://flutter.dev)**):
```
$ git clone https://github.com/RealNoitasinagro/epoch.git
$ cd epoch

$ flutter build linux --release
$ flutter run -d linux
```

Alternatively the *web app*:
```
$ flutter build web --release
$ flutter run -d chrome
```
OR
```
$ flutter build web --release
$ cd build/web
$ python -m http.server 8000
```
You can then open http://0.0.0.0:8000/ or http://127.0.0.1:8000/ with a browser.


## Verifying downloads

Every release on GitHub comes with the APK files and a `sha256sums.txt`.
The APKs on GitHub and on F-Droid are signed with the same key.

Check the file integrity (Linux):
```
$ sha256sum --check --ignore-missing sha256sums.txt
```
Check the signature with `apksigner verify --print-certs <downloaded apk>` (`apksigner` is part of the Android SDK build tools):
```
$ apksigner verify --print-certs app-arm64-v8a-release.apk | grep SHA-256
V2 Signer: certificate SHA-256 digest: 7263c0bfce95b625839598b01fdcc695c04cdbe6dd4fa34a02a2d3ad2522c246
```
The `certificate SHA-256 digest` line must show: `7263c0bfce95b625839598b01fdcc695c04cdbe6dd4fa34a02a2d3ad2522c246`. \
The same fingerprint is published independently of this repository in F-Droid's [build metadata](https://gitlab.com/fdroid/fdroiddata/-/blob/master/metadata/io.github.RealEarthling.epoch.yml) (`AllowedAPKSigningKeys`). \
If the digest differs, or `apksigner` reports an error, do not install the APK.

## Contributing

Found a bug or have a feature request?
[Open an issue](https://github.com/RealNoitasinagro/epoch/issues) — feedback is welcome.


## License

[![GPLv3+](https://www.gnu.org/graphics/gplv3-127x51.png)](https://www.gnu.org/licenses/gpl-3.0.html)

Epoch is free software under the
[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.html.en),
© 2026 RealEarthling.

Epoch includes data and a font under other licenses: IANA time zone data
(public domain), Unicode CLDR (Unicode License v3), Wikidata capitals (CC0) and
JetBrains Mono (SIL Open Font License 1.1). Details are in
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). The licenses of all packages,
the bundled data and the font can also be read in the app (menu, About,
View licenses).


[^1]: These values use a 'seconds since midnight in base N' rather than a 'fraction of day in base N' approach.
