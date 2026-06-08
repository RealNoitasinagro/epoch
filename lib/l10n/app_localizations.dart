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

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'A time display app for nerds and amateur astronomers. Displays the current time in civil, technical, and astronomical time systems.'**
  String get aboutDescription;

  /// No description provided for @aboutLegalese.
  ///
  /// In en, this message translates to:
  /// **'© 2026 RealEarthling'**
  String get aboutLegalese;

  /// No description provided for @aboutThisValue.
  ///
  /// In en, this message translates to:
  /// **'About this value'**
  String get aboutThisValue;

  /// No description provided for @addTab.
  ///
  /// In en, this message translates to:
  /// **'Add tab'**
  String get addTab;

  /// No description provided for @addValue.
  ///
  /// In en, this message translates to:
  /// **'Add value'**
  String get addValue;

  /// No description provided for @alreadyDisplayed.
  ///
  /// In en, this message translates to:
  /// **'This value is already displayed.'**
  String get alreadyDisplayed;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Epoch'**
  String get appName;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @binaryClockPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Graphical binary clock'**
  String get binaryClockPlaceholder;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied: {label}'**
  String copiedToClipboard(String label);

  /// No description provided for @copyToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get copyToClipboard;

  /// No description provided for @dateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'week {week} · day {day}'**
  String dateSubtitle(int week, int day);

  /// No description provided for @deleteTab.
  ///
  /// In en, this message translates to:
  /// **'Delete tab'**
  String get deleteTab;

  /// No description provided for @deselect.
  ///
  /// In en, this message translates to:
  /// **'Deselect'**
  String get deselect;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect all'**
  String get deselectAll;

  /// No description provided for @doneEditing.
  ///
  /// In en, this message translates to:
  /// **'Done editing'**
  String get doneEditing;

  /// No description provided for @editLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit label'**
  String get editLabel;

  /// No description provided for @editLayout.
  ///
  /// In en, this message translates to:
  /// **'Edit layout'**
  String get editLayout;

  /// No description provided for @emptyTabHint.
  ///
  /// In en, this message translates to:
  /// **'Configurable tab.\nUse the edit mode to add values.'**
  String get emptyTabHint;

  /// No description provided for @infoBinaryClockBcd.
  ///
  /// In en, this message translates to:
  /// **'Each decimal digit of hours, minutes and seconds is shown as a separate binary column (BCD = Binary-Coded Decimal), as seen on the Wikipedia binary clock article.'**
  String get infoBinaryClockBcd;

  /// No description provided for @infoBinaryClockColumns.
  ///
  /// In en, this message translates to:
  /// **'Time displayed in binary. Each column shows hours, minutes, or seconds in base-2. Read top bit as most significant.'**
  String get infoBinaryClockColumns;

  /// No description provided for @infoBinaryClockString.
  ///
  /// In en, this message translates to:
  /// **'Compact binary representation: hours:minutes:seconds in base-2, e.g. 10:110000:10111.'**
  String get infoBinaryClockString;

  /// No description provided for @infoDate.
  ///
  /// In en, this message translates to:
  /// **'The current calendar date in the selected timezone.'**
  String get infoDate;

  /// No description provided for @infoDateTime.
  ///
  /// In en, this message translates to:
  /// **'The current date and time in the selected timezone, combined in one value. Useful for copying a complete timestamp to the clipboard.'**
  String get infoDateTime;

  /// No description provided for @infoDayPercent.
  ///
  /// In en, this message translates to:
  /// **'Percentage of the day elapsed in the selected timezone. Resets to 0 at midnight.'**
  String get infoDayPercent;

  /// No description provided for @infoDaySecond.
  ///
  /// In en, this message translates to:
  /// **'Seconds elapsed since midnight in the selected timezone. Resets to 0 at midnight.'**
  String get infoDaySecond;

  /// No description provided for @infoDoomsdayClock.
  ///
  /// In en, this message translates to:
  /// **'The Doomsday Clock is a symbol representing how close humanity is to self-destruction. Maintained by the Bulletin of the Atomic Scientists. Currently set to 85 seconds to midnight (as of Jan 2026).'**
  String get infoDoomsdayClock;

  /// No description provided for @infoGmst.
  ///
  /// In en, this message translates to:
  /// **'Greenwich Mean Sidereal Time (GMST) – the hour angle of the vernal equinox at Greenwich. Used by astronomers to determine which part of the sky is overhead.'**
  String get infoGmst;

  /// No description provided for @infoGps.
  ///
  /// In en, this message translates to:
  /// **'GPS time counts seconds since 1980-01-06 00:00:00 UTC and does not include leap seconds. Currently, in May 2026, 18 seconds ahead of UTC. The last leap second was added on 2016-12-31 at 23:59:60 UTC.'**
  String get infoGps;

  /// No description provided for @infoJulianDate.
  ///
  /// In en, this message translates to:
  /// **'Julian Date counts days since noon on January 1, 4713 BC (-4712-01-01 12:00:00 UT). The standard time reference in astronomy for calculating intervals between events.'**
  String get infoJulianDate;

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

  /// No description provided for @infoLmst.
  ///
  /// In en, this message translates to:
  /// **'Local Mean Sidereal Time (LMST) – the hour angle of the vernal equinox at your location. Derived from GMST by adding your longitude. Used by astronomers to determine which objects are currently observable.'**
  String get infoLmst;

  /// No description provided for @infoModifiedJulianDate.
  ///
  /// In en, this message translates to:
  /// **'Modified Julian Date = JD − 2,400,000.5 (1858-11-17 00:00:00 UT). Starts at midnight rather than noon, and has smaller numbers. Introduced by the Smithsonian Astrophysical Observatory in 1957 to record the orbit of Sputnik.'**
  String get infoModifiedJulianDate;

  /// No description provided for @infoModifiedJulianDate2000.
  ///
  /// In en, this message translates to:
  /// **'Modified Julian Date 2000 = JD – 2,451,544.5 or MJD – 51,544 (2000-01-01 00:00:00 UTC). Used in geodesy, geophysics, and spaceflight to simplify calculations with smaller numbers by shifting the reference to the beginning of the year 2000.'**
  String get infoModifiedJulianDate2000;

  /// No description provided for @infoSwatchBeats.
  ///
  /// In en, this message translates to:
  /// **'Swatch Internet Time divides the day into 1000 .beats. There are no time zones — the whole world shares the same .beat. Based on UTC+1 (Biel Mean Time).'**
  String get infoSwatchBeats;

  /// No description provided for @infoTai.
  ///
  /// In en, this message translates to:
  /// **'International Atomic Time (TAI) counts seconds since 1977-01-01 00:00:00 UTC and does not include leap seconds. Currently, in May 2026, 37 seconds ahead of UTC. The last leap second was added on 2016-12-31 at 23:59:60 UTC.'**
  String get infoTai;

  /// No description provided for @infoTime.
  ///
  /// In en, this message translates to:
  /// **'The current time in the selected timezone.'**
  String get infoTime;

  /// No description provided for @infoUnixSeconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds elapsed since the Unix epoch: 1970-01-01 00:00:00 UTC.'**
  String get infoUnixSeconds;

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

  /// No description provided for @labelMinutes.
  ///
  /// In en, this message translates to:
  /// **'MM'**
  String get labelMinutes;

  /// No description provided for @labelSeconds.
  ///
  /// In en, this message translates to:
  /// **'SS'**
  String get labelSeconds;

  /// No description provided for @labelUtc.
  ///
  /// In en, this message translates to:
  /// **'UTC'**
  String get labelUtc;

  /// No description provided for @lmstDetermineLocation.
  ///
  /// In en, this message translates to:
  /// **'Determine'**
  String get lmstDetermineLocation;

  /// No description provided for @lmstLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get lmstLocationDenied;

  /// No description provided for @lmstLocationNotYetDetermined.
  ///
  /// In en, this message translates to:
  /// **'Not yet determined'**
  String get lmstLocationNotYetDetermined;

  /// No description provided for @lmstLongitudeLabel.
  ///
  /// In en, this message translates to:
  /// **'Longitude (negative = West)'**
  String get lmstLongitudeLabel;

  /// No description provided for @lmstModeLocation.
  ///
  /// In en, this message translates to:
  /// **'Use approximate location'**
  String get lmstModeLocation;

  /// No description provided for @lmstModeLocationSub.
  ///
  /// In en, this message translates to:
  /// **'One-time, without GPS, no tracking'**
  String get lmstModeLocationSub;

  /// No description provided for @lmstModeManual.
  ///
  /// In en, this message translates to:
  /// **'Manual longitude'**
  String get lmstModeManual;

  /// No description provided for @lmstModeManualSub.
  ///
  /// In en, this message translates to:
  /// **'Enter your longitude in decimal degrees'**
  String get lmstModeManualSub;

  /// No description provided for @lmstModeOff.
  ///
  /// In en, this message translates to:
  /// **'Do not show'**
  String get lmstModeOff;

  /// No description provided for @maxValuesReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum of {count} values reached.'**
  String maxValuesReached(int count);

  /// No description provided for @newLabelName.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get newLabelName;

  /// No description provided for @newTabName.
  ///
  /// In en, this message translates to:
  /// **'Tab name'**
  String get newTabName;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available yet.'**
  String get noDescription;

  /// No description provided for @removeSelected.
  ///
  /// In en, this message translates to:
  /// **'Remove selected'**
  String get removeSelected;

  /// No description provided for @renameTab.
  ///
  /// In en, this message translates to:
  /// **'Rename tab'**
  String get renameTab;

  /// No description provided for @resetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get resetToDefaults;

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

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @selectForRemoval.
  ///
  /// In en, this message translates to:
  /// **'Select for removal'**
  String get selectForRemoval;

  /// No description provided for @selectTimezone.
  ///
  /// In en, this message translates to:
  /// **'Select timezone'**
  String get selectTimezone;

  /// No description provided for @selectValueType.
  ///
  /// In en, this message translates to:
  /// **'Select value type'**
  String get selectValueType;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsDateWithDetails.
  ///
  /// In en, this message translates to:
  /// **'Expanded Date'**
  String get settingsDateWithDetails;

  /// No description provided for @settingsDateWithDetailsSub.
  ///
  /// In en, this message translates to:
  /// **'On = with ISO calender week, day of the year'**
  String get settingsDateWithDetailsSub;

  /// No description provided for @settingsHourFormat.
  ///
  /// In en, this message translates to:
  /// **'24-hour format'**
  String get settingsHourFormat;

  /// No description provided for @settingsHourFormatSub.
  ///
  /// In en, this message translates to:
  /// **'Off = 12-hour with AM/PM'**
  String get settingsHourFormatSub;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLmst.
  ///
  /// In en, this message translates to:
  /// **'LOCAL SIDEREAL TIME'**
  String get settingsLmst;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeNight.
  ///
  /// In en, this message translates to:
  /// **'Night (red)'**
  String get settingsThemeNight;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThousandsSep.
  ///
  /// In en, this message translates to:
  /// **'Thousands separator'**
  String get settingsThousandsSep;

  /// No description provided for @settingsThousandsSepSub.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1,746,000 instead of 1746000'**
  String get settingsThousandsSepSub;

  /// No description provided for @settingsWhatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s New'**
  String get settingsWhatsNew;

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

  /// No description provided for @tabValueCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no values} =1{1 value} other{{count} values}}'**
  String tabValueCount(num count);

  /// No description provided for @tabWatchlist.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get tabWatchlist;

  /// No description provided for @timezoneNoResults.
  ///
  /// In en, this message translates to:
  /// **'No matching timezone found.'**
  String get timezoneNoResults;

  /// No description provided for @timezoneSearchHint.
  ///
  /// In en, this message translates to:
  /// **'City, country, zone or offset (e.g. UTC+5:30)'**
  String get timezoneSearchHint;

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

  /// No description provided for @zoneLocal.
  ///
  /// In en, this message translates to:
  /// **'Local (system timezone)'**
  String get zoneLocal;

  /// No description provided for @zoneOther.
  ///
  /// In en, this message translates to:
  /// **'Other…'**
  String get zoneOther;

  /// No description provided for @zoneUtc.
  ///
  /// In en, this message translates to:
  /// **'UTC'**
  String get zoneUtc;
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
