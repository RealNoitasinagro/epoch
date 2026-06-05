import 'package:shared_preferences/shared_preferences.dart';
import 'time_value.dart';

const _kCustomTabsKey = 'custom_tabs';
const int maxCustomTabs = 4;

class CustomTabData {
  final String id;
  String name;
  List<TimeValue> entries;

  CustomTabData({
    required this.id,
    required this.name,
    required this.entries,
  });

  // Serialisation format: id\tname\tentry1\tentry2\t...
  String toPrefsString() {
    final parts = [id, name, ...entries.map((e) => e.toPrefsString())];
    return parts.join('\t');
  }

  static CustomTabData? fromPrefsString(String s) {
    final parts = s.split('\t');
    if (parts.length < 2) return null;
    final id   = parts[0];
    final name = parts[1];
    final entries = parts
        .sublist(2)
        .map(TimeValue.fromPrefsString)
        .whereType<TimeValue>()
        .toList();
    return CustomTabData(id: id, name: name, entries: entries);
  }
}

Future<List<CustomTabData>> loadCustomTabs() async {
  final prefs = await SharedPreferences.getInstance();
  final stored = prefs.getStringList(_kCustomTabsKey);
  if (stored == null) return [];
  return stored
      .map(CustomTabData.fromPrefsString)
      .whereType<CustomTabData>()
      .toList();
}

Future<void> saveCustomTabs(List<CustomTabData> tabs) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(
    _kCustomTabsKey,
    tabs.map((t) => t.toPrefsString()).toList(),
  );
}

// Generates a default name like "Watchlist 1".
String defaultTabName(int existingCount) =>
    'Watchlist ${existingCount + 1}';

// Generates a simple unique ID.
String generateTabId() =>
    DateTime.now().millisecondsSinceEpoch.toString();