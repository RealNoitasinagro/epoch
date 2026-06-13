import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionDeleteTab.
  ///
  /// In en, this message translates to:
  /// **'Delete tab'**
  String get actionDeleteTab;

  /// No description provided for @actionRenameTab.
  ///
  /// In en, this message translates to:
  /// **'Rename tab'**
  String get actionRenameTab;

  /// No description provided for @actionZoneLocal.
  ///
  /// In en, this message translates to:
  /// **'Local (system timezone)'**
  String get actionZoneLocal;

  /// No description provided for @actionZoneNamed.
  ///
  /// In en, this message translates to:
  /// **'Other…'**
  String get actionZoneNamed;

  /// No description provided for @actionZoneUtc.
  ///
  /// In en, this message translates to:
  /// **'UTC'**
  String get actionZoneUtc;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Epoch'**
  String get appName;

  /// No description provided for @dataBinaryClocksPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Graphical binary clock'**
  String get dataBinaryClocksPlaceholder;

  /// No description provided for @dataDateSub.
  ///
  /// In en, this message translates to:
  /// **'week {week} · day {day}'**
  String dataDateSub(int week, int day);

  /// No description provided for @dataTabValueCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no values} =1{1 value} other{{count} values}}'**
  String dataTabValueCount(num count);

  /// No description provided for @dialogueAbout.
  ///
  /// In en, this message translates to:
  /// **'A time display app for nerds and amateur astronomers. Displays the current time in civil, technical, and astronomical time systems.'**
  String get dialogueAbout;

  /// No description provided for @dialogueAboutLegalese.
  ///
  /// In en, this message translates to:
  /// **'© 2026 RealEarthling'**
  String get dialogueAboutLegalese;

  /// No description provided for @hintAboutThisValue.
  ///
  /// In en, this message translates to:
  /// **'About this value'**
  String get hintAboutThisValue;

  /// No description provided for @hintAddTab.
  ///
  /// In en, this message translates to:
  /// **'Add tab'**
  String get hintAddTab;

  /// No description provided for @hintAddValue.
  ///
  /// In en, this message translates to:
  /// **'Add value'**
  String get hintAddValue;

  /// No description provided for @hintBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get hintBack;

  /// No description provided for @hintCopyToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get hintCopyToClipboard;

  /// No description provided for @hintDeselect.
  ///
  /// In en, this message translates to:
  /// **'Deselect'**
  String get hintDeselect;

  /// No description provided for @hintDeselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect all'**
  String get hintDeselectAll;

  /// No description provided for @hintDoneEditing.
  ///
  /// In en, this message translates to:
  /// **'Done editing'**
  String get hintDoneEditing;

  /// No description provided for @hintEditLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit label'**
  String get hintEditLabel;

  /// No description provided for @hintEditLayout.
  ///
  /// In en, this message translates to:
  /// **'Edit layout'**
  String get hintEditLayout;

  /// No description provided for @hintRemoveSelected.
  ///
  /// In en, this message translates to:
  /// **'Remove hintSelected'**
  String get hintRemoveSelected;

  /// No description provided for @hintResetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get hintResetToDefaults;

  /// No description provided for @hintSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get hintSelect;

  /// No description provided for @hintSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get hintSelectAll;

  /// No description provided for @hintSelectTimezone.
  ///
  /// In en, this message translates to:
  /// **'Select timezone'**
  String get hintSelectTimezone;

  /// No description provided for @hintSelectValueType.
  ///
  /// In en, this message translates to:
  /// **'Select value type'**
  String get hintSelectValueType;

  /// No description provided for @hintTimezoneSearch.
  ///
  /// In en, this message translates to:
  /// **'City, country, zone or offset (e.g. UTC+5:30)'**
  String get hintTimezoneSearch;

  /// No description provided for @infoLinkBinaryClockBcd.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Binary_clock'**
  String get infoLinkBinaryClockBcd;

  /// No description provided for @infoLinkBinaryClockColumns.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Binary_clock'**
  String get infoLinkBinaryClockColumns;

  /// No description provided for @infoLinkBinaryClockString.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Binary_clock'**
  String get infoLinkBinaryClockString;

  /// No description provided for @infoLinkDoomsdayClock.
  ///
  /// In en, this message translates to:
  /// **'https://thebulletin.org/doomsday-clock/'**
  String get infoLinkDoomsdayClock;

  /// No description provided for @infoLinkGmst.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Sidereal_time'**
  String get infoLinkGmst;

  /// No description provided for @infoLinkGps.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/GPS_time#Timekeeping'**
  String get infoLinkGps;

  /// No description provided for @infoLinkJulianDate.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Julian_day'**
  String get infoLinkJulianDate;

  /// No description provided for @infoLinkLmst.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Sidereal_time'**
  String get infoLinkLmst;

  /// No description provided for @infoLinkModifiedJulianDate.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Julian_day#Variants'**
  String get infoLinkModifiedJulianDate;

  /// No description provided for @infoLinkModifiedJulianDate2000.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Julian_day#Variants'**
  String get infoLinkModifiedJulianDate2000;

  /// No description provided for @infoLinkSwatchBeats.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Swatch_Internet_Time'**
  String get infoLinkSwatchBeats;

  /// No description provided for @infoLinkTai.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/International_Atomic_Time'**
  String get infoLinkTai;

  /// No description provided for @infoLinkUnixSeconds.
  ///
  /// In en, this message translates to:
  /// **'https://en.wikipedia.org/wiki/Unix_time'**
  String get infoLinkUnixSeconds;

  /// No description provided for @infoTextBinaryClockBcd.
  ///
  /// In en, this message translates to:
  /// **'Each decimal digit of hours, minutes and seconds is shown as a separate binary column (BCD = Binary-Coded Decimal), as seen on the Wikipedia binary clock article.'**
  String get infoTextBinaryClockBcd;

  /// No description provided for @infoTextBinaryClockColumns.
  ///
  /// In en, this message translates to:
  /// **'Time displayed in binary. Each column shows hours, minutes, or seconds in base-2. Read top bit as most significant.'**
  String get infoTextBinaryClockColumns;

  /// No description provided for @infoTextBinaryClockString.
  ///
  /// In en, this message translates to:
  /// **'Compact binary representation: hours:minutes:seconds in base-2, e.g. 10:110000:10111.'**
  String get infoTextBinaryClockString;

  /// No description provided for @infoTextDate.
  ///
  /// In en, this message translates to:
  /// **'The current calendar date in the hintSelected timezone.'**
  String get infoTextDate;

  /// No description provided for @infoTextDateTime.
  ///
  /// In en, this message translates to:
  /// **'The current date and time in the hintSelected timezone, combined in one value. Useful for copying a complete timestamp to the clipboard.'**
  String get infoTextDateTime;

  /// No description provided for @infoTextDayPercent.
  ///
  /// In en, this message translates to:
  /// **'Percentage of the day elapsed in the hintSelected timezone. Resets to 0 at midnight.'**
  String get infoTextDayPercent;

  /// No description provided for @infoTextDaySecond.
  ///
  /// In en, this message translates to:
  /// **'Seconds elapsed since midnight in the hintSelected timezone. Resets to 0 at midnight.'**
  String get infoTextDaySecond;

  /// No description provided for @infoTextDoomsdayClock.
  ///
  /// In en, this message translates to:
  /// **'The Doomsday Clock is a symbol representing how close humanity is to self-destruction. Maintained by the Bulletin of the Atomic Scientists. Currently set to 85 seconds to midnight (as of Jan 2026).'**
  String get infoTextDoomsdayClock;

  /// No description provided for @infoTextGmst.
  ///
  /// In en, this message translates to:
  /// **'Greenwich Mean Sidereal Time (GMST) – the hour angle of the vernal equinox at Greenwich. Used by astronomers to determine which part of the sky is overhead.'**
  String get infoTextGmst;

  /// No description provided for @infoTextGps.
  ///
  /// In en, this message translates to:
  /// **'GPS time counts seconds since 1980-01-06 00:00:00 UTC and does not include leap seconds. Currently, in May 2026, 18 seconds ahead of UTC. The last leap second was added on 2016-12-31 at 23:59:60 UTC.'**
  String get infoTextGps;

  /// No description provided for @infoTextJulianDate.
  ///
  /// In en, this message translates to:
  /// **'Julian Date counts days since noon on January 1, 4713 BC (-4712-01-01 12:00:00 UT). The standard time reference in astronomy for calculating intervals between events.'**
  String get infoTextJulianDate;

  /// No description provided for @infoTextLmst.
  ///
  /// In en, this message translates to:
  /// **'Local Mean Sidereal Time (LMST) – the hour angle of the vernal equinox at your location. Derived from GMST by adding your longitude. Used by astronomers to determine which objects are currently observable.'**
  String get infoTextLmst;

  /// No description provided for @infoTextModifiedJulianDate.
  ///
  /// In en, this message translates to:
  /// **'Modified Julian Date = JD − 2,400,000.5 (1858-11-17 00:00:00 UT). Starts at midnight rather than noon, and has smaller numbers. Introduced by the Smithsonian Astrophysical Observatory in 1957 to record the orbit of Sputnik.'**
  String get infoTextModifiedJulianDate;

  /// No description provided for @infoTextModifiedJulianDate2000.
  ///
  /// In en, this message translates to:
  /// **'Modified Julian Date 2000 = JD – 2,451,544.5 or MJD – 51,544 (2000-01-01 00:00:00 UTC). Used in geodesy, geophysics, and spaceflight to simplify calculations with smaller numbers by shifting the reference to the beginning of the year 2000.'**
  String get infoTextModifiedJulianDate2000;

  /// No description provided for @infoTextSwatchBeats.
  ///
  /// In en, this message translates to:
  /// **'Swatch Internet Time divides the day into 1000 .beats. There are no time zones — the whole world shares the same .beat. Based on UTC+1 (Biel Mean Time).'**
  String get infoTextSwatchBeats;

  /// No description provided for @infoTextTai.
  ///
  /// In en, this message translates to:
  /// **'International Atomic Time (TAI) counts seconds since 1977-01-01 00:00:00 UTC and does not include leap seconds. Currently, in May 2026, 37 seconds ahead of UTC. The last leap second was added on 2016-12-31 at 23:59:60 UTC.'**
  String get infoTextTai;

  /// No description provided for @infoTextTime.
  ///
  /// In en, this message translates to:
  /// **'The current time in the hintSelected timezone.'**
  String get infoTextTime;

  /// No description provided for @infoTextUnixSeconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds elapsed since the Unix epoch: 1970-01-01 00:00:00 UTC.'**
  String get infoTextUnixSeconds;

  /// No description provided for @labelHours.
  ///
  /// In en, this message translates to:
  /// **'HH'**
  String get labelHours;

  /// No description provided for @labelLocal.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get labelLocal;

  /// No description provided for @labelLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude (negative = West)'**
  String get labelLongitude;

  /// No description provided for @labelMinutes.
  ///
  /// In en, this message translates to:
  /// **'MM'**
  String get labelMinutes;

  /// No description provided for @labelNewLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get labelNewLabel;

  /// No description provided for @labelNewTabName.
  ///
  /// In en, this message translates to:
  /// **'Tab name'**
  String get labelNewTabName;

  /// No description provided for @labelSeconds.
  ///
  /// In en, this message translates to:
  /// **'SS'**
  String get labelSeconds;

  /// No description provided for @messageAlreadyDisplayed.
  ///
  /// In en, this message translates to:
  /// **'This value is already displayed.'**
  String get messageAlreadyDisplayed;

  /// No description provided for @messageCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied: {label}'**
  String messageCopiedToClipboard(String label);

  /// No description provided for @messageEmptyTab.
  ///
  /// In en, this message translates to:
  /// **'Configurable tab.\nUse the edit mode to add values.'**
  String get messageEmptyTab;

  /// No description provided for @messageMaxValues.
  ///
  /// In en, this message translates to:
  /// **'Maximum of {count} values reached.'**
  String messageMaxValues(int count);

  /// No description provided for @messageNoTimezone.
  ///
  /// In en, this message translates to:
  /// **'No matching timezone found.'**
  String get messageNoTimezone;

  /// No description provided for @pageSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get pageSettings;

  /// No description provided for @pageSettingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get pageSettingsAbout;

  /// No description provided for @pageSettingsDateWithDetails.
  ///
  /// In en, this message translates to:
  /// **'Expanded Date'**
  String get pageSettingsDateWithDetails;

  /// No description provided for @pageSettingsDateWithDetailsSub.
  ///
  /// In en, this message translates to:
  /// **'On = with ISO calender week, day of the year'**
  String get pageSettingsDateWithDetailsSub;

  /// No description provided for @pageSettingsHourFormat.
  ///
  /// In en, this message translates to:
  /// **'24-hour format'**
  String get pageSettingsHourFormat;

  /// No description provided for @pageSettingsHourFormatSub.
  ///
  /// In en, this message translates to:
  /// **'Off = 12-hour with AM/PM'**
  String get pageSettingsHourFormatSub;

  /// No description provided for @pageSettingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get pageSettingsLanguage;

  /// No description provided for @pageSettingsLmst.
  ///
  /// In en, this message translates to:
  /// **'Local sidereal time'**
  String get pageSettingsLmst;

  /// No description provided for @pageSettingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get pageSettingsTheme;

  /// No description provided for @pageSettingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get pageSettingsThemeDark;

  /// No description provided for @pageSettingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get pageSettingsThemeLight;

  /// No description provided for @pageSettingsThemeNight.
  ///
  /// In en, this message translates to:
  /// **'Night (red)'**
  String get pageSettingsThemeNight;

  /// No description provided for @pageSettingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get pageSettingsThemeSystem;

  /// No description provided for @pageSettingsThousandsSep.
  ///
  /// In en, this message translates to:
  /// **'Thousands separator'**
  String get pageSettingsThousandsSep;

  /// No description provided for @pageSettingsThousandsSepSub.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1,746,000 instead of 1746000'**
  String get pageSettingsThousandsSepSub;

  /// No description provided for @pageSettingsWhatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s New'**
  String get pageSettingsWhatsNew;

  /// No description provided for @sectionAtomic.
  ///
  /// In en, this message translates to:
  /// **'Atomic Clock'**
  String get sectionAtomic;

  /// No description provided for @sectionBinaryClock.
  ///
  /// In en, this message translates to:
  /// **'Binary Clock'**
  String get sectionBinaryClock;

  /// No description provided for @sectionDoomsdayClock.
  ///
  /// In en, this message translates to:
  /// **'Doomsday Clock'**
  String get sectionDoomsdayClock;

  /// No description provided for @sectionGps.
  ///
  /// In en, this message translates to:
  /// **'Global Positioning System'**
  String get sectionGps;

  /// No description provided for @sectionInternet.
  ///
  /// In en, this message translates to:
  /// **'Internet Time'**
  String get sectionInternet;

  /// No description provided for @sectionJulian.
  ///
  /// In en, this message translates to:
  /// **'Julian Date'**
  String get sectionJulian;

  /// No description provided for @sectionSidereal.
  ///
  /// In en, this message translates to:
  /// **'Sidereal Time'**
  String get sectionSidereal;

  /// No description provided for @sectionUnix.
  ///
  /// In en, this message translates to:
  /// **'Unix Epoch'**
  String get sectionUnix;

  /// No description provided for @settingLmstLongitudeAuto.
  ///
  /// In en, this message translates to:
  /// **'Use approximate location'**
  String get settingLmstLongitudeAuto;

  /// No description provided for @settingLmstLongitudeAutoSub.
  ///
  /// In en, this message translates to:
  /// **'One-time, without GPS, no tracking'**
  String get settingLmstLongitudeAutoSub;

  /// No description provided for @settingLmstLongitudeManual.
  ///
  /// In en, this message translates to:
  /// **'Manual longitude'**
  String get settingLmstLongitudeManual;

  /// No description provided for @settingLmstLongitudeManualSub.
  ///
  /// In en, this message translates to:
  /// **'Enter your longitude in decimal degrees (DDD.DDDD)'**
  String get settingLmstLongitudeManualSub;

  /// No description provided for @settingLmstOff.
  ///
  /// In en, this message translates to:
  /// **'Do not show'**
  String get settingLmstOff;

  /// No description provided for @tabAstronomical.
  ///
  /// In en, this message translates to:
  /// **'Astronomical'**
  String get tabAstronomical;

  /// No description provided for @tabCivil.
  ///
  /// In en, this message translates to:
  /// **'Civil'**
  String get tabCivil;

  /// No description provided for @tabCuriosities.
  ///
  /// In en, this message translates to:
  /// **'Curiosities'**
  String get tabCuriosities;

  /// No description provided for @tabTechnical.
  ///
  /// In en, this message translates to:
  /// **'Technical'**
  String get tabTechnical;

  /// No description provided for @valueTypeBinaryClockBcd.
  ///
  /// In en, this message translates to:
  /// **'Binary clock (BCD)'**
  String get valueTypeBinaryClockBcd;

  /// No description provided for @valueTypeBinaryClockColumns.
  ///
  /// In en, this message translates to:
  /// **'Binary clock (columns)'**
  String get valueTypeBinaryClockColumns;

  /// No description provided for @valueTypeBinaryClockString.
  ///
  /// In en, this message translates to:
  /// **'Binary time (string)'**
  String get valueTypeBinaryClockString;

  /// No description provided for @valueTypeDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get valueTypeDate;

  /// No description provided for @valueTypeDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get valueTypeDateTime;

  /// No description provided for @valueTypeDayPercent.
  ///
  /// In en, this message translates to:
  /// **'Day percent'**
  String get valueTypeDayPercent;

  /// No description provided for @valueTypeDaySecond.
  ///
  /// In en, this message translates to:
  /// **'Day second'**
  String get valueTypeDaySecond;

  /// No description provided for @valueTypeDoomsdayClock.
  ///
  /// In en, this message translates to:
  /// **'Doomsday Clock'**
  String get valueTypeDoomsdayClock;

  /// No description provided for @valueTypeGmst.
  ///
  /// In en, this message translates to:
  /// **'GMST'**
  String get valueTypeGmst;

  /// No description provided for @valueTypeGps.
  ///
  /// In en, this message translates to:
  /// **'GPS time (s)'**
  String get valueTypeGps;

  /// No description provided for @valueTypeJulianDate.
  ///
  /// In en, this message translates to:
  /// **'Julian Date'**
  String get valueTypeJulianDate;

  /// No description provided for @valueTypeLmst.
  ///
  /// In en, this message translates to:
  /// **'LMST'**
  String get valueTypeLmst;

  /// No description provided for @valueTypeModifiedJulianDate.
  ///
  /// In en, this message translates to:
  /// **'Modified Julian Date'**
  String get valueTypeModifiedJulianDate;

  /// No description provided for @valueTypeModifiedJulianDate2000.
  ///
  /// In en, this message translates to:
  /// **'Modified Julian Date 2000'**
  String get valueTypeModifiedJulianDate2000;

  /// No description provided for @valueTypeSwatchBeats.
  ///
  /// In en, this message translates to:
  /// **'Swatch Internet Time'**
  String get valueTypeSwatchBeats;

  /// No description provided for @valueTypeTai.
  ///
  /// In en, this message translates to:
  /// **'TAI (s)'**
  String get valueTypeTai;

  /// No description provided for @valueTypeTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get valueTypeTime;

  /// No description provided for @valueTypeUnixSeconds.
  ///
  /// In en, this message translates to:
  /// **'Unix time (s)'**
  String get valueTypeUnixSeconds;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
