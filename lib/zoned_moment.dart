import 'package:timezone/timezone.dart' as tz;
import 'models/time_value.dart';
import 'time_utils.dart';

/// A moment as seen in the time zone setting of one value: wall-clock
/// reading, offset, abbreviation and the progress of the local day.
/// Everything that depends on the zone is resolved here, so that formatting
/// only turns finished numbers into text.
class ZonedMoment {
  /// The moment itself.
  final DateTime utc;

  /// The zone whose rules apply; null for UTC. For a value pinned to standard
  /// or summer time it is still the named zone (see [elapsedSeconds]).
  final String? ianaZone;

  /// Wall-clock reading in the zone. Only its fields (year ... second) are
  /// meaningful, not the instant it stands for.
  final DateTime wallClock;

  final Duration offset;

  /// Abbreviation as in the time zone data (e.g. "CEST"), not localized.
  final String abbreviation;

  /// Seconds since the start of the local day, and the real length of that
  /// day: 82,800 or 90,000 on days with a clock change, 86,400 otherwise.
  final int elapsedSeconds;
  final int daySeconds;

  const ZonedMoment._({
    required this.utc,
    required this.ianaZone,
    required this.wallClock,
    required this.offset,
    required this.abbreviation,
    required this.elapsedSeconds,
    required this.daySeconds,
  });

  factory ZonedMoment.of(
      TimeValue timeValue,
      DateTime utc,
      String localIanaZone,
      ) {
    final moment = utc.toUtc();
    switch (timeValue.zone) {
      case ZoneUtc():
        return ZonedMoment._fixedOffset(
          moment,
          ianaZone: null,
          offset: Duration.zero,
          abbreviation: 'UTC',
        );
      case ZoneLocal():
        return ZonedMoment._inZone(
          moment,
          ianaZone: localIanaZone,
          wallClock: moment.toLocal(),
        );
      case ZoneNamed(ianaZone: final zone):
        final mode = timeValue.timezoneClockChangeMode;
        if (mode != TimezoneClockChangeMode.auto) {
          final pinned = TimeUtils.daylightOrStandardOffset(
            zone,
            mode == TimezoneClockChangeMode.forceDst,
          );
          if (pinned != null) {
            return ZonedMoment._fixedOffset(
              moment,
              ianaZone: zone,
              offset: pinned.offset,
              abbreviation: pinned.abbreviation,
            );
          }
        }
        return ZonedMoment._inZone(
          moment,
          ianaZone: zone,
          wallClock: TimeUtils.inZone(moment, zone),
        );
    }
  }

  /// UTC and values pinned to standard or summer time: no clock changes,
  /// every day has 86,400 seconds.
  factory ZonedMoment._fixedOffset(
      DateTime utc, {
        required String? ianaZone,
        required Duration offset,
        required String abbreviation,
      }) {
    final wallClock = utc.add(offset);
    final dayProgress = TimeUtils.dayProgressFixedOffset(wallClock);
    return ZonedMoment._(
      utc: utc,
      ianaZone: ianaZone,
      wallClock: wallClock,
      offset: offset,
      abbreviation: abbreviation,
      elapsedSeconds: dayProgress.elapsedSeconds,
      daySeconds: dayProgress.lengthSeconds,
    );
  }

  /// A real zone with clock changes.
  factory ZonedMoment._inZone(
      DateTime utc, {
        required String ianaZone,
        required DateTime wallClock,
      }) {
    final dayProgress = TimeUtils.dayProgressInZone(utc, ianaZone);
    return ZonedMoment._(
      utc: utc,
      ianaZone: ianaZone,
      wallClock: wallClock,
      offset: wallClock.timeZoneOffset,
      abbreviation: _abbreviationAt(utc, ianaZone, wallClock),
      elapsedSeconds: dayProgress.elapsedSeconds,
      daySeconds: dayProgress.lengthSeconds,
    );
  }

  static String _abbreviationAt(
      DateTime utc,
      String ianaZone,
      DateTime wallClock,
      ) {
    try {
      final location = tz.getLocation(ianaZone);
      return tz.TZDateTime.from(utc, location).timeZone.abbreviation;
    } catch (_) {
      return wallClock.timeZoneName;
    }
  }

  /// Share of the local day that has elapsed, 0 <= x < 1.
  double get dayFraction => elapsedSeconds / daySeconds;

  /// Whole minutes since the start of the local day, plus the remaining seconds.
  ({int minutes, int seconds}) get dayMinute {
    return (
      minutes: elapsedSeconds ~/ 60,
      seconds: elapsedSeconds % 60,
    );
  }

  /// French decimal time: the day has 10 hours of 100 minutes of 100 seconds.
  ({int hours, int minutes, int seconds}) get decimalTime {
    final decimalSeconds = (dayFraction * 100000).round() % 100000;
    return (
      hours: decimalSeconds ~/ 10000,
      minutes: (decimalSeconds % 10000) ~/ 100,
      seconds: decimalSeconds % 100,
    );
  }
}
