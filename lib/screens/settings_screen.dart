import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../main.dart';
import '../strings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ThemeMode _themeMode;
  late bool _thousandsSep;
  late bool _hourFormat24;

  static const _fallbackVersion = '1.0.0';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read current values from app state – runs after context is available.
    final app = EpochApp.of(context);
    _themeMode = app.themeMode;
    _thousandsSep = app.thousandsSep;
    _hourFormat24 = app.hourFormat24;
  }

  Future<void> _showAbout(BuildContext context) async {
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
      applicationName: AppStrings.appName,
      applicationVersion: '$version (build $build)',
      applicationLegalese: '© 2026 RealEarthling',
      children: const [
        SizedBox(height: 16),
        Text(
          'A time display app for nerds and amateur astronomers. '
              'Displays the current time in civil, technical, and astronomical '
              'time systems.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = EpochApp.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text(AppStrings.settingsTheme),
            trailing: DropdownButton<ThemeMode>(
              value: _themeMode,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
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
            secondary: const Icon(Icons.tag),
            title: const Text('Thousands separator'),
            subtitle: const Text('e.g. 1,746,000 instead of 1746000'),
            value: _thousandsSep,
            onChanged: (val) {
              setState(() => _thousandsSep = val);
              app.setThousandsSep(val);
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.schedule),
            title: const Text(AppStrings.settingsHourFormat),
            subtitle: const Text('Off = 12-hour with AM/PM'),
            value: _hourFormat24,
            onChanged: (val) {
              setState(() => _hourFormat24 = val);
              app.setHourFormat24(val);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text(AppStrings.settingsLanguage),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(AppStrings.settingsAbout),
            onTap: () => _showAbout(context),
          ),
        ],
      ),
    );
  }
}