import 'package:epoch/effective_clock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DateTime fakeSystemTime;

  setUp(() {
    fakeSystemTime = DateTime.utc(2026, 10, 23, 12).toLocal();
    EffectiveClock.systemNow = () => fakeSystemTime;
    EffectiveClock.reset();
  });

  tearDown(() {
    EffectiveClock.systemNow = DateTime.now;
    EffectiveClock.reset();
  });

  test('without shift it equals the system time', () {
    expect(EffectiveClock.now(), equals(fakeSystemTime));
    expect(EffectiveClock.isShifted, isFalse);
  });

  test('running shift keeps ticking from the target', () {
    final target = DateTime.utc(2030, 1, 1).toLocal();
    EffectiveClock.shiftTo(target);
    expect(EffectiveClock.now(), equals(target));
    fakeSystemTime = fakeSystemTime.add(const Duration(seconds: 5));
    expect(EffectiveClock.now(), equals(target.add(const Duration(seconds: 5))));
    expect(EffectiveClock.isShifted, isTrue);
    expect(EffectiveClock.isFrozen, isFalse);
  });

  test('frozen shift does not advance', () {
    final target = DateTime.utc(1999, 12, 31, 23, 59).toLocal();
    EffectiveClock.shiftTo(target, frozen: true);
    fakeSystemTime = fakeSystemTime.add(const Duration(hours: 1));
    expect(EffectiveClock.now(), equals(target));
    expect(EffectiveClock.isFrozen, isTrue);
  });

  test('deviation is positive for the future, negative for the past', () {
    EffectiveClock.shiftTo(fakeSystemTime.add(const Duration(days: 1)));
    expect(EffectiveClock.deviationFromSystem, const Duration(days: 1));
    EffectiveClock.shiftTo(fakeSystemTime.subtract(const Duration(days: 1)));
    expect(EffectiveClock.deviationFromSystem, const Duration(days: -1));
  });

  test('reset returns to the system time', () {
    EffectiveClock.shiftTo(DateTime.utc(2000).toLocal(), frozen: true);
    EffectiveClock.reset();
    expect(EffectiveClock.now(), equals(fakeSystemTime));
    expect(EffectiveClock.isShifted, isFalse);
  });

  test('shifting to the current time is no shift (sub-second noise ignored)', () {
    fakeSystemTime = fakeSystemTime.add(const Duration(milliseconds: 700));
    EffectiveClock.shiftTo(EffectiveClock.now());
    expect(EffectiveClock.isShifted, isFalse);
  });

  test('change notifier fires on shift and reset', () {
    final before = EffectiveClock.changeNotifier.value;
    EffectiveClock.shiftTo(DateTime.utc(2000).toLocal());
    EffectiveClock.reset();
    expect(EffectiveClock.changeNotifier.value, before + 2);
  });
}
