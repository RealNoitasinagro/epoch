// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutDescription =>
      'A time display app for nerds and amateur astronomers. Displays the current time in civil, technical, and astronomical time systems.';

  @override
  String get aboutLegalese => '© 2026 RealEarthling';

  @override
  String get aboutThisValue => 'About this value';

  @override
  String get addTab => 'Add tab';

  @override
  String get addValue => 'Add value';

  @override
  String get alreadyDisplayed => 'This value is already displayed.';

  @override
  String get appName => 'Epoch';

  @override
  String get back => 'Back';

  @override
  String get binaryClockPlaceholder => 'Graphical binary clock';

  @override
  String get cancel => 'Cancel';

  @override
  String copiedToClipboard(String label) {
    return 'Copied: $label';
  }

  @override
  String get copyToClipboard => 'Copy to clipboard';

  @override
  String get deleteTab => 'Delete tab';

  @override
  String get deselect => 'Deselect';

  @override
  String get deselectAll => 'Deselect all';

  @override
  String get doneEditing => 'Done editing';

  @override
  String get editLabel => 'Edit label';

  @override
  String get editLayout => 'Edit layout';

  @override
  String get emptyTabHint =>
      'Configurable tab.\nUse the edit mode to add values.';

  @override
  String get infoBinaryClockBcd =>
      'Each decimal digit of hours, minutes and seconds is shown as a separate binary column (BCD = Binary-Coded Decimal), as seen on the Wikipedia binary clock article.';

  @override
  String get infoBinaryClockColumns =>
      'Time displayed in binary. Each column shows hours, minutes, or seconds in base-2. Read top bit as most significant.';

  @override
  String get infoBinaryClockString =>
      'Compact binary representation: hours:minutes:seconds in base-2, e.g. 10:110000:10111.';

  @override
  String get infoDate => 'The current calendar date in the selected timezone.';

  @override
  String get infoDateTime =>
      'The current date and time in the selected timezone, combined in one value. Useful for copying a complete timestamp to the clipboard.';

  @override
  String get infoDayPercent =>
      'Percentage of the day elapsed in the selected timezone. Resets to 0 at midnight.';

  @override
  String get infoDaySecond =>
      'Seconds elapsed since midnight in the selected timezone. Resets to 0 at midnight.';

  @override
  String get infoDoomsdayClock =>
      'The Doomsday Clock is a symbol representing how close humanity is to self-destruction. Maintained by the Bulletin of the Atomic Scientists. Currently set to 85 seconds to midnight (as of Jan 2026).';

  @override
  String get infoGmst =>
      'Greenwich Mean Sidereal Time (GMST) – the hour angle of the vernal equinox at Greenwich. Used by astronomers to determine which part of the sky is overhead.';

  @override
  String get infoGps =>
      'GPS time counts seconds since 1980-01-06 00:00:00 UTC and does not include leap seconds. Currently, in May 2026, 18 seconds ahead of UTC. The last leap second was added on 2016-12-31 at 23:59:60 UTC.';

  @override
  String get infoJulianDate =>
      'Julian Date counts days since noon on January 1, 4713 BC (-4712-01-01 12:00:00 UT). The standard time reference in astronomy for calculating intervals between events.';

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
  String get infoLinkModifiedJulianDate =>
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
  String get infoModifiedJulianDate =>
      'Modified Julian Date = JD − 2,400,000.5 (1858-11-17 00:00:00 UT). Starts at midnight rather than noon, and has smaller numbers. Commonly used in satellite operations and pulsar astronomy.';

  @override
  String get infoSwatchBeats =>
      'Swatch Internet Time divides the day into 1000 .beats. There are no time zones — the whole world shares the same .beat. Based on UTC+1 (Biel Mean Time).';

  @override
  String get infoTai =>
      'International Atomic Time (TAI) counts seconds since 1977-01-01 00:00:00 UTC and does not include leap seconds. Currently, in May 2026, 37 seconds ahead of UTC. The last leap second was added on 2016-12-31 at 23:59:60 UTC.';

  @override
  String get infoTime => 'The current time in the selected timezone.';

  @override
  String get infoUnixSeconds =>
      'Seconds elapsed since the Unix epoch: 1970-01-01 00:00:00 UTC.';

  @override
  String get labelHours => 'HH';

  @override
  String get labelLocal => 'Local';

  @override
  String get labelMinutes => 'MM';

  @override
  String get labelSeconds => 'SS';

  @override
  String get labelUtc => 'UTC';

  @override
  String maxValuesReached(int count) {
    return 'Maximum of $count values reached.';
  }

  @override
  String get newLabelName => 'Label';

  @override
  String get newTabName => 'Tab name';

  @override
  String get noDescription => 'No description available yet.';

  @override
  String get removeSelected => 'Remove selected';

  @override
  String get renameTab => 'Rename tab';

  @override
  String get resetToDefaults => 'Reset to defaults';

  @override
  String get sectionAtomic => 'Atomic Clock';

  @override
  String get sectionBinaryClock => 'Binary Clock';

  @override
  String get sectionDoomsdayClock => 'Doomsday Clock';

  @override
  String get sectionEpoch => 'Unix Epoch';

  @override
  String get sectionGps => 'Global Positioning System';

  @override
  String get sectionInternet => 'Internet Time';

  @override
  String get sectionJulian => 'Julian Date';

  @override
  String get sectionSidereal => 'Sidereal Time';

  @override
  String get selectAll => 'Select all';

  @override
  String get selectForRemoval => 'Select for removal';

  @override
  String get selectTimezone => 'Select timezone';

  @override
  String get selectValueType => 'Select value type';

  @override
  String get settings => 'Settings';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsHourFormat => '24-hour format';

  @override
  String get settingsHourFormatSub => 'Off = 12-hour with AM/PM';

  @override
  String get settingsLanguage => 'Language';

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
  String get settingsThousandsSepSub => 'e.g. 1,746,000 instead of 1746000';

  @override
  String get tabAstronomical => 'Astronomical';

  @override
  String get tabCivil => 'Civil';

  @override
  String get tabCuriosities => 'Curiosities';

  @override
  String get tabTechnical => 'Technical';

  @override
  String get tabWatchlist => 'Watchlist';

  @override
  String get timezoneNoResults => 'No matching timezone found.';

  @override
  String get timezoneSearchHint =>
      'City, country, zone or offset (e.g. UTC+5:30)';

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
  String get valueTypeModifiedJulianDate => 'Modified Julian Date';

  @override
  String get valueTypeSwatchBeats => 'Swatch Internet Time';

  @override
  String get valueTypeTai => 'TAI (s)';

  @override
  String get valueTypeTime => 'Time';

  @override
  String get valueTypeUnixSeconds => 'Unix time (s)';

  @override
  String get zoneLocal => 'Local (system timezone)';

  @override
  String get zoneOther => 'Other…';

  @override
  String get zoneUtc => 'UTC';
}
