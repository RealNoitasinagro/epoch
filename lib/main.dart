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

class EpochApp extends StatefulWidget {
  const EpochApp({super.key});

  // Allows child widgets to call EpochApp.of(context).setThemeMode(...)
  static _EpochAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_EpochAppState>()!;

  @override
  State<EpochApp> createState() => _EpochAppState();
}

class _EpochAppState extends State<EpochApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _thousandsSep = true;
  bool _hourFormat24 = true;
  bool _settingsLoaded = false;
  //Locale? _locale; // null = system locale (?)
  Locale _locale = const Locale('en'); // default to English

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final theme = await loadThemeMode();
    final thousands = await loadThousandsSep();
    final hour24 = await loadHourFormat24();
    final locale = await loadLocale() ?? const Locale('en');

    setState(() {
      _themeMode = theme;
      _thousandsSep = thousands;
      _hourFormat24 = hour24;
      _locale = locale;
      _settingsLoaded = true;
    });
  }

  void setThemeMode(ThemeMode mode) {
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

  ThemeMode get themeMode => _themeMode;
  bool get thousandsSep => _thousandsSep;
  bool get hourFormat24 => _hourFormat24;
  Locale? get locale => _locale;

  @override
  Widget build(BuildContext context) {
    if (!_settingsLoaded) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MaterialApp(
      //title: AppStrings.appName,
      title: AppLocalizations.of(context)!.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
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
          //title: const Text(AppStrings.appName),
          //title: Text(AppLocalizations.of(context)!.appName),
          title: Text(l10n.appName),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              //tooltip: AppStrings.settings,
              tooltip: l10n.settings,
              onPressed: () => _openSettings(context),
            ),
          ],
          bottom: TabBar(
            tabs: [
              //Tab(text: AppStrings.tabMain),
              //Tab(text: AppLocalizations.of(context)!.tabMain),
              Tab(text: l10n.tabMain),
              //Tab(text: AppStrings.tabTechnical),
              //Tab(text: AppLocalizations.of(context)!.tabTechnical),
              Tab(text: l10n.tabTechnical),
              //Tab(text: AppStrings.tabAstronomy),
              //Tab(text: AppLocalizations.of(context)!.tabAstronomy),
              Tab(text: l10n.tabAstronomy),
              //Tab(text: AppStrings.tabCuriosities),
              //Tab(text: AppLocalizations.of(context)!.tabCuriosities),
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