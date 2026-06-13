// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get actionCancel => 'Abbrechen';

  @override
  String get actionDeleteTab => 'Tab löschen';

  @override
  String get actionRenameTab => 'Tab umbenennen';

  @override
  String get actionZoneLocal => 'Lokal (Systemzeitzone)';

  @override
  String get actionZoneNamed => 'Andere…';

  @override
  String get actionZoneUtc => 'UTC';

  @override
  String get appName => 'Epoch';

  @override
  String get dataBinaryClocksPlaceholder => 'Graphische Binäruhr';

  @override
  String dataDateSub(int week, int day) {
    return 'Woche $week · Tag $day';
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
      other: '$countString Werte',
      one: '1 Wert',
      zero: 'keine Werte',
    );
    return '$_temp0';
  }

  @override
  String get dialogueAbout =>
      'Eine Zeitanzeige-App für Nerds und Hobbyastronomen. Zeigt die aktuelle Zeit in zivilen, technischen und astronomischen Zeitsystemen an.';

  @override
  String get dialogueAboutLegalese => '© 2026 RealEarthling';

  @override
  String get hintAboutThisValue => 'Über diesen Wert';

  @override
  String get hintAddTab => 'Tab hinzufügen';

  @override
  String get hintAddValue => 'Wert hinzufügen';

  @override
  String get hintBack => 'Zurück';

  @override
  String get hintCopyToClipboard => 'In Zwischenablage kopieren';

  @override
  String get hintDeselect => 'Abwählen';

  @override
  String get hintDeselectAll => 'Alle abwählen';

  @override
  String get hintDoneEditing => 'Fertig';

  @override
  String get hintEditLabel => 'Bezeichnung bearbeiten';

  @override
  String get hintEditLayout => 'Layout bearbeiten';

  @override
  String get hintRemoveSelected => 'Markierte entfernen';

  @override
  String get hintResetToDefaults => 'Zurücksetzen';

  @override
  String get hintSelect => 'Auswählen';

  @override
  String get hintSelectAll => 'Alle auswählen';

  @override
  String get hintSelectTimezone => 'Zeitzone auswählen';

  @override
  String get hintSelectValueType => 'Werttyp auswählen';

  @override
  String get hintTimezoneSearch =>
      'Stadt, Land, Zone oder Offset (z. B. UTC+5:30)';

  @override
  String get infoLinkBinaryClockBcd =>
      'https://de.wikipedia.org/wiki/Bin%C3%A4re_Uhr';

  @override
  String get infoLinkBinaryClockColumns =>
      'https://de.wikipedia.org/wiki/Bin%C3%A4re_Uhr';

  @override
  String get infoLinkBinaryClockString =>
      'https://de.wikipedia.org/wiki/Bin%C3%A4re_Uhr';

  @override
  String get infoLinkDoomsdayClock => 'https://thebulletin.org/doomsday-clock/';

  @override
  String get infoLinkGmst => 'https://de.wikipedia.org/wiki/Sternzeit';

  @override
  String get infoLinkGps => 'https://de.wikipedia.org/wiki/GPS-Zeit';

  @override
  String get infoLinkJulianDate =>
      'https://de.wikipedia.org/wiki/Julianisches_Datum';

  @override
  String get infoLinkLmst => 'https://de.wikipedia.org/wiki/Sternzeit';

  @override
  String get infoLinkModifiedJulianDate =>
      'https://de.wikipedia.org/wiki/Julianisches_Datum#Modifiziertes_Julianisches_Datum';

  @override
  String get infoLinkModifiedJulianDate2000 =>
      'https://de.wikipedia.org/wiki/Julianisches_Datum#Modifiziertes_Julianisches_Datum';

  @override
  String get infoLinkSwatchBeats =>
      'https://de.wikipedia.org/wiki/Swatch-Internetzeit';

  @override
  String get infoLinkTai =>
      'https://de.wikipedia.org/wiki/Internationale_Atomzeit';

  @override
  String get infoLinkUnixSeconds => 'https://de.wikipedia.org/wiki/Unixzeit';

  @override
  String get infoTextBinaryClockBcd =>
      'Jede Dezimalziffer von Stunden, Minuten und Sekunden wird als eigene Binärspalte dargestellt (BCD = Binär-codierte Dezimalzahl), wie im Wikipedia-Artikel zur Binäruhr.';

  @override
  String get infoTextBinaryClockColumns =>
      'Zeit in binärer Darstellung. Jede Spalte zeigt Stunden, Minuten oder Sekunden zur Basis 2. Oberstes Bit ist das mit dem höchsten Wert.';

  @override
  String get infoTextBinaryClockString =>
      'Kompakte Binärdarstellung: Stunden:Minuten:Sekunden zur Basis 2, z. B. 10:110000:10111.';

  @override
  String get infoTextDate =>
      'Das aktuelle Kalenderdatum in der gewählten Zeitzone.';

  @override
  String get infoTextDateTime =>
      'Das aktuelle Datum und die Uhrzeit in der gewählten Zeitzone, als kombinierter Wert. Nützlich zum Kopieren eines vollständigen Zeitstempels.';

  @override
  String get infoTextDayPercent =>
      'Prozentsatz des verstrichenen Tages in der gewählten Zeitzone. Wird um Mitternacht auf 0 zurückgesetzt.';

  @override
  String get infoTextDaySecond =>
      'Sekunden seit Mitternacht in der gewählten Zeitzone. Wird um Mitternacht auf 0 zurückgesetzt.';

  @override
  String get infoTextDoomsdayClock =>
      'Die Weltuntergangsuhr symbolisiert, wie nah die Menschheit der Selbstvernichtung ist. Herausgegeben vom Bulletin of the Atomic Scientists. Aktuell auf 85 Sekunden vor Mitternacht gestellt (Stand Jan. 2026).';

  @override
  String get infoTextGmst =>
      'Greenwich Mean Sidereal Time (GMST), mittlere Greenwicher Sternzeit – der Stundenwinkel des Frühlingspunkts in Greenwich. Von Astronomen genutzt, um zu bestimmen, welcher Teil des Himmels sich gerade im Zenit befindet.';

  @override
  String get infoTextGps =>
      'GPS-Zeit zählt Sekunden seit 1980-01-06 00:00:00 UTC ohne Schaltsekunden. Aktuell, im Mai 2026, 18 Sekunden vor UTC. Die letzte Schaltsekunde wurde am 2016-12-31 um 23:59:60 UTC eingefügt.';

  @override
  String get infoTextJulianDate =>
      'Das Julianische Datum zählt Tage seit dem Mittag des 1. Januar 4713 v. Chr. (-4712-01-01 12:00:00 UT). Standardreferenz in der Astronomie für Zeitintervalle zwischen Ereignissen.';

  @override
  String get infoTextLmst =>
      'Local Mean Sidereal Time (LMST), lokale mittlere Sternzeit oder mittlere Ortssternzeit – der Stundenwinkel des Frühlingspunkts an deinem Standort. Wird aus der GMST durch Addition des Längengrads berechnet. Von Astronomen genutzt, um festzustellen, welche Himmelsobjekte gerade beobachtbar sind.';

  @override
  String get infoTextModifiedJulianDate =>
      'Modifiziertes Julianisches Datum = JD − 2.400.000,5 (1858-11-17 00:00:00 UT). Beginnt um Mitternacht statt mittags und hat kleinere Zahlen. Wurde 1957 vom Smithsonian Astrophysical Observatory eingeführt, um die Erdumlaufbahn von Sputnik aufzuzeichnen.';

  @override
  String get infoTextModifiedJulianDate2000 =>
      'Modifiziertes Julianisches Datum 2000 = JD − 2.451.544,5 oder MJD – 51.544 (2000-01-01 00:00:00 UTC). Wird in der Geodäsie, Geophysik und Raumfahrt verwendet, um Berechnungen durch kleinere Zahlen zu vereinfachen, indem das Referenzdatum an den Beginn des Jahres 2000 verschoben wird.';

  @override
  String get infoTextSwatchBeats =>
      'Die Swatch-Internetzeit teilt den Tag in 1000 .beats. Es gibt keine Zeitzonen — die ganze Welt teilt dieselbe .beat-Zeit. Basiert auf UTC+1 (Bieler Meantime).';

  @override
  String get infoTextTai =>
      'Internationale Atomzeit (TAI) zählt Sekunden seit 1977-01-01 00:00:00 UTC ohne Schaltsekunden. Aktuell, im Mai 2026, 37 Sekunden vor UTC. Die letzte Schaltsekunde wurde am 2016-12-31 um 23:59:60 UTC eingefügt.';

  @override
  String get infoTextTime => 'Die aktuelle Uhrzeit in der gewählten Zeitzone.';

  @override
  String get infoTextUnixSeconds =>
      'Sekunden seit der Unix-Epoche: 1970-01-01 00:00:00 UTC.';

  @override
  String get labelHours => 'Std';

  @override
  String get labelLocal => 'Lokal';

  @override
  String get labelLongitude => 'Längengrad (negativ = West)';

  @override
  String get labelMinutes => 'Min';

  @override
  String get labelNewLabel => 'Bezeichnung';

  @override
  String get labelNewTabName => 'Tab-Name';

  @override
  String get labelSeconds => 'Sek';

  @override
  String get messageAlreadyDisplayed => 'Dieser Wert wird bereits angezeigt.';

  @override
  String messageCopiedToClipboard(String label) {
    return 'Kopiert: $label';
  }

  @override
  String get messageEmptyTab =>
      'Konfigurierbarer Tab.\nBenutze den Edit-Modus, um Werte einzufügen.';

  @override
  String messageMaxValues(int count) {
    return 'Maximal $count Werte erlaubt.';
  }

  @override
  String get messageNoTimezone => 'Keine passende Zeitzone gefunden.';

  @override
  String get pageSettings => 'Einstellungen';

  @override
  String get pageSettingsAbout => 'Über die App';

  @override
  String get pageSettingsDateWithDetails => 'Erweitertes Datum';

  @override
  String get pageSettingsDateWithDetailsSub =>
      'Ein = mit ISO-Kalenderwoche, Tag des Jahres';

  @override
  String get pageSettingsHourFormat => '24-Stunden-Format';

  @override
  String get pageSettingsHourFormatSub => 'Aus = 12-Stunden mit AM/PM';

  @override
  String get pageSettingsLanguage => 'Sprache';

  @override
  String get pageSettingsLmst => 'Lokale Sternzeit';

  @override
  String get pageSettingsTheme => 'Design';

  @override
  String get pageSettingsThemeDark => 'Dunkel';

  @override
  String get pageSettingsThemeLight => 'Hell';

  @override
  String get pageSettingsThemeNight => 'Nacht (Rot)';

  @override
  String get pageSettingsThemeSystem => 'System';

  @override
  String get pageSettingsThousandsSep => 'Tausendertrennzeichen';

  @override
  String get pageSettingsThousandsSepSub => 'z. B. 1.746.000 statt 1746000';

  @override
  String get pageSettingsWhatsNew => 'Was ist neu';

  @override
  String get sectionAtomic => 'Atomuhr';

  @override
  String get sectionBinaryClock => 'Binäruhr';

  @override
  String get sectionDoomsdayClock => 'Weltuntergangsuhr';

  @override
  String get sectionGps => 'Global Positioning System';

  @override
  String get sectionInternet => 'Internetzeit';

  @override
  String get sectionJulian => 'Julianisches Datum';

  @override
  String get sectionSidereal => 'Sternzeit';

  @override
  String get sectionUnix => 'Unix-Epoche';

  @override
  String get settingLmstLongitudeAuto => 'Ungefähren Standort verwenden';

  @override
  String get settingLmstLongitudeAutoSub => 'Einmalig, ohne GPS, kein Tracking';

  @override
  String get settingLmstLongitudeManual => 'Längengrad manuell eingeben';

  @override
  String get settingLmstLongitudeManualSub =>
      'Längengrad in Dezimalgrad (DDD,DDDD) eingeben';

  @override
  String get settingLmstOff => 'Nicht anzeigen';

  @override
  String get tabAstronomical => 'Astronomisch';

  @override
  String get tabCivil => 'Bürgerlich';

  @override
  String get tabCuriosities => 'Kurioses';

  @override
  String get tabTechnical => 'Technisch';

  @override
  String get valueTypeBinaryClockBcd => 'Binäruhr (BCD)';

  @override
  String get valueTypeBinaryClockColumns => 'Binäruhr (Spalten)';

  @override
  String get valueTypeBinaryClockString => 'Binärzeit (String)';

  @override
  String get valueTypeDate => 'Datum';

  @override
  String get valueTypeDateTime => 'Datum & Uhrzeit';

  @override
  String get valueTypeDayPercent => 'Tagesprozent';

  @override
  String get valueTypeDaySecond => 'Tagessekunde';

  @override
  String get valueTypeDoomsdayClock => 'Doomsday Clock';

  @override
  String get valueTypeGmst => 'GMST';

  @override
  String get valueTypeGps => 'GPS-Zeit (s)';

  @override
  String get valueTypeJulianDate => 'Julianisches Datum';

  @override
  String get valueTypeLmst => 'LMST';

  @override
  String get valueTypeModifiedJulianDate => 'Modifiziertes Julianisches Datum';

  @override
  String get valueTypeModifiedJulianDate2000 =>
      'Modifiziertes Julianisches Datum 2000';

  @override
  String get valueTypeSwatchBeats => 'Swatch-Internetzeit';

  @override
  String get valueTypeTai => 'TAI (s)';

  @override
  String get valueTypeTime => 'Uhrzeit';

  @override
  String get valueTypeUnixSeconds => 'Unix-Zeit (s)';
}
