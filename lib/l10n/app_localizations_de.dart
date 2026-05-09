// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Epoch';

  @override
  String get tabMain => 'Bürgerlich';

  @override
  String get tabTechnical => 'Technisch';

  @override
  String get tabAstronomy => 'Astronomisch';

  @override
  String get tabCuriosities => 'Kurioses';

  @override
  String get labelLocal => 'Lokal';

  @override
  String get labelUtc => 'UTC';

  @override
  String get labelDate => 'Datum';

  @override
  String get labelTime => 'Uhrzeit';

  @override
  String get labelDaySecond => 'Tagessekunde';

  @override
  String get sectionEpoch => 'Unix-Epoche';

  @override
  String get sectionAtomicGps => 'Atom & GPS';

  @override
  String get labelUnixSeconds => 'Unix-Zeit (s)';

  @override
  String get labelTai => 'TAI (s seit Epoche)';

  @override
  String get labelGps => 'GPS-Zeit (s)';

  @override
  String get settings => 'Einstellungen';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsThemeNight => 'Nacht (Rot)';

  @override
  String get settingsThousandsSep => 'Tausendertrennzeichen';

  @override
  String get settingsThousandsSepSub => 'z. B. 1.746.000 statt 1746000';

  @override
  String get settingsHourFormat => '24-Stunden-Format';

  @override
  String get settingsHourFormatSub => 'Aus = 12-Stunden mit AM/PM';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsAbout => 'Über die App';

  @override
  String get aboutDescription =>
      'Eine Zeitanzeige-App für Nerds und Hobbyastronomen. Zeigt die aktuelle Zeit in zivilen, technischen und astronomischen Zeitsystemen an.';

  @override
  String get aboutLegalese => '© 2026 RealEarthling';

  @override
  String get zoneLocal => 'Lokal (Systemzeitzone)';

  @override
  String get zoneUtc => 'UTC';

  @override
  String get zoneOther => 'Andere…';

  @override
  String get selectValueType => 'Werttyp auswählen';

  @override
  String get selectTimezone => 'Zeitzone auswählen';

  @override
  String get selectRegion => 'Region auswählen';

  @override
  String get valueTypeDate => 'Datum';

  @override
  String get valueTypeTime => 'Uhrzeit';

  @override
  String get valueTypeDaySecond => 'Tagessekunde';

  @override
  String get addValue => 'Wert hinzufügen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get back => 'Zurück';

  @override
  String get editLayout => 'Layout bearbeiten';

  @override
  String get doneEditing => 'Fertig';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get deselectAll => 'Alle abwählen';

  @override
  String get selectForRemoval => 'Zum Entfernen markieren';

  @override
  String get deselect => 'Abwählen';

  @override
  String get removeSelected => 'Markierte entfernen';

  @override
  String get resetToDefaults => 'Auf Standard zurücksetzen';

  @override
  String get moveUp => 'Nach oben';

  @override
  String get moveDown => 'Nach unten';

  @override
  String maxValuesReached(int count) {
    return 'Maximal $count Werte erlaubt.';
  }

  @override
  String get alreadyDisplayed => 'Dieser Wert wird bereits angezeigt.';

  @override
  String get allValuesDisplayed =>
      'Alle verfügbaren Werte werden bereits angezeigt.';

  @override
  String copiedToClipboard(String label) {
    return 'Kopiert: $label';
  }

  @override
  String get aboutThisValue => 'Über diesen Wert';

  @override
  String get copyToClipboard => 'In Zwischenablage kopieren';

  @override
  String get noDescription => 'Noch keine Beschreibung verfügbar.';

  @override
  String get infoLocalDate =>
      'Das aktuelle Kalenderdatum in der gewählten Zeitzone.';

  @override
  String get infoLocalTime => 'Die aktuelle Uhrzeit in der gewählten Zeitzone.';

  @override
  String get infoDaySecond =>
      'Sekunden seit Mitternacht in der gewählten Zeitzone. Wird um Mitternacht auf 0 zurückgesetzt.';

  @override
  String get infoUnixSeconds =>
      'Sekunden seit der Unix-Epoche: 1970-01-01 00:00:00 UTC. Schaltsekunden werden nicht gezählt.';

  @override
  String get infoTai =>
      'Internationale Atomzeit (TAI) basiert auf Atomuhren und läuft aktuell 37 Sekunden vor UTC.';

  @override
  String get infoGps =>
      'GPS-Zeit zählt Sekunden seit 1980-01-06 00:00:00 UTC ohne Schaltsekunden. Aktuell 18 Sekunden vor UTC.';

  @override
  String get sectionSwatch => 'Swatch-Internetzeit';

  @override
  String get labelSwatchBeats => 'Internetzeit';

  @override
  String get infoSwatch =>
      'Die Swatch-Internetzeit teilt den Tag in 1000 .beats. Es gibt keine Zeitzonen — die ganze Welt teilt dieselbe .beat-Zeit. Basiert auf UTC+1 (Bieler Meantime).';

  @override
  String get sectionBinaryClock => 'Binäruhr';

  @override
  String get labelHours => 'Std';

  @override
  String get labelMinutes => 'Min';

  @override
  String get labelSeconds => 'Sek';

  @override
  String get infoBinaryClock =>
      'Zeit in binärer Darstellung. Jede Spalte zeigt Stunden, Minuten oder Sekunden zur Basis 2. Oberstes Bit ist das mit dem höchsten Wert.';

  @override
  String get sectionDoomsday => 'Weltuntergangsuhr';

  @override
  String get labelDoomsdayClock => 'Zeit bis Mitternacht';

  @override
  String get infoDoomsday =>
      'Die Weltuntergangsuhr symbolisiert, wie nah die Menschheit der Selbstvernichtung ist. Herausgegeben vom Bulletin of the Atomic Scientists. Aktuell auf 85 Sekunden vor Mitternacht gestellt (Stand Jan. 2026).';

  @override
  String get doomsdayLink => '→ thebulletin.org/doomsday-clock';

  @override
  String get labelBinaryClockColumns => 'Binäruhr (Spalten)';

  @override
  String get labelBinaryClockBcd => 'Binäruhr (BCD)';

  @override
  String get labelBinaryClockString => 'Binärzeit (String)';

  @override
  String get infoBinaryClockBcd =>
      'Jede Dezimalziffer von Stunden, Minuten und Sekunden wird als eigene Binärspalte dargestellt (BCD = Binär-codierte Dezimalzahl), wie im Wikipedia-Artikel zur Binäruhr.';

  @override
  String get infoBinaryClockString =>
      'Kompakte Binärdarstellung: Stunden:Minuten:Sekunden zur Basis 2, z. B. 10:110000:10111.';

  @override
  String get sectionSidereal => 'Sternzeit';

  @override
  String get sectionJulian => 'Julianisches Datum';

  @override
  String get labelGmst => 'GMST';

  @override
  String get labelJd => 'Julianisches Datum';

  @override
  String get labelMjd => 'Modifiziertes Julianisches Datum';

  @override
  String get infoGmst =>
      'Greenwich Mean Sidereal Time – der Stundenwinkel des Frühlingspunkts in Greenwich. Von Astronomen genutzt, um zu bestimmen, welcher Teil des Himmels sich gerade im Zenit befindet.';

  @override
  String get infoJd =>
      'Das Julianische Datum zählt Tage seit dem Mittag des 1. Januar 4713 v. Chr. Standardreferenz in der Astronomie für Zeitintervalle zwischen Ereignissen.';

  @override
  String get infoMjd =>
      'Modifiziertes Julianisches Datum = JD − 2400000.5. Beginnt um Mitternacht statt mittags und hat kleinere Zahlen. Häufig in der Satellitentechnik und Pulsarastronomie verwendet.';

  @override
  String get timezoneSearchHint =>
      'Stadt, Land, Kürzel oder Offset (z. B. UTC+5:30)';

  @override
  String get timezoneNoResults => 'Keine passende Zeitzone gefunden.';
}
