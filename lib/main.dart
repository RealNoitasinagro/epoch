import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'app/bundled_licenses.dart';
import 'app/epoch_app.dart';
import 'screens/startup_error_screen.dart';
import 'settings/prefs_migrations.dart';
import 'settings/settings_io.dart';
import 'settings/time_shift_start.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Comment out to test the StartupErrorScreen:
    //throw StateError('test');
    registerBundledLicenses();
    await runPrefsMigrations();
    tz.initializeTimeZones();
    await _loadConfigFromCommandLine(args);
    await applyTimeShiftStart();
  } catch (error, stackTrace) {
    runApp(StartupErrorApp(error: error, stackTrace: stackTrace));
    return;
  }
  runApp(const EpochApp());
}

Future<void> _loadConfigFromCommandLine(List<String> args) async {
  if (kIsWeb || !Platform.isLinux || args.isEmpty) return;
  if (args.contains('--help') || args.contains('-h')) {
    stdout.writeln('Usage: epoch [config.json]');
    exit(0);
  }
  final configPath = args.where((a) => !a.startsWith('--')).firstOrNull;
  if (configPath == null) return;
  final file = File(configPath);
  if (!file.existsSync()) {
    stderr.writeln('Config file not found: $configPath');
    exit(1);
  }
  try {
    await importSettingsJson(await file.readAsString());
  } catch (e) {
    stderr.writeln('Failed to load config: $e');
    exit(1);
  }
}
