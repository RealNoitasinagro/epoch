import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _showAbout(BuildContext context) async {
    final info = await PackageInfo.fromPlatform();
    if (!context.mounted) return;
    showAboutDialog(
      context: context,
      applicationName: AppStrings.appName,
      applicationVersion: '${info.version} (build ${info.buildNumber})',
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