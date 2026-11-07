import 'dart:math' as math;
import 'package:epoch/widgets/clocks/analog_clock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const quarterTurn = math.pi / 2;

  group('hand angles', () {
    test('hour hand: 15:00 is a quarter turn on 12h, 22.5° less on 24h', () {
      final threePm = DateTime(2026, 1, 1, 15);
      expect(analogHourHandAngle(threePm, AnalogClockScale.twelveHour),
          closeTo(quarterTurn, 1e-9));
      expect(analogHourHandAngle(DateTime(2026, 1, 1, 6), AnalogClockScale.twentyFourHour),
          closeTo(quarterTurn, 1e-9));
      expect(analogHourHandAngle(threePm, AnalogClockScale.twentyFourHour),
          closeTo(15 / 24 * 2 * math.pi, 1e-9));
    });

    test('hour hand moves continuously with minutes', () {
      final halfPastTwelve = DateTime(2026, 1, 1, 0, 30);
      expect(analogHourHandAngle(halfPastTwelve, AnalogClockScale.twelveHour),
          closeTo(math.pi / 12, 1e-9));
    });

    test('minute hand is continuous, second hand ticks', () {
      final moment = DateTime(2026, 1, 1, 10, 15, 30);
      expect(analogMinuteHandAngle(moment),
          closeTo((15.5 / 60) * 2 * math.pi, 1e-9));
      expect(analogSecondHandAngle(moment), closeTo(math.pi, 1e-9));
    });
  });

  test('"+12" only on the 12-hour dial, from noon on', () {
    expect(analogClockShowsPlusTwelve(11, AnalogClockScale.twelveHour), isFalse);
    expect(analogClockShowsPlusTwelve(12, AnalogClockScale.twelveHour), isTrue);
    expect(analogClockShowsPlusTwelve(23, AnalogClockScale.twelveHour), isTrue);
    expect(analogClockShowsPlusTwelve(15, AnalogClockScale.twentyFourHour), isFalse);
  });
}
