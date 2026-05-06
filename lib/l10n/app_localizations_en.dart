// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Epoch';

  @override
  String get tabMain => 'Main';

  @override
  String get tabTechnical => 'Technical';

  @override
  String get tabAstronomy => 'Astronomy';

  @override
  String get tabCuriosities => 'Curiosities';

  @override
  String get labelLocal => 'Local';

  @override
  String get labelUtc => 'UTC';

  @override
  String get labelDate => 'Date';

  @override
  String get labelTime => 'Time';

  @override
  String get labelDaySecond => 'Day second';

  @override
  String get sectionEpoch => 'Unix Epoch';

  @override
  String get sectionAtomicGps => 'Atomic & GPS';

  @override
  String get labelUnixSeconds => 'Unix time (s)';

  @override
  String get labelTai => 'TAI (s since epoch)';

  @override
  String get labelGps => 'GPS time (s)';

  @override
  String get settings => 'Settings';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThousandsSep => 'Thousands separator';

  @override
  String get settingsThousandsSepSub => 'e.g. 1,746,000 instead of 1746000';

  @override
  String get settingsHourFormat => '24-hour format';

  @override
  String get settingsHourFormatSub => 'Off = 12-hour with AM/PM';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAbout => 'About';

  @override
  String get aboutDescription =>
      'A time display app for nerds and amateur astronomers. Displays the current time in civil, technical, and astronomical time systems.';

  @override
  String get aboutLegalese => '© 2026 RealEarthling';

  @override
  String get zoneLocal => 'Local (system timezone)';

  @override
  String get zoneUtc => 'UTC';

  @override
  String get zoneOther => 'Other…';

  @override
  String get selectValueType => 'Select value type';

  @override
  String get selectTimezone => 'Select timezone';

  @override
  String get selectRegion => 'Select region';

  @override
  String get valueTypeDate => 'Date';

  @override
  String get valueTypeTime => 'Time';

  @override
  String get valueTypeDaySecond => 'Day second';

  @override
  String get addValue => 'Add value';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';

  @override
  String get editLayout => 'Edit layout';

  @override
  String get doneEditing => 'Done editing';

  @override
  String get selectAll => 'Select all';

  @override
  String get deselectAll => 'Deselect all';

  @override
  String get selectForRemoval => 'Select for removal';

  @override
  String get deselect => 'Deselect';

  @override
  String get removeSelected => 'Remove selected';

  @override
  String get resetToDefaults => 'Reset to defaults';

  @override
  String get moveUp => 'Move up';

  @override
  String get moveDown => 'Move down';

  @override
  String maxValuesReached(int count) {
    return 'Maximum of $count values reached.';
  }

  @override
  String get alreadyDisplayed => 'This value is already displayed.';

  @override
  String get allValuesDisplayed =>
      'All available values are already displayed.';

  @override
  String copiedToClipboard(String label) {
    return 'Copied: $label';
  }

  @override
  String get aboutThisValue => 'About this value';

  @override
  String get copyToClipboard => 'Copy to clipboard';

  @override
  String get noDescription => 'No description available yet.';

  @override
  String get infoLocalDate =>
      'The current calendar date in the selected timezone.';

  @override
  String get infoLocalTime => 'The current time in the selected timezone.';

  @override
  String get infoDaySecond =>
      'Seconds elapsed since midnight in the selected timezone. Resets to 0 at midnight.';

  @override
  String get infoUnixSeconds =>
      'Seconds elapsed since the Unix epoch: 1970-01-01 00:00:00 UTC. Does not count leap seconds.';

  @override
  String get infoTai =>
      'International Atomic Time (TAI) is based on atomic clocks and currently runs 37 seconds ahead of UTC.';

  @override
  String get infoGps =>
      'GPS time counts seconds since 1980-01-06 00:00:00 UTC and does not include leap seconds. Currently 18 seconds ahead of UTC.';

  @override
  String get sectionSwatch => 'Swatch Internet Time';

  @override
  String get labelSwatchBeats => 'Internet Time';

  @override
  String get infoSwatch =>
      'Swatch Internet Time divides the day into 1000 .beats. There are no time zones — the whole world shares the same .beat. Based on UTC+1 (Biel Mean Time).';

  @override
  String get sectionBinaryClock => 'Binary Clock';

  @override
  String get labelHours => 'HH';

  @override
  String get labelMinutes => 'MM';

  @override
  String get labelSeconds => 'SS';

  @override
  String get infoBinaryClock =>
      'Time displayed in binary. Each column shows hours, minutes, or seconds in base-2. Read top bit as most significant.';

  @override
  String get sectionDoomsday => 'Doomsday Clock';

  @override
  String get labelDoomsdayClock => 'Time to midnight';

  @override
  String get infoDoomsday =>
      'The Doomsday Clock is a symbol representing how close humanity is to self-destruction. Maintained by the Bulletin of the Atomic Scientists. Currently set to 89 seconds to midnight (as of Jan 2025).';

  @override
  String get doomsdayLink => '→ thebulletin.org/doomsday-clock';
}
