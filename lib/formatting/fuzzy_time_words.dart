import '../l10n/app_localizations.dart';
import '../time/fuzzy_time.dart';
import 'number_words.dart';

const String _english = 'en';
const String _german = 'de';

/// Longest line of a fuzzy time on a tile.
const kFuzzyTimeLineLength = 25;

/// The fuzzy time as phrases that must not be split across lines.
List<String> fuzzyTimeSegments(
  FuzzyCell cell,
  FuzzyTimeLevel level,
  AppLocalizations l10n,
) {
  return switch (cell) {
    DayOrNightCell(:final value) => [
      value == DayOrNight.day ? l10n.fuzzyWordDay : l10n.fuzzyWordNight,
    ],
    DayPartCell(:final value) => [_coarseDayPartWord(value, l10n)],
    EarlyOrLateCell(:final value) => [_dayPartWord(value, l10n)],
    ClockTimeCell(:final value) =>
      l10n.localeName.startsWith(_german)
          ? _germanClockSegments(value, level, l10n)
          : _englishClockSegments(value, level, l10n),
  };
}

/// The fuzzy time as one sentence, without line breaks.
String fuzzyTimeText(
  FuzzyCell cell,
  FuzzyTimeLevel level,
  AppLocalizations l10n,
) => fuzzyTimeSegments(cell, level, l10n).join(' ');

/// One line if everything fits, otherwise one line per segment. Segments are
/// never split; the fuzzy time has at most two.
List<String> layoutFuzzyLines(
  List<String> segments, {
  int maxLineLength = kFuzzyTimeLineLength,
}) {
  final whole = segments.join(' ');
  return whole.length <= maxLineLength ? [whole] : segments;
}

String _coarseDayPartWord(CoarseDayPart part, AppLocalizations l10n) =>
    switch (part) {
      CoarseDayPart.night => l10n.fuzzyDayPartNight,
      CoarseDayPart.morning => l10n.fuzzyDayPartMorning,
      CoarseDayPart.lateMorning => l10n.fuzzyDayPartLateMorning,
      CoarseDayPart.noon => l10n.fuzzyDayPartNoon,
      CoarseDayPart.afternoon => l10n.fuzzyDayPartAfternoon,
      CoarseDayPart.evening => l10n.fuzzyDayPartEvening,
    };

String _dayPartWord(FuzzyDayPart part, AppLocalizations l10n) => switch (part) {
  FuzzyDayPart.night => l10n.fuzzyDayPartNight,
  FuzzyDayPart.deepNight => l10n.fuzzyDayPartDeepNight,
  FuzzyDayPart.earlyMorning => l10n.fuzzyDayPartEarlyMorning,
  FuzzyDayPart.morning => l10n.fuzzyDayPartMorning,
  FuzzyDayPart.lateMorning => l10n.fuzzyDayPartLateMorning,
  FuzzyDayPart.noon => l10n.fuzzyDayPartNoon,
  FuzzyDayPart.earlyAfternoon => l10n.fuzzyDayPartEarlyAfternoon,
  FuzzyDayPart.lateAfternoon => l10n.fuzzyDayPartLateAfternoon,
  FuzzyDayPart.earlyEvening => l10n.fuzzyDayPartEarlyEvening,
  FuzzyDayPart.evening => l10n.fuzzyDayPartEvening,
};

/// The hour after [hour] on the 12-hour dial (12 is followed by 1).
int _nextDialHour(int hour) => hour % 12 + 1;

/// On the minute level, the distance to the nearest full hour, as
/// ("minutes", before or after, hour): 27 is 27 minutes after, 57 is
/// 3 minutes before the next hour.
({int minutes, bool isPast, int hour}) _distanceToFullHour(ClockCell cell) =>
    cell.minute < 30
    ? (minutes: cell.minute, isPast: true, hour: cell.hour)
    : (
        minutes: 60 - cell.minute,
        isPast: false,
        hour: _nextDialHour(cell.hour),
      );

String fuzzyLevelName(FuzzyTimeLevel level, AppLocalizations l10n) =>
    switch (level) {
      FuzzyTimeLevel.dayOrNight => l10n.fuzzyLevelDayOrNight,
      FuzzyTimeLevel.partOfDay => l10n.fuzzyLevelPartOfDay,
      FuzzyTimeLevel.earlyOrLate => l10n.fuzzyLevelEarlyOrLate,
      FuzzyTimeLevel.quarterHour => l10n.fuzzyLevelQuarterHour,
      FuzzyTimeLevel.fiveMinutes => l10n.fuzzyLevelFiveMinutes,
      FuzzyTimeLevel.minute => l10n.fuzzyLevelMinute,
    };

// ── German ─────────────────────────────────────────────────────────────────

List<String> _germanClockSegments(
  ClockCell cell,
  FuzzyTimeLevel level,
  AppLocalizations l10n,
) {
  final nextHour = _nextDialHour(cell.hour);
  String hourWord(int hour) => numberWords(hour, _german); // 1 is "eins"

  if (cell.minute == 0) {
    final fullHour = cell.hour == 1 ? 'ein' : hourWord(cell.hour);
    return ['$fullHour ${l10n.fuzzyWordOClock}'];
  }
  if (cell.minute == 30) return ['${l10n.fuzzyWordHalf} ${hourWord(nextHour)}'];

  if (level == FuzzyTimeLevel.minute) {
    final distance = _distanceToFullHour(cell);
    final amount = distance.minutes == 1
        ? l10n.fuzzyWordOneMinute
        : '${numberWords(distance.minutes, _german)} ${l10n.fuzzyWordMinutes}';
    final direction = distance.isPast ? l10n.fuzzyWordPast : l10n.fuzzyWordTo;
    return [amount, '$direction ${hourWord(distance.hour)}'];
  }

  if (cell.minute == 15) {
    return [
      '${l10n.fuzzyWordQuarter} ${l10n.fuzzyWordPast} ${hourWord(cell.hour)}',
    ];
  }
  if (cell.minute == 45) {
    return [
      '${l10n.fuzzyWordQuarter} ${l10n.fuzzyWordTo} ${hourWord(nextHour)}',
    ];
  }
  if (cell.minute < 25) {
    return [
      '${numberWords(cell.minute, _german)} ${l10n.fuzzyWordPast} '
          '${hourWord(cell.hour)}',
    ];
  }
  if (cell.minute < 30) {
    // five to half
    return [
      '${numberWords(30 - cell.minute, _german)} ${l10n.fuzzyWordTo} '
          '${l10n.fuzzyWordHalf} ${hourWord(nextHour)}',
    ];
  }
  if (cell.minute <= 35) {
    // five past half
    return [
      '${numberWords(cell.minute - 30, _german)} ${l10n.fuzzyWordPast} '
          '${l10n.fuzzyWordHalf} ${hourWord(nextHour)}',
    ];
  }
  return [
    '${numberWords(60 - cell.minute, _german)} ${l10n.fuzzyWordTo} '
        '${hourWord(nextHour)}',
  ];
}

// ── English ────────────────────────────────────────────────────────────────

List<String> _englishClockSegments(
  ClockCell cell,
  FuzzyTimeLevel level,
  AppLocalizations l10n,
) {
  String hourWord(int hour) => numberWords(hour, _english);

  if (cell.minute == 0)
    return ['${hourWord(cell.hour)} ${l10n.fuzzyWordOClock}'];
  if (cell.minute == 30)
    return ['${l10n.fuzzyWordHalf} ${hourWord(cell.hour)}'];

  final distance = _distanceToFullHour(cell);
  final String amount;
  if (level == FuzzyTimeLevel.minute) {
    amount = distance.minutes == 1
        ? l10n.fuzzyWordOneMinute
        : '${numberWords(distance.minutes, _english)} ${l10n.fuzzyWordMinutes}';
  } else if (distance.minutes == 15) {
    amount = l10n.fuzzyWordQuarter;
  } else {
    amount = numberWords(distance.minutes, _english);
  }
  final direction = distance.isPast ? l10n.fuzzyWordPast : l10n.fuzzyWordTo;
  // Not used by English: "five to half". 25 and 35 are "twenty-five past/to".
  final rest = '$direction ${hourWord(distance.hour)}';
  return level == FuzzyTimeLevel.minute ? [amount, rest] : ['$amount $rest'];
}
