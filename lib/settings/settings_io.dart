import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/epoch_app.dart';
import '../app/layout_constants.dart';
import '../l10n/app_localizations.dart';
import '../time/effective_clock.dart';
import 'settings_json.dart';
import 'time_shift_start.dart';
import 'tolerant_prefs.dart';

const _extJson = 'json';
final _defaultExportFilename = const ['epoch_settings', _extJson].join('.');
const _kLastExportDirKey = 'last_export_dir';

Future<bool> exportSettings(
  BuildContext context, {
  bool doBackup = false,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final json = await exportSettingsJson();
  final bytes = Uint8List.fromList(utf8.encode(json));

  String dialogTitle = doBackup
      ? l10n.settingsPreferencesResetBackupTitle
      : l10n.settingsPreferencesExport;
  String exportFilename = doBackup
      ? _getBackupFilename()
      : _defaultExportFilename;

  String? path = await _openSaveDialog(
    // triggers download on web
    l10n,
    bytes,
    dialogTitle,
    exportFilename,
  );

  if (!context.mounted) return false;
  if (kIsWeb) return true; // no SnackBar on web – timing unreliable
  if (path == null) return false; // Android, Linux: user cancelled

  if (Platform.isLinux) {
    await File(path).writeAsString(json);
    await _saveLastExportDirectory(File(path).parent.path);
  }

  if (!doBackup) {
    _showSnackBar(context, l10n.messageSettingsExported); // Android, Linux
  }
  return true;
}

Future<void> importSettings(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;

  final result = await FilePicker.pickFiles(
    dialogTitle: l10n.settingsPreferencesImport,
    type: FileType.custom,
    allowedExtensions: [_extJson],
    withData: true,
    initialDirectory: await _loadLastExportDirectory(),
  );

  if (result == null || result.files.isEmpty) return;

  final file = result.files.first;
  final String json;

  if (file.bytes != null) {
    json = utf8.decode(file.bytes!);
  } else if (file.path != null) {
    json = await File(file.path!).readAsString();
    await _saveLastExportDirectory(File(file.path!).parent.path);
  } else
    return;

  final List<String> ignoredKeys;
  try {
    ignoredKeys = await importSettingsJson(json);
    if (file.path != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_imported_config', file.name);
    }
  } on FormatException {
    if (!context.mounted) return;
    _showSnackBar(context, l10n.messageSettingsImportFailed);
    return;
  }

  if (!context.mounted) return;
  EffectiveClock.reset(); // an import starts from a clean slate ...
  await applyTimeShiftStart(); // ... except for a start value the file brings along
  await EpochApp.of(context).reloadPreferences();

  if (!context.mounted) return;
  _showSnackBar(
    context,
    ignoredKeys.isEmpty
        ? l10n.messageSettingsImported
        : l10n.messageSettingsImportedIgnored(
            ignoredKeys.length,
            _keyList(ignoredKeys),
          ),
    duration: ignoredKeys.isEmpty ? null : kSnackBarLong,
  );
}

Future<void> resetSettings(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;

  // backup first
  final backupSaved = await exportSettings(context, doBackup: true);
  if (!backupSaved) return; // User cancelled backup → abort reset

  // reset
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  EffectiveClock.reset(); // reset includes Time Shift

  // reload
  if (!context.mounted) return;
  await EpochApp.of(context).reloadPreferences();

  // report
  if (!context.mounted) return;
  _showSnackBar(context, l10n.messageSettingsReset);
}

// ── Private helpers ──────────────────────────────────────────────────────────

String _getBackupFilename() {
  final timestamp = DateTime.now()
      .toIso8601String()
      .replaceAll(':', '-')
      .substring(0, 19);
  final backupFilename =
      '${_defaultExportFilename.replaceFirst(RegExp(r'\.' + _extJson + r'$'), '')}'
      '_$timestamp.$_extJson';
  return backupFilename;
}

Future<String?> _openSaveDialog(
  AppLocalizations l10n,
  Uint8List bytes,
  String dialogTitle,
  String fileName,
) async {
  String? path = await FilePicker.saveFile(
    dialogTitle: dialogTitle,
    fileName: fileName,
    type: FileType.custom,
    allowedExtensions: [_extJson],
    bytes: bytes,
    initialDirectory: await _loadLastExportDirectory(),
  );
  return path;
}

Future<void> _saveLastExportDirectory(String dir) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLastExportDirKey, dir);
}

Future<String?> _loadLastExportDirectory() async {
  final prefs = await SharedPreferences.getInstance();
  final dir = prefs.tolerantString(_kLastExportDirKey);
  if (dir == null) return null;
  if (!kIsWeb && !Directory(dir).existsSync()) return null;
  return dir;
}

const _maxListedKeys = 4;

/// "a, b, c, d, …": a snack bar has little room.
String _keyList(List<String> keys) => keys.length <= _maxListedKeys
    ? keys.join(', ')
    : '${keys.take(_maxListedKeys).join(', ')}, …';

void _showSnackBar(BuildContext context, String message, {Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: duration ?? kSnackBarStandard,
    ),
  );
}
