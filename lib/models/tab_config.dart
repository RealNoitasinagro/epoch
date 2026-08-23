import 'package:epoch/models/time_value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import 'astronomical_tab_config.dart';
import 'civil_tab_config.dart';
import 'curiosities_tab_config.dart';
import 'tab_entry.dart';
import 'technical_tab_config.dart';

const _kAllTabsKey = 'all_tabs';
const int maxCustomTabs = 4;  // unchanged limit on user-created (Watchlist) tabs

// Identifies one of the four preinstalled tab categories.
// Order here has no bearing on display order – that comes purely from
// storage order in `all_tabs` (see TabConfig list load/save).
enum BuiltinTabKind { civil, technical, astronomical, curiosities }

class TabConfig {
  final String id;
  String? customName;           // null = use localized builtin name
  final BuiltinTabKind? builtinKind;  // null = user-created (Watchlist) tab
  final bool isVisible;
  List<TabEntry> entries;

  TabConfig({
    required this.id,
    required this.entries,
    this.customName,
    this.builtinKind,
    this.isVisible = true,
  });

  bool get isBuiltin => builtinKind != null;

  // Localized for builtin tabs, custom name otherwise.
  String displayName(AppLocalizations l10n) {
    if (customName != null) return customName!;
    return switch (builtinKind!) {
      BuiltinTabKind.civil         => l10n.tabCivil,
      BuiltinTabKind.technical     => l10n.tabTechnical,
      BuiltinTabKind.astronomical  => l10n.tabAstronomical,
      BuiltinTabKind.curiosities   => l10n.tabCuriosities,
    };
  }

  TabConfig copyWith({
    String? customName,
    bool clearCustomName = false,
    bool? isVisible,
    List<TabEntry>? entries,
  }) => TabConfig(
    id: id,
    builtinKind: builtinKind,
    customName: clearCustomName ? null : (customName ?? this.customName),
    isVisible: isVisible ?? this.isVisible,
    entries: entries ?? this.entries,
  );

  // Serialisation format:
  // id\tcustomNameOrEmpty\tbuiltinKindOrEmpty\tvisible\tentry1\tentry2\t...
  String toPrefsString() {
    final parts = [
      id,
      customName ?? '',
      builtinKind?.name ?? '',
      isVisible ? '1' : '0',
      ...entries.map((e) => e.toPrefsString()),
    ];
    return parts.join('\t');
  }

  static TabConfig? fromPrefsString(String s) {
    final parts = s.split('\t');
    if (parts.length < 4) return null;
    final id = parts[0];
    final customName = parts[1].isEmpty ? null : parts[1];
    final builtinKind = parts[2].isEmpty
        ? null
        : BuiltinTabKind.values.where((k) => k.name == parts[2]).firstOrNull;
    final isVisible = parts[3] == '1';
    final entries = parts
        .sublist(4)
        .map(TabEntry.fromPrefsString)
        .whereType<TabEntry>()
        .toList();
    return TabConfig(
      id: id,
      customName: customName,
      builtinKind: builtinKind,
      isVisible: isVisible,
      entries: entries,
    );
  }
}

Future<List<TabConfig>> loadAllTabs() async {
  final prefs = await SharedPreferences.getInstance();
  final stored = prefs.getStringList(_kAllTabsKey);
  if (stored == null) return [];  // caller (main.dart) seeds builtin defaults
  return stored
      .map(TabConfig.fromPrefsString)
      .whereType<TabConfig>()
      .toList();
}

Future<void> saveAllTabs(List<TabConfig> tabs) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(
    _kAllTabsKey,
    tabs.map((t) => t.toPrefsString()).toList(),
  );
}

// Generates a default name like "Watchlist 1", counting only existing
// Watchlist (non-builtin) tabs.
String defaultTabName(int existingWatchlistCount) =>
    'Watchlist ${existingWatchlistCount + 1}';

int _idCounter = 0;

// Generates a unique ID. Guards against collisions when called several
// times within the same millisecond (e.g. building the four builtin
// tabs back-to-back in defaultBuiltinTabs()).
String generateId() {
  final id = '${DateTime.now().millisecondsSinceEpoch}_$_idCounter';
  _idCounter = (_idCounter + 1) % 1000000;
  return id;
}

// Fresh set of the four builtin tabs, used both for brand-new installs
// and for migrating pre-1.5.0 preferences.
List<TabConfig> defaultBuiltinTabs() => [
  TabConfig(id: generateId(), builtinKind: BuiltinTabKind.civil,
      entries: List.of(defaultCivilEntries)),
  TabConfig(id: generateId(), builtinKind: BuiltinTabKind.technical,
      entries: List.of(defaultTechnicalEntries)),
  TabConfig(id: generateId(), builtinKind: BuiltinTabKind.astronomical,
      entries: List.of(defaultAstronomicalEntries)),
  TabConfig(id: generateId(), builtinKind: BuiltinTabKind.curiosities,
      entries: List.of(defaultCuriositiesEntries)),
];

// Returns the correct default-entry list for a builtin tab kind –
// used by ConfigurableTab's per-tab "reset to defaults".
List<TabEntry> defaultEntriesFor(BuiltinTabKind kind) => switch (kind) {
  BuiltinTabKind.civil        => List.of(defaultCivilEntries),
  BuiltinTabKind.technical    => List.of(defaultTechnicalEntries),
  BuiltinTabKind.astronomical => List.of(defaultAstronomicalEntries),
  BuiltinTabKind.curiosities  => List.of(defaultCuriositiesEntries),
};

const List<TabEntry> defaultWatchlistEntries = [
  TimeValue(valueType: ValueType.date, zone: ZoneLocal()),
  TimeValue(valueType: ValueType.time, zone: ZoneLocal()),
  TimeValue(
    valueType: ValueType.time,
    zone: ZoneNamed('Europe/Berlin'),
    timezoneClockChangeMode: TimezoneClockChangeMode.forceStandard,
  ),
  TabDivider(id: 'builtin_divider_watchlist_1'),
  TimeValue(valueType: ValueType.gmst, zone: ZoneUtc()),
  TimeValue(valueType: ValueType.swatchBeats, zone: ZoneUtc()),
];
