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
import '../time_utils.dart';
import '../widgets/clocks/binary_coded_decimal_clock.dart';
import '../widgets/clocks/binary_columns_clock.dart';
import '../widgets/time_string_row.dart';

const _colorOptions = [
  Color(0xFFFFFFFF),  // white
  Color(0xFFCC1010),  // night red
  Color(0xFF00FF41),  // matrix green
  Color(0xFFFFB300),  // amber
  Color(0xFF00E5FF),  // cyan
  Color(0xFFB0B0B0),  // grey
];

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
  late DateTime _now;
  late Timer _timer;
  Color _textColor = Colors.white;

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
    final app = EpochApp.of(context);
    final savedColor = await loadFocusColor(app.isNightMode);
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
    if (mounted) setState(() {
      _brightness = initial;
      _textColor = savedColor;
    });
  }

  Future<void> _saveBrightness(double value) async {
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
    final l10n = AppLocalizations.of(context)!;
    final bool showColorPicker = !widget.timeValue.valueType.isGraphical;

    if (_brightness != null) return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: _exit,
        onTap: _showControls,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // Controls overlay (colors + brightness + hint) – fades in/out together:
            AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: _controlsHideDuration,
              child: SafeArea(
                child: Stack(
                  children: [
                    // Color swatches – top center:
                    if (showColorPicker) Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _colorOptions.map((color) {
                            final isSelected = _textColor == color;
                            return GestureDetector(
                              onTap: () {
                                setState(() => _textColor = color);
                                saveFocusColor(color);
                                _scheduleControlsHide();
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: isSelected ? Colors.white : Colors.transparent,
                                    width: 2.5,
                                  ),
                                  boxShadow: isSelected && _controlsVisible ? [
                                    BoxShadow(color: color.withAlpha(255), blurRadius: 48),
                                  ] : null,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    // Brightness slider + exit hint – bottom center:
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!kIsWeb && _brightness != null) Row(
                              children: [
                                Icon(Icons.brightness_low,
                                    color: _textColor, size: kIconSizeDefault),
                                Expanded(
                                  child: Slider(
                                    value: _brightness!,
                                    min: 0.01,
                                    max: 1.0,
                                    divisions: 20,
                                    label: '${(_brightness! * 100).toInt()} %',
                                    showValueIndicator: ShowValueIndicator.onDrag,
                                    activeColor: _textColor,
                                    inactiveColor: Colors.white24,
                                    onChanged: (v) {
                                      setState(() => _brightness = v);
                                      _saveBrightness(v);
                                      _scheduleControlsHide();
                                    },
                                  ),
                                ),
                                Icon(Icons.brightness_high,
                                    color: _textColor, size: kIconSizeDefault),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.hintFocusScreenExit,
                              style: TextStyle(
                                color: _textColor.withAlpha(150),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Main value display – fills entire screen:
            Center(
              child: _buildValueDisplay(),
            ),
          ],
        ),
      ),
    );
    else {
      return Scaffold();
    }
  }

  Widget _buildValueDisplay() {
    if (widget.timeValue.valueType.isGraphical) {
      final zonedNow = TimeUtils.resolveLocalTime(
          widget.timeValue, _now.toUtc(),
          EpochApp.of(context).localIanaZone);
      final l10n = AppLocalizations.of(context)!;
      final clock = widget.timeValue.valueType == ValueType.binaryClockColumns
          ? BinaryColumnsClock(now: zonedNow, l10n: l10n)
          : BinaryCodedDecimalClock(now: zonedNow, l10n: l10n);
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: FittedBox(fit: BoxFit.contain, child: clock),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          _currentValue(),
          style: TextStyle(
            color: _textColor,
            fontFamily: fontFamilyDefault,
            fontWeight: FontWeight.w500,
            fontSize: 200,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}