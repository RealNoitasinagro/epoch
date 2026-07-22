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
  String get dialogueAbout =>
      'A time display app for nerds and amateur astronomers. Displays the current time in civil, technical, and astronomical time systems.';

  @override
  String get dialogueAboutLegalese => '© 2026 RealEarthling';

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
  String get hintCopyToClipboard => 'Copy to clipboard';

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
  String get hintFocusScreenExit => 'Double-tap to exit';

  @override
  String get hintFocusScreenOpen => 'Double-tap to switch to focus screen';

  @override
  String get hintFocusScreenToggleSecondsOff => 'Hold to suppress seconds';

  @override
  String get hintFocusScreenToggleSecondsOn => 'Hold to display seconds';

  @override
  String get hintFocusScreenToggleToOneLine => 'Hold for one line';

  @override
  String get hintFocusScreenToggleToTwoLines => 'Hold for two lines';

  @override
  String get hintPinnedIndicator => 'Automatic clock change disabled';

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
  String get infoLinkDoomsdayClock => 'https://thebulletin.org/doomsday-clock/';

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
  String get infoLinkSwatchBeats =>
      'https://en.wikipedia.org/wiki/Swatch_Internet_Time';

  @override
  String get infoLinkTai =>
      'https://en.wikipedia.org/wiki/International_Atomic_Time';

  @override
  String get infoLinkUnixSeconds => 'https://en.wikipedia.org/wiki/Unix_time';

  @override
  String get infoTextBinaryClockBcd =>
      'Each decimal digit of hours, minutes and seconds is shown as a separate binary column (BCD = Binary-Coded Decimal), as seen on the Wikipedia binary clock article.';

  @override
  String get infoTextBinaryClockColumns =>
      'Time displayed in binary. Each column shows hours, minutes, or seconds in base-2. Read top bit as most significant.';

  @override
  String get infoTextBinaryClockString =>
      'Compact binary representation: hours:minutes:seconds in base-2, e.g. 10:110000:10111.';

  @override
  String get infoTextDate =>
      'The current calendar date in the selected timezone.';

  @override
  String get infoTextDateTime =>
      'The current date and time in the selected timezone, combined in one value. Useful for copying a complete timestamp to the clipboard.';

  @override
  String get infoTextDayPercent =>
      'Percentage of the day elapsed in the selected timezone. Resets to 0 at midnight.';

  @override
  String get infoTextDaySecond =>
      'Seconds elapsed since midnight in the selected timezone. Resets to 0 at midnight.';

  @override
  String get infoTextDoomsdayClock =>
      'The Doomsday Clock is a symbol representing how close humanity is to self-destruction. Maintained by the Bulletin of the Atomic Scientists. Currently set to 85 seconds to midnight (as of Jan 2026).';

  @override
  String get infoTextGmst =>
      'Greenwich Mean Sidereal Time (GMST) – the hour angle of the vernal equinox at Greenwich. Used by astronomers to determine which part of the sky is overhead.';

  @override
  String get infoTextGps =>
      'GPS time counts seconds since 1980-01-06 00:00:00 UTC and does not include leap seconds. Currently, in May 2026, 18 seconds ahead of UTC. The last leap second was added on 2016-12-31 at 23:59:60 UTC.';

  @override
  String get infoTextJulianDate =>
      'Julian Date counts days since noon on January 1, 4713 BC (-4712-01-01 12:00:00 UT). The standard time reference in astronomy for calculating intervals between events.';

  @override
  String get infoTextLmst =>
      'Local Mean Sidereal Time (LMST) – the hour angle of the vernal equinox at your location. Derived from GMST by adding your longitude. Used by astronomers to determine which objects are currently observable.';

  @override
  String get infoTextModifiedJulianDate =>
      'Modified Julian Date = JD − 2,400,000.5 (1858-11-17 00:00:00 UT). Starts at midnight rather than noon, and has smaller numbers. Introduced by the Smithsonian Astrophysical Observatory in 1957 to record the orbit of Sputnik.';

  @override
  String get infoTextModifiedJulianDate2000 =>
      'Modified Julian Date 2000 = JD – 2,451,544.5 or MJD – 51,544 (2000-01-01 00:00:00 UTC). Used in geodesy, geophysics, and spaceflight to simplify calculations with smaller numbers by shifting the reference to the beginning of the year 2000.';

  @override
  String get infoTextSevenSegmentTime =>
      'The current time in the selected timezone in alarm clock design.';

  @override
  String get infoTextSwatchBeats =>
      'Swatch Internet Time divides the day into 1000 .beats. There are no time zones — the whole world shares the same .beat. Based on UTC+1 (Biel Mean Time).';

  @override
  String get infoTextTai =>
      'International Atomic Time (TAI) counts seconds since 1977-01-01 00:00:00 UTC and does not include leap seconds. Currently, in May 2026, 37 seconds ahead of UTC. The last leap second was added on 2016-12-31 at 23:59:60 UTC.';

  @override
  String get infoTextTime => 'The current time in the selected timezone.';

  @override
  String get infoTextUnixSeconds =>
      'Seconds elapsed since the Unix epoch: 1970-01-01 00:00:00 UTC.';

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
  String get labelMinutes => 'MM';

  @override
  String get labelNewLabel => 'Label';

  @override
  String get labelNewSectionName => 'Section name';

  @override
  String get labelNewTabName => 'Tab name';

  @override
  String get labelNextClockChanges => 'Next clock changes';

  @override
  String get labelSeconds => 'SS';

  @override
  String get labelShowSeconds => 'Show seconds';

  @override
  String get messageAlreadyDisplayed => 'This value is already displayed.';

  @override
  String messageCopiedToClipboard(String label) {
    return 'Copied: $label';
  }

  @override
  String get messageEmptyTab =>
      'Configurable tab.\nUse the edit mode to add values.';

  @override
  String messageMaxValues(int count) {
    return 'Maximum of $count values reached.';
  }

  @override
  String get messageNoTimezone => 'No matching timezone found.';

  @override
  String get messageSettingsExported => 'Settings exported';

  @override
  String get messageSettingsImportFailed => 'Import failed – invalid file';

  @override
  String get messageSettingsImported => 'Settings imported';

  @override
  String get messageSettingsReset => 'Settings reset to defaults';

  @override
  String get pageSettings => 'Settings';

  @override
  String get sectionAtomic => 'Atomic Clock';

  @override
  String get sectionBinaryClock => 'Binary Clock';

  @override
  String get sectionDoomsdayClock => 'Doomsday Clock';

  @override
  String get sectionGps => 'Global Positioning System';

  @override
  String get sectionInternet => 'Internet Time';

  @override
  String get sectionJulian => 'Julian Date';

  @override
  String get sectionSidereal => 'Sidereal Time';

  @override
  String get sectionUnix => 'Unix Epoch';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsDateWithDetails => 'Expanded date';

  @override
  String get settingsDateWithDetailsSub =>
      'On = with ISO calender week, day of the year';

  @override
  String get settingsDstAlwaysOff => 'Always standard time';

  @override
  String get settingsDstAlwaysOn => 'Always summer time';

  @override
  String get settingsDstAuto => 'Automatic';

  @override
  String get settingsDstMode => 'Daylight saving time (DST)';

  @override
  String get settingsHourFormat => '24-hour format';

  @override
  String get settingsHourFormatSub => 'Off = 12-hour with AM/PM';

  @override
  String get settingsLanguage => 'Language';

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
  String get settingsPreferencesExport => 'Export preferences';

  @override
  String get settingsPreferencesImport => 'Import preferences';

  @override
  String get settingsPreferencesReset => 'Reset preferences';

  @override
  String get settingsPreferencesResetBackupTitle => 'Save backup before reset';

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
  String get settingsWhatsNew => 'What\'s New';

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
  String get tabAstronomical => 'Astronomical';

  @override
  String get tabCivil => 'Civil';

  @override
  String get tabCuriosities => 'Curiosities';

  @override
  String get tabTechnical => 'Technical';

  @override
  String get valueTypeBinaryClockBcd => 'Binary clock (BCD)';

  @override
  String get valueTypeBinaryClockColumns => 'Binary clock (columns)';

  @override
  String get valueTypeBinaryClockString => 'Binary time (string)';

  @override
  String get valueTypeDate => 'Date';

  @override
  String get valueTypeDateTime => 'Date & Time';

  @override
  String get valueTypeDayPercent => 'Day percent';

  @override
  String get valueTypeDaySecond => 'Day second';

  @override
  String get valueTypeDoomsdayClock => 'Doomsday Clock';

  @override
  String get valueTypeGmst => 'GMST';

  @override
  String get valueTypeGps => 'GPS time (s)';

  @override
  String get valueTypeJulianDate => 'Julian Date';

  @override
  String get valueTypeLmst => 'LMST';

  @override
  String get valueTypeModifiedJulianDate => 'Modified Julian Date';

  @override
  String get valueTypeModifiedJulianDate2000 => 'Modified Julian Date 2000';

  @override
  String get valueTypeSevenSegmentTime => 'Seven-segment clock';

  @override
  String get valueTypeSwatchBeats => 'Swatch Internet Time';

  @override
  String get valueTypeTai => 'TAI (s)';

  @override
  String get valueTypeTime => 'Time';

  @override
  String get valueTypeUnixSeconds => 'Unix time (s)';
}
