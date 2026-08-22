import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:url_launcher/url_launcher.dart';
import 'build_info.dart';
import 'l10n/app_localizations.dart';
import 'layout_constants.dart';
import 'models/app_settings.dart';
import 'models/prefs_migrations.dart';
import 'models/settings_io.dart';
import 'models/tab_config.dart';
import 'models/tab_entry.dart';
import 'models/time_value.dart';
import 'screens/configurable_tab.dart';
import 'screens/settings_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await runPrefsMigrations();
  tz.initializeTimeZones();

  if (!kIsWeb && Platform.isLinux && args.isNotEmpty) {
    if (args.contains('--help') || args.contains('-h')) {
      stdout.writeln('Usage: epoch [config.json]');
      exit(0);
    }
    final configPath = args.where((a) => !a.startsWith('--')).firstOrNull;
    if (configPath != null) {
      final file = File(configPath);
      if (file.existsSync()) {
        try {
          final json = await file.readAsString();
          await importSettingsJson(json);
        } catch (e) {
          stderr.writeln('Failed to load config: $e');
          exit(1);
        }
      } else {
        stderr.writeln('Config file not found: $configPath');
        exit(1);
      }
    }
  }

  runApp(const EpochApp());
}

const fontFamilyDefault = 'JetBrainsMono';  // 'monospace';
const _nightRed = kColorNightRed;
const _nightRedDim = kColorNightRedDim;

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
    headlineSmall: TextStyle(color: _nightRed, fontFamily: fontFamilyDefault),
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

  static EpochAppState of(BuildContext context) =>
      context.findAncestorStateOfType<EpochAppState>()!;

  @override
  State<EpochApp> createState() => EpochAppState();
}

class EpochAppState extends State<EpochApp> {
  bool _settingsLoaded             = false;
  String _localIanaZone            = 'UTC';
  Locale _locale                   = kDefaultLocale;
  AppThemeMode _themeMode          = kDefaultThemeMode;
  bool _hourFormat24               = kDefaultHourFormat24;
  bool _thousandsSep               = kDefaultThousandsSep;
  bool _dateWithDetails            = kDefaultDateWithDetails;
  String _dateFormat               = kDatePatternIso;
  String _timeFormat               = kTimePatternFull;
  ZoneDisplayMode _zoneDisplayMode = kDefaultZoneDisplayMode;
  bool _dayQuarterColor            = kDefaultDayQuarterColor;
  LmstMode _lmstMode               = kDefaultLmstMode;
  double? _lmstLongitude;
  String? _lastImportedConfig;

  Key _homeKey = UniqueKey();
  final ValueNotifier<int> settingsReloadNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> reloadPreferences() async {
    await _loadPreferences();
    if (mounted) {
      setState(() => _homeKey = UniqueKey());
      settingsReloadNotifier.value++;  // signals SettingsScreen to refresh
    }
  }

  Future<void> _loadPreferences() async {
    final locale             = await loadLocale() ?? kDefaultLocale;
    final theme              = await loadThemeMode();
    final hour24             = await loadHourFormat24();
    final thousands          = await loadThousandsSep();
    final dateWithDetails    = await loadDateWithDetails();
    final dateFormat         = await loadDateFormat();
    final timeFormat         = await loadTimeFormat();
    final zoneDisplayMode    = await loadZoneDisplayMode();
    final dayQuarterColor    = await loadDayQuarterColor();
    final lmstMode           = await loadLmstMode();
    final lmstLongitude      = await loadLmstLongitude();
    final lastImportedConfig = await loadLastImportedConfig();

    String localZone = 'UTC';
    try {
      final TimezoneInfo currentTimeZone = await FlutterTimezone.getLocalTimezone();
      localZone = currentTimeZone.identifier;
    } catch (_) {
      localZone = 'UTC';
    }

    setState(() {
      _localIanaZone      = localZone;
      _locale             = locale;
      _themeMode          = theme;
      _hourFormat24       = hour24;
      _thousandsSep       = thousands;
      _dateWithDetails    = dateWithDetails;
      _dateFormat         = dateFormat;
      _timeFormat         = timeFormat;
      _zoneDisplayMode    = zoneDisplayMode;
      _dayQuarterColor    = dayQuarterColor;
      _lmstMode           = lmstMode;
      _lmstLongitude      = lmstLongitude;
      _lastImportedConfig = lastImportedConfig;
      _settingsLoaded     = true;
    });
  }

  void setLocale(Locale l) {
    setState(() => _locale = l);
    saveLocale(l.languageCode);
  }

  void setThemeMode(AppThemeMode mode) {
    setState(() => _themeMode = mode);
    saveThemeMode(mode);
  }

  void setHourFormat24(bool v) {
    setState(() => _hourFormat24 = v);
    saveHourFormat24(v);
  }

  void setThousandsSep(bool v) {
    setState(() => _thousandsSep = v);
    saveThousandsSep(v);
  }

  void setDateWithDetails(bool v) {
    setState(() => _dateWithDetails = v);
    saveDateWithDetails(v);
  }

  void setDateFormat(String pattern) {
    setState(() => _dateFormat = pattern);
    saveDateFormat(pattern);
  }

  void setTimeFormat(String pattern) {
    setState(() => _timeFormat = pattern);
    saveTimeFormat(pattern);
  }

  void setZoneDisplayMode(ZoneDisplayMode mode) {
    setState(() => _zoneDisplayMode = mode);
    saveZoneDisplayMode(mode);
  }

  void setDayQuarterColor(bool v) {
    setState(() => _dayQuarterColor = v);
    saveDayQuarterColor(v);
  }

  void setLmstMode(LmstMode mode) {
    setState(() => _lmstMode = mode);
    saveLmstMode(mode);
  }

  void setLmstLongitude(double? lon) {
    setState(() => _lmstLongitude = lon);
    if (lon != null) saveLmstLongitude(lon);
  }

  void setLastImportedConfig(String filename) {
    setState(() => _lastImportedConfig = filename);
    saveLastImportedConfig(filename);
  }

  String get localIanaZone => _localIanaZone;
  Locale? get locale                  => _locale;
  AppThemeMode get themeMode          => _themeMode;
  ThemeMode get _flutterThemeMode => switch (_themeMode) {
    AppThemeMode.light  => ThemeMode.light,
    AppThemeMode.dark   => ThemeMode.dark,
    AppThemeMode.night  => ThemeMode.dark,
    AppThemeMode.system => ThemeMode.system,
  };
  bool get isNightMode                => _themeMode == AppThemeMode.night;
  bool get hourFormat24               => _hourFormat24;
  bool get thousandsSep               => _thousandsSep;
  bool get dateWithDetails            => _dateWithDetails;
  String get dateFormat               => _dateFormat;
  String get timeFormat               => _timeFormat;
  ZoneDisplayMode get zoneDisplayMode => _zoneDisplayMode;
  bool get dayQuarterColor            => _dayQuarterColor;
  LmstMode get lmstMode               => _lmstMode;
  double?  get lmstLongitude          => _lmstLongitude;
  String? get lastImportedConfig      => _lastImportedConfig;

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
      home: HomeScreen(key: _homeKey),
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
  List<TabConfig> _tabs = [];
  bool _loaded = false;
  bool _isFullscreen = false;

  static const _fallbackVersion = '0.0.0';
  static const _fallbackBuildNumber = '0';
  static const changelogLink = 'https://github.com/RealNoitasinagro/epoch/blob/main/CHANGELOG.md';

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

  List<TabConfig> get _visibleTabs =>
      _tabs.where((t) => t.isVisible).toList();
  int get _tabCount => _visibleTabs.length;

  Future<void> _loadData() async {
    var tabs = await loadAllTabs();
    if (tabs.isEmpty) {
      tabs = defaultBuiltinTabs();
      await saveAllTabs(tabs);
    }
    final activeTab = await loadActiveTab();
    setState(() {
      _tabs   = tabs;
      _loaded = true;
    });
    _updateTabController(initialIndex: activeTab);
  }

  void _toggleFullscreen() {
    setState(() => _isFullscreen = !_isFullscreen);
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  void _onTabEntriesChanged(String id, List<TabEntry> entries) {
    final tab = _tabs.firstWhere((t) => t.id == id);
    tab.entries = entries;
    saveAllTabs(_tabs);
    setState(() {});
  }

  void _updateTabController({int? initialIndex}) {
    final newCount = _tabCount;
    final oldIndex = initialIndex ?? _tabController?.index ?? 0;
    final oldController = _tabController;
    _tabController = TabController(
      length: newCount,
      vsync: this,
      initialIndex: oldIndex.clamp(0, newCount - 1),
    );
    _tabController!.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      oldController?.dispose();
    });
    setState(() {});
  }

  void _onTabChanged() {
    if (!mounted) return;
    if (_tabController!.indexIsChanging) return;
    saveActiveTab(_tabController!.index);
  }

  void _addCustomTab(AppLocalizations l10n) {
    final watchlistCount = _tabs.where((t) => !t.isBuiltin).length;
    if (watchlistCount >= maxCustomTabs) return;
    final tab = TabConfig(
      id: generateId(),
      customName: defaultTabName(watchlistCount),
      entries: [],
    );
    _tabs.add(tab);
    saveAllTabs(_tabs);
    _updateTabController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _tabController?.animateTo(_visibleTabs.length - 1);
    });
  }

  void _deleteCustomTab(String id) {
    final idx = _visibleTabs.indexWhere((t) => t.id == id);
    _tabs.removeWhere((t) => t.id == id);
    saveAllTabs(_tabs);
    final targetIndex = (idx - 1).clamp(0, _tabCount - 1);
    _updateTabController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _tabController?.animateTo(targetIndex);
    });
  }


  Future<void> _renameCustomTab(
      BuildContext context, AppLocalizations l10n, String id) async {
    final tab = _tabs.firstWhere((t) => t.id == id);
    final controller = TextEditingController(text: tab.customName);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.actionRenameTab),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(labelText: l10n.labelNewTabName),
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.actionCancel),
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
    setState(() => tab.customName = result);
    saveAllTabs(_tabs);
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    ).then((_) async {
      if (!mounted) return;
      if (EpochApp.of(context).lmstMode == LmstMode.off) {
        _removeLmstFromAllTabs();
      }
      // Tab visibility may have changed in Settings – reload:
      final reloadedTabs = await loadAllTabs();
      if (!mounted) return;
      setState(() => _tabs = reloadedTabs);
      _updateTabController();
    });
  }

  void _removeLmstFromAllTabs() {
    for (final tab in _tabs) {
      final newEntries = tab.entries
          .where((e) => e.valueType != ValueType.lmst)
          .toList();
      if (newEntries.length != tab.entries.length) {
        tab.entries = newEntries;
      }
    }
    saveAllTabs(_tabs);
    setState(() {});
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
        titleSpacing: NavigationToolbar.kMiddleSpacing,
        flexibleSpace: Builder(
          builder: (context) {
            final isNight = EpochApp.of(context).isNightMode;
            if (isNight) return const SizedBox.shrink();
            final colorScheme = Theme.of(context).colorScheme;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primaryContainer,
                    colorScheme.inversePrimary,
                    colorScheme.secondaryContainer,
                  ],
                ),
              ),
            );
          },
        ),
        title: GestureDetector(
          child: Text(l10n.appName),
          onDoubleTap: _toggleFullscreen,
          onLongPress: () => _showBuildInfo(context),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_tabs.where((t) => !t.isBuiltin).length < maxCustomTabs)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: l10n.hintAddTab,
              onPressed: () {
                final l10n = AppLocalizations.of(context)!;
                _addCustomTab(l10n);
              },
            ),
          // If we still need a direct shortcut...
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   tooltip: l10n.pageSettings,
          //   onPressed: () => _openSettings(context),
          // ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  _openSettings(context);
                case 'about':
                  _showAbout(context, l10n);
                case 'whats_new':
                  launchUrl(
                    Uri.parse(changelogLink),
                    mode: LaunchMode.externalApplication
                  );
              }
            },
            itemBuilder: (context) {
              final l10n = AppLocalizations.of(context)!;
              return [
                PopupMenuItem(
                  value: 'settings',
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(l10n.pageSettings),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  value: 'about',
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(l10n.settingsAbout),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
                PopupMenuItem(
                  value: 'whats_new',
                  child: ListTile(
                    leading: const Icon(Icons.new_releases_outlined),
                    title: Text(l10n.settingsWhatsNew),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ),
              ];
            },
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: _visibleTabs.map((tab) => _AppTab(
            tabConfig: tab,
            onRename: tab.isBuiltin
                ? null
                : () => _renameCustomTab(context, l10n, tab.id),
            onHideOrDelete: tab.isBuiltin
                ? () => _hideBuiltinTab(tab.id)
                : () => _deleteCustomTab(tab.id),
          )).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _visibleTabs.map((tab) => ConfigurableTab(
          key: ValueKey(tab.id),
          now: _now,
          entries: tab.entries,
          defaultEntries: tab.isBuiltin
              ? defaultEntriesFor(tab.builtinKind!)
              : const [],
          thousandsSep: app.thousandsSep,
          hourFormat24: app.hourFormat24,
          showDateDetails: app.dateWithDetails,
          onEntriesChanged: (e) => _onTabEntriesChanged(tab.id, e),
        )).toList(),
      ),
    );
  }

  void _hideBuiltinTab(String id) {
    final idx = _tabs.indexWhere((t) => t.id == id);
    _tabs[idx] = _tabs[idx].copyWith(isVisible: false);
    saveAllTabs(_tabs);
    _updateTabController();
    setState(() {});
  }

  void _showBuildInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Build info'),
        content: Text(
          kBuildInfo,
          style: const TextStyle(fontFamily: fontFamilyDefault),
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

  Future<void> _showAbout(BuildContext context, AppLocalizations l10n) async {
    String version;
    String build;
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      version = info.version.isNotEmpty ? info.version : _fallbackVersion;
      build = info.buildNumber.isNotEmpty ? info.buildNumber : _fallbackBuildNumber;
    } catch (_) {
      version = _fallbackVersion;
      build = _fallbackBuildNumber;
    }
    if (!context.mounted) return;
    showAboutDialog(
      context: context,
      applicationName: l10n.appName,
      applicationVersion: '$version (build $build)',
      applicationLegalese: l10n.dialogueAboutLegalese,
      children: [
        SizedBox(height: 16),
        Text(l10n.dialogueAbout),
      ],
    );
  }
}

class _AppTab extends StatelessWidget {
  final TabConfig tabConfig;
  final VoidCallback? onRename;  // null for builtin tabs (no rename)
  final VoidCallback onHideOrDelete;

  const _AppTab({
    required this.tabConfig,
    required this.onRename,
    required this.onHideOrDelete,
  });

  void _showOptions(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onRename != null)
              ListTile(
                leading: const Icon(Icons.edit),
                title: Text(l10n.actionRenameTab),
                onTap: () {
                  Navigator.pop(ctx);
                  onRename!();
                },
              ),
            ListTile(
              leading: Icon(
                tabConfig.isBuiltin ? Icons.visibility_off_outlined : Icons.delete_outline,
                color: Colors.redAccent,
              ),
              title: Text(
                tabConfig.isBuiltin ? l10n.actionHideTab : l10n.actionDeleteTab,
                style: const TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.pop(ctx);
                onHideOrDelete();
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
          tabConfig.displayName(l10n),
          style: tabConfig.isBuiltin
              ? const TextStyle(fontStyle: FontStyle.italic)
              : null,
        ),
      ),
    );
  }
}
