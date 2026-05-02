import 'package:flutter/material.dart';
import '../strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text(AppStrings.settingsTimezone),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(AppStrings.settingsTheme),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(AppStrings.settingsHourFormat),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(AppStrings.settingsLanguage),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text(AppStrings.settingsAbout),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}