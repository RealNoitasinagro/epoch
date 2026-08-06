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

| Key                | Type             | Default             | Description                                                                             |
|--------------------|------------------|---------------------|-----------------------------------------------------------------------------------------|
| `active_tab`       | string           | `0`                 | app will open with the tab used last                                                    |
| `custom_tabs`      | array of strings | `[]`                | user-defined Watchlist tabs (see below)                                                 |
| `date_cw_doy`      | bool             | `true`              | Show ISO week number and day of year                                                    |
| `date_format`      | string           | `"EEE, YYYY-MM-DD"` | Date display format (see tokens below)                                                  |
| `focus_brightness` | number           | `0.5`               | Focus screen brightness (0.01–1.0, mobile-only)                                         |
| `focus_color`      | integer          | `4294967295`        | Focus screen text color as ARGB integer (see below)                                     |
| `hour_format_24`   | bool             | `true`              | 24-hour clock                                                                           |
| `last_export_dir`  | string           | `""`                | Path to a folder (defaults platform-specific)                                           |
| `lmst_lon`         | number           | `—`                 | Longitude in decimal degrees (−180 to +180)                                             |
| `lmst_mode`        | string           | `"off"`             | `"off"`, `"manual"`, `"locationAccess"`                                                 |
| `locale`           | string           | `"en"`              | `"en"` or `"de"`                                                                        |
| `theme_mode`       | string           | `"system"`          | `"light"`, `"dark"`, `"night"`, `"system"`                                              |
| `time_format`      | string           | `"HH:mm:ss"`        | Time display format (see tokens below)                                                  |
| `thousands_sep`    | bool             | `true`              | Thousands separator in numbers (locale-dependent)                                       |
| `zone_display`     | string           | `"full"`            | `"full"`, `"abbreviation"`, `"offsetLong"`, `"offsetShort"`, `"offsetMini"`, `"hidden"` |

> [!TIP]
> If you want to set up your own configuration from scratch, start with a copy of `epoch_settings_reference.json`. \
> As an alternative way to reset the whole app to defaults (and bypassing backup!), you can import an empty config (`reset_to_defaults.json`).

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

The Civil, Technical, Astronomical, and Curiosities tabs are built in and
cannot currently be configured via the file format. \
This will change soon. Custom tabs are already fully configurable.

### Custom Tabs

Custom tabs are stored as a JSON array under the key `custom_tabs`. \
Each entry is a tab string, its position in the array determines its place in the app.
(It's currently not possible to reorder tabs in the app itself.) \
The string consists of fields separated by tabulator characters (`\t`):

```
"custom_tabs": [
  "TAB_ID\tTab Name\tENTRY\tENTRY\t..."
]
```

**Tab ID:** Typically a numeric string (millisecond timestamp).

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

**Value types:**

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

**Zones:**

| `zone`                | Description                |
|-----------------------|----------------------------|
| `local`               | Device local time          |
| `utc`                 | Coordinated Universal Time |
| `named:Europe/Berlin` | Any IANA timezone name     |

> [!IMPORTANT]
> The zone part is mandatory -- even for zone-independent value types (e. g. `gps`). \
> Use `utc` for those. Other values would work technically, but are probably more confusing. \
> Values where the zone is missing will be silently ignored.

**Clock change mode** (optional suffix, for zones that have DST):

| Suffix              | Effect                                |
|---------------------|---------------------------------------|
| *(none)*            | Automatic (follows current DST rules) |
| `dst:forceDst`      | Always show summer time               |
| `dst:forceStandard` | Always show standard time             |

**Show seconds** (optional suffix for `binaryClockColumns`, `binaryClockBcd`, `sevenSegmentClock` and `swatchBeats`):

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

### Custom Tab Example

```json
{
  "active_tab": 4,
  "custom_tabs": [
    "1000000000000\tMy Tab\tdateTime/local|Home\tdivider:2000000000001\tsection:2000000000002:Sidereal\tgmst/utc\tlmst/utc\tdivider:3000000000001\tsection:3000000000002:Julian\tjulianDate/utc\tmodifiedJulianDate/utc\tmodifiedJulianDate2000/utc"
  ],
  "date_format": "EEEE, YYYY-MM-DD",
  "lmst_lon": 10.2339598,
  "lmst_mode": "manual"
}
```
> [!TIP]
> The app keeps JSON keys in alphabetical order.
> Though not necessary technically, you might want to do the same when creating configs manually to facilitate comparing files. 

> [!NOTE]
> Manually editing configuration files can exceed limits enforced by the app UI  (e.g. more than 25 values per tab, duplicate entries, trailing dividers). \
> The app does not validate imported files beyond basic JSON syntax. Use with care.

## Contributing

Have an interesting configuration? Pull requests for new example configs are welcome. \
Please include a brief description of the use case.
