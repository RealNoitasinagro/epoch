import 'models/time_value.dart';
import 'time_utils.dart';

/// Wall-clock reading of the instant [utc] in [zone], as a UTC-kind DateTime
/// whose fields (year ... second) are exactly that reading.
DateTime wallClockOf(DateTime utc, ZoneSpec zone) {
  final DateTime reading = switch (zone) {
    ZoneUtc() => utc.toUtc(),
    ZoneLocal() => utc.toLocal(),
    ZoneNamed(ianaZone: final ianaZone) => TimeUtils.inZone(utc.toUtc(), ianaZone),
  };
  return DateTime.utc(
      reading.year, reading.month, reading.day,
      reading.hour, reading.minute, reading.second
  );
}

/// The instant at which [wallClock] (only its fields count) is read in
/// [zone]. A reading that a clock change skips continues after the change
/// (02:30 becomes 03:30); a reading that occurs twice means its first occurrence.
DateTime instantOfWallClock(DateTime wallClock, ZoneSpec zone) {
  final reading = DateTime.utc(wallClock.year, wallClock.month, wallClock.day,
      wallClock.hour, wallClock.minute, wallClock.second);
  switch (zone) {
    case ZoneUtc():
      return reading;
    case ZoneLocal():
      return DateTime(
          reading.year, reading.month, reading.day,
          reading.hour, reading.minute, reading.second
      ).toUtc();
    case ZoneNamed(ianaZone: final ianaZone):
      return _instantInNamedZone(reading, ianaZone);
  }
}

/// UTC offset of [zone] at the instant [utc].
Duration offsetInZone(DateTime utc, ZoneSpec zone) => switch (zone) {
  ZoneUtc() => Duration.zero,
  ZoneLocal() => utc.toLocal().timeZoneOffset,
  ZoneNamed(ianaZone: final ianaZone) =>
  TimeUtils.inZone(utc.toUtc(), ianaZone).timeZoneOffset,
};

DateTime _instantInNamedZone(DateTime reading, String ianaZone) {
  const margin = Duration(days: 1);
  // The offsets before and after a clock change near the reading (the same
  // one twice if there is none):
  final offsetBefore =
      TimeUtils.inZone(reading.subtract(margin), ianaZone).timeZoneOffset;
  final offsetAfter =
      TimeUtils.inZone(reading.add(margin), ianaZone).timeZoneOffset;

  final possibleInstants = <DateTime>[
    for (final offset in {offsetBefore, offsetAfter})
      if (TimeUtils.inZone(reading.subtract(offset), ianaZone).timeZoneOffset ==
          offset)
        reading.subtract(offset),
  ]..sort();

  // None: the reading is skipped, the old offset lands after the change.
  return possibleInstants.isEmpty
      ? reading.subtract(offsetBefore)
      : possibleInstants.first;
}
