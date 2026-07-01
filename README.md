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
- **Curiosities** – Swatch Internet Time, 3 binary clocks, Doomsday Clock

### Configurable display
- Fully customizable tabs (*Watchlist*) — any values from any category, in any order, plus custom tab labels
- Civil tab configurable with any timezone worldwide
- Flexible timezone search (city, country, timezone name or abbreviation, UTC offset)
- Optionally force standard or summer time for zoned time values all year round
- Drag-and-drop reordering, swipe to remove
- Custom labels for individual values
- Custom section headers and dividers
- Copy any value to clipboard with one tap

### Design
- Night mode with red-on-black display — preserves dark adaptation for stargazing
- Light, dark, and system themes
- Full-screen toggle (double-tap on the app's name in the top-left corner)
- 12 / 24-hour format toggle
- Thousands separator toggle
- Expanded date toggle
- Export, import, and reset all preferences (cross-platform, with automatic backup on reset)
- Available in English and German
- Android widgets coming soon
- Not yet: conversions between time systems

### Privacy & permissions
- **No ads. No notifications. No tracking. No analytics. No network requests.**
- All settings stored locally on your device
- No permissions required -- for LMST, you can specify longitude manually,
  or temporarily grant ACCESS_COARSE_LOCATION permission (one-time setup step)


## What makes Epoch different?

Most clock apps show you one or two time formats.
Epoch shows you 18 different time values simultaneously, lets you pick exactly
which ones you care about, and explains what each one means.
It is built for people who are curious about how time actually works.


## Screenshots

Android screenshots are in `fastlane/metadata/android/{en-US,de-DE}`.

<details>
<summary>Click to expand (English)</summary>

<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/1.png" width="200" alt="en 1">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/2.png" width="200" alt="en 2">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/3.png" width="200" alt="en 3">
</p>
<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/4.png" width="200" alt="en 4">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/5.png" width="200" alt="en 5">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/en-US/images/phoneScreenshots/6.png" width="200" alt="en 6">
</p>

</details>

<details>
<summary>Click to expand (German)</summary>

<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/1.png" width="200" alt="de 1">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/2.png" width="200" alt="de 2">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/3.png" width="200" alt="de 3">
</p>
<p>
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/4.png" width="200" alt="de 4">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/5.png" width="200" alt="de 5">
  <img src="https://raw.githubusercontent.com/RealNoitasinagro/epoch/main/fastlane/metadata/android/de-DE/images/phoneScreenshots/6.png" width="200" alt="de 6">
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