import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import '../formatting/value_format_settings.dart';
import '../l10n/app_localizations.dart';
import '../l10n/system_locale.dart';
import '../models/time_value.dart';
import '../screens/focus_screen.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/startup_error_screen.dart';
import '../settings/app_settings.dart';
import '../settings/night_mode_schedule.dart';
import '../time/effective_clock.dart';
import 'app_themes.dart';

class EpochApp extends StatefulWidget {
  const EpochApp({super.key});

  static EpochAppState of(BuildContext context) =>
      context.findAncestorStateOfType<EpochAppState>()!;

  @override
  State<EpochApp> createState() => EpochAppState();
}

class EpochAppState extends State<EpochApp> with WidgetsBindingObserver {
  ({Object error, StackTrace stackTrace})? _startupError;
  bool _settingsLoaded = false;
  bool _splashMinDurationElapsed = false;
  String _localIanaZone = 'UTC';
  Locale _locale = kDefaultLocale;
  AppThemeMode _themeMode = kDefaultThemeMode;
  bool _hourFormat24 = kDefaultHourFormat24;
  bool _thousandsSep = kDefaultThousandsSep;
  bool _dateWithDetails = kDefaultDateWithDetails;
  String _dateFormat = kDatePatternIso;
  String _timeFormat = kTimePatternFull;
  ZoneDisplayMode _zoneDisplayMode = kDefaultZoneDisplayMode;
  bool _dayQuarterColor = kDefaultDayQuarterColor;
  LmstMode _lmstMode = kDefaultLmstMode;
  double? _lmstLongitude;
  String? _lastImportedConfig;
  TimeValue? _startupFocusValue;
  bool _focusTimeShiftIndicator = kDefaultFocusTimeShiftIndicator;
  Set<ValueType> _optionalPartHiddenTypes = {};

  NightModeSchedule _nightModeSchedule = NightModeSchedule.none;
  late bool _nightModeScheduleActive =
      false; // system time is within the window
  Timer? _nightModeTimer;
  bool _nightModeOverridden = false; // the user chose a theme within the window

  /// True while night mode is in effect (chosen or scheduled), for screens
  /// that must react to a change while they are open (Focus screen).
  final ValueNotifier<bool> nightModeNotifier = ValueNotifier(false);

  Key _homeKey = UniqueKey();
  final ValueNotifier<int> settingsReloadNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPreferences();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) setState(() => _splashMinDurationElapsed = true);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _nightModeTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // A timer is not reliable while the device sleeps, and the system time
    // or time zone may have changed meanwhile.
    if (state == AppLifecycleState.resumed) _applyNightModeSchedule();
  }

  /// Checks the system time against the window (not the shifted time: Time
  /// Shift is no reason for a theme change) and waits for the next change.
  void _applyNightModeSchedule() {
    _nightModeTimer?.cancel();
    final now = EffectiveClock.systemTime();
    final scheduleActive = _nightModeSchedule.isNightAt(now);
    if (scheduleActive != _nightModeScheduleActive) {
      setState(() {
        _nightModeScheduleActive = scheduleActive;
        _nightModeOverridden = false; // the choice was for the previous window
      });
    }
    nightModeNotifier.value = isNightMode;
    final nextChange = _nightModeSchedule.nextChangeAfter(now);
    if (nextChange == null) return;
    _nightModeTimer = Timer(
      nextChange.difference(now),
      _applyNightModeSchedule,
    );
  }

  void setNightModeSchedule(NightModeSchedule schedule) {
    setState(() => _nightModeSchedule = schedule);
    saveNightModeSchedule(schedule);
    _applyNightModeSchedule();
  }

  Future<void> reloadPreferences() async {
    await _loadPreferences();
    if (mounted) {
      setState(() => _homeKey = UniqueKey());
      settingsReloadNotifier.value++; // signals SettingsScreen to refresh
    }
  }

  Future<void> _loadPreferences() async {
    try {
      final locale =
          await loadLocale() ?? supportedSystemLocale(fallback: kDefaultLocale);
      final theme = await loadThemeMode();
      final nightModeSchedule = await loadNightModeSchedule();
      final hour24 = await loadHourFormat24();
      final thousands = await loadThousandsSep();
      final dateWithDetails = await loadDateWithDetails();
      final dateFormat = await loadDateFormat();
      final timeFormat = await loadTimeFormat();
      final zoneDisplayMode = await loadZoneDisplayMode();
      final dayQuarterColor = await loadDayQuarterColor();
      final lmstMode = await loadLmstMode();
      final lmstLongitude = await loadLmstLongitude();
      final lastImportedConfig = await loadLastImportedConfig();
      final startupFocusValue = await loadStartupFocusValue();
      final focusTimeShiftIndicator = await loadFocusTimeShiftIndicator();
      final optionalPartHiddenTypes = await loadOptionalPartHiddenTypes();

      String localZone = 'UTC';
      try {
        final TimezoneInfo currentTimeZone =
            await FlutterTimezone.getLocalTimezone();
        localZone = currentTimeZone.identifier;
      } catch (_) {
        localZone = 'UTC';
      }

      setState(() {
        _localIanaZone = localZone;
        _locale = locale;
        _nightModeSchedule = nightModeSchedule;
        _themeMode = theme;
        _hourFormat24 = hour24;
        _thousandsSep = thousands;
        _dateWithDetails = dateWithDetails;
        _dateFormat = dateFormat;
        _timeFormat = timeFormat;
        _zoneDisplayMode = zoneDisplayMode;
        _dayQuarterColor = dayQuarterColor;
        _lmstMode = lmstMode;
        _lmstLongitude = lmstLongitude;
        _lastImportedConfig = lastImportedConfig;
        _startupFocusValue = startupFocusValue;
        _focusTimeShiftIndicator = focusTimeShiftIndicator;
        _optionalPartHiddenTypes = optionalPartHiddenTypes;
        _nightModeOverridden = false;
        _settingsLoaded = true;
      });
    } catch (error, stackTrace) {
      if (mounted) {
        setState(() => _startupError = (error: error, stackTrace: stackTrace));
      }
    }
    _applyNightModeSchedule();
  }

  void setLocale(Locale l) {
    setState(() => _locale = l);
    saveLocale(l.languageCode);
  }

  void setThemeMode(AppThemeMode mode) {
    setState(() {
      _themeMode = mode;
      // An explicit choice within the window wins until the window ends.
      if (_nightModeScheduleActive) _nightModeOverridden = true;
    });
    saveThemeMode(mode);
    nightModeNotifier.value = isNightMode;
  }

  void setHourFormat24(bool v) {
    setState(() => _hourFormat24 = v);
    saveHourFormat24(v);
  }

  void setThousandsSep(bool v) {
    setState(() => _thousandsSep = v);
    saveThousandsSep(v);
  }

  void setDateWithDetails(bool v) {
    setState(() => _dateWithDetails = v);
    saveDateWithDetails(v);
  }

  void setDateFormat(String pattern) {
    setState(() => _dateFormat = pattern);
    saveDateFormat(pattern);
  }

  void setTimeFormat(String pattern) {
    setState(() => _timeFormat = pattern);
    saveTimeFormat(pattern);
  }

  void setZoneDisplayMode(ZoneDisplayMode mode) {
    setState(() => _zoneDisplayMode = mode);
    saveZoneDisplayMode(mode);
  }

  void setDayQuarterColor(bool v) {
    setState(() => _dayQuarterColor = v);
    saveDayQuarterColor(v);
  }

  void setLmstMode(LmstMode mode) {
    setState(() => _lmstMode = mode);
    saveLmstMode(mode);
  }

  void setLmstLongitude(double? lon) {
    setState(() => _lmstLongitude = lon);
    if (lon != null) saveLmstLongitude(lon);
  }

  void setLastImportedConfig(String filename) {
    setState(() => _lastImportedConfig = filename);
    saveLastImportedConfig(filename);
  }

  void setFocusTimeShiftIndicator(bool v) {
    setState(() => _focusTimeShiftIndicator = v);
    saveFocusTimeShiftIndicator(v);
  }

  void setOptionalPartHiddenTypes(Set<ValueType> valueTypes) {
    setState(() => _optionalPartHiddenTypes = valueTypes);
    saveOptionalPartHiddenTypes(valueTypes);
  }

  /// The zone of the device, whatever Time Shift says.
  String get systemIanaZone => _localIanaZone;

  /// The zone "local" stands for: the zone of the device, unless Time Shift
  /// has redefined it.
  String get localIanaZone =>
      EffectiveClock.virtualLocalIanaZone ?? _localIanaZone;

  Locale? get locale => _locale;

  /// The theme in effect: night mode within the night mode window (unless the
  /// user chose a theme meanwhile), otherwise the user's choice.
  AppThemeMode get themeMode =>
      _nightModeScheduleActive && !_nightModeOverridden
      ? AppThemeMode.night
      : _themeMode;

  /// The user's own choice, which the night mode window never changes.
  AppThemeMode get userThemeMode => _themeMode;

  NightModeSchedule get nightModeSchedule => _nightModeSchedule;

  ThemeMode get _flutterThemeMode => switch (themeMode) {
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
    AppThemeMode.night => ThemeMode.dark,
    AppThemeMode.system => ThemeMode.system,
  };

  bool get isNightMode => themeMode == AppThemeMode.night;

  bool get dayQuarterColor => _dayQuarterColor;
  LmstMode get lmstMode => _lmstMode;
  double? get lmstLongitude => _lmstLongitude;
  String? get lastImportedConfig => _lastImportedConfig;
  bool get focusTimeShiftIndicator => _focusTimeShiftIndicator;

  ValueFormatSettings get formatSettings {
    return ValueFormatSettings(
      hourFormat24: _hourFormat24,
      thousandsSep: _thousandsSep,
      dateFormat: _dateFormat,
      timeFormat: _timeFormat,
      zoneDisplayMode: _zoneDisplayMode,
      dateWithDetails: _dateWithDetails,
      localIanaZone: localIanaZone,
      longitude: _lmstLongitude,
      optionalPartHiddenTypes: _optionalPartHiddenTypes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final showSplash = !_settingsLoaded || !_splashMinDurationElapsed;
    return MaterialApp(
      title: 'Epoch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      darkTheme: isNightMode ? buildNightTheme() : buildDarkTheme(),
      themeMode: showSplash ? ThemeMode.dark : _flutterThemeMode,
      locale: showSplash ? null : _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: _startupError != null
          ? StartupErrorScreen(
              error: _startupError!.error,
              stackTrace: _startupError!.stackTrace,
            )
          : showSplash
          ? const SplashScreen()
          : (_startupFocusValue != null
                ? FocusScreen(
                    timeValue: _startupFocusValue!,
                    locale: _locale.languageCode,
                  )
                : HomeScreen(key: _homeKey)),
    );
  }
}
