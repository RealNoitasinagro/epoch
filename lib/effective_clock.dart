import 'package:flutter/foundation.dart';

/// Single source of "now" for everything the user sees (tabs, Focus screen,
/// DST notices, ...). Without a time shift it equals the system time.
///
/// Intentionally NOT used for technical timestamps (backup file names,
/// generated IDs, caches keyed by the real day) – those keep DateTime.now().
class EffectiveClock {
  EffectiveClock._();

  /// Source of the real system time; replaceable in tests.
  @visibleForTesting
  static DateTime Function() systemNow = DateTime.now;

  /// Supported range: the Unix epoch up to the end of 32-bit Unix time,
  /// which is also where the IANA data in the timezone package ends.
  static final DateTime earliestMoment = DateTime.utc(1970);
  static final DateTime latestMoment = DateTime.utc(2038, 1, 19, 3, 14, 7);

  /// Incremented whenever the shift changes, so screens can refresh at once.
  static final ValueNotifier<int> changeNotifier = ValueNotifier(0);

  static Duration _offsetFromSystem = Duration.zero;
  static DateTime? _frozenMoment;

  /// The moment to display. Always a local-kind DateTime, like DateTime.now().
  static DateTime now() {
    final frozen = _frozenMoment;
    if (frozen != null) return frozen;
    final system = systemNow();
    return _offsetFromSystem == Duration.zero
        ? system
        : system.add(_offsetFromSystem);
  }

  /// True if the displayed time deviates from the system time.
  static bool get isShifted => isFrozen || _offsetFromSystem != Duration.zero;

  static bool get isFrozen => _frozenMoment != null;

  /// Displayed time minus system time (positive = future).
  static Duration get deviationFromSystem => now().difference(systemNow());

  static bool isSupported(DateTime moment) {
    final utc = moment.toUtc();
    return !utc.isBefore(earliestMoment) && !utc.isAfter(latestMoment);
  }

  /// Makes [target] the displayed moment. Frozen: stays there; otherwise it
  /// keeps running from there at normal speed.
  /// The offset is a whole number of seconds (sub-second parts are dropped on
  /// both sides), so "shifting" to the current time is no shift at all.
  static void shiftTo(DateTime target, {bool frozen = false}) {
    final targetWholeSecond = _truncateToSeconds(target.toLocal());
    _offsetFromSystem =
        targetWholeSecond.difference(_truncateToSeconds(systemNow()));
    _frozenMoment = frozen ? targetWholeSecond : null;
    changeNotifier.value++;
  }

  /// Back to the system time.
  static void reset() {
    _offsetFromSystem = Duration.zero;
    _frozenMoment = null;
    changeNotifier.value++;
  }

  static DateTime _truncateToSeconds(DateTime moment) => moment.subtract(
      Duration(milliseconds: moment.millisecond, microseconds: moment.microsecond));
}
