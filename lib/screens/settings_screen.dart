import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

// Version is read from PackageInfo where available (Android, Linux)
  // and falls back to a build-time constant on web.
  static const _fallbackVersion = '1.0.0';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text(AppStrings.settingsTheme),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text(AppStrings.settingsHourFormat),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
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