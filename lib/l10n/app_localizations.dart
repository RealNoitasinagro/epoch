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

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Epoch'**
  String get appName;

  /// No description provided for @tabMain.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get tabMain;

  /// No description provided for @tabTechnical.
  ///
  /// In en, this message translates to:
  /// **'Technical'**
  String get tabTechnical;

  /// No description provided for @tabAstronomy.
  ///
  /// In en, this message translates to:
  /// **'Astronomy'**
  String get tabAstronomy;

  /// No description provided for @tabCuriosities.
  ///
  /// In en, this message translates to:
  /// **'Curiosities'**
  String get tabCuriosities;

  /// No description provided for @labelLocal.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get labelLocal;

  /// No description provided for @labelUtc.
  ///
  /// In en, this message translates to:
  /// **'UTC'**
  String get labelUtc;

  /// No description provided for @labelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get labelDate;

  /// No description provided for @labelTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get labelTime;

  /// No description provided for @labelDaySecond.
  ///
  /// In en, this message translates to:
  /// **'Day second'**
  String get labelDaySecond;

  /// No description provided for @sectionEpoch.
  ///
  /// In en, this message translates to:
  /// **'Unix Epoch'**
  String get sectionEpoch;

  /// No description provided for @sectionAtomicGps.
  ///
  /// In en, this message translates to:
  /// **'Atomic & GPS'**
  String get sectionAtomicGps;

  /// No description provided for @labelUnixSeconds.
  ///
  /// In en, this message translates to:
  /// **'Unix time (s)'**
  String get labelUnixSeconds;

  /// No description provided for @labelTai.
  ///
  /// In en, this message translates to:
  /// **'TAI (s since epoch)'**
  String get labelTai;

  /// No description provided for @labelGps.
  ///
  /// In en, this message translates to:
  /// **'GPS time (s)'**
  String get labelGps;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

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

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

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

  /// No description provided for @zoneLocal.
  ///
  /// In en, this message translates to:
  /// **'Local (system timezone)'**
  String get zoneLocal;

  /// No description provided for @zoneUtc.
  ///
  /// In en, this message translates to:
  /// **'UTC'**
  String get zoneUtc;

  /// No description provided for @zoneOther.
  ///
  /// In en, this message translates to:
  /// **'Other…'**
  String get zoneOther;

  /// No description provided for @selectValueType.
  ///
  /// In en, this message translates to:
  /// **'Select value type'**
  String get selectValueType;

  /// No description provided for @selectTimezone.
  ///
  /// In en, this message translates to:
  /// **'Select timezone'**
  String get selectTimezone;

  /// No description provided for @selectRegion.
  ///
  /// In en, this message translates to:
  /// **'Select region'**
  String get selectRegion;

  /// No description provided for @valueTypeDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get valueTypeDate;

  /// No description provided for @valueTypeTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get valueTypeTime;

  /// No description provided for @valueTypeDaySecond.
  ///
  /// In en, this message translates to:
  /// **'Day second'**
  String get valueTypeDaySecond;

  /// No description provided for @addValue.
  ///
  /// In en, this message translates to:
  /// **'Add value'**
  String get addValue;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @editLayout.
  ///
  /// In en, this message translates to:
  /// **'Edit layout'**
  String get editLayout;

  /// No description provided for @doneEditing.
  ///
  /// In en, this message translates to:
  /// **'Done editing'**
  String get doneEditing;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect all'**
  String get deselectAll;

  /// No description provided for @selectForRemoval.
  ///
  /// In en, this message translates to:
  /// **'Select for removal'**
  String get selectForRemoval;

  /// No description provided for @deselect.
  ///
  /// In en, this message translates to:
  /// **'Deselect'**
  String get deselect;

  /// No description provided for @removeSelected.
  ///
  /// In en, this message translates to:
  /// **'Remove selected'**
  String get removeSelected;

  /// No description provided for @resetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get resetToDefaults;

  /// No description provided for @moveUp.
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get moveUp;

  /// No description provided for @moveDown.
  ///
  /// In en, this message translates to:
  /// **'Move down'**
  String get moveDown;

  /// No description provided for @maxValuesReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum of {count} values reached.'**
  String maxValuesReached(int count);

  /// No description provided for @alreadyDisplayed.
  ///
  /// In en, this message translates to:
  /// **'This value is already displayed.'**
  String get alreadyDisplayed;

  /// No description provided for @allValuesDisplayed.
  ///
  /// In en, this message translates to:
  /// **'All available values are already displayed.'**
  String get allValuesDisplayed;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied: {label}'**
  String copiedToClipboard(String label);

  /// No description provided for @aboutThisValue.
  ///
  /// In en, this message translates to:
  /// **'About this value'**
  String get aboutThisValue;

  /// No description provided for @copyToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get copyToClipboard;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available yet.'**
  String get noDescription;

  /// No description provided for @infoLocalDate.
  ///
  /// In en, this message translates to:
  /// **'The current calendar date in the selected timezone.'**
  String get infoLocalDate;

  /// No description provided for @infoLocalTime.
  ///
  /// In en, this message translates to:
  /// **'The current time in the selected timezone.'**
  String get infoLocalTime;

  /// No description provided for @infoDaySecond.
  ///
  /// In en, this message translates to:
  /// **'Seconds elapsed since midnight in the selected timezone. Resets to 0 at midnight.'**
  String get infoDaySecond;

  /// No description provided for @infoUnixSeconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds elapsed since the Unix epoch: 1970-01-01 00:00:00 UTC. Does not count leap seconds.'**
  String get infoUnixSeconds;

  /// No description provided for @infoTai.
  ///
  /// In en, this message translates to:
  /// **'International Atomic Time (TAI) is based on atomic clocks and currently runs 37 seconds ahead of UTC.'**
  String get infoTai;

  /// No description provided for @infoGps.
  ///
  /// In en, this message translates to:
  /// **'GPS time counts seconds since 1980-01-06 00:00:00 UTC and does not include leap seconds. Currently 18 seconds ahead of UTC.'**
  String get infoGps;

  /// No description provided for @sectionSwatch.
  ///
  /// In en, this message translates to:
  /// **'Swatch Internet Time'**
  String get sectionSwatch;

  /// No description provided for @labelSwatchBeats.
  ///
  /// In en, this message translates to:
  /// **'Internet Time'**
  String get labelSwatchBeats;

  /// No description provided for @infoSwatch.
  ///
  /// In en, this message translates to:
  /// **'Swatch Internet Time divides the day into 1000 .beats. There are no time zones — the whole world shares the same .beat. Based on UTC+1 (Biel Mean Time).'**
  String get infoSwatch;

  /// No description provided for @sectionBinaryClock.
  ///
  /// In en, this message translates to:
  /// **'Binary Clock'**
  String get sectionBinaryClock;

  /// No description provided for @labelHours.
  ///
  /// In en, this message translates to:
  /// **'HH'**
  String get labelHours;

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

  /// No description provided for @infoBinaryClock.
  ///
  /// In en, this message translates to:
  /// **'Time displayed in binary. Each column shows hours, minutes, or seconds in base-2. Read top bit as most significant.'**
  String get infoBinaryClock;

  /// No description provided for @sectionDoomsday.
  ///
  /// In en, this message translates to:
  /// **'Doomsday Clock'**
  String get sectionDoomsday;

  /// No description provided for @labelDoomsdayClock.
  ///
  /// In en, this message translates to:
  /// **'Time to midnight'**
  String get labelDoomsdayClock;

  /// No description provided for @infoDoomsday.
  ///
  /// In en, this message translates to:
  /// **'The Doomsday Clock is a symbol representing how close humanity is to self-destruction. Maintained by the Bulletin of the Atomic Scientists. Currently set to 85 seconds to midnight (as of Jan 2026).'**
  String get infoDoomsday;

  /// No description provided for @doomsdayLink.
  ///
  /// In en, this message translates to:
  /// **'→ thebulletin.org/doomsday-clock'**
  String get doomsdayLink;

  /// No description provided for @labelBinaryClockColumns.
  ///
  /// In en, this message translates to:
  /// **'Binary clock (columns)'**
  String get labelBinaryClockColumns;

  /// No description provided for @labelBinaryClockBcd.
  ///
  /// In en, this message translates to:
  /// **'Binary clock (BCD)'**
  String get labelBinaryClockBcd;

  /// No description provided for @labelBinaryClockString.
  ///
  /// In en, this message translates to:
  /// **'Binary time (string)'**
  String get labelBinaryClockString;

  /// No description provided for @infoBinaryClockBcd.
  ///
  /// In en, this message translates to:
  /// **'Each decimal digit of hours, minutes and seconds is shown as a separate binary column (BCD = Binary-Coded Decimal), as seen on the Wikipedia binary clock article.'**
  String get infoBinaryClockBcd;

  /// No description provided for @infoBinaryClockString.
  ///
  /// In en, this message translates to:
  /// **'Compact binary representation: hours:minutes:seconds in base-2, e.g. 10:110000:10111.'**
  String get infoBinaryClockString;
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
