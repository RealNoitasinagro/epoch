import '../time/fuzzy_time.dart';

/// For time zones with daylight saving time: automatic clock changes, or one
/// pinned value.
enum TimezoneClockChangeMode { auto, forceDst, forceStandard }

/// For [ValueOptions.copyWith]: tells "set to null" (the default applies)
/// from "leave as it is".
class NewValue<T> {
  final T? value;
  const NewValue(this.value);
}

/// What the user can set for a single value, apart from its type and zone.
/// Null means "the global setting applies" (not for the label and the mode).
class ValueOptions {
  static final _dstSuffix = RegExp(r'\|dst:([^|]*)$');
  static final _fuzzySuffix = RegExp(r'\|fz:([A-Za-z]*)$');

  final String? customLabel;
  final TimezoneClockChangeMode timezoneClockChangeMode;

  /// Whether seconds or decimals are shown, see [ValueTypeProps.optionalPart].
  final bool? showOptionalPart;

  /// Whether the details line (time zone, week and day of the year, degrees)
  /// is shown, see [ValueTypeProps.hasDetailsLine].
  final bool? showDetails;

  /// Whether what is left of the day is shown instead of what has elapsed,
  /// see [ValueTypeProps.supportsRemaining].
  final bool remaining;

  /// Null: the default level ([kDefaultFuzzyTimeLevel]). Never holds the
  /// default itself, so that "not set" and "explicitly the default" are one
  /// and the same value (see [identitySuffix]).
  final FuzzyTimeLevel? fuzzyLevel;

  const ValueOptions({
    this.customLabel,
    this.timezoneClockChangeMode = TimezoneClockChangeMode.auto,
    this.showOptionalPart,
    this.showDetails,
    this.remaining = false,
    this.fuzzyLevel,
  });

  static const none = ValueOptions();

  ValueOptions copyWith({
    NewValue<String>? customLabel,
    TimezoneClockChangeMode? timezoneClockChangeMode,
    NewValue<bool>? showOptionalPart,
    NewValue<bool>? showDetails,
    bool? remaining,
    NewValue<FuzzyTimeLevel?>? fuzzyLevel,
  }) => ValueOptions(
    customLabel: customLabel != null ? customLabel.value : this.customLabel,
    timezoneClockChangeMode:
        timezoneClockChangeMode ?? this.timezoneClockChangeMode,
    showOptionalPart: showOptionalPart != null
        ? showOptionalPart.value
        : this.showOptionalPart,
    showDetails: showDetails != null ? showDetails.value : this.showDetails,
    remaining: remaining ?? this.remaining,
    fuzzyLevel: fuzzyLevel == null
        ? this.fuzzyLevel
        : _unlessDefault(fuzzyLevel.value),
  );

  /// What makes values of the same type and zone different values, so that
  /// they can be on the same tab (Berlin automatic and Berlin standard time).
  /// Appended to the key of a value.
  String get identitySuffix {
    final modeSuffix = switch (timezoneClockChangeMode) {
      TimezoneClockChangeMode.auto => '',
      TimezoneClockChangeMode.forceDst => '/dst',
      TimezoneClockChangeMode.forceStandard => '/std',
    };
    final levelSuffix = fuzzyLevel == null ? '' : '/fz:${fuzzyLevel!.name}';
    return '$modeSuffix${remaining ? '/rem' : ''}$levelSuffix';
  }

  FuzzyTimeLevel get effectiveFuzzyLevel =>
      fuzzyLevel ?? kDefaultFuzzyTimeLevel;

  static String _withoutSuffix(String text, String suffix) =>
      text.substring(0, text.length - suffix.length);

  static FuzzyTimeLevel? _unlessDefault(FuzzyTimeLevel? level) =>
      level == kDefaultFuzzyTimeLevel ? null : level;

  /// [baseKey] ("valueType/zone") with the options behind it: label, clock
  /// change mode, flags. Everything that is not set is left out.
  String appendTo(String baseKey) => [
    baseKey,
    if (customLabel != null) '|$customLabel',
    if (timezoneClockChangeMode != TimezoneClockChangeMode.auto)
      '|dst:${timezoneClockChangeMode.name}',
    if (showOptionalPart != null) showOptionalPart! ? '|sec' : '|nosec',
    if (showDetails != null) showDetails! ? '|det' : '|nodet',
    if (remaining) '|rem',
    if (fuzzyLevel != null) '|fz:${fuzzyLevel!.name}',
  ].join();

  /// Splits [text] into "valueType/zone" and the options behind it. The
  /// suffixes are taken off the end, in any order, as long as one is there;
  /// what is left behind the first "|" is the label. The label may contain
  /// "|", but cannot end in one of the suffixes.
  static ({String keyPart, ValueOptions options}) splitPrefsString(
    String text,
  ) {
    var rest = text;
    var mode = TimezoneClockChangeMode.auto;
    bool? showOptionalPart;
    bool? showDetails;
    bool remaining = false;
    FuzzyTimeLevel? fuzzyLevel;

    while (true) {
      final dstMatch = _dstSuffix.firstMatch(rest);
      if (rest.endsWith('|nosec')) {
        showOptionalPart = false;
        rest = _withoutSuffix(rest, '|nosec');
      } else if (rest.endsWith('|sec')) {
        showOptionalPart = true;
        rest = _withoutSuffix(rest, '|sec');
      } else if (rest.endsWith('|nodet')) {
        showDetails = false;
        rest = _withoutSuffix(rest, '|nodet');
      } else if (rest.endsWith('|det')) {
        showDetails = true;
        rest = _withoutSuffix(rest, '|det');
      } else if (dstMatch != null) {
        // An unknown mode name counts as automatic.
        mode =
            TimezoneClockChangeMode.values
                .where((candidate) => candidate.name == dstMatch.group(1))
                .firstOrNull ??
            TimezoneClockChangeMode.auto;
        rest = rest.substring(0, dstMatch.start);
      } else if (rest.endsWith('|rem')) {
        remaining = true;
        rest = _withoutSuffix(rest, '|rem');
      } else if (_fuzzySuffix.firstMatch(rest) case final match?) {
        fuzzyLevel = FuzzyTimeLevel.values
            .where((level) => level.name == match.group(1))
            .firstOrNull;
        rest = rest.substring(0, match.start);
      } else {
        break;
      }
    }

    final pipeIndex = rest.indexOf('|');
    final keyPart = pipeIndex >= 0 ? rest.substring(0, pipeIndex) : rest;
    final label = pipeIndex >= 0 ? rest.substring(pipeIndex + 1) : null;
    return (
      keyPart: keyPart,
      options: ValueOptions(
        customLabel: (label == null || label.isEmpty) ? null : label,
        timezoneClockChangeMode: mode,
        showOptionalPart: showOptionalPart,
        showDetails: showDetails,
        remaining: remaining,
        fuzzyLevel: _unlessDefault(fuzzyLevel),
      ),
    );
  }
}
