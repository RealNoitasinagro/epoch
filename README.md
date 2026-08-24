[![GitHub Release](https://img.shields.io/github/v/release/RealNoitasinagro/epoch?logo=github)](https://github.com/RealNoitasinagro/epoch/releases/latest)
[![F-Droid](https://img.shields.io/f-droid/v/io.github.RealEarthling.epoch?logo=fdroid)](https://f-droid.org/packages/io.github.RealEarthling.epoch/)
[![Reproducible Build](https://img.shields.io/badge/reproducible%20build-yes-brightgreen?logo=android)](https://verification.f-droid.org/packages/io.github.RealEarthling.epoch/)
[![GPLv3+](https://img.shields.io/badge/license-GPLv3+-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![Android](https://img.shields.io/badge/platform-Android-green?logo=android)](https://f-droid.org/packages/io.github.RealEarthling.epoch/)
[![Flutter](https://img.shields.io/badge/built%20with-Flutter-blue?logo=flutter)](https://flutter.dev)

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


## Features

### Time systems
- **Civil** – date, time, day second, day percent for any timezone
- **Technical** – Unix time, TAI, GPS time
- **Astronomical** – GMST, LMST, Julian Date, Modified Julian Date (MJD), MJD2000
- **Curiosities** – Swatch Internet Time, seven-segment and binary clocks, Doomsday Clock

### Configurable display
- Fully customizable tabs (*Watchlist*) — any values from any category, in any order, plus custom tab labels
- Civil tab configurable with any timezone worldwide
- Flexible timezone search (city, country, timezone name or abbreviation, UTC offset)
- Optionally force standard or summer time for zoned time values all year round
- 7-day advance clock change notice, display upcoming clock changes in the next few years
- Customizable date and time formats, 12/24-hour format toggle
- Timezone details (abbreviation and UTC offset) configurable
- Expanded date toggle
- Thousands separator toggle
- Day quarter color toggle
- Drag-and-drop reordering, swipe to remove
- Custom labels for individual values
- Custom section headers and dividers
- Copy any value to clipboard with one tap

### Design
- Night mode with red-on-black display — preserves dark adaptation for stargazing
- Light, dark, and system themes
- Full-screen toggle (double-tap on the app's name in the top-left corner)
- Focus mode: double-tap any value for full-screen, always-on display; adjustable brightness and color
- Export, import, and reset all preferences (cross-platform, with automatic backup on reset)
- Available in English and German
- Android widgets planned
- Not yet: conversions between time systems

### Privacy & permissions
- **No ads. No notifications. No tracking. No analytics. No network requests.**
- All settings stored locally on your device
- No permissions required -- for LMST, you can specify longitude manually,
  or temporarily grant ACCESS_COARSE_LOCATION permission (one-time setup step)


## What makes Epoch different?

Most clock apps show you one or two time formats.
Epoch shows you 19 different time values simultaneously, lets you pick exactly
which ones you care about, and explains what each one means.

**Epoch is for you if you...**
- are curious about different time systems in use around the world
- want to compare local times across many timezones at a glance (e. g. friends/colleagues abroad)
- enjoy unusual time representations like Swatch Internet Time, day seconds, or binary clocks
- do amateur astronomy and want a single app for sidereal time, LMST, and Julian Date —
  without blue light ruining your dark adaptation
- keep an eye on the Doomsday Clock
- just want to know what Unix time it is right now

Epoch is built around flexibility:
rather than making choices for you, it gives you the building blocks
to assemble exactly the time display you need — and nothing you don't.

> [!TIP]
> Check out the `example_configs` folder with (partly) localized pre-made configurations 
> that you might like to fine-tune for your needs. \
> It also has a [config manual](https://github.com/RealNoitasinagro/epoch/blob/main/example_configs/CONFIG_MANUAL.md) for reference, as well as screenshots (see next section).


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

---

## Platforms

| Platform | Status          | Distribution                                                                                                                                   |
|----------|-----------------|------------------------------------------------------------------------------------------------------------------------------------------------|
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
> Current (2026-08) versions:
> - timezone [0.11.1](https://github.com/dart-lang/labs/releases/tag/timezone-v0.11.1),
> - IANA database in timezone: [2025c](https://www.iana.org/time-zones/releases/2025c), latest available: [2026c](https://www.iana.org/time-zones/releases/2026c)

### Linux

Build and run the *Linux app* from source (requires **[Flutter](https://flutter.dev)**):
```
git clone https://github.com/RealNoitasinagro/epoch.git
cd epoch

flutter build linux --release
flutter run -d linux
```

Alternatively the *web app*:
```
flutter build web --release
flutter run -d chrome
```
OR
```
flutter build web --release
cd build/web
python -m http.server 8000
```
You can then open http://0.0.0.0:8000/ or http://127.0.0.1:8000/ with a browser.

---

## Contributing

Found a bug or have a feature request?
[Open an issue](https://github.com/RealNoitasinagro/epoch/issues) — feedback is welcome.


## License

[![GPLv3+](https://www.gnu.org/graphics/gplv3-127x51.png)](https://www.gnu.org/licenses/gpl-3.0.html)

[GPL-3.0-or-later](https://www.gnu.org/licenses/gpl-3.0.html.en) © 2026 RealEarthling
