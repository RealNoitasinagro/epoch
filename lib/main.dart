import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'models/app_settings.dart';
import 'models/main_tab_config.dart';
import 'models/custom_tab_model.dart';
import 'models/time_entry.dart';
import 'screens/configurable_tab.dart';
import 'screens/technical_tab.dart';
import 'screens/astronomy_tab.dart';
import 'screens/curiosities_tab.dart';
import 'screens/settings_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const EpochApp());
}

const _nightRed    = Color(0xFFCC1010);
const _nightRedDim = Color(0xFF7A0000);

ThemeData _nightTheme() => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: _nightRed,
    onPrimary: Colors.black,
    secondary: _nightRed,
    onSecondary: Colors.black,
    onSurface: _nightRed,
    outline: _nightRedDim,
    outlineVariant: _nightRedDim,
  ),
  appBarTheme: const AppBarTheme(
    foregroundColor: _nightRed,
    iconTheme: IconThemeData(color: _nightRed),
  ),
  tabBarTheme: const TabBarThemeData(
    labelColor: _nightRed,
    unselectedLabelColor: _nightRedDim,
    indicatorColor: _nightRed,
  ),
  iconTheme: const IconThemeData(color: _nightRed),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: _nightRed, fontFamily: 'monospace'),
    bodyMedium: TextStyle(color: _nightRed),
    bodySmall: TextStyle(color: _nightRedDim),
    labelSmall: TextStyle(color: _nightRedDim),
    labelMedium: TextStyle(color: _nightRed),
  ),
  dividerTheme: const DividerThemeData(color: _nightRedDim),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(_nightRed),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_nightRed),
    trackColor: WidgetStateProperty.all(_nightRedDim),
  ),
  useMaterial3: true,
);

class EpochApp extends StatefulWidget {
  const EpochApp({super.key});

  static _EpochAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_EpochAppState>()!;

  @override
  State<EpochApp> createState() => _EpochAppState();
}

class _EpochAppState extends State<EpochApp> {
  AppThemeMode _themeMode  = AppThemeMode.system;
  bool _thousandsSep       = true;
  bool _hourFormat24       = true;
  bool _settingsLoaded     = false;
  Locale _locale           = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final theme     = await loadThemeMode();
    final thousands = await loadThousandsSep();
    final hour24    = await loadHourFormat24();
    final locale    = await loadLocale() ?? const Locale('en');
    setState(() {
      _themeMode    = theme;
      _thousandsSep = thousands;
      _hourFormat24 = hour24;
      _locale       = locale;
      _settingsLoaded = true;
    });
  }

  void setThemeMode(AppThemeMode mode) {
    setState(() => _themeMode = mode);
    saveThemeMode(mode);
  }

  void setThousandsSep(bool v) {
    setState(() => _thousandsSep = v);
    saveThousandsSep(v);
  }

  void setHourFormat24(bool v) {
    setState(() => _hourFormat24 = v);
    saveHourFormat24(v);
  }

  void setLocale(Locale l) {
    setState(() => _locale = l);
    saveLocale(l.languageCode);
  }

  AppThemeMode get themeMode  => _themeMode;
  bool get thousandsSep       => _thousandsSep;
  bool get hourFormat24       => _hourFormat24;
  Locale? get locale          => _locale;
  bool get isNightMode        => _themeMode == AppThemeMode.night;

  ThemeMode get _flutterThemeMode => switch (_themeMode) {
    AppThemeMode.light  => ThemeMode.light,
    AppThemeMode.dark   => ThemeMode.dark,
    AppThemeMode.night  => ThemeMode.dark,
    AppThemeMode.system => ThemeMode.system,
  };

  @override
  Widget build(BuildContext context) {
    if (!_settingsLoaded) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MaterialApp(
      title: 'Epoch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      darkTheme: isNightMode ? _nightTheme() : ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _flutterThemeMode,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  late DateTime _now;

  // Civil tab entries.
  List<TimeEntry> _civilEntries = [];

  // Custom (Watchlist) tabs.
  List<CustomTabData> _customTabs = [];

  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
    _loadData();
  }

  Future<void> _loadData() async {
    final civil  = await loadCivilEntries();
    final custom = await loadCustomTabs();
    setState(() {
      _civilEntries = civil;
      _customTabs   = custom;
      _loaded       = true;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // ── Civil tab callbacks ──────────────────────────────────────────────

  void _onCivilChanged(List<TimeEntry> entries) {
    setState(() => _civilEntries = entries);
    saveCivilEntries(entries);
  }

  // ── Custom tab management ────────────────────────────────────────────

  void _addCustomTab(AppLocalizations l10n) {
    if (_customTabs.length >= maxCustomTabs) return;
    final tab = CustomTabData(
      id:      generateTabId(),
      name:    defaultTabName(_customTabs.length),
      entries: [],
    );
    setState(() => _customTabs.add(tab));
    saveCustomTabs(_customTabs);
  }

  void _deleteCustomTab(String id) {
    setState(() => _customTabs.removeWhere((t) => t.id == id));
    saveCustomTabs(_customTabs);
  }

  void _onCustomTabEntriesChanged(String id, List<TimeEntry> entries) {
    final tab = _customTabs.firstWhere((t) => t.id == id);
    tab.entries = entries;
    saveCustomTabs(_customTabs);
    setState(() {});
  }

  Future<void> _renameCustomTab(
      BuildContext context, AppLocalizations l10n, String id) async {
    final tab = _customTabs.firstWhere((t) => t.id == id);
    final controller = TextEditingController(text: tab.name);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.renameTab),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(labelText: l10n.newTabName),
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (result == null || result.isEmpty) return;
    setState(() => tab.name = result);
    saveCustomTabs(_customTabs);
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final app  = EpochApp.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Fixed tabs count: Civil, Technical, Astronomy, Curiosities.
    // Custom tabs come after.
    final totalTabs = 4 + _customTabs.length +
        (_customTabs.length < maxCustomTabs ? 1 : 0); // +1 for add-button

    return DefaultTabController(
      length: totalTabs,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.appName),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              tooltip: l10n.settings,
              onPressed: () => _openSettings(context),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              // Fixed tabs.
              Tab(child: Text(l10n.tabMain)),
              Tab(child: Text(l10n.tabTechnical)),
              Tab(child: Text(l10n.tabAstronomy)),
              Tab(child: Text(l10n.tabCuriosities)),
              // Custom tabs – italic, long-press to rename.
              ..._customTabs.map((tab) => _CustomTab(
                name: tab.name,
                onLongPress: () =>
                    _renameCustomTab(context, l10n, tab.id),
                onDelete: () => _deleteCustomTab(tab.id),
              )),
              // Add-tab button (if under limit).
              if (_customTabs.length < maxCustomTabs)
                Tab(
                  child: Tooltip(
                    message: l10n.addTab,
                    child: const Icon(Icons.add, size: 20),
                  ),
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Fixed tabs.
            ConfigurableTab(
              now: _now,
              entries: _civilEntries,
              thousandsSep: app.thousandsSep,
              hourFormat24: app.hourFormat24,
              onEntriesChanged: _onCivilChanged,
            ),
            TechnicalTab(now: _now, thousandsSep: app.thousandsSep),
            AstronomyTab(now: _now),
            CuriositiesTab(now: _now),
            // Custom tabs.
            ..._customTabs.map((tab) => ConfigurableTab(
              now: _now,
              entries: tab.entries,
              thousandsSep: app.thousandsSep,
              hourFormat24: app.hourFormat24,
              onEntriesChanged: (e) =>
                  _onCustomTabEntriesChanged(tab.id, e),
            )),
            // Add-tab placeholder.
            if (_customTabs.length < maxCustomTabs)
              _AddTabPlaceholder(
                onAdd: () => _addCustomTab(l10n),
                l10n: l10n,
              ),
          ],
        ),
      ),
    );
  }
}

// ── Custom tab label with long-press and delete ───────────────────────────────

class _CustomTab extends StatelessWidget {
  final String name;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;

  const _CustomTab({
    required this.name,
    required this.onLongPress,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: GestureDetector(
        // Use onLongPressEnd to ensure the gesture is fully complete
        // before triggering the dialog, avoiding the assertion error
        // that occurs when a dialog opens mid-gesture on Linux.
        onLongPressEnd: (_) =>
            WidgetsBinding.instance.addPostFrameCallback((_) => onLongPress()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTapUp: (_) =>
                  WidgetsBinding.instance.addPostFrameCallback(
                          (_) => onDelete()),
              child: Icon(
                Icons.close,
                size: 14,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty placeholder shown when user taps the + tab ─────────────────────────

class _AddTabPlaceholder extends StatelessWidget {
  final VoidCallback onAdd;
  final AppLocalizations l10n;

  const _AddTabPlaceholder({required this.onAdd, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.addTab,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: Text(l10n.addTab),
          ),
        ],
      ),
    );
  }
}