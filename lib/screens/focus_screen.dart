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
import '../widgets/clocks/seven_segment_clock.dart';
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
  static const _controlsAutoHideDelay = Duration(seconds: 8);
  static const _controlsHideDuration = Duration(milliseconds: 500);

  late DateTime _now;
  late Timer _timer;
  Color _textColor = Colors.white;
  bool _showLine2 = false;
  bool _showSeconds = true;

  double? _brightness;
  bool _controlsVisible = true;
  Timer? _controlsHideTimer;

  bool get _showColorPicker => true;

  bool get _showBrightnessSlider =>
      !kIsWeb && Platform.isAndroid && _brightness != null;
  bool _sliderActive = false;

  Orientation? _lastOrientation;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1),
            (_) => setState(() => _now = DateTime.now()));
    WakelockPlus.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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

  void _toggleLine2() {
    if (_sliderActive) return;
    setState(() => _showLine2 = !_showLine2);
    _showControls();
  }

  ({String line1, String line2}) _currentDisplay() {
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
      showDateDetails: app.dateWithDetails,
    );
  }

  void _exit() {
    WakelockPlus.disable();
    if (!kIsWeb && !Platform.isLinux) ScreenBrightness().resetApplicationScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Navigator.of(context).pop();
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
    final display = _currentDisplay();
    final hasLine2 = display.line2.isNotEmpty &&
        !widget.timeValue.valueType.isGraphical;

    if (_brightness == null) return const Scaffold(backgroundColor: Colors.black);

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: _exit,
        onTap: _showControls,
        onLongPress: _toggleLine2,
        behavior: HitTestBehavior.opaque,
        child: OrientationBuilder(
          builder: (context, orientation) {
            // Reset hide timer on orientation change:
            if (_lastOrientation != null && _lastOrientation != orientation) {
              // Orientation changed – reset hide timer:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _scheduleControlsHide();
              });
            }
            _lastOrientation = orientation;
            final isLandscape = orientation == Orientation.landscape;
            final mediaPadding = MediaQuery.of(context).padding;
            return Stack(
              fit: StackFit.expand,
              children: [
                // Value display – ALWAYS visible, outside AnimatedOpacity:
                Center(child: _buildValueDisplay(isLandscape)),

                // Controls overlay – fades in/out:
                AnimatedOpacity(
                  opacity: _controlsVisible ? 1.0 : 0.0,
                  duration: _controlsHideDuration,
                  child: isLandscape
                      ? _buildLandscapeControls(
                      l10n, hasLine2, mediaPadding)
                      : _buildPortraitControls(
                      l10n, hasLine2, mediaPadding),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortraitControls(AppLocalizations l10n,
      bool hasLine2, EdgeInsets mediaPadding) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Color swatches – top center:
        if (_showColorPicker) Positioned(
          top: mediaPadding.top + 8,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _colorSwatches(),
          ),
        ),
        // Brightness slider – bottom, above hint:
        if (_showBrightnessSlider) Positioned(
          left: 32,
          right: 32,
          bottom: mediaPadding.bottom + 44,  // above hint text
          child: _brightnessSliderHorizontal(),
        ),
        // Exit hint – bottom center:
        Positioned(
          left: 0,
          right: 0,
          bottom: mediaPadding.bottom + 12,
          child: _exitHint(hasLine2: hasLine2, l10n: l10n),
        ),
      ],
    );
  }

  Widget _buildLandscapeControls(AppLocalizations l10n,
      bool hasLine2, EdgeInsets mediaPadding) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Color swatches – left side, vertically centered:
        if (_showColorPicker) Positioned(
          left: mediaPadding.left + 8,
          top: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: _colorSwatches(vertical: true),
          ),
        ),
        // Brightness slider – right side, vertically centered:
        if (_showBrightnessSlider) Positioned(
          right: mediaPadding.right + 8,
          top: 8,
          bottom: 40,  // above hint
          child: _brightnessSliderVertical(),
        ),
        // Exit hint – bottom center:
        Positioned(
          left: 0,
          right: 0,
          bottom: mediaPadding.bottom + 12,
          child: _exitHint(hasLine2: hasLine2, l10n: l10n),
        ),
      ],
    );
  }

  List<Widget> _colorSwatches({bool vertical = false}) {
    List<Color> colorOptions =
      vertical ? _colorOptions.reversed.toList() : _colorOptions;
    return colorOptions.map((color) {
      final isSelected = _textColor == color;
      return GestureDetector(
        onTap: () {
          setState(() => _textColor = color);
          saveFocusColor(color);
          _scheduleControlsHide();
        },
        child: Container(
          margin: vertical
              ? const EdgeInsets.symmetric(vertical: 6)
              : const EdgeInsets.symmetric(horizontal: 8),
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
            boxShadow: isSelected ? [
              BoxShadow(
                  color: color.withAlpha(200),
                  blurRadius: 12,
                  spreadRadius: 2),
            ] : null,
          ),
        ),
      );
    }).toList();
  }

  Widget _brightnessSliderHorizontal() {
    return Row(
      children: [
        Icon(Icons.brightness_low, color: _textColor, size: kIconSizeDefault),
        Expanded(
          child: Slider(
            value: _brightness!,
            min: 0.01,
            max: 1.0,
            divisions: 20,
            activeColor: _textColor,
            inactiveColor: Colors.white24,
            onChanged: (v) {
              _sliderActive = true;
              setState(() => _brightness = v);
              _saveBrightness(v);
              _scheduleControlsHide();
            },
            onChangeEnd: (_) => _sliderActive = false,
          ),
        ),
        Text(
          '${(_brightness! * 100).toInt()} %',
          style: TextStyle(color: _textColor.withAlpha(180), fontSize: 11),
        ),
        SizedBox(width: 8),
        Icon(Icons.brightness_high, color: _textColor, size: kIconSizeDefault),
      ],
    );
  }

  Widget _brightnessSliderVertical() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.brightness_high, color: _textColor, size: kIconSizeDefault),
        Text(
          '${(_brightness! * 100).toInt()} %',
          style: TextStyle(color: _textColor.withAlpha(180), fontSize: 11),
        ),
        Expanded(
          child: RotatedBox(
            quarterTurns: 3,  // bottom=dark, top=bright
            child: Slider(
              value: _brightness!,
              min: 0.01, max: 1.0, divisions: 20,
              activeColor: _textColor,
              inactiveColor: Colors.white24,
              onChanged: (v) {
                _sliderActive = true;
                setState(() => _brightness = v);
                _saveBrightness(v);
                _scheduleControlsHide();
              },
              onChangeEnd: (_) => _sliderActive = false,
            ),
          ),
        ),
        Icon(Icons.brightness_low, color: _textColor, size: kIconSizeDefault),
      ],
    );
  }

  Widget _exitHint({required bool hasLine2, required AppLocalizations l10n}) {
    final text = hasLine2
        ? _showLine2
        ? '${l10n.hintFocusScreenExit}  ·  ${l10n.hintFocusScreenToggleToOneLine}'
        : '${l10n.hintFocusScreenExit}  ·  ${l10n.hintFocusScreenToggleToTwoLines}'
        : l10n.hintFocusScreenExit;
    return Text(
      text,
      style: TextStyle(color: _textColor.withAlpha(150), fontSize: 12),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildValueDisplay(bool isLandscape) {
    final app = EpochApp.of(context);

    // Horizontal padding: make room for side controls in landscape:
    final hPadding = isLandscape ? 80.0 : 24.0;
    final vPadding = 24.0;

    if (widget.timeValue.valueType.isGraphical) {
      final zonedNow = TimeUtils.resolveLocalTime(
          widget.timeValue, _now.toUtc(),
          EpochApp.of(context).localIanaZone);
      final l10n = AppLocalizations.of(context)!;
      final Widget clock;

      switch (widget.timeValue.valueType) {
        case ValueType.sevenSegmentClock:
          clock = SevenSegmentClock(
            now: zonedNow,
            l10n: l10n,
            digitHeight: kGraphicalSegmentClockHeightFocus,
            showSeconds: _showSeconds,
            hourFormat24: app.hourFormat24,
            color: _textColor,
          );
        case ValueType.binaryClockColumns:
          clock = BinaryColumnsClock(
            now: zonedNow,
            l10n: l10n,
            dotSize: kGraphicalBinaryClockDotSizeFocus,
            showLabels: false,
          );
        case ValueType.binaryClockBcd:
          clock = BinaryCodedDecimalClock(
            now: zonedNow,
            l10n: l10n,
            dotSize: kGraphicalBinaryClockDotSizeFocus,
            showLabels: false,
          );
        default:
          clock = SevenSegmentClock(
            now: zonedNow,
            l10n: l10n,
            digitHeight: kGraphicalSegmentClockHeightFocus,
            showSeconds: _showSeconds,
            hourFormat24: app.hourFormat24,
            color: _textColor,
          );
      }
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: hPadding, vertical: vPadding),
        child: FittedBox(fit: BoxFit.contain, child: clock),
      );
    }

    final display = _currentDisplay();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: hPadding, vertical: vPadding),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              display.line1,
              style: TextStyle(
                color: _textColor,
                fontFamily: fontFamilyDefault,
                fontWeight: FontWeight.w500,
                fontSize: 200,
              ),
              maxLines: 1,
            ),
            if (_showLine2 && display.line2.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                display.line2,
                style: TextStyle(
                  color: _textColor.withAlpha(180),
                  fontFamily: fontFamilyDefault,
                  fontWeight: FontWeight.w400,
                  fontSize: 80,
                ),
                maxLines: 1,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
