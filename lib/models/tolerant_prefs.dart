import 'package:shared_preferences/shared_preferences.dart';

/// Typed reads that never throw: a value of the wrong type (a hand-edited or
/// imported config) counts as missing, so the default applies. The typed
/// getters of SharedPreferences throw a TypeError instead, which in an
/// asynchronous screen start means a blank screen.
extension TolerantPrefs on SharedPreferences {
  bool? tolerantBool(String key) {
    final value = get(key);
    return value is bool ? value : null;
  }

  int? tolerantInt(String key) {
    final value = get(key);
    return value is int ? value : null;
  }

  /// Accepts integers too: JSON does not tell 1 from 1.0.
  double? tolerantDouble(String key) {
    final value = get(key);
    return value is num ? value.toDouble() : null;
  }

  String? tolerantString(String key) {
    final value = get(key);
    return value is String ? value : null;
  }

  List<String>? tolerantStringList(String key) {
    final value = get(key);
    if (value is! List || !value.every((entry) => entry is String)) return null;
    return value.cast<String>().toList();
  }
}
