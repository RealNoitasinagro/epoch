import 'dart:async';
import 'dart:io';
import 'package:epoch/models/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/time_value.dart';
import '../widgets/time_string_row.dart';

class FocusScreen extends StatefulWidget {
  final TimeValue timeValue;
  final String locale;

  const FocusScreen({
    super.key,
    required this.timeValue,
    required this.locale,
  });

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  late Timer _timer;
  late DateTime _now;

  // Brightness control:
  double? _brightness;
  bool _controlsVisible = true;
  Timer? _controlsHideTimer;

  static const _controlsAutoHideDelay = Duration(seconds: 8);
  static const _controlsHideDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1),
            (_) => setState(() => _now = DateTime.now()));
    WakelockPlus.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _scheduleControlsHide();
    _initBrightness();
  }

  Future<void> _initBrightness() async {
    double initial;
    try {
      final saved = await loadFocusBrightness();
      if (saved != null) {
        initial = saved;
        if (!kIsWeb && !Platform.isLinux) {
          await ScreenBrightness().setApplicationScreenBrightness(initial);
        }
      } else {
        initial = (!kIsWeb && !Platform.isLinux)
            ? await ScreenBrightness().application
            : 1.0;
      }
    } catch (_) {
      initial = 1.0;
    }
    if (mounted) setState(() => _brightness = initial);
  }

  Future<void> _saveBrightness(double value) async {
    // Persisted via SharedPreferences in app_settings.dart –
    // add kFocusBrightnessKey there alongside other settings.
    // For now handled inline via EpochApp:
    try {
      await ScreenBrightness().setApplicationScreenBrightness(value);
      await saveFocusBrightness(value);
    } catch (_) {}
  }

  void _scheduleControlsHide() {
    _controlsHideTimer?.cancel();
    _controlsHideTimer = Timer(_controlsAutoHideDelay, () {
      if (mounted) setState(() => _controlsVisible = false);
    });
  }

  void _showControls() {
    setState(() => _controlsVisible = true);
    _scheduleControlsHide();
  }

  void _exit() {
    WakelockPlus.disable();
    if (!kIsWeb && !Platform.isLinux) ScreenBrightness().resetApplicationScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Navigator.of(context).pop();
  }

  String _currentValue() {
    final app = EpochApp.of(context);
    return TimeStringRow.computeDisplay(
      widget.timeValue,
      _now,
      widget.locale,
      AppLocalizations.of(context)!,
      hourFormat24: app.hourFormat24,
      thousandsSep: app.thousandsSep,
      localIanaZone: app.localIanaZone,
      longitude: app.lmstLongitude,
      showDateDetails: false,
    ).line1;
  }

  @override
  void dispose() {
    _timer.cancel();
    _controlsHideTimer?.cancel();
    // Cleanup is in _exit(); if disposed without _exit (e.g. back button),
    // restore here too:
    WakelockPlus.disable();
    if (!kIsWeb && !Platform.isLinux) ScreenBrightness().resetApplicationScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = _currentValue();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: _exit,
        onTap: _showControls,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // Main value display – fills entire screen:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: fontFamilyDefault,
                      fontWeight: FontWeight.w500,
                      // Base size – FittedBox scales this to fill available space:
                      fontSize: 200,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),

            // Controls overlay – fades in/out:
            AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: _controlsHideDuration,
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Brightness label:
                        if (!kIsWeb && !Platform.isLinux)
                        //if (!kIsWeb)
                          if (_brightness != null) Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.brightness_low,
                                  color: Colors.white54, size: kIconSizeDefault),
                              Expanded(
                                child: Slider(
                                  value: _brightness!,
                                  min: 0.01,  // avoid full black
                                  max: 1.0,
                                  divisions: 20,
                                  label: (_brightness! * 100).toInt().toString() + ' %',
                                  showValueIndicator: ShowValueIndicator.onDrag,
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white24,
                                  onChanged: (v) {
                                    setState(() => _brightness = v);
                                    _saveBrightness(v);
                                    _scheduleControlsHide();
                                  },
                                ),
                              ),
                              const Icon(Icons.brightness_high,
                                  color: Colors.white54, size: kIconSizeDefault),
                            ],
                          ),
                        const SizedBox(height: 8),
                        // Exit hint:
                        Text(
                          l10n.hintFocusScreenExit,
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}