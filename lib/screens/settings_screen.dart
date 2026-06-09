import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  bool _locationLoading = false;
  final _longitudeController = TextEditingController();

  static const _fallbackVersion = '1.0.0';

  bool get _isDesktop =>
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS;

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
      applicationLegalese: l10n.aboutLegalese,
      children: [
        SizedBox(height: 16),
        Text(l10n.aboutDescription),
      ],
    );
  }

  Future<void> _determineLocation(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _locationLoading = true);
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.lmstLocationDenied)),
        );
        return;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,  // COARSE is sufficient
        ),
      );
      final lon = double.parse(pos.longitude.toStringAsFixed(4));
      setState(() => _lmstLongitude = lon);
      EpochApp.of(context).setLmstLongitude(lon);
    } finally {
      setState(() => _locationLoading = false);
    }
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
            title: Text(l10n.settingsTheme),
            trailing: DropdownButton<AppThemeMode>(
              value: _themeMode,
              underline: const SizedBox.shrink(),
              iconEnabledColor: Theme.of(context).colorScheme.primary,
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
          SwitchListTile(
            secondary: const Icon(Icons.calendar_today),
            title: Text(l10n.settingsDateWithDetails),
            subtitle: Text(l10n.settingsDateWithDetailsSub),
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
              l10n.settingsLmst,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 1.5,
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
                  title: Text(l10n.lmstModeOff),
                  secondary: const Icon(Icons.visibility_off_outlined),
                ),
                RadioListTile(
                  value: LmstMode.manual,
                  title: Text(l10n.lmstModeManual),
                  subtitle: Text(l10n.lmstModeManualSub),
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
                              labelText: l10n.lmstLongitudeLabel,
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
                if (!_isDesktop) ...[
                  RadioListTile<LmstMode>(
                    value: LmstMode.locationAccess,
                    title: Text(l10n.lmstModeLocation),
                    subtitle: Text(l10n.lmstModeLocationSub),
                    secondary: const Icon(Icons.my_location),
                  ),
                  if (_lmstMode == LmstMode.locationAccess)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(72, 0, 16, 8),
                      child: Row(
                        children: [
                          if (_locationLoading)
                            const SizedBox(
                              width: 20, height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          else if (_lmstLongitude != null)
                            Text(
                              TimeValueFormatter.formatDecimal(
                                  _lmstLongitude!,
                                  _locale.toString(),
                                  4,
                                  thousandsSep: false
                              ),
                              style: Theme.of(context).textTheme.bodyMedium
                            )
                          else
                            Text(l10n.lmstLocationNotYetDetermined,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withAlpha(150))),
                          const SizedBox(width: 12),
                          TextButton.icon(
                            icon: const Icon(Icons.refresh, size: 16),
                            label: Text(l10n.lmstDetermineLocation),
                            onPressed: _locationLoading ? null
                                : () => _determineLocation(context),
                          ),
                        ],
                      ),
                    ),
                ],
              ],
            )
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.settingsAbout),
            onTap: () => _showAbout(context, l10n),
          ),
          ListTile(
            leading: const Icon(Icons.new_releases_outlined),
            title: Text(l10n.settingsWhatsNew),
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