/// How coarse a fuzzy time is, from coarse to fine.
enum FuzzyTimeLevel {
  dayOrNight,
  partOfDay,
  earlyOrLate,
  quarterHour,
  fiveMinutes,
  minute,
}

const kDefaultFuzzyTimeLevel = FuzzyTimeLevel.fiveMinutes;

/// Level 1: daytime (06:00 to 22:00) or night.
enum DayOrNight { day, night }

/// Parts of the day, coarse division (level 2).
enum CoarseDayPart { night, morning, lateMorning, noon, afternoon, evening }

/// Parts of the day, finest division (level 3). Each belongs to exactly one
/// coarse part ([FuzzyDayPart.coarse]) and one half of the day or night.
enum FuzzyDayPart {
  night(coarse: CoarseDayPart.night),
  deepNight(coarse: CoarseDayPart.night),
  earlyMorning(coarse: CoarseDayPart.morning),
  morning(coarse: CoarseDayPart.morning),
  lateMorning(coarse: CoarseDayPart.lateMorning),
  noon(coarse: CoarseDayPart.noon),
  earlyAfternoon(coarse: CoarseDayPart.afternoon),
  lateAfternoon(coarse: CoarseDayPart.afternoon),
  earlyEvening(coarse: CoarseDayPart.evening),
  evening(coarse: CoarseDayPart.evening);

  const FuzzyDayPart({required this.coarse});

  final CoarseDayPart coarse;
}

DayOrNight dayOrNightOfHour(int hour) =>
    hour >= 6 && hour < 22 ? DayOrNight.day : DayOrNight.night;

/// The part of the day at [hour] (0 ... 23), as used by level 3.
FuzzyDayPart fuzzyDayPartOfHour(int hour) => switch (hour) {
  >= 22 || < 2 => FuzzyDayPart.night,
  >= 2 && < 5 => FuzzyDayPart.deepNight,
  >= 5 && < 7 => FuzzyDayPart.earlyMorning,
  >= 7 && < 9 => FuzzyDayPart.morning,
  >= 9 && < 11 => FuzzyDayPart.lateMorning,
  >= 11 && < 14 => FuzzyDayPart.noon,
  >= 14 && < 16 => FuzzyDayPart.earlyAfternoon,
  >= 16 && < 18 => FuzzyDayPart.lateAfternoon,
  >= 18 && < 20 => FuzzyDayPart.earlyEvening,
  _ => FuzzyDayPart.evening,
};

/// A spoken time on the 12-hour dial: [minute] minutes past [hour] o'clock,
/// [minute] a multiple of the level's step. [hour] is the hour before the
/// time, 1 ... 12 (12:35 is hour 12, minute 35); 12 stands for noon and
/// midnight alike.
typedef ClockCell = ({int hour, int minute});

/// The fuzzy time of a wall-clock reading.
sealed class FuzzyCell {
  const FuzzyCell();
}

class DayOrNightCell extends FuzzyCell {
  final DayOrNight value;
  const DayOrNightCell(this.value);

  @override
  bool operator ==(Object other) =>
      other is DayOrNightCell && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

class DayPartCell extends FuzzyCell {
  final CoarseDayPart value;
  const DayPartCell(this.value);

  @override
  bool operator ==(Object other) =>
      other is DayPartCell && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

class EarlyOrLateCell extends FuzzyCell {
  final FuzzyDayPart value;
  const EarlyOrLateCell(this.value);

  @override
  bool operator ==(Object other) =>
      other is EarlyOrLateCell && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

class ClockTimeCell extends FuzzyCell {
  final ClockCell value;
  const ClockTimeCell(this.value);

  @override
  bool operator ==(Object other) =>
      other is ClockTimeCell && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

/// Step in minutes of the clock levels; null for the day-part levels.
int? fuzzyStepMinutes(FuzzyTimeLevel level) => switch (level) {
  FuzzyTimeLevel.quarterHour => 15,
  FuzzyTimeLevel.fiveMinutes => 5,
  FuzzyTimeLevel.minute => 1,
  _ => null,
};

/// Rounds the wall-clock reading to the cell it falls into. Seconds count:
/// the middle of a cell belongs to the higher one (with five minutes,
/// 12:02:30 up to 12:07:29 is "five past twelve").
FuzzyCell quantizeFuzzyTime(DateTime wallClock, FuzzyTimeLevel level) {
  final step = fuzzyStepMinutes(level);
  if (step == null) {
    return switch (level) {
      FuzzyTimeLevel.dayOrNight => DayOrNightCell(
        dayOrNightOfHour(wallClock.hour),
      ),
      FuzzyTimeLevel.partOfDay => DayPartCell(
        fuzzyDayPartOfHour(wallClock.hour).coarse,
      ),
      _ => EarlyOrLateCell(fuzzyDayPartOfHour(wallClock.hour)),
    };
  }
  final stepSeconds = step * 60;
  final secondsIntoHour = wallClock.minute * 60 + wallClock.second;
  final roundedSteps = (secondsIntoHour + stepSeconds ~/ 2) ~/ stepSeconds;
  final roundedMinutes = roundedSteps * step;
  // Rounding up can reach the full hour: 12:58 is 13:00.
  final hourCarry = roundedMinutes ~/ 60;
  final minute = roundedMinutes % 60;
  final hour24 = (wallClock.hour + hourCarry) % 24;
  return ClockTimeCell((hour: _dialHour(hour24), minute: minute));
}

/// 0 and 12 are both "twelve", 13 is "one", ...
int _dialHour(int hour24) => hour24 % 12 == 0 ? 12 : hour24 % 12;
