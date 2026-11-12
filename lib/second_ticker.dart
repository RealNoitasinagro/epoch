import 'dart:async';
import 'package:flutter/foundation.dart';
import 'effective_clock.dart';

/// One tick per second, at the second boundary of the system clock, shared by
/// all screens that show the time: they change together with the clock on the
/// wall and never out of step with each other. Runs only while somebody listens.
///
/// A time shift moves the clock by whole seconds (see [EffectiveClock]), so the
/// boundaries of the system clock are the boundaries of the shifted clock too.
class SecondTicker extends ChangeNotifier {
  SecondTicker._();

  static final SecondTicker instance = SecondTicker._();

  /// A timer never fires early, but the system clock may be adjusted by a few
  /// milliseconds; without the margin a tick could still read the old second.
  static const _margin = Duration(milliseconds: 15);

  Timer? _timer;

  /// Time from [systemTime] to the next tick: the next second boundary, plus
  /// the margin.
  @visibleForTesting
  static Duration delayUntilNextTick(DateTime systemTime) {
    final microsecondsIntoSecond =
        systemTime.millisecond * 1000 + systemTime.microsecond;
    return Duration(
        microseconds: Duration.microsecondsPerSecond - microsecondsIntoSecond
    ) + _margin;
  }

  /// Every tick sets the next timer from the clock again: a late tick (device
  /// asleep, busy) or a slowly drifting timer corrects itself.
  Timer _scheduleNextTick() =>
      Timer(delayUntilNextTick(EffectiveClock.systemTime()), _tick);

  void _tick() {
    _timer = _scheduleNextTick();  // before notifying: listeners may remove themselves
    notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _timer ??= _scheduleNextTick();
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      _timer?.cancel();
      _timer = null;
    }
  }
}
