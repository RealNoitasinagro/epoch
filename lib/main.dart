import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'models/app_settings.dart';
import 'screens/main_tab.dart';
import 'screens/technical_tab.dart';
import 'screens/astronomy_tab.dart';
import 'screens/curiosities_tab.dart';
import 'screens/settings_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const EpochApp());
}

// Night mode color: dark red, easy on dark-adapted eyes.
const _nightRed = Color(0xFFCC1010);
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
  appBarTheme: AppBarTheme(
    //backgroundColor: Colors.grey[900],
    foregroundColor: _nightRed,
    iconTheme: const IconThemeData(color: _nightRed),
  ),
  tabBarTheme: const TabBarThemeData(
    labelColor: _nightRed,
    unselectedLabelColor: _nightRedDim,
    indicatorColor: _nightRed,
  ),
  iconTheme: const IconThemeData(color: _nightRed),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      color: _nightRed,
      fontFamily: 'monospace',
    ),
    bodyMedium: TextStyle(color: _nightRed),
    bodySmall: TextStyle(color: _nightRedDim),
    labelSmall: TextStyle(color: _nightRedDim),
    labelMedium: TextStyle(color: _nightRed),
  ),
  dividerTheme: const DividerThemeData(
    color: _nightRedDim,
  ),
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
  AppThemeMode _themeMode = AppThemeMode.system;
  bool _thousandsSep = true;
  bool _hourFormat24 = true;
  bool _settingsLoaded = false;
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final theme    = await loadThemeMode();
    final thousands = await loadThousandsSep();
    final hour24   = await loadHourFormat24();
    final locale   = await loadLocale() ?? const Locale('en');
    setState(() {
      _themeMode      = theme;
      _thousandsSep   = thousands;
      _hourFormat24   = hour24;
      _locale         = locale;
      _settingsLoaded = true;
    });
  }

  void setThemeMode(AppThemeMode mode) {
    setState(() => _themeMode = mode);
    saveThemeMode(mode);
  }

  void setThousandsSep(bool enabled) {
    setState(() => _thousandsSep = enabled);
    saveThousandsSep(enabled);
  }

  void setHourFormat24(bool use24) {
    setState(() => _hourFormat24 = use24);
    saveHourFormat24(use24);
  }

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
    saveLocale(locale.languageCode);
  }

  AppThemeMode get themeMode => _themeMode;
  bool get thousandsSep => _thousandsSep;
  bool get hourFormat24 => _hourFormat24;
  Locale? get locale => _locale;

  // Resolves AppThemeMode to Flutter's ThemeMode for MaterialApp.
  // Night mode uses ThemeMode.dark + a custom ThemeData.
  ThemeMode get _flutterThemeMode => switch (_themeMode) {
    AppThemeMode.light  => ThemeMode.light,
    AppThemeMode.dark   => ThemeMode.dark,
    AppThemeMode.night  => ThemeMode.dark,
    AppThemeMode.system => ThemeMode.system,
  };

  bool get isNightMode => _themeMode == AppThemeMode.night;

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

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = EpochApp.of(context);
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 4,
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
            tabs: [
              Tab(text: l10n.tabMain),
              Tab(text: l10n.tabTechnical),
              Tab(text: l10n.tabAstronomy),
              Tab(text: l10n.tabCuriosities),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MainTab(now: _now, thousandsSep: app.thousandsSep,
                hourFormat24: app.hourFormat24),
            TechnicalTab(now: _now, thousandsSep: app.thousandsSep),
            AstronomyTab(now: _now),
            CuriositiesTab(now: _now),
          ],
        ),
      ),
    );
  }
}