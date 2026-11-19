import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Licenses of data and fonts bundled with the app, as shown on the app's
/// license page (next to the automatically collected package licenses).
const bundledLicenses = <({String name, String asset})>[
  (
    name: 'Unicode CLDR (country, city and time zone names)',
    asset: 'assets/licenses/unicode_cldr.txt',
  ),
  (
    name: 'JetBrains Mono font',
    asset: 'assets/licenses/jetbrains_mono.txt',
  ),
];

void registerBundledLicenses() {
  LicenseRegistry.addLicense(() async* {
    for (final license in bundledLicenses) {
      yield LicenseEntryWithLineBreaks(
          [license.name], await rootBundle.loadString(license.asset));
    }
  });
}
