import 'package:epoch/app/app_themes.dart';
import 'package:epoch/app/layout_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the night theme dims what is disabled in red, not in grey', () {
    expect(buildNightTheme().disabledColor, kColorNightRedDim);
  });
}
