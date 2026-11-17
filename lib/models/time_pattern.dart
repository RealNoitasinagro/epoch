/// Helpers for time patterns such as "HH:mm:ss" (tokens H, HH, mm, ss).

bool timePatternHasSeconds(String pattern) => pattern.contains('ss');

/// The pattern without its seconds and the separator before them,
/// e.g. "HH:mm:ss" -> "HH:mm". Patterns where the seconds do not follow
/// the minutes are returned unchanged.
String timePatternWithoutSeconds(String pattern) {
  final secondsIndex = pattern.indexOf('ss');
  if (secondsIndex < 0) return pattern;
  final minutesIndex = pattern.lastIndexOf('mm', secondsIndex);
  if (minutesIndex < 0) return pattern;
  final endOfMinutes = minutesIndex + 'mm'.length;
  return pattern.substring(0, endOfMinutes) +
      pattern.substring(secondsIndex + 'ss'.length);
}

/// The pattern with seconds: unchanged if it has them, otherwise "ss" is
/// added after the minutes, with the separator used between hours and
/// minutes: "HH:mm" -> "HH:mm:ss", "H.mm" -> "H.mm.ss", "HHmm" -> "HHmmss".
String timePatternWithSeconds(String pattern) {
  if (timePatternHasSeconds(pattern)) return pattern;
  final minutesIndex = pattern.indexOf('mm');
  if (minutesIndex < 0) return pattern;
  final separator = _separatorBeforeMinutes(pattern, minutesIndex);
  final endOfMinutes = minutesIndex + 'mm'.length;
  return '${pattern.substring(0, endOfMinutes)}$separator'
      'ss${pattern.substring(endOfMinutes)}';
}

/// The separator between hours and minutes if it is short and free of
/// letters and digits (":", ".", " ", or nothing); otherwise ":".
String _separatorBeforeMinutes(String pattern, int minutesIndex) {
  final hourIndex = pattern.indexOf('H');
  if (hourIndex < 0 || hourIndex > minutesIndex) return ':';
  var endOfHours = hourIndex;
  while (endOfHours < minutesIndex && pattern[endOfHours] == 'H') {
    endOfHours++;
  }
  final separator = pattern.substring(endOfHours, minutesIndex);
  return RegExp(r'^[^A-Za-z0-9]{0,2}$').hasMatch(separator) ? separator : ':';
}
