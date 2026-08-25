# Epoch Configuration Manual

Epoch stores all settings in a single JSON file that can be exported, imported, and edited manually. \
This folder contains example configurations and this reference document. \
There are also localized configurations in corresponding sub-folders with accompanying screenshots; \
they focus on setting up custom tabs and are otherwise pretty minimal (using defaults as much as possible). \
Try these configs out, tweak them to your liking, and perhaps create your own collection of configs for different purposes.


## Quick Start

1. Open Epoch → Settings → Export preferences
2. Open the exported file in a text editor
3. Make changes following this guide
4. Import via Settings → Import preferences


## File Format

The configuration file is a flat JSON object. All keys are optional — missing keys fall back to Epoch's defaults. \
Default values will show up in config files when a non-default value had been configured previously.

### Global Settings

| Key                        | Type             | Default             | Description                                                                             |
|----------------------------|------------------|---------------------|-----------------------------------------------------------------------------------------|
| `active_tab`               | string           | `0`                 | app will open with the tab used last                                                    |
| `all_tabs`                 | array of strings | `[]`                | each line contains the settings for one tab (see below)                                 |
| `date_cw_doy`              | bool             | `true`              | Show ISO week number and day of year                                                    |
| `date_format`              | string           | `"EEE, YYYY-MM-DD"` | Date display format (see tokens below)                                                  |
| `day_quarter_color`        | bool             | `true`              | Show day quarter indicator in night red, cyan, amber, matrix green                      |
| `focus_brightness`         | number           | `0.5`               | Focus screen brightness (0.01–1.0, mobile-only)                                         |
| `focus_color`              | integer          | `4294967295`        | Focus screen text color as ARGB integer (see below)                                     |
| `focus_pixel_shift`        | bool             | `true` (Android)    | Burn-in protection for Focus screen through regular pixel shift                         |
| `hour_format_24`           | bool             | `true`              | 24-hour clock                                                                           |
| `last_export_dir`          | string           | `""`                | Path to a folder (defaults platform-specific)                                           |
| `last_imported_config`[^1] | string           | `""`                | Filename of the last imported config                                                    |
| `lmst_longitude`           | number           | `—`                 | Longitude in decimal degrees (−180 to +180)                                             |
| `lmst_mode`                | string           | `"off"`             | `"off"`, `"manual"`, `"locationAccess"`                                                 |
| `locale`                   | string           | `"en"`              | `"en"` or `"de"`                                                                        |
| `theme_mode`               | string           | `"system"`          | `"light"`, `"dark"`, `"night"`, `"system"`                                              |
| `time_format`              | string           | `"HH:mm:ss"`        | Time display format (see tokens below)                                                  |
| `thousands_sep`            | bool             | `true`              | Thousands separator in numbers (locale-dependent)                                       |
| `zone_display_mode`        | string           | `"full"`            | `"full"`, `"abbreviation"`, `"offsetLong"`, `"offsetShort"`, `"offsetMini"`, `"hidden"` |

[^1]: Information only, setting this by hand has no effect, therefore not included in `epoch_settings_reference.json`.

> [!TIP]
> * If you want to set up your own configuration from scratch, start with a copy of `epoch_settings_reference.json`.
> * As an alternative way to reset the whole app to defaults (and bypassing backup!), you can import an empty config (`reset_to_defaults.json`).
> * If you want to "comment out" a setting, rename its key to make it invalid, e.g. append "ooo" for out-of-order. That way you can keep an entry in the config while making the app ignore it.

### Date Format Tokens

| Token  | Example (2026-01-09) | Description             |
|--------|----------------------|-------------------------|
| `YYYY` | 2026                 | Four-digit year         |
| `YY`   | 26                   | Two-digit year          |
| `MM`   | 01                   | Month, zero-padded      |
| `M`    | 1                    | Month, no leading zero  |
| `MMMM` | January              | Month name, full        |
| `MMM`  | Jan                  | Month name, abbreviated |
| `DD`   | 09                   | Day, zero-padded        |
| `D`    | 9                    | Day, no leading zero    |
| `EEEE` | Friday               | Weekday, full           |
| `EEE`  | Fri                  | Weekday, abbreviated    |

Any character not listed above is used as a literal separator. \
Examples: `YYYY-MM-DD`, `DD.MM.YYYY`, `EEE, MMMM D YYYY`

### Time Format Tokens

| Token | Example (08:14:27) | Description           |
|-------|--------------------|-----------------------|
| `HH`  | 08                 | Hour, zero-padded     |
| `H`   | 8                  | Hour, no leading zero |
| `mm`  | 14                 | Minutes, zero-padded  |
| `ss`  | 27                 | Seconds, zero-padded  |

Examples: `HH:mm:ss`, `HH:mm`, `HHmm` \
Note: The 12/24-hour setting applies to all time values uniformly.

### Focus Color Options

| Color           | ARGB integer |
|-----------------|--------------|
| white (default) | 4294967295   |
| night red       | 4291563536   |
| matrix green    | 4278255425   |
| amber           | 4294947584   |
| cyan            | 4278248959   |
| grey            | 4289769648   |


## Tab Configuration

### Predefined Tabs

Civil, Technical, Astronomical, and Curiosities behave like any custom Watchlist tab – 
fully configurable, with edit mode, reset-to-defaults, and full value-type picker. \
The only real difference is that they cannot be renamed.
They can be hidden and re-shown either via their own tab menu (long-press) or via Settings → Tab visibility. \
Their built-in default entries are defined by the app; any user edits are persisted like on any other tab.

### Tabs

Tabs are stored as a JSON array under the key `all_tabs`. \
Each entry is a tab string, its position in the array determines its place in the app.
(It's currently not possible to reorder tabs in the app itself.) \
The string consists of fields separated by tabulator characters (`\t`):

```
"all_tabs": [
  TAB_ID\tCustomNameOrEmpty\tBuiltinKindOrEmpty\tVisible\tENTRY\tENTRY\t...
]
```
- **`TAB_ID`**: a numeric string (millisecond timestamp, or timestamp + counter), must be *unique across all tabs in the file* – duplicate IDs cause entry updates and deletions to target the wrong tab.
- **`CustomNameOrEmpty`**: the tab's name. Leave empty for a built-in tab (Civil/Technical/Astronomical/Curiosities) – its name is always shown localized in the app's current language and cannot be overridden. Required (non-empty) for Watchlist tabs.
- **`BuiltinKindOrEmpty`**: one of `civil`, `technical`, `astronomical`, `curiosities` for a built-in tab, or empty for a Watchlist tab.
- **`Visible`**: `1` (visible) or `0` (hidden). Hidden built-in tabs keep their entries in the file and can be re-shown via Settings → Tab visibility. Hidden Watchlist tabs are not currently reachable from the UI.

**Entries** can be one of:
- time value of a certain value type,
- divider,
- section header.

#### Time Value

```
valueType/zone
valueType/zone|Custom Label
valueType/zone|Custom Label|dst:forceDst
valueType/zone||dst:forceStandard
```
Note: `valueType` and `zone` are obligatory, custom label and forced clock change mode settings are optional.

##### Value types

| `valueType`              | Description                  |
|--------------------------|------------------------------|
| `date`                   | Current date                 |
| `time`                   | Current time                 |
| `dateTime`               | Date and time combined       |
| `daySecond`              | Seconds elapsed today        |
| `dayPercent`             | Day progress as percentage   |
| *`sevenSegmentClock`*    | Seven-segment Clock          |
| `unixSeconds`            | Unix timestamp               |
| `tai`                    | International Atomic Time    |
| `gps`                    | GPS Time                     |
| `gmst`                   | Greenwich Mean Sidereal Time |
| `lmst`                   | Local Mean Sidereal Time     |
| `julianDate`             | Julian Date                  |
| `modifiedJulianDate`     | Modified Julian Date         |
| `modifiedJulianDate2000` | MJD relative to J2000.0      |
| `binaryClockString`      | Binary Time (string)         |
| *`binaryClockColumns`*   | Binary Clock (columns)       |
| *`binaryClockBcd`*       | Binary Clock (BCD)           |
| `swatchBeats`            | Swatch Internet Time         |
| `doomsdayClock`          | Doomsday Clock               |

*Graphical types* in italics.

##### Zones

| `zone`                | Description                |
|-----------------------|----------------------------|
| `local`               | Device local time          |
| `utc`                 | Coordinated Universal Time |
| `named:Europe/Berlin` | Any IANA timezone name     |

> [!IMPORTANT]
> The zone part is mandatory -- even for zone-independent value types (e. g. `gps`). \
> Use `utc` for those. Other values would work technically, but are probably more confusing. \
> Values where the zone is missing will be silently ignored.

##### Clock change mode

The optional suffix is only for zones that have DST:

| Suffix              | Effect                                |
|---------------------|---------------------------------------|
| *(none)*            | Automatic (follows current DST rules) |
| `dst:forceDst`      | Always show summer time               |
| `dst:forceStandard` | Always show standard time             |

##### Show seconds

The optional suffix is only for `binaryClockColumns`, `binaryClockBcd`, `sevenSegmentClock` and `swatchBeats`:

| Suffix    | Effect                  |
|-----------|-------------------------|
| *(none)*  | Show seconds / decimals |
| `\|nosec` | Hide seconds / decimals |

#### Divider

```
divider:DIVIDER_ID
```

Renders a horizontal line between entries.

#### Section Header

```
section:SECTION_ID:Section Title
```

Renders a section heading above the following entries.

> [!NOTE]
> A section title starting with `@` is reserved for the app's own built-in, localized section headers (`unix`, `atomic`, `gps`, `sidereal`, `julian`, `internet`, `binaryClock`, `doomsdayClock` – these show translated names that follow the app's current language).
> Your own section titles can start with `@` too; just make sure it does not exactly match one of these reserved keywords.

### Config Example

```json
{
  "active_tab": 4,
  "all_tabs": [
    "1000000000000\t\tcivil\t1",
    "1000000000001\t\ttechnical\t0",
    "1000000000002\t\tastronomical\t0",
    "1000000000003\t\tcuriosities\t0",
    "1000000000004\tMy Tab\t\t1\tdateTime/local|Home\tdivider:2000000000001\tsection:2000000000002:Sidereal\tgmst/utc\tlmst/utc\tdivider:3000000000001\tsection:3000000000002:Julian\tjulianDate/utc\tmodifiedJulianDate/utc\tmodifiedJulianDate2000/utc"
  ],
  "date_format": "EEEE, YYYY-MM-DD",
  "lmst_longitude": 10.2339598,
  "lmst_mode": "manual"
}
```
Note that the four built-in tabs above are shown with an empty entry list purely for brevity in this example (it's syntactically valid, Civil would show with defaults). 
In a real config they typically carry their full default entries (cf. `epoch_settings_reference.json`), or your own customizations of them. \
In case you have the `all_tabs` array in your config and want to see only your custom tabs in the app, you need to specify the builtin tabs explicitly with visibility off (0). Otherwise the app will try to restore missing tabs. 

> [!TIP]
> The app keeps JSON keys in alphabetical order.
> Though not necessary technically, you might want to do the same when creating configs manually to facilitate comparing files. 

> [!NOTE]
> Manually editing configuration files can exceed limits enforced by the app UI  (e.g. more than the max number of values per tab, duplicate entries, trailing dividers). \
> The app does not validate imported files beyond basic JSON syntax. Use with care.

## Contributing

Have an interesting configuration to share? Pull requests for new example configs are welcome. \
Please include a brief description of the use case.
