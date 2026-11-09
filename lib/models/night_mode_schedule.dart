/// Time window in which the app uses night mode, whatever theme is chosen.
/// Times are minutes since midnight (wall clock of the device); the window
/// may span midnight (23:00 to 07:00).
class NightModeSchedule {
  final int? startMinute;
  final int? endMinute;

  const NightModeSchedule({this.startMinute, this.endMinute});

  static const none = NightModeSchedule();

  /// Only both times together switch the feature on. Equal times would be
  /// an empty window.
  bool get isActive =>
      startMinute != null && endMinute != null && startMinute != endMinute;

  NightModeSchedule withStart(int minuteOfDay) =>
      NightModeSchedule(startMinute: minuteOfDay, endMinute: endMinute);

  NightModeSchedule withEnd(int minuteOfDay) =>
      NightModeSchedule(startMinute: startMinute, endMinute: minuteOfDay);

  /// Whether [localTime] lies in the window: the start is included, the end
  /// is not.
  bool isNightAt(DateTime localTime) {
    if (!isActive) return false;
    final minuteOfDay = localTime.hour * 60 + localTime.minute;
    final start = startMinute!;
    final end = endMinute!;
    return start < end
        ? minuteOfDay >= start && minuteOfDay < end   // 17:00 -- 23:00
        : minuteOfDay >= start || minuteOfDay < end;  // 23:00 -- 07:00
  }

  /// The next moment after [localTime] at which the window starts or ends;
  /// null without an active window.
  DateTime? nextChangeAfter(DateTime localTime) {
    if (!isActive) return null;
    DateTime? next;
    for (var dayOffset = 0; dayOffset <= 1; dayOffset++) {
      for (final minuteOfDay in [startMinute!, endMinute!]) {
        final candidate = DateTime(localTime.year, localTime.month,
            localTime.day + dayOffset, minuteOfDay ~/ 60, minuteOfDay % 60);
        if (candidate.isAfter(localTime) &&
            (next == null || candidate.isBefore(next))) {
          next = candidate;
        }
      }
    }
    return next;
  }
}

/// Where the time pickers start when a time is not set yet.
const int kDefaultNightModeStartMinute = 23 * 60;
const int kDefaultNightModeEndMinute = 7 * 60;

/// "23:00" or "7:30" to minutes since midnight; null if not a valid time.
int? parseMinuteOfDay(String? text) {
  if (text == null) return null;
  final match =
      RegExp(r'^([01]?\d|2[0-3]):([0-5]\d)$').firstMatch(text.trim());
  if (match == null) return null;
  return int.parse(match.group(1)!) * 60 + int.parse(match.group(2)!);
}

/// Minutes since midnight to "07:30" (always 24-hour, like the dial picker).
String formatMinuteOfDay(int minuteOfDay) =>
    '${(minuteOfDay ~/ 60).toString().padLeft(2, '0')}:'
        '${(minuteOfDay % 60).toString().padLeft(2, '0')}';
