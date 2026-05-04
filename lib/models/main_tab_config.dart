import 'package:shared_preferences/shared_preferences.dart';
import 'time_value.dart';

const _kMainTabKey = 'main_tab_ids';

// Loads the ordered list of TimeValueIds for the Main tab from persistent
// storage. Returns defaultMainTabIds if nothing has been saved yet.
Future<List<TimeValueId>> loadMainTabIds() async {
  final prefs = await SharedPreferences.getInstance();
  final stored = prefs.getStringList(_kMainTabKey);
  if (stored == null) return List.of(defaultMainTabIds);
  return stored
      .map((s) => TimeValueId.values.where((e) => e.name == s).firstOrNull)
      .whereType<TimeValueId>()
      .toList();
}

// Persists the current ordered list of TimeValueIds for the Main tab.
Future<void> saveMainTabIds(List<TimeValueId> ids) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(_kMainTabKey, ids.map((e) => e.name).toList());
}