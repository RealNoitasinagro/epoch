import 'package:epoch/bundled_licenses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('every bundled license asset is declared and readable', () async {
    for (final license in bundledLicenses) {
      final text = await rootBundle.loadString(license.asset);
      expect(text, isNotEmpty, reason: license.asset);
    }
  });

  test('bundled licenses are registered under their names', () async {
    registerBundledLicenses();
    final entries = await LicenseRegistry.licenses.toList();
    final packageNames = entries.expand((entry) => entry.packages).toSet();
    expect(packageNames, containsAll(bundledLicenses.map((l) => l.name)));
  });
}
