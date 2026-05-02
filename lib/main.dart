import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
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

class EpochApp extends StatelessWidget {
  const EpochApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
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
            MainTab(now: _now),
            TechnicalTab(now: _now),
            AstronomyTab(now: _now),
            CuriositiesTab(now: _now),
          ],
        ),
      ),
    );
  }
}