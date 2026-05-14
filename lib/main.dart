import 'dart:async';
import 'package:epoch/screens/civil_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'build_info.dart';
import 'models/app_settings.dart';
import 'models/main_tab_config.dart';
import 'models/custom_tab_model.dart';
import 'models/time_entry.dart';
import 'screens/configurable_tab.dart';
import 'screens/technical_tab.dart';
import 'screens/astronomical_tab.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late Timer _timer;
  late DateTime _now;
  TabController? _tabController;
  List<TimeEntry> _civilEntries = [];
  List<CustomTabData> _customTabs = [];
  bool _loaded = false;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
    _loadData();
  }

  @override
  void dispose() {
    _timer.cancel();
    _tabController?.dispose();
    super.dispose();
  }

  int get _tabCount => 4 + _customTabs.length;

  Future<void> _loadData() async {
    final civil  = await loadCivilEntries();
    final custom = await loadCustomTabs();
    setState(() {
      _civilEntries = civil;
      _customTabs   = custom;
      _loaded       = true;
    });
    _updateTabController();
  }

  void _toggleFullscreen() {
    setState(() => _isFullscreen = !_isFullscreen);
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  // ── Civil tab callbacks ──────────────────────────────────────────────

  void _onCivilChanged(List<TimeEntry> entries) {
    setState(() => _civilEntries = entries);
    saveCivilEntries(entries);
  }

  // ── Custom tab management ────────────────────────────────────────────

  void _updateTabController() {
    final newCount = _tabCount;
    final oldIndex = _tabController?.index ?? 0;
    final oldController = _tabController;

    _tabController = TabController(
      length: newCount,
      vsync: this,
      initialIndex: oldIndex.clamp(0, newCount - 1),
    );
    _tabController!.addListener(_onTabChanged);

    // Dispose old controller after the current frame to avoid
    // disposing during notifyListeners().
    WidgetsBinding.instance.addPostFrameCallback((_) {
      oldController?.dispose();
    });
    setState(() {});
  }

  void _onTabChanged() {
    if (!_tabController!.indexIsChanging) return;
    final addTabIndex = 4 + _customTabs.length;
    if (_tabController!.index == addTabIndex &&
        _customTabs.length < maxCustomTabs) {
      // Snap back to previous tab immediately, then add.
      _tabController!.index = _tabController!.previousIndex;
      final l10n = AppLocalizations.of(context)!;
      _addCustomTab(l10n);
    }
  }

  void _addCustomTab(AppLocalizations l10n) {
    if (_customTabs.length >= maxCustomTabs) return;
    final tab = CustomTabData(
      id:      generateTabId(),
      name:    defaultTabName(_customTabs.length),
      entries: [],
    );
    _customTabs.add(tab);
    saveCustomTabs(_customTabs);
    _updateTabController();
    // Navigate to the newly created tab.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _tabController?.animateTo(4 + _customTabs.length - 1);
    });
  }

  void _deleteCustomTab(String id) {
    final idx = _customTabs.indexWhere((t) => t.id == id);
    _customTabs.removeWhere((t) => t.id == id);
    saveCustomTabs(_customTabs);
    // Navigate to tab left of the deleted one, minimum index 0.
    final targetIndex = (idx + 3).clamp(0, _tabCount - 2);
    _updateTabController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _tabController?.animateTo(targetIndex);
    });
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
    // Note: controller.dispose() intentionally omitted – causes a
    // post-frame assertion on Linux when the dialog rebuilds after pop.
    // The GC will collect it correctly since no further references exist.
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
    if (!_loaded || _tabController == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final app  = EpochApp.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: _toggleFullscreen,
          onLongPress: () => _showBuildInfo(context),
          child: Text(l10n.appName),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_customTabs.length < maxCustomTabs)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: l10n.addTab,
              onPressed: () {
                final l10n = AppLocalizations.of(context)!;
                _addCustomTab(l10n);
              },
            ),
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: l10n.settings,
            onPressed: () => _openSettings(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(child: Text(l10n.tabCivil)),
            Tab(child: Text(l10n.tabTechnical)),
            Tab(child: Text(l10n.tabAstronomical)),
            Tab(child: Text(l10n.tabCuriosities)),
            ..._customTabs.map((tab) => _CustomTab(
              name: tab.name,
              onRename: () => _renameCustomTab(context, l10n, tab.id),
              onDelete: () => _deleteCustomTab(tab.id),
            )),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CivilTab(
            now: _now,
            entries: _civilEntries,
            thousandsSep: app.thousandsSep,
            hourFormat24: app.hourFormat24,
            onEntriesChanged: _onCivilChanged,
          ),
          TechnicalTab(now: _now, thousandsSep: app.thousandsSep),
          AstronomicalTab(now: _now),
          CuriositiesTab(now: _now),
          ..._customTabs.map((tab) => ConfigurableTab(
            now: _now,
            entries: tab.entries,
            thousandsSep: app.thousandsSep,
            hourFormat24: app.hourFormat24,
            onEntriesChanged: (e) =>
                _onCustomTabEntriesChanged(tab.id, e),
          )),
        ],
      ),
    );
  }

  void _showBuildInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Build info'),
        content: Text(
          kBuildTimestamp,
          style: const TextStyle(fontFamily: 'monospace'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// ── Custom tab label with long-press and delete ───────────────────────────────

class _CustomTab extends StatelessWidget {
  final String name;
  final VoidCallback onRename;
  final VoidCallback onDelete;

  const _CustomTab({
    required this.name,
    required this.onRename,
    required this.onDelete,
  });

  void _showOptions(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(l10n.renameTab),
              onTap: () {
                Navigator.pop(ctx);
                onRename();
              },
            ),
            ListTile(
              leading: const Icon(Icons.close,
                  color: Colors.redAccent),
              title: Text(l10n.deleteTab,
                  style: const TextStyle(color: Colors.redAccent)),
              onTap: () {
                Navigator.pop(ctx);
                onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Tab(
      child: GestureDetector(
        onLongPress: () => _showOptions(context, l10n),
        child: Text(
          name,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
