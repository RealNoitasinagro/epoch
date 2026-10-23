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
  static bool get isShifted =>
      _frozenMoment != null || _offsetFromSystem != Duration.zero;

  static bool get isFrozen => _frozenMoment != null;

  /// Displayed time minus system time (positive = future).
  static Duration get deviationFromSystem => now().difference(systemNow());

  /// Makes [target] the displayed moment. Frozen: stays there; otherwise it
  /// keeps running from there at normal speed.
  static void shiftTo(DateTime target, {bool frozen = false}) {
    final targetLocal = target.toLocal();
    _offsetFromSystem = targetLocal.difference(systemNow());
    _frozenMoment = frozen ? targetLocal : null;
  }

  /// Back to the system time.
  static void reset() {
    _offsetFromSystem = Duration.zero;
    _frozenMoment = null;
  }
}
