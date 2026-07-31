import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../l10n/app_localizations.dart';
import '../models/app_settings.dart';
import '../models/settings_io.dart';
import '../services/location_service.dart';
import '../time_value_formatter.dart';
import '../widgets/section_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Locale? _locale;
  late AppThemeMode _themeMode;
  late bool _hourFormat24;
  late bool _thousandsSep;
  late bool _dateWithDetails;
  String _dateFormat = kDatePatternIso;
  String _timeFormat = kTimePatternFull;
  late ZoneDisplayMode _zoneDisplayMode;
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
    final app = EpochApp.of(context);
    setState(() {
      _locale = app.locale;
      _themeMode = app.themeMode;
      _hourFormat24 = app.hourFormat24;
      _thousandsSep = app.thousandsSep;
      _dateWithDetails = app.dateWithDetails;
      _dateFormat = app.dateFormat;
      _timeFormat = app.timeFormat;
      _zoneDisplayMode = app.zoneDisplayMode;
      _lmstMode = app.lmstMode;
      _lmstLongitude = app.lmstLongitude;
      _longitudeController.text = _lmstLongitude?.toStringAsFixed(4) ?? '';
    });
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

  Future<void> _determineLocation() async {
    final l10n = AppLocalizations.of(context)!;
    final longitude = await LocationService.getLastKnownLongitude();
    if (longitude == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.settingsLmstLongitudeUnavailable),
          duration: const Duration(seconds: 8),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _lmstLongitude = longitude);
    EpochApp.of(context).setLmstLongitude(longitude);
    _longitudeController.text = longitude.toStringAsFixed(4);
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
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(l10n.settingsDateFormat),
            subtitle: Text(_dateFormat, style: TextStyle(fontFamily: fontFamilyDefault)),
            onTap: () => _showFormatPicker(context, l10n, isDate: true),
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text(l10n.settingsTimeFormat),
            subtitle: Text(_timeFormat, style: TextStyle(fontFamily: fontFamilyDefault)),
            onTap: () => _showFormatPicker(context, l10n, isDate: false),
          ),
          ListTile(
            leading: const Icon(Icons.format_list_numbered),
            title: Text(l10n.settingsZoneDisplayMode),
            subtitle: Text(l10n.settingsZoneDisplayModeSub),
            trailing: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 184),
              child: DropdownButton<ZoneDisplayMode>(
                isExpanded: true,
                value: _zoneDisplayMode,
                underline: const SizedBox.shrink(),
                iconEnabledColor: Theme.of(context).colorScheme.primary,
                items: [
                  DropdownMenuItem(
                    value: ZoneDisplayMode.full,
                    child: Text(l10n.settingsZoneDisplayModeFull),
                  ),
                  DropdownMenuItem(
                    value: ZoneDisplayMode.abbreviation,
                    child: Text(l10n.settingsZoneDisplayModeAbbreviation),
                  ),
                  DropdownMenuItem(
                    value: ZoneDisplayMode.offsetLong,
                    child: Text(l10n.settingsZoneDisplayModeOffsetLong),
                  ),
                  DropdownMenuItem(
                    value: ZoneDisplayMode.offsetShort,
                    child: Text(l10n.settingsZoneDisplayModeOffsetShort),
                  ),
                  DropdownMenuItem(
                    value: ZoneDisplayMode.offsetMini,
                    child: Text(l10n.settingsZoneDisplayModeOffsetMini),
                  ),
                  DropdownMenuItem(
                    value: ZoneDisplayMode.hidden,
                    child: Text(l10n.settingsZoneDisplayModeHidden),
                  ),
                ],
                onChanged: (mode) {
                  if (mode == null) return;
                  setState(() => _zoneDisplayMode = mode);
                  app.setZoneDisplayMode(mode);
                },
              ),
            ),
          ),
          const Divider(height: kDividerHeight),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                kTabHorizontalPadding, 0,
                kTabHorizontalPadding, 0,
            ),
            child: SectionHeader(label: l10n.settingsLmst),
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
                  title: Text(l10n.settingsLmstOff),
                  secondary: const Icon(Icons.visibility_off_outlined),
                ),
                RadioListTile(
                  value: LmstMode.manual,
                  title: Text(l10n.settingsLmstLongitudeManual),
                  subtitle: Text(l10n.settingsLmstLongitudeManualSub),
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
                if (!_isDesktop) ...[
                  RadioListTile<LmstMode>(
                    value: LmstMode.locationAccess,
                    title: Text(l10n.settingsLmstLongitudeAuto),
                    subtitle: Text(l10n.settingsLmstLongitudeAutoSub),
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
                            Text(l10n.settingsLmstLongitudeNotYetDetermined,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withAlpha(150))),
                          const SizedBox(width: 12),
                          TextButton.icon(
                            icon: const Icon(Icons.refresh, size: 16),
                            label: Text(l10n.settingsLmstLongitudeDetermineLocation),
                            onPressed: _locationLoading ? null
                                : () => _determineLocation(),
                          ),
                        ],
                      ),
                    ),
                ],
              ],
            )
          ),
          const Divider(height: kDividerHeight),
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
          const Divider(height: kDividerHeight),
          ListTile(
            leading: const Icon(Icons.download),
            title: Text(l10n.settingsPreferencesExport),
            onTap: () async => await exportSettings(context),
          ),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: Text(l10n.settingsPreferencesImport),
            onTap: () async => await importSettings(context),
          ),
          ListTile(
            leading: const Icon(Icons.restart_alt),
            title: Text(l10n.settingsPreferencesReset),
            onTap: () async => await resetSettings(context),
          )
        ],
      ),
    );
  }

  Future<void> _showFormatPicker(BuildContext context,
      AppLocalizations l10n, {required bool isDate}) async {
    final presets = isDate
        ? [kDatePatternIso, kDatePatternDe, kDatePatternUk,
      kDatePatternUs, kDatePatternIsoTight, kDatePatternCompact]
        : [kTimePatternFull, kTimePatternNoSeconds,
      kTimePatternNoLeadingZero, kTimePatternCompact];

    final current = isDate ? _dateFormat : _timeFormat;
    // If current is a custom pattern, start with it; otherwise start with preset:
    String selected = current;

    final confirmed = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final isCustom = !presets.contains(selected);

          return AlertDialog(
            title: Text(isDate
                ? l10n.settingsDateFormat
                : l10n.settingsTimeFormat),
            content: SingleChildScrollView(
              child: RadioGroup<String>(
                groupValue: isCustom ? '__custom__' : selected,
                onChanged: (v) async {
                  if (v == '__custom__') {
                    // Open custom dialog with current pattern as starting point:
                    final custom = await _showCustomFormatDialog(
                        ctx, l10n, selected, isDate);
                    if (custom != null) setDialogState(() => selected = custom);
                  } else if (v != null) {
                    setDialogState(() => selected = v);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Preset options:
                    ...presets.map((pattern) => RadioListTile(
                      value: pattern,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        _formatPreview(pattern, isDate, l10n.localeName),
                        style: const TextStyle(fontFamily: fontFamilyDefault),
                      ),
                      subtitle: Text(
                        pattern,
                        style: TextStyle(
                          fontFamily: fontFamilyDefault,
                          fontSize: 10,
                          color: Theme.of(ctx).colorScheme.onSurface.withAlpha(120),
                        ),
                      ),
                    )),
                    // Custom option:
                    RadioListTile(
                      value: '__custom__',
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(l10n.settingsCustomFormat),
                      subtitle: isCustom
                          ? Text(
                        '${_formatPreview(selected, isDate, l10n.localeName)}'
                            '  ($selected)',
                        style: TextStyle(
                          fontFamily: fontFamilyDefault,
                          fontSize: 10,
                          color: Theme.of(ctx).colorScheme.onSurface.withAlpha(120),
                        ),
                      )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l10n.actionCancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, selected),
                child: const Text('OK'),
              ),
            ],
          );
        },
      ),
    );

    if (confirmed == null || confirmed == current) return;
    if (!context.mounted) return;
    setState(() {
      if (isDate) {
        _dateFormat = confirmed;
        EpochApp.of(context).setDateFormat(confirmed);
      } else {
        _timeFormat = confirmed;
        EpochApp.of(context).setTimeFormat(confirmed);
      }
    });
  }

  String _formatPreview(String pattern, bool isDate, String locale) {
    final reference = DateTime.now().copyWith(hour: 8, minute: 14, second: 27);
    if (isDate) {
      return TimeValueFormatter.formatDatePattern(reference, pattern, locale);
    }
    return TimeValueFormatter.formatTimePattern(reference, pattern,
        hourFormat24: _hourFormat24);
  }

  Future<String?> _showCustomFormatDialog(
      BuildContext context, AppLocalizations l10n,
      String initialPattern, bool isDate) async {
    final locale = Localizations.localeOf(context).toString();
    final controller = TextEditingController(text: initialPattern);
    final previewNow = DateTime.now();
    final referenceDateTime = DateTime(2026, 5, 1, 8, 14, 27);
    final tokenRows = isDate
        ? [
            ('YYYY', TimeValueFormatter.formatDatePattern(referenceDateTime, 'YYYY', locale)),
            ('YY',   TimeValueFormatter.formatDatePattern(referenceDateTime, 'YY',   locale)),
            ('MM',   TimeValueFormatter.formatDatePattern(referenceDateTime, 'MM',   locale)),
            ('M',    TimeValueFormatter.formatDatePattern(referenceDateTime, 'M',    locale)),
            ('MMM',  TimeValueFormatter.formatDatePattern(referenceDateTime, 'MMM',  locale)),
            ('MMMM', TimeValueFormatter.formatDatePattern(referenceDateTime, 'MMMM', locale)),
            ('DD',   TimeValueFormatter.formatDatePattern(referenceDateTime, 'DD',   locale)),
            ('D',    TimeValueFormatter.formatDatePattern(referenceDateTime, 'D',    locale)),
            ('EEE',  TimeValueFormatter.formatDatePattern(referenceDateTime, 'EEE',  locale)),
            ('EEEE', TimeValueFormatter.formatDatePattern(referenceDateTime, 'EEEE', locale)),
          ]
        : [
            ('HH', TimeValueFormatter.formatTimePattern(referenceDateTime, 'HH', hourFormat24: _hourFormat24)),
            ('H',  TimeValueFormatter.formatTimePattern(referenceDateTime, 'H',  hourFormat24: _hourFormat24)),
            ('mm', TimeValueFormatter.formatTimePattern(referenceDateTime, 'mm', hourFormat24: _hourFormat24)),
            ('ss', TimeValueFormatter.formatTimePattern(referenceDateTime, 'ss', hourFormat24: _hourFormat24)),
          ];

    return showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final error = TimeValueFormatter.validatePattern(
              controller.text, isDate);
          final preview = error == null
              ? (isDate
                ? TimeValueFormatter.formatDatePattern(
                  previewNow, controller.text, l10n.localeName)
                : TimeValueFormatter.formatTimePattern(
                  previewNow, controller.text,
                  hourFormat24: _hourFormat24))
              : null;

          return AlertDialog(
            title: Text(isDate
                ? l10n.settingsDateFormat
                : l10n.settingsTimeFormat),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(60),
                    1: FlexColumnWidth(),
                  },
                  children: tokenRows.map<TableRow>(((String, String) row) =>
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(row.$1,
                            style: TextStyle(
                              fontFamily: fontFamilyDefault,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(row.$2,
                            style: TextStyle(
                              fontFamily: fontFamilyDefault,
                              fontSize: 11,
                              color: Theme.of(ctx).colorScheme.onSurface.withAlpha(180),
                            ),
                          ),
                        ),
                      ])
                  ).toList(),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller,
                  autofocus: true,
                  onChanged: (_) => setDialogState(() {}),
                  style: const TextStyle(fontFamily: fontFamilyDefault),
                  decoration: InputDecoration(
                    labelText: l10n.settingsCustomFormat,
                    errorText: error,
                  ),
                ),
                if (preview != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    preview,
                    style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontFamily: fontFamilyDefault,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l10n.actionCancel),
              ),
              TextButton(
                onPressed: error != null
                    ? null
                    : () => Navigator.pop(ctx, controller.text.trim()),
                child: const Text('OK'),
              ),
            ],
          );
        },
      ),
    );
  }
}
