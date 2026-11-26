/// Spoken forms of the numbers 0 ... 59 for the fuzzy time. Plain Dart:
/// rules for German, a short table for English.
String numberWords(int number, String locale) {
  if (number < 0 || number > 59) {
    throw RangeError.range(number, 0, 59, 'number');
  }
  return locale.startsWith('de')
      ? _germanNumberWords(number)
      : _englishNumberWords(number);
}

const _germanUnits = [
  'null',
  'ein',
  'zwei',
  'drei',
  'vier',
  'fünf',
  'sechs',
  'sieben',
  'acht',
  'neun',
  'zehn',
  'elf',
  'zwölf',
  'dreizehn',
  'vierzehn',
  'fünfzehn',
  'sechzehn',
  'siebzehn',
  'achtzehn',
  'neunzehn',
];
const _germanTens = ['', '', 'zwanzig', 'dreißig', 'vierzig', 'fünfzig'];

String _germanNumberWords(int number) {
  if (number < 20) {
    return number == 1 ? 'eins' : _germanUnits[number];
  }
  final tens = _germanTens[number ~/ 10];
  final units = number % 10;
  return units == 0 ? tens : '${_germanUnits[units]}und$tens';
}

const _englishUnits = [
  'zero',
  'one',
  'two',
  'three',
  'four',
  'five',
  'six',
  'seven',
  'eight',
  'nine',
  'ten',
  'eleven',
  'twelve',
  'thirteen',
  'fourteen',
  'fifteen',
  'sixteen',
  'seventeen',
  'eighteen',
  'nineteen',
];
const _englishTens = ['', '', 'twenty', 'thirty', 'forty', 'fifty'];

String _englishNumberWords(int number) {
  if (number < 20) return _englishUnits[number];
  final tens = _englishTens[number ~/ 10];
  final units = number % 10;
  return units == 0 ? tens : '$tens-${_englishUnits[units]}';
}
