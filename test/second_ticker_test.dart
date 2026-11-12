import 'package:epoch/second_ticker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('waits for the next second boundary, plus a small margin', () {
    for (final (milliseconds, base) in [(250, 750), (0, 1000), (999, 1)]) {
      final delay = SecondTicker.delayUntilNextTick(
          DateTime(2026, 1, 1, 12, 0, 0, milliseconds));
      expect(delay.inMilliseconds, inInclusiveRange(base, base + 50),
          reason: '$milliseconds ms');
    }
  });

  test('microseconds count too', () {
    final delay =
    SecondTicker.delayUntilNextTick(DateTime(2026, 1, 1, 12, 0, 0, 0, 500));
    expect(delay.inMicroseconds, inInclusiveRange(999500, 999500 + 50000));
  });

  testWidgets('ticks while somebody listens, stops after the last listener',
          (tester) async {
        var ticks = 0;
        void onTick() => ticks++;
        SecondTicker.instance.addListener(onTick);
        await tester.pump(const Duration(seconds: 3));
        expect(ticks, greaterThanOrEqualTo(1));

        SecondTicker.instance.removeListener(onTick);
        final ticksAtStop = ticks;
        await tester.pump(const Duration(seconds: 3));
        expect(ticks, ticksAtStop);
      });
}
