import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'config_validation.dart';
import 'prefs_migrations.dart';

/// All preferences as indented JSON, keys sorted (stable output, easy diffs).
Future<String> exportSettingsJson() async {
  final prefs = await SharedPreferences.getInstance();
  final sortedKeys = prefs.getKeys().toList()..sort();
  final map = <String, dynamic>{
    for (final key in sortedKeys) key: prefs.get(key),
  };
  const encoder = JsonEncoder.withIndent('  ');
  return '${encoder.convert(map)}\n';
}

/// Replaces all preferences by those in [json]. Returns the keys whose values
/// cannot be used and are therefore ignored (see [findIgnoredConfigKeys]).
/// Throws a FormatException, before anything changes, if [json] is not a
/// JSON object.
Future<List<String>> importSettingsJson(String json) async {
  final decoded = jsonDecode(json);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('A config file must contain a JSON object');
  }
  final ignoredKeys = findIgnoredConfigKeys(decoded);

  final prefs = await SharedPreferences.getInstance();
  // Snapshot for rollback:
  final backup = <String, dynamic>{
    for (final key in prefs.getKeys()) key: prefs.get(key),
  };

  await prefs.clear();
  try {
    await _writeMapToPrefs(prefs, decoded);
    await runPrefsMigrations();  // handle configs exported before 1.5.0
  } catch (e) {
    await prefs.clear();
    await _writeMapToPrefs(prefs, backup);
    rethrow;
  }
  return ignoredKeys;
}

Future<void> _writeMapToPrefs(
    SharedPreferences prefs, Map<String, dynamic> map) async {
  for (final entry in map.entries) {
    final value = entry.value;
    if (value is bool) {
      await prefs.setBool(entry.key, value);
    } else if (value is int) {
      await prefs.setInt(entry.key, value);
    } else if (value is double) {
      await prefs.setDouble(entry.key, value);
    } else if (value is String) {
      await prefs.setString(entry.key, value);
    } else if (value is List && value.every((item) => item is String)) {
      await prefs.setStringList(entry.key, value.cast<String>());
    }
  }
}
