import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../l10n/app_localizations.dart';
import '../models/app_settings.dart';
import '../time_value_formatter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppThemeMode _themeMode;
  late bool _thousandsSep;
  late bool _hourFormat24;
  late bool _dateWithDetails;
  Locale? _locale;
  late LmstMode _lmstMode;
  late double? _lmstLongitude;
  final _longitudeController = TextEditingController();

  static const _fallbackVersion = '1.0.0';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read current values from app state – runs after context is available.
    final app = EpochApp.of(context);
    _themeMode = app.themeMode;
    _thousandsSep = app.thousandsSep;
    _hourFormat24 = app.hourFormat24;
    _dateWithDetails = app.dateWithDetails;
    _locale = app.locale;
    _lmstMode = app.lmstMode;
    _lmstLongitude = app.lmstLongitude;
    _longitudeController.text = _lmstLongitude?.toStringAsFixed(4) ?? '';
  }

  @override
  void dispose() {
    _longitudeController.dispose();
    super.dispose();
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
      applicationLegalese: l10n.dialogueAboutLegalese,
      children: [
        SizedBox(height: 16),
        Text(l10n.dialogueAbout),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = EpochApp.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pageSettings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.pageSettingsLanguage),
            trailing: DropdownButton<String>(
              value: _locale?.languageCode ?? 'en',
              underline: const SizedBox.shrink(),
              iconEnabledColor: Theme.of(context).colorScheme.primary,
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
            title: Text(l10n.pageSettingsTheme),
            trailing: DropdownButton<AppThemeMode>(
              value: _themeMode,
              underline: const SizedBox.shrink(),
              iconEnabledColor: Theme.of(context).colorScheme.primary,
              items: [
                DropdownMenuItem(
                  value: AppThemeMode.system,
                  child: Text(l10n.pageSettingsThemeSystem),
                ),
                DropdownMenuItem(
                  value: AppThemeMode.light,
                  child: Text(l10n.pageSettingsThemeLight),
                ),
                DropdownMenuItem(
                  value: AppThemeMode.dark,
                  child: Text(l10n.pageSettingsThemeDark),
                ),
                DropdownMenuItem(
                  value: AppThemeMode.night,
                  child: Text(l10n.pageSettingsThemeNight),
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
            title: Text(l10n.pageSettingsHourFormat),
            subtitle: Text(l10n.pageSettingsHourFormatSub),
            value: _hourFormat24,
            onChanged: (val) {
              setState(() => _hourFormat24 = val);
              app.setHourFormat24(val);
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.tag),
            title: Text(l10n.pageSettingsThousandsSep),
            subtitle: Text(l10n.pageSettingsThousandsSepSub),
            value: _thousandsSep,
            onChanged: (val) {
              setState(() => _thousandsSep = val);
              app.setThousandsSep(val);
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.calendar_today),
            title: Text(l10n.pageSettingsDateWithDetails),
            subtitle: Text(l10n.pageSettingsDateWithDetailsSub),
            value: _dateWithDetails,
            onChanged: (val) {
              setState(() => _dateWithDetails = val);
              app.setDateWithDetails(val);
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              l10n.pageSettingsLmst.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 2,
              ),
            ),
          ),
          RadioGroup<LmstMode>(
            groupValue: _lmstMode,
            onChanged: (v) {
              if (v == null) return;
              setState(() => _lmstMode = v);
              app.setLmstMode(v);
            },
            child: Column(
              children: [
                RadioListTile(
                  value: LmstMode.off,
                  title: Text(l10n.settingLmstOff),
                  secondary: const Icon(Icons.visibility_off_outlined),
                ),
                RadioListTile(
                  value: LmstMode.manual,
                  title: Text(l10n.settingLmstLongitudeManual),
                  subtitle: Text(l10n.settingLmstLongitudeManualSub),
                  secondary: const Icon(Icons.edit_location_outlined),
                ),
                if (_lmstMode == LmstMode.manual)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(72, 0, 16, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            decoration: InputDecoration(
                              labelText: l10n.labelLongitude,
                              suffixText: '°',
                              hintText: TimeValueFormatter.formatDecimal(
                                  8.6821,
                                  _locale.toString(),
                                  4,
                                  thousandsSep: false
                              ),
                              isDense: true,
                            ),
                            controller: _longitudeController,
                            onSubmitted: (v) {
                              final normalized = v.replaceAll(',', '.');
                              final lon = double.tryParse(normalized);
                              if (lon != null && lon >= -180 && lon <= 180) {
                                setState(() => _lmstLongitude = lon);
                                app.setLmstLongitude(lon);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            )
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.pageSettingsAbout),
            onTap: () => _showAbout(context, l10n),
          ),
          ListTile(
            leading: const Icon(Icons.new_releases_outlined),
            title: Text(l10n.pageSettingsWhatsNew),
            onTap: () async {
              final uri = Uri.parse(
                  'https://github.com/RealNoitasinagro/epoch/blob/main/CHANGELOG.md');
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
          ),
        ],
      ),
    );
  }
}