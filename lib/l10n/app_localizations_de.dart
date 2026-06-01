// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get aboutDescription =>
      'Eine Zeitanzeige-App für Nerds und Hobbyastronomen. Zeigt die aktuelle Zeit in zivilen, technischen und astronomischen Zeitsystemen an.';

  @override
  String get aboutLegalese => '© 2026 RealEarthling';

  @override
  String get aboutThisValue => 'Über diesen Wert';

  @override
  String get addTab => 'Tab hinzufügen';

  @override
  String get addValue => 'Wert hinzufügen';

  @override
  String get alreadyDisplayed => 'Dieser Wert wird bereits angezeigt.';

  @override
  String get appName => 'Epoch';

  @override
  String get back => 'Zurück';

  @override
  String get binaryClockPlaceholder => 'Graphische Binäruhr';

  @override
  String get cancel => 'Abbrechen';

  @override
  String copiedToClipboard(String label) {
    return 'Kopiert: $label';
  }

  @override
  String get copyToClipboard => 'In Zwischenablage kopieren';

  @override
  String get deleteTab => 'Tab löschen';

  @override
  String get deselect => 'Abwählen';

  @override
  String get deselectAll => 'Alle abwählen';

  @override
  String get doneEditing => 'Fertig';

  @override
  String get editLabel => 'Bezeichnung bearbeiten';

  @override
  String get editLayout => 'Layout bearbeiten';

  @override
  String get emptyTabHint =>
      'Konfigurierbarer Tab.\nBenutze den Edit-Modus, um Werte einzufügen.';

  @override
  String get infoBinaryClockBcd =>
      'Jede Dezimalziffer von Stunden, Minuten und Sekunden wird als eigene Binärspalte dargestellt (BCD = Binär-codierte Dezimalzahl), wie im Wikipedia-Artikel zur Binäruhr.';

  @override
  String get infoBinaryClockColumns =>
      'Zeit in binärer Darstellung. Jede Spalte zeigt Stunden, Minuten oder Sekunden zur Basis 2. Oberstes Bit ist das mit dem höchsten Wert.';

  @override
  String get infoBinaryClockString =>
      'Kompakte Binärdarstellung: Stunden:Minuten:Sekunden zur Basis 2, z. B. 10:110000:10111.';

  @override
  String get infoDate =>
      'Das aktuelle Kalenderdatum in der gewählten Zeitzone.';

  @override
  String get infoDateTime =>
      'Das aktuelle Datum und die Uhrzeit in der gewählten Zeitzone, als kombinierter Wert. Nützlich zum Kopieren eines vollständigen Zeitstempels.';

  @override
  String get infoDayPercent =>
      'Prozentsatz des verstrichenen Tages in der gewählten Zeitzone. Wird um Mitternacht auf 0 zurückgesetzt.';

  @override
  String get infoDaySecond =>
      'Sekunden seit Mitternacht in der gewählten Zeitzone. Wird um Mitternacht auf 0 zurückgesetzt.';

  @override
  String get infoDoomsdayClock =>
      'Die Weltuntergangsuhr symbolisiert, wie nah die Menschheit der Selbstvernichtung ist. Herausgegeben vom Bulletin of the Atomic Scientists. Aktuell auf 85 Sekunden vor Mitternacht gestellt (Stand Jan. 2026).';

  @override
  String get infoGmst =>
      'Greenwich Mean Sidereal Time (GMST) – der Stundenwinkel des Frühlingspunkts in Greenwich. Von Astronomen genutzt, um zu bestimmen, welcher Teil des Himmels sich gerade im Zenit befindet.';

  @override
  String get infoGps =>
      'GPS-Zeit zählt Sekunden seit 1980-01-06 00:00:00 UTC ohne Schaltsekunden. Aktuell, im Mai 2026, 18 Sekunden vor UTC. Die letzte Schaltsekunde wurde am 2016-12-31 um 23:59:60 UTC eingefügt.';

  @override
  String get infoJulianDate =>
      'Das Julianische Datum zählt Tage seit dem Mittag des 1. Januar 4713 v. Chr. (-4712-01-01 12:00:00 UT). Standardreferenz in der Astronomie für Zeitintervalle zwischen Ereignissen.';

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
  String get infoLinkModifiedJulianDate =>
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
  String get infoModifiedJulianDate =>
      'Modifiziertes Julianisches Datum = JD − 2.400.000,5 (1858-11-17 00:00:00 UT). Beginnt um Mitternacht statt mittags und hat kleinere Zahlen. Häufig in der Satellitentechnik und Pulsarastronomie verwendet.';

  @override
  String get infoSwatchBeats =>
      'Die Swatch-Internetzeit teilt den Tag in 1000 .beats. Es gibt keine Zeitzonen — die ganze Welt teilt dieselbe .beat-Zeit. Basiert auf UTC+1 (Bieler Meantime).';

  @override
  String get infoTai =>
      'Internationale Atomzeit (TAI) zählt Sekunden seit 1977-01-01 00:00:00 UTC ohne Schaltsekunden. Aktuell, im Mai 2026, 37 Sekunden vor UTC. Die letzte Schaltsekunde wurde am 2016-12-31 um 23:59:60 UTC eingefügt.';

  @override
  String get infoTime => 'Die aktuelle Uhrzeit in der gewählten Zeitzone.';

  @override
  String get infoUnixSeconds =>
      'Sekunden seit der Unix-Epoche: 1970-01-01 00:00:00 UTC.';

  @override
  String get labelHours => 'Std';

  @override
  String get labelLocal => 'Lokal';

  @override
  String get labelMinutes => 'Min';

  @override
  String get labelSeconds => 'Sek';

  @override
  String get labelUtc => 'UTC';

  @override
  String maxValuesReached(int count) {
    return 'Maximal $count Werte erlaubt.';
  }

  @override
  String get newLabelName => 'Bezeichnung';

  @override
  String get newTabName => 'Tab-Name';

  @override
  String get noDescription => 'Noch keine Beschreibung verfügbar.';

  @override
  String get removeSelected => 'Markierte entfernen';

  @override
  String get renameTab => 'Tab umbenennen';

  @override
  String get resetToDefaults => 'Auf Standard zurücksetzen';

  @override
  String get sectionAtomic => 'Atomuhr';

  @override
  String get sectionBinaryClock => 'Binäruhr';

  @override
  String get sectionDoomsdayClock => 'Weltuntergangsuhr';

  @override
  String get sectionEpoch => 'Unix-Epoche';

  @override
  String get sectionGps => 'Global Positioning System';

  @override
  String get sectionInternet => 'Internetzeit';

  @override
  String get sectionJulian => 'Julianisches Datum';

  @override
  String get sectionSidereal => 'Sternzeit';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get selectForRemoval => 'Zum Entfernen markieren';

  @override
  String get selectTimezone => 'Zeitzone auswählen';

  @override
  String get selectValueType => 'Werttyp auswählen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get settingsAbout => 'Über die App';

  @override
  String get settingsHourFormat => '24-Stunden-Format';

  @override
  String get settingsHourFormatSub => 'Aus = 12-Stunden mit AM/PM';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeNight => 'Nacht (Rot)';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThousandsSep => 'Tausendertrennzeichen';

  @override
  String get settingsThousandsSepSub => 'z. B. 1.746.000 statt 1746000';

  @override
  String get tabAstronomical => 'Astronomisch';

  @override
  String get tabCivil => 'Bürgerlich';

  @override
  String get tabCuriosities => 'Kurioses';

  @override
  String get tabTechnical => 'Technisch';

  @override
  String get tabWatchlist => 'Watchlist';

  @override
  String get timezoneNoResults => 'Keine passende Zeitzone gefunden.';

  @override
  String get timezoneSearchHint =>
      'Stadt, Land, Zone oder Offset (z. B. UTC+5:30)';

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
  String get valueTypeModifiedJulianDate => 'Modifiziertes Julianisches Datum';

  @override
  String get valueTypeSwatchBeats => 'Swatch-Internetzeit';

  @override
  String get valueTypeTai => 'TAI (s)';

  @override
  String get valueTypeTime => 'Uhrzeit';

  @override
  String get valueTypeUnixSeconds => 'Unix-Zeit (s)';

  @override
  String get zoneLocal => 'Lokal (Systemzeitzone)';

  @override
  String get zoneOther => 'Andere…';

  @override
  String get zoneUtc => 'UTC';
}
