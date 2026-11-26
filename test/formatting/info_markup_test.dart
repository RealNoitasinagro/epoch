import 'package:epoch/formatting/info_markup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseInfoMarkup', () {
    test('plain text is one segment', () {
      expect(parseInfoMarkup('just text'), [
        (text: 'just text', style: InfoStyle.plain),
      ]);
    });

    test('bold, italic and code', () {
      expect(parseInfoMarkup('a **b** c *d* e `f`'), [
        (text: 'a ', style: InfoStyle.plain),
        (text: 'b', style: InfoStyle.bold),
        (text: ' c ', style: InfoStyle.plain),
        (text: 'd', style: InfoStyle.italic),
        (text: ' e ', style: InfoStyle.plain),
        (text: 'f', style: InfoStyle.code),
      ]);
    });

    test('the longer marker wins: ** is bold, not two italics', () {
      expect(parseInfoMarkup('**x**'), [(text: 'x', style: InfoStyle.bold)]);
    });

    test('unclosed or empty markers stay literal', () {
      expect(parseInfoMarkup('2 * 3'), [
        (text: '2 * 3', style: InfoStyle.plain),
      ]);
      expect(parseInfoMarkup('a **** b'), [
        (text: 'a **** b', style: InfoStyle.plain),
      ]);
      expect(parseInfoMarkup('`open'), [
        (text: '`open', style: InfoStyle.plain),
      ]);
    });

    test('code is taken literally', () {
      expect(parseInfoMarkup('`*a*`'), [(text: '*a*', style: InfoStyle.code)]);
    });

    test('text of every language survives a round trip without markup', () {
      const text = 'Rest: von 10ʰ00ᵐ00ˢ bis „0“ – 1,5 °';
      expect(parseInfoMarkup(text).map((s) => s.text).join(), text);
    });
  });

  group('splitParagraphs', () {
    test('splits at empty lines and drops empty paragraphs', () {
      expect(splitParagraphs('a\n\nb\n\n\n\n c '), ['a', 'b', 'c']);
    });
  });
}
