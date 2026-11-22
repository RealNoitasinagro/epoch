// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDeleteTab => 'Delete tab';

  @override
  String get actionExitApp => 'Exit';

  @override
  String get actionHideTab => 'Hide tab';

  @override
  String get actionRenameTab => 'Rename tab';

  @override
  String get actionZoneLocal => 'Local (system timezone)';

  @override
  String get actionZoneNamed => 'Named time zone';

  @override
  String get actionZoneUtc => 'UTC';

  @override
  String get appName => 'Epoch';

  @override
  String dataDateSub(int week, int day) {
    return 'week $week · day $day';
  }

  @override
  String dataTabValueCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString values',
      one: '1 value',
      zero: 'no values',
    );
    return '$_temp0';
  }

  @override
  String get dialogAbout => 'About';

  @override
  String get dialogAboutChangelog => 'Changes in each version (CHANGELOG)';

  @override
  String get dialogAboutLegalese => '© 2026 RealEarthling';

  @override
  String get dialogAboutReadme => 'Description of the features (README)';

  @override
  String get dialogAboutText =>
      'A feature-rich time display app for nerds and amateur astronomers. Displays the current time in civil, technical and astronomical time systems, and a few curiosities.';

  @override
  String get hintAboutThisValue => 'About this value';

  @override
  String get hintAddDivider => 'Add divider';

  @override
  String get hintAddSectionHeader => 'Add section header';

  @override
  String get hintAddTab => 'Add tab';

  @override
  String get hintAddValue => 'Add value';

  @override
  String get hintBack => 'Back';

  @override
  String get hintCopyToClipboard =>
      'Copy · Long-press for value only, no label';

  @override
  String get hintDeselect => 'Deselect';

  @override
  String get hintDeselectAll => 'Deselect all';

  @override
  String get hintDoneEditing => 'Done editing';

  @override
  String get hintDstStatusIndicatorActive =>
      'Value shows summer/daylight-saving time (DST)';

  @override
  String get hintDstStatusIndicatorInactive =>
      'Value shows standard time (DST inactive)';

  @override
  String get hintEditLayout => 'Edit layout';

  @override
  String get hintEditSectionHeader => 'Edit section header';

  @override
  String get hintEditTimeValue => 'Edit time value';

  @override
  String get hintFocusScreenColor => 'Color';

  @override
  String get hintFocusScreenColorDayQuarter =>
      'Changes with the quarter of the day';

  @override
  String get hintFocusScreenColorRandom => 'A different color at every start';

  @override
  String get hintFocusScreenDetailsOff => 'Hide details line';

  @override
  String get hintFocusScreenDetailsOn => 'Show details line';

  @override
  String get hintFocusScreenExit => 'Double-tap to exit';

  @override
  String get hintFocusScreenOpen => 'Double-tap to switch to focus screen';

  @override
  String get hintFocusScreenToggleDecimalsOff => 'Hold to suppress decimals';

  @override
  String get hintFocusScreenToggleDecimalsOn => 'Hold to display decimals';

  @override
  String get hintFocusScreenToggleSecondsOff => 'Hold to suppress seconds';

  @override
  String get hintFocusScreenToggleSecondsOn => 'Hold to display seconds';

  @override
  String hintMatchAlsoCity(String name) {
    return 'Same time zone as $name';
  }

  @override
  String hintMatchAlsoCountry(String name) {
    return 'Time zone also used in $name';
  }

  @override
  String get hintPinnedIndicator => 'Automatic clock change disabled';

  @override
  String get hintPixelShiftOff => 'Burn-in protection off – tap to enable';

  @override
  String get hintPixelShiftOn => 'Burn-in protection on – tap to disable';

  @override
  String get hintRemoveSelected => 'Remove selected';

  @override
  String get hintResetToDefaults => 'Reset to defaults';

  @override
  String get hintSelect => 'Select';

  @override
  String get hintSelectAll => 'Select all';

  @override
  String get hintSelectTimezone => 'Select timezone';

  @override
  String get hintSelectValueType => 'Select value type';

  @override
  String get hintTimeShiftFuture => 'into the future';

  @override
  String hintTimeShiftIndicator(String date, String period) {
    return 'Time Shift $period · system date: $date';
  }

  @override
  String get hintTimeShiftIndicatorTap => 'Tap to change or reset';

  @override
  String get hintTimeShiftPast => 'into the past';

  @override
  String hintTimeShiftPlaceIndicator(String zone, String systemZone) {
    return 'Local time zone: $zone (system: $systemZone)';
  }

  @override
  String get hintTimezoneSearch =>
      'City, country, zone or offset (e.g. UTC+5:30)';

  @override
  String get hintZoneIndicator => 'Timezone-dependent value';

  @override
  String get infoLinkBinaryClockBcd =>
      'https://en.wikipedia.org/wiki/Binary_clock';

  @override
  String get infoLinkBinaryClockColumns =>
      'https://en.wikipedia.org/wiki/Binary_clock';

  @override
  String get infoLinkBinaryClockString =>
      'https://en.wikipedia.org/wiki/Binary_clock';

  @override
  String get infoLinkCcsdsJulianDate =>
      'https://en.wikipedia.org/wiki/Julian_day#Variants';

  @override
  String get infoLinkCnesJulianDate =>
      'https://en.wikipedia.org/wiki/Julian_day#Variants';

  @override
  String get infoLinkDecimalTime =>
      'https://en.wikipedia.org/wiki/Decimal_time';

  @override
  String get infoLinkDoomsdayClock => 'https://thebulletin.org/doomsday-clock/';

  @override
  String get infoLinkDublinJulianDate =>
      'https://en.wikipedia.org/wiki/Julian_day#Variants';

  @override
  String get infoLinkGmst => 'https://en.wikipedia.org/wiki/Sidereal_time';

  @override
  String get infoLinkGps =>
      'https://en.wikipedia.org/wiki/GPS_time#Timekeeping';

  @override
  String get infoLinkJulianDate => 'https://en.wikipedia.org/wiki/Julian_day';

  @override
  String get infoLinkLmst => 'https://en.wikipedia.org/wiki/Sidereal_time';

  @override
  String get infoLinkModifiedJulianDate =>
      'https://en.wikipedia.org/wiki/Julian_day#Variants';

  @override
  String get infoLinkModifiedJulianDate2000 =>
      'https://en.wikipedia.org/wiki/Julian_day#Variants';

  @override
  String get infoLinkNewEarthTime =>
      'https://en.wikipedia.org/wiki/New_Earth_Time';

  @override
  String get infoLinkReducedJulianDate =>
      'https://en.wikipedia.org/wiki/Julian_day#Variants';

  @override
  String get infoLinkRomanNumeralsTime =>
      'https://en.wikipedia.org/wiki/Roman_numerals';

  @override
  String get infoLinkSwatchBeats =>
      'https://en.wikipedia.org/wiki/Swatch_Internet_Time';

  @override
  String get infoLinkTai =>
      'https://en.wikipedia.org/wiki/International_Atomic_Time';

  @override
  String get infoLinkUnixSeconds => 'https://en.wikipedia.org/wiki/Unix_time';

  @override
  String get infoTextAnalogClock12h =>
      'The current time in the selected timezone as an analog clock with a 12-hour face. The hour hand turns twice a day; from noon on, \"+12\" appears below the 12.';

  @override
  String get infoTextAnalogClock24h =>
      'The current time in the selected timezone as an analog clock with a 24-hour face. The hour hand turns once a day. Minutes and seconds are read on the outer scale, hours on the inner one.';

  @override
  String get infoTextBinaryClockBcd =>
      'Hours, minutes and seconds of the selected timezone as on a wall clock (24 hours of 60 minutes of 60 seconds), each decimal digit in binary (BCD, binary-coded decimal) in its own column of circles. Lit circles stand for 1, unlit circles for 0. The bottom circle is worth 2^0 = 1, above it 2^1 = 2, 2^2 = 4 etc.; a digit is the sum of its lit circles. Tens digits need 2 or 3 bits, units digits 4.';

  @override
  String get infoTextBinaryClockColumns =>
      'Hours, minutes and seconds of the selected timezone as on a wall clock (24 hours of 60 minutes of 60 seconds), each as one binary number in its own column (5 bits for hours, 6 for minutes and seconds). Lit circles stand for 1, unlit circles for 0. The bottom circle is worth 2^0 = 1, above it 2^1 = 2, 2^2 = 4 etc.; a number is the sum of its lit circles.';

  @override
  String get infoTextBinaryClockString =>
      'Hours, minutes and seconds of the selected timezone as on a wall clock (24 hours of 60 minutes of 60 seconds), each written as a binary number with 5, 6 and 6 digits. The rightmost digit of a number is worth 2^0 = 1, to its left 2^1 = 2, 2^2 = 4 etc. Example: 10110:110000:010111 is 22:48:23.';

  @override
  String get infoTextCcsdsJulianDate =>
      'CCSDS Julian Date (CCSDS JD) = JD − 2,436,204.5 (epoch: 1958-01-01 00:00:00 UT). Introduced by the Consultative Committee for Space Data Systems (CCSDS) for standardized spacecraft time codes, using 1958 as the historical reference date of International Atomic Time (TAI).';

  @override
  String get infoTextCnesJulianDate =>
      'CNES Julian Date (CNES JD) = JD − 2,433,282.5 (epoch: 1950-01-01 00:00:00 UT). Introduced by the French space agency CNES as a compact day count for spaceflight calculations, using the beginning of 1950 as its reference epoch.';

  @override
  String get infoTextDate =>
      'The current calendar date in the selected timezone, by default with the ISO week number (weeks start on Monday, week 1 contains the first Thursday) and the day of the year below.';

  @override
  String get infoTextDateTime =>
      'The current date and time in the selected timezone, combined in one value. Useful e.g. for world clock tabs and copying a complete timestamp to the clipboard.';

  @override
  String get infoTextDayMinute =>
      'Minutes elapsed since midnight in the selected timezone, from 0 to 1,439. On a day with a clock change the last minute is 1,379 or 1,499 (Lord Howe: 1,409 or 1,469; Troll: 1,319 or 1,559).';

  @override
  String get infoTextDayPercent =>
      'Percentage of the day elapsed in the selected timezone, from 0 to just under 100. It relates to the real length of the day: on a day with a clock change that is 23 or 25 hours (Lord Howe: 23.5 or 24.5; Troll: 22 or 26), not 24.';

  @override
  String get infoTextDaySecond =>
      'Seconds elapsed since midnight in the selected timezone, from 0 to 86,399. On a day with a clock change the last second is 82,799 or 89,999 (Lord Howe: 84,599 or 88,199; Troll: 79,199 or 93,599).';

  @override
  String get infoTextDecimalTime =>
      'Decimal time, briefly in use in France in the 1790s, divides the day into 10 decimal hours of 100 decimal minutes of 100 decimal seconds, from 0h 00m 00s to 9h 99m 99s. On a normal day a decimal second lasts 0.864 s; on a day with a clock change the decimal day stretches or shrinks with the real day.';

  @override
  String get infoTextDoomsdayClock =>
      'The Doomsday Clock is a symbol of how close humanity is to self-destruction, set by the Bulletin of the Atomic Scientists since 1947. Epoch shows the setting as a time of day; latest: 23:58:35, i.e. 85 seconds to midnight (January 2026). With Time Shift, historical settings are shown.';

  @override
  String get infoTextDublinJulianDate =>
      'Dublin Julian Date (DJD) = JD − 2,415,020 (epoch: 1899-12-31 12:00:00 UT). Defined by the International Astronomical Union (IAU) in 1955 at its Dublin meeting as a convenient day count for astronomical calculations.';

  @override
  String get infoTextGmst =>
      'Greenwich Mean Sidereal Time (GMST) – the hour angle of the vernal equinox at Greenwich, i.e. which part of the sky is overhead there. A sidereal day lasts 23 h 56 min 4.09 s, almost 4 minutes less than a solar day, so GMST gains about 3 min 56 s per day on the clock and runs through one more day than the clock over a year.';

  @override
  String get infoTextGps =>
      'GPS time counts seconds since 1980-01-06 00:00:00 UTC without any leap seconds. It matched UTC at the start; UTC has since added 18 leap seconds, so GPS time is 18 s ahead of UTC and 19 s behind TAI. From 2027 UTC adds no more leap seconds, so the gap stays at 18 s.';

  @override
  String get infoTextHexadecimalTime =>
      'Seconds elapsed since midnight in the selected timezone, shown in base 16 (hexadecimal) and grouped in pairs from the right: from 0_00_00 to 1_51_7F on a normal day. A day with a clock change ends earlier or later.';

  @override
  String get infoTextJulianDate =>
      'Julian Date (JD) counts days since noon on January 1, 4713 BC in the proleptic Julian calendar (epoch: -4712-01-01 12:00:00 UT). The standard time reference in astronomy for calculating intervals between events. A JD is the Julian day number plus the fraction of a day since the preceding noon UT; at midnight UT it therefore ends in .5.';

  @override
  String get infoTextLmst =>
      'Local Mean Sidereal Time (LMST) – the hour angle of the vernal equinox at your location: GMST plus your longitude (15° = 1 hour).';

  @override
  String get infoTextModifiedJulianDate =>
      'Modified Julian Date (MJD) = JD − 2,400,000.5 (epoch: 1858-11-17 00:00:00 UT). Starts at midnight rather than noon, and has smaller numbers. Introduced by the Smithsonian Astrophysical Observatory in 1957 for satellite tracking, including the orbit of Sputnik.';

  @override
  String get infoTextModifiedJulianDate2000 =>
      'Modified Julian Date 2000 (MJD2000) = JD − 2,451,544.5 or MJD − 51,544 (epoch: 2000-01-01 00:00:00 UTC). Used in geodesy, geophysics, and spaceflight to simplify calculations with smaller numbers by shifting the reference to the beginning of the year 2000.';

  @override
  String get infoTextNewEarthTime =>
      'New Earth Time (NET, 1999), also called degree time, splits the day into 360 degrees: 0° is midnight, 180° noon. A degree lasts 4 minutes and is divided into 60 intervals of 4 seconds. There are no time zones: the whole world shares the same degree time. It is based on UTC+0.';

  @override
  String get infoTextOctalTime =>
      'Seconds elapsed since midnight in the selected timezone, shown in base 8 (octal) with six digits: from 000000 to 250577 on a normal day. A day with a clock change ends earlier or later.';

  @override
  String get infoTextReducedJulianDate =>
      'Reduced Julian Date (RJD) = JD − 2,400,000 (epoch: 1858-11-16 12:00:00 UT). A simple reduction of the Julian Date used mainly in astronomy to make the numbers shorter, while retaining the original noon-based start of the Julian day.';

  @override
  String get infoTextRomanNumeralsTime =>
      'The current time in the selected timezone, shown in Roman numerals. Roman numerals have no zero, so, as medieval scholars did, N for nulla (Latin for \'none\') stands in for it.';

  @override
  String get infoTextSevenSegmentClock =>
      'The current time in the selected timezone in alarm clock design.';

  @override
  String get infoTextSwatchBeats =>
      'Swatch Internet Time (1998) divides the day into 1000 .beats of 86.4 seconds each. There are no time zones: the whole world shares the same .beat time. It is based on UTC+1, which Swatch calls Biel Mean Time (BMT).';

  @override
  String get infoTextTai =>
      'International Atomic Time (TAI, French: Temps Atomique International) is a continuous scale without leap seconds: atomic clocks just keep ticking, and it is UTC that gets adjusted, so TAI is 37 s ahead of UTC. Epoch shows TAI the way Unix time counts (seconds since 1970-01-01 00:00:00 UTC), i.e. Unix time plus 37. According to a decision by the General Conference on Weights and Measures in October 2026, there will be no more leap seconds, so the 37 s stay.';

  @override
  String get infoTextTime =>
      'The current time in the selected timezone, by default with the time zone abbreviation and UTC offset below. Within 7 days before a clock change, a notice about it replaces them.';

  @override
  String get infoTextUnixSeconds =>
      'Seconds since the Unix epoch, 1970-01-01 00:00:00 UTC. Unix time counts every day as exactly 86,400 seconds and ignores leap seconds. A signed 32-bit counter overflows on 2038-01-19 at 03:14:07 UTC (the \"Year 2038 problem\"); Time Shift stops there, too.';

  @override
  String get labelDay => 'DD';

  @override
  String labelDefaultState(String state) {
    return 'Default: $state';
  }

  @override
  String labelDstChangeInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'in $days $_temp0';
  }

  @override
  String get labelDstChangeToday => 'today';

  @override
  String get labelDstChangeTomorrow => 'tomorrow';

  @override
  String get labelHours => 'HH';

  @override
  String get labelLocal => 'Local';

  @override
  String get labelLongitude => 'Longitude (negative = West)';

  @override
  String get labelMinutes => 'mm';

  @override
  String get labelMonth => 'MM';

  @override
  String get labelNewLabel => 'Label';

  @override
  String get labelNewSectionName => 'Section name';

  @override
  String get labelNewTabName => 'Tab name';

  @override
  String get labelNextClockChanges => 'Next clock changes';

  @override
  String get labelRemaining => 'remaining';

  @override
  String get labelSeconds => 'ss';

  @override
  String get labelShowDecimals => 'Show decimals';

  @override
  String get labelShowDetails => 'Show details line';

  @override
  String get labelShowRemaining => 'Show what is left of the day';

  @override
  String get labelShowSeconds => 'Show seconds';

  @override
  String get labelYear => 'YYYY';

  @override
  String get linkWiki => 'Wiki';

  @override
  String messageCopiedToClipboard(String label) {
    return 'Copied: $label';
  }

  @override
  String messageDuplicateValue(String label) {
    return '\"$label\" is shown twice. Change or remove one of them to finish editing.';
  }

  @override
  String get messageEmptyTab =>
      'Configurable tab.\nUse the edit mode to add values.';

  @override
  String messageMaxValues(int count) {
    return 'Maximum of $count values reached.';
  }

  @override
  String get messageMissingTabsRestored =>
      'Some built-in tabs were missing from the loaded configuration and have been restored.';

  @override
  String get messageNoTabsVisible =>
      'All tabs are hidden.\nActivate a tab in Settings, or add a new one.';

  @override
  String get messageNoTimezone => 'No matching timezone found.';

  @override
  String get messagePatternNeedsHour => 'Hour (H or HH) required';

  @override
  String get messagePatternNeedsMinutes => 'Minutes (mm) required';

  @override
  String get messagePatternNoToken => 'At least one date token required';

  @override
  String messagePatternTooLong(int maxLength) {
    return 'Too long: the result could exceed $maxLength characters';
  }

  @override
  String messagePatternUnknownTokens(String tokens) {
    return 'Unknown: $tokens';
  }

  @override
  String get messageSettingsExported => 'Settings exported';

  @override
  String get messageSettingsImportFailed => 'Import failed – invalid file';

  @override
  String get messageSettingsImported => 'Settings imported';

  @override
  String messageSettingsImportedIgnored(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Settings imported, $count values ignored: $keys',
      one: 'Settings imported, 1 value ignored: $keys',
    );
    return '$_temp0';
  }

  @override
  String get messageSettingsReset => 'Settings reset to defaults';

  @override
  String messageTabReactivated(String resetAction) {
    return 'Tab reactivated – it may not match the default configuration anymore. Use \"$resetAction\" on the tab if needed.';
  }

  @override
  String get pageSettings => 'Settings';

  @override
  String get pageTimeShift => 'Time Shift';

  @override
  String get sectionAlternative => 'Alternative Time Scales';

  @override
  String get sectionAtomic => 'Atomic Clock';

  @override
  String get sectionDoomsdayClock => 'Doomsday Clock';

  @override
  String get sectionGps => 'Global Positioning System';

  @override
  String get sectionJulian => 'Julian Date';

  @override
  String get sectionLocal => 'Local Time';

  @override
  String get sectionNumberSystems => 'Number Systems';

  @override
  String get sectionOther => 'Other Time Zones';

  @override
  String get sectionSidereal => 'Sidereal Time';

  @override
  String get sectionUnix => 'Unix Epoch';

  @override
  String get settingsCustomFormat => 'Custom…';

  @override
  String get settingsDateFormat => 'Date format';

  @override
  String get settingsDateWithDetails => 'Expanded date';

  @override
  String get settingsDateWithDetailsSub => 'calendar week, day of the year';

  @override
  String get settingsDayQuarterColor => 'Day quarter color';

  @override
  String get settingsDayQuarterColorSub1st => '1st red';

  @override
  String get settingsDayQuarterColorSub2nd => '2nd cyan';

  @override
  String get settingsDayQuarterColorSub3rd => '3rd amber';

  @override
  String get settingsDayQuarterColorSub4th => '4th green';

  @override
  String get settingsDstAlwaysOff => 'Always standard time';

  @override
  String get settingsDstAlwaysOn => 'Always summer time';

  @override
  String get settingsDstAuto => 'Automatic';

  @override
  String get settingsDstMode => 'Daylight saving time (DST)';

  @override
  String get settingsExportImportReset => 'Export, import and reset';

  @override
  String get settingsHourFormat => '24-hour format';

  @override
  String get settingsHourFormatSub => 'Off = 12-hour with AM/PM';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageTheme => 'Language and theme';

  @override
  String get settingsLmst => 'Local sidereal time';

  @override
  String get settingsLmstLongitudeAuto => 'Use approximate location';

  @override
  String get settingsLmstLongitudeAutoSub =>
      'One-time, without GPS, no tracking';

  @override
  String get settingsLmstLongitudeDetermineLocation => 'Determine';

  @override
  String get settingsLmstLongitudeManual => 'Manual longitude';

  @override
  String get settingsLmstLongitudeManualSub =>
      'Enter longitude in decimal degrees (DDD.DDDD)';

  @override
  String get settingsLmstLongitudeNotYetDetermined => 'Not yet determined';

  @override
  String get settingsLmstLongitudeUnavailable =>
      'Location unavailable – enable location access and grant permission to Epoch temporarily, or enter longitude manually';

  @override
  String get settingsLmstOff => 'Do not show';

  @override
  String get settingsNightMode => 'Night mode';

  @override
  String get settingsNightModeClear => 'Clear time window';

  @override
  String get settingsNightModeHint => 'Set start and end time to turn on';

  @override
  String get settingsNightModeSub =>
      'Replaces the theme within this time window';

  @override
  String get settingsOff => 'off';

  @override
  String get settingsOn => 'on';

  @override
  String get settingsOptionalPart => 'Seconds and decimals';

  @override
  String get settingsOptionalPartAll => 'All';

  @override
  String settingsOptionalPartSummary(int hidden, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      hidden,
      locale: localeName,
      other: '$hidden of $total hidden',
      zero: 'All shown',
    );
    return '$_temp0';
  }

  @override
  String get settingsOptionalPartTimeNote =>
      'Time and Date & Time follow the time format.';

  @override
  String get settingsPreferencesExport => 'Export preferences';

  @override
  String get settingsPreferencesImport => 'Import preferences';

  @override
  String get settingsPreferencesReset => 'Reset preferences';

  @override
  String get settingsPreferencesResetBackupTitle => 'Save backup before reset';

  @override
  String get settingsStartupFocusValue => 'App start in Focus mode';

  @override
  String get settingsStartupFocusValueClear => 'Clear selection';

  @override
  String get settingsStartupFocusValueNone =>
      'Not set – app opens with active tab';

  @override
  String get settingsTabVisibility => 'Tab visibility';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeNight => 'Night (red)';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThousandsSep => 'Thousands separator';

  @override
  String get settingsThousandsSepSub => 'e. g. 1,746,000 instead of 1746000';

  @override
  String get settingsTimeFormat => 'Time format';

  @override
  String get settingsValueDisplay => 'Value display';

  @override
  String get settingsZoneDisplayMode => 'Time zone display';

  @override
  String get settingsZoneDisplayModeAbbreviation => 'Abbreviation\n  [CEST]';

  @override
  String get settingsZoneDisplayModeFull =>
      'Abbreviation + offset\n  [CEST (UTC+02:00)]';

  @override
  String get settingsZoneDisplayModeHidden => 'Hidden';

  @override
  String get settingsZoneDisplayModeOffsetLong => 'Offset Long\n  [UTC+02:00]';

  @override
  String get settingsZoneDisplayModeOffsetMini => 'Offset Mini\n  [+2]';

  @override
  String get settingsZoneDisplayModeOffsetShort => 'Offset Short\n  [+02:00]';

  @override
  String get settingsZoneDisplayModeSub => 'abbreviation, UTC-offset';

  @override
  String get startupErrorCopied => 'Details copied';

  @override
  String get startupErrorCopy => 'Copy details';

  @override
  String get startupErrorHint =>
      'Something went wrong while loading the app. If possible, please report the details below on GitHub:';

  @override
  String get startupErrorTitle => 'Epoch could not start';

  @override
  String get tabAstronomical => 'Astronomical';

  @override
  String get tabCivil => 'Civil';

  @override
  String get tabCuriosities => 'Curiosities';

  @override
  String get tabTechnical => 'Technical';

  @override
  String get timeShiftApply => 'Apply';

  @override
  String get timeShiftDate => 'Date';

  @override
  String get timeShiftFocusIndicator => 'Indicator in Focus screen';

  @override
  String get timeShiftFocusIndicatorSub =>
      'Shows a small icon or two while the displayed time and/or zone deviate from the system time';

  @override
  String get timeShiftFrozen => 'Freeze time';

  @override
  String get timeShiftFrozenSubOff =>
      'The time used in the app keeps running from the set moment.';

  @override
  String get timeShiftFrozenSubOn =>
      'The time used in the app stays at the set moment.';

  @override
  String timeShiftHint(String apply, String reset) {
    return '\"$apply\" sets the moment Epoch uses for all time values – from the past or the future, running or frozen – without changing your device\'s clock. You can return to the system time at any time with \"$reset\". The setting is not saved by itself: after a restart, Epoch shows the system time – unless you saved a start value (below). The chosen time zone can also stand in for \"local\".';
  }

  @override
  String get timeShiftHintApply =>
      'Applies the selected date and time to the whole app.';

  @override
  String timeShiftHintRange(String earliest, String latest) {
    return 'Supported range: $earliest to $latest, limited by Unix time and the available IANA time zone data.';
  }

  @override
  String get timeShiftHintReset =>
      'Returns the whole app to the system clock and the system time zone.';

  @override
  String timeShiftHintResetToSystemDate(String apply) {
    return 'Sets the Time Shift selection date to the system date, time of day stays as set.\nBecomes effective only with the \"$apply\" button.';
  }

  @override
  String timeShiftHintResetToSystemTime(String apply) {
    return 'Sets the Time Shift selection time to the system time, date stays as set.\nBecomes effective only with the \"$apply\" button.';
  }

  @override
  String get timeShiftHours => 'Hours';

  @override
  String get timeShiftMinutes => 'Minutes';

  @override
  String timeShiftOutOfRange(String earliest, String latest) {
    return 'Supported range: $earliest to $latest';
  }

  @override
  String get timeShiftReset => 'Reset to system clock';

  @override
  String get timeShiftSeconds => 'Seconds';

  @override
  String timeShiftSkippedTime(String requested, String used) {
    return '$requested does not exist because of a clock change, using $used.';
  }

  @override
  String get timeShiftStartHint =>
      'Save the point of time set above to your preferences: the app always starts with this until you change it or remove it.';

  @override
  String get timeShiftStartNone => 'Not set – app starts with the system time';

  @override
  String get timeShiftStartRemove => 'Remove start value';

  @override
  String get timeShiftStartRemoved => 'Start value removed';

  @override
  String get timeShiftStartSave => 'Save start value';

  @override
  String get timeShiftStartSaved => 'Start value saved';

  @override
  String get timeShiftStartSection => 'App start';

  @override
  String timeShiftStartSummaryFrozen(String moment, String zone) {
    return '$moment ($zone), frozen';
  }

  @override
  String timeShiftStartSummaryPlaceOnly(String zone) {
    return '$zone, time not shifted';
  }

  @override
  String timeShiftStartSummaryRunning(String moment, String zone) {
    return '$moment ($zone), running';
  }

  @override
  String get timeShiftTime => 'Time';

  @override
  String get timeShiftZone => 'Time zone';

  @override
  String get timeShiftZoneAsLocal => 'Use as local time zone';

  @override
  String get timeShiftZoneAsLocalSub =>
      'Values for \"local\" show this zone instead of your device\'s';

  @override
  String get valueTypeAnalogClock12h => 'Analog clock (12h)';

  @override
  String get valueTypeAnalogClock24h => 'Analog clock (24h)';

  @override
  String get valueTypeBinaryClockBcd => 'Binary clock (BCD)';

  @override
  String get valueTypeBinaryClockColumns => 'Binary clock (columns)';

  @override
  String get valueTypeBinaryClockString => 'Binary time (string)';

  @override
  String get valueTypeCcsdsJulianDate => 'CCSDS Julian Date';

  @override
  String get valueTypeCnesJulianDate => 'CNES Julian Date';

  @override
  String get valueTypeDate => 'Date';

  @override
  String get valueTypeDateTime => 'Date & Time';

  @override
  String get valueTypeDayMinute => 'Day minute';

  @override
  String get valueTypeDayPercent => 'Day percent';

  @override
  String get valueTypeDaySecond => 'Day second';

  @override
  String get valueTypeDecimalTime => 'Decimal time';

  @override
  String get valueTypeDoomsdayClock => 'Doomsday Clock';

  @override
  String get valueTypeDublinJulianDate => 'Dublin Julian Date';

  @override
  String get valueTypeGmst => 'GMST';

  @override
  String get valueTypeGps => 'GPS time (s)';

  @override
  String get valueTypeHexadecimalTime => 'Hexadecimal time';

  @override
  String get valueTypeJulianDate => 'Julian Date';

  @override
  String get valueTypeLmst => 'LMST';

  @override
  String get valueTypeModifiedJulianDate => 'Modified Julian Date';

  @override
  String get valueTypeModifiedJulianDate2000 => 'Modified Julian Date 2000';

  @override
  String get valueTypeNewEarthTime => 'New Earth Time';

  @override
  String get valueTypeOctalTime => 'Octal time';

  @override
  String get valueTypeReducedJulianDate => 'Reduced Julian Date';

  @override
  String get valueTypeRomanNumeralsTime => 'Roman numerals time';

  @override
  String get valueTypeSevenSegmentClock => 'Seven-segment clock';

  @override
  String get valueTypeSwatchBeats => 'Swatch Internet Time';

  @override
  String get valueTypeTai => 'Unix time (TAI) (s)';

  @override
  String get valueTypeTime => 'Time';

  @override
  String get valueTypeUnixSeconds => 'Unix time (s)';
}
