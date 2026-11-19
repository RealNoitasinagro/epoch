const _diacriticsFoldMap = {
  'á':'a','à':'a','â':'a','ã':'a','ä':'a','å':'a',
  'ç':'c',
  'é':'e','è':'e','ê':'e','ë':'e',
  'í':'i','ì':'i','î':'i','ï':'i',
  'ñ':'n',
  'ó':'o','ò':'o','ô':'o','õ':'o','ö':'o',
  'ú':'u','ù':'u','û':'u','ü':'u',
  'ý':'y','ÿ':'y',
  'ß':'ss',
};

String _foldDiacritics(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    final ch = String.fromCharCode(rune);
    buffer.write(_diacriticsFoldMap[ch] ?? ch);
  }
  return buffer.toString();
}

String _stripCombiningMarks(String input) =>
    input.replaceAll(RegExp(r'\p{Mn}', unicode: true), '');

String _stripApostrophes(String input) => input.replaceAll(
    RegExp("['\u2018\u2019\u201B\u02B9\u02BC\u02BB\u02BD\u0060\u00B4]"), '');

String _foldSaintAbbreviation(String input) => input
    .replaceAll(RegExp(r'\bsankt\b', caseSensitive: false), 'st')
    .replaceAll(RegExp(r'\bsaint\b', caseSensitive: false), 'st')
    .replaceAll(RegExp(r'\bst\.', caseSensitive: false), 'st');

String _foldHyphens(String input) =>
    input.replaceAll('-', ' ');

String _foldUnderscores(String input) => input.replaceAll('_', ' ');

String _foldPunctuation(String input) =>
    input.replaceAll(RegExp(r'[,.]'), '');

String normalize(String s) {
  var result = s.toLowerCase();
  result = result.replaceAll(' & ', ' and ');
  result = _foldDiacritics(result);
  result = _stripCombiningMarks(result);
  result = _stripApostrophes(result);
  result = _foldSaintAbbreviation(result);
  result = _foldHyphens(result);
  result = _foldUnderscores(result);
  result = _foldPunctuation(result);
  result = result.replaceAll(' the ', ' ');
  result = result.replaceAll(RegExp(r'\bislands\b'), 'island');
  return result;
}

String stripParenthetical(String s) =>
    s.replaceAll(RegExp(r'\s*\(.*?\)'), '').trim();

/// Time-zone-name-specific spelling variants (not general text
/// normalization) -- lets alias/metazone data store ONE canonical form
/// per concept instead of every colloquial suffix variant by hand.
Iterable<String> expandTimeZoneNameVariants(String term) {
  final lower = term.toLowerCase();
  final variants = <String>{term};
  // German
  if (lower.endsWith('normalzeit')) {
    final stem = term.substring(0, term.length - 'normalzeit'.length);
    variants.add('${stem}Normal-Zeit');
    variants.add('${stem}Standardzeit');
    variants.add('${stem}Standard-Zeit');
    variants.add('${stem}Winterzeit');   // not always correct, but not harmful
    variants.add('${stem}Winter-Zeit');  // not always correct, but not harmful
  }
  else if (lower.endsWith('sommerzeit')) {
    final stem = term.substring(0, term.length - 'sommerzeit'.length);
    variants.add('${stem}Sommer-Zeit');
  }
  // English
  else if (lower.endsWith('daylight time')) {
    final stem = term.substring(0, term.length - 'daylight time'.length);
    variants.add('${stem}Daylight Saving Time');
    variants.add('${stem}Daylight Savings Time');
    variants.add('${stem}Summer Time');
  }
  else if (lower.endsWith('summer time')) {
    final stem = term.substring(0, term.length - 'summer time'.length);
    variants.add('${stem}Daylight Time');
    variants.add('${stem}Daylight Saving Time');
    variants.add('${stem}Daylight Savings Time');
  }
  else if (lower.endsWith('time') && !lower.endsWith('standard time')) {
    final stem = term.substring(0, term.length - 'time'.length);
    variants.add('${stem}Standard Time');
  }

  if (lower.startsWith('eastern ')) {
    variants.add('East ${term.substring('Eastern '.length)}');
  } else if (lower.startsWith('east ')) {
    variants.add('Eastern ${term.substring('East '.length)}');
  }
  if (lower.startsWith('western ')) {
    variants.add('West ${term.substring('Western '.length)}');
  } else if (lower.startsWith('west ')) {
    variants.add('Western ${term.substring('West '.length)}');
  }

  return variants;
}
