import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'models/app_settings.dart';
import 'screens/main_tab.dart';
import 'screens/technical_tab.dart';
import 'screens/astronomy_tab.dart';
import 'screens/curiosities_tab.dart';
import 'screens/settings_screen.dart';
import 'strings.dart';

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

  ThemeMode get themeMode => _themeMode;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final theme = await loadThemeMode();
    final thousands = await loadThousandsSep();
    final hour24 = await loadHourFormat24();
    setState(() {
      _themeMode = theme;
      _thousandsSep = thousands;
      _hourFormat24 = hour24;
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

  bool get thousandsSep => _thousandsSep;
  bool get hourFormat24 => _hourFormat24;

  @override
  Widget build(BuildContext context) {
    if (!_settingsLoaded) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MaterialApp(
      title: AppStrings.appName,
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              tooltip: AppStrings.settings,
              onPressed: () => _openSettings(context),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: AppStrings.tabMain),
              Tab(text: AppStrings.tabTechnical),
              Tab(text: AppStrings.tabAstronomy),
              Tab(text: AppStrings.tabCuriosities),
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