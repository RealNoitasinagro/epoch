import 'package:epoch/models/tab_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TabSection with builtinKey', () {
    test('serializes builtin sections with the @-marker, not the label', () {
      const s = TabSection(id: 'x', label: 'ignored', builtinKey: BuiltinSectionKey.gps);
      expect(s.toPrefsString(), equals('section:x:@gps'));
    });

    test('roundtrip preserves builtinKey', () {
      const s = TabSection(id: 'x', label: '', builtinKey: BuiltinSectionKey.julian);
      final s2 = TabSection.fromPrefsString(s.toPrefsString());
      expect(s2?.builtinKey, equals(BuiltinSectionKey.julian));
    });

    test('unknown @-key degrades to a literal label instead of being dropped', () {
      final s = TabSection.fromPrefsString('section:x:@notARealKey');
      expect(s, isNotNull);
      expect(s!.builtinKey, isNull);
      expect(s.label, equals('@notARealKey'));
    });

    test('legacy user section starting with @ (pre-1.5.0 export) still loads', () {
      // Simulates an old export where '@' had no special meaning yet.
      final s = TabSection.fromPrefsString('section:x:@home');
      expect(s, isNotNull);
      expect(s!.builtinKey, isNull);
      expect(s.label, equals('@home'));
    });

    test('withLabel detaches from builtinKey', () {
      const s = TabSection(id: 'x', label: '', builtinKey: BuiltinSectionKey.unix);
      final renamed = s.withLabel('My Custom Header');
      expect(renamed.builtinKey, isNull);
      expect(renamed.label, equals('My Custom Header'));
    });

    test('legacy two-field format (no builtinKey) still parses', () {
      final s = TabSection.fromPrefsString('section:id123:Some Label');
      expect(s?.label, equals('Some Label'));
      expect(s?.builtinKey, isNull);
    });
  });
}
