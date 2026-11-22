import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

main() {
  test('lib reads preferences only through the tolerant helpers', () {
    final offenders = [
      for (final file in Directory('lib').listSync(recursive: true))
        if (file is File &&
            file.path.endsWith('.dart') &&
            !file.path.endsWith('tolerant_prefs.dart') &&
            RegExp(
              r'\.get(Bool|Int|Double|String|StringList)\(',
            ).hasMatch(file.readAsStringSync()))
          file.path,
    ];
    expect(offenders, isEmpty);
  });
}
