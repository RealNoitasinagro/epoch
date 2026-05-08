import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../main.dart';
import '../l10n/app_localizations.dart';
import '../models/app_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppThemeMode _themeMode;
  late bool _thousandsSep;
  late bool _hourFormat24;
  Locale? _locale;
  
  static const _fallbackVersion = '1.0.0';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read current values from app state – runs after context is available.
    final app = EpochApp.of(context);
    _themeMode = app.themeMode;
    _thousandsSep = app.thousandsSep;
    _hourFormat24 = app.hourFormat24;
    _locale = app.locale;
  }

  Future<void> _showAbout(BuildContext context, AppLocalizations l10n) async {
    String version;
    String build;
    try {
      final info = await PackageInfo.fromPlatform();
      version = info.version.isNotEmpty ? info.version : _fallbackVersion;
      build = info.buildNumber.isNotEmpty ? info.buildNumber : '1';
    } catch (_) {
      version = _fallbackVersion;
      build = '1';
    }
    if (!context.mounted) return;
    showAboutDialog(
      context: context,
      applicationName: l10n.appName,
      applicationVersion: '$version (build $build)',
      applicationLegalese: l10n.aboutLegalese,
      children: [
        SizedBox(height: 16),
        Text(l10n.aboutDescription),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = EpochApp.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.settingsLanguage),
            trailing: DropdownButton<String>(
              value: _locale?.languageCode ?? 'en',
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'de', child: Text('Deutsch')),
              ],
              onChanged: (code) {
                if (code == null) return;
                final locale = Locale(code);
                setState(() => _locale = locale);
                app.setLocale(locale);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(l10n.settingsTheme),
            trailing: DropdownButton<AppThemeMode>(
              value: _themeMode,
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem(
                  value: AppThemeMode.system,
                  child: Text(l10n.settingsThemeSystem),
                ),
                DropdownMenuItem(
                  value: AppThemeMode.light,
                  child: Text(l10n.settingsThemeLight),
                ),
                DropdownMenuItem(
                  value: AppThemeMode.dark,
                  child: Text(l10n.settingsThemeDark),
                ),
                DropdownMenuItem(
                  value: AppThemeMode.night,
                  child: Text(l10n.settingsThemeNight),
                ),
              ],
              onChanged: (mode) {
                if (mode == null) return;
                setState(() => _themeMode = mode);
                app.setThemeMode(mode);
              },
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.schedule),
            title: Text(l10n.settingsHourFormat),
            subtitle: Text(l10n.settingsHourFormatSub),
            value: _hourFormat24,
            onChanged: (val) {
              setState(() => _hourFormat24 = val);
              app.setHourFormat24(val);
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.tag),
            title: Text(l10n.settingsThousandsSep),
            subtitle: Text(l10n.settingsThousandsSepSub),
            value: _thousandsSep,
            onChanged: (val) {
              setState(() => _thousandsSep = val);
              app.setThousandsSep(val);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.settingsAbout),
            onTap: () => _showAbout(context, l10n),
          ),
        ],
      ),
    );
  }
}