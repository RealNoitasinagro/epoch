/// Date and time patterns such as "YYYY-MM-DD" or "HH:mm:ss": substituting
/// tokens, and checking patterns a user types in.

/// Longest result of each date token (for the length check): the longest
/// month (September) and weekday (Donnerstag), abbreviations with a period.
const Map<String, String> datePatternWorstCase = {
  'YYYY': '2026',
  'YY': '26',
  'MMMM': 'September',
  'MMM': 'Sep',
  'MM': '12',
  'M': '12',
  'EEEE': 'Donnerstag',
  'EEE': 'Do.',
  'DD': '28',
  'D': '28',
};

const Map<String, String> timePatternWorstCase = {
  'HH': '23',
  'H': '23',
  'mm': '59',
  'ss': '59',
};

/// Longest result the user may configure, separators included. This keeps out
/// nonsense; it does not guarantee that a value fits into one line of a tile.
const int maxDatePatternRenderedLength = 30;
const int maxTimePatternRenderedLength = 16;

/// Replaces the tokens of [pattern] by their values, longest token first;
/// everything else is copied as a literal.
String applyPatternTokens(String pattern, Map<String, String> tokens) {
  final sortedTokens = tokens.keys.toList()
    ..sort((a, b) => b.length.compareTo(a.length));

  final buffer = StringBuffer();
  var index = 0;
  while (index < pattern.length) {
    final token = sortedTokens
        .where((candidate) => pattern.startsWith(candidate, index))
        .firstOrNull;
    if (token == null) {
      buffer.write(pattern[index]);
      index++;
    } else {
      buffer.write(tokens[token]);
      index += token.length;
    }
  }
  return buffer.toString();
}

/// Why a pattern is rejected.
sealed class PatternIssue {
  const PatternIssue();
}

class PatternMissingToken extends PatternIssue {
  const PatternMissingToken();
}

class PatternUnknownTokens extends PatternIssue {
  final List<String> tokens;
  const PatternUnknownTokens(this.tokens);
}

class PatternMissingHour extends PatternIssue {
  const PatternMissingHour();
}

class PatternMissingMinutes extends PatternIssue {
  const PatternMissingMinutes();
}

class PatternTooLong extends PatternIssue {
  final int maxLength;
  const PatternTooLong(this.maxLength);
}

/// Null: the date pattern is fine.
PatternIssue? validateDatePattern(String pattern) {
  final unknownTokens = _unknownTokens(pattern, datePatternWorstCase.keys);
  if (unknownTokens != null) return unknownTokens;
  if (!datePatternWorstCase.keys.any(pattern.contains)) {
    return const PatternMissingToken();
  }
  return _lengthIssue(
      pattern, datePatternWorstCase, maxDatePatternRenderedLength);
}

/// Null: the time pattern is fine. It needs the hour and the minutes.
PatternIssue? validateTimePattern(String pattern) {
  final unknownTokens = _unknownTokens(pattern, timePatternWorstCase.keys);
  if (unknownTokens != null) return unknownTokens;
  if (!pattern.contains('H')) return const PatternMissingHour();
  if (!pattern.contains('mm')) return const PatternMissingMinutes();
  return _lengthIssue(
      pattern, timePatternWorstCase, maxTimePatternRenderedLength);
}

/// Uppercase letters left over once all tokens are removed. (Lowercase
/// letters are harmless literals, uppercase ones are probably typos.)
PatternIssue? _unknownTokens(String pattern, Iterable<String> validTokens) {
  final longestFirst = validTokens.toList()
    ..sort((a, b) => b.length.compareTo(a.length));
  var remaining = pattern;
  for (final token in longestFirst) {
    remaining = remaining.replaceAll(token, '');
  }
  final unknown = RegExp(r'[A-Z]+')
      .allMatches(remaining)
      .map((match) => match.group(0)!)
      .toSet()
      .toList();
  return unknown.isEmpty ? null : PatternUnknownTokens(unknown);
}

PatternIssue? _lengthIssue(
    String pattern, Map<String, String> worstCase, int maxLength) {
  return applyPatternTokens(pattern, worstCase).length > maxLength
      ? PatternTooLong(maxLength)
      : null;
}
