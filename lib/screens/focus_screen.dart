import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/app_settings.dart';
import '../models/time_value.dart';
import '../time_utils.dart';
import '../widgets/clocks/binary_coded_decimal_clock.dart';
import '../widgets/clocks/binary_columns_clock.dart';
import '../widgets/clocks/seven_segment_clock.dart';
import '../widgets/time_string_row.dart';

const _colorOptions = [
  kColorWhite,
  kColorNightRed,
  kColorMatrixGreen,
  kColorAmber,
  kColorCyan,
  kColorGrey,
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
  late bool _showSeconds;

  double? _brightness;
  bool _controlsVisible = true;
  Timer? _controlsHideTimer;

  final _valueDisplayKey = GlobalKey();
  bool _pixelShiftEnabled = kDefaultFocusPixelShift;
  int _pixelShiftDirection = 1;  // +1 or -1
  int _pixelShiftIndex = 0;
  bool _pixelShiftInitialized = false;
  double _pixelShiftOffsetY = 0;
  Timer? _pixelShiftTimer;
  static const _pixelShiftInterval = Duration(seconds: 180);
  static const _safetyMargin = 8.0;  // extra breathing room, both ends

  double? _measuredContentHeight;
  double get _topReservedForShift =>
      _lastOrientation == Orientation.landscape ? 40.0 : 80.0;
  double get _bottomReservedForShift =>
      _lastOrientation == Orientation.landscape ? 56.0 : 64.0;

  List<double> get _pixelShiftLevels {
    final screenHeight = MediaQuery.of(context).size.height;
    final contentHeight = _measuredContentHeight ?? 0;
    final available = screenHeight
        - _topReservedForShift
        - _bottomReservedForShift
        - contentHeight;
    final maxOffset = ((available / 2) - _safetyMargin).clamp(0.0, double.infinity);

    if (maxOffset < 2) return const [0.0];
    const targetStepSize = 18.0;  // aim for ~18px between adjacent levels
    final halfSteps = (maxOffset / targetStepSize).floor().clamp(1, 6);
    final steps = halfSteps * 2 + 1;  // odd count, always includes center (0.0)
    return List.generate(
        steps, (i) => -maxOffset + (2 * maxOffset * i / (steps - 1))
    );
  }

  bool get _showBrightnessSlider =>
      !kIsWeb && Platform.isAndroid && _brightness != null;
  bool _sliderActive = false;

  Orientation? _lastOrientation;

  @override
  void initState() {
    super.initState();
    _showSeconds = widget.timeValue.showSeconds;
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1),
            (_) => setState(() => _now = DateTime.now()));
    WakelockPlus.enable();
    _initPixelShift();
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

  void _remeasureContent() {
    final box = _valueDisplayKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final height = (box.size.height / 4).round() * 4.0;  // quantize to 4px steps
    if (height != _measuredContentHeight) {
      setState(() {
        _measuredContentHeight = height;
        if (_pixelShiftEnabled && _pixelShiftInitialized) _resetPixelShiftPosition();
      });
    }
  }

  Future<void> _initPixelShift() async {
    final enabled = await loadFocusPixelShift();
    if (!mounted) return;
    setState(() => _pixelShiftEnabled = enabled);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _resetPixelShiftPosition();  // context/MediaQuery is safe here
      _pixelShiftInitialized = true;
      if (enabled) _startPixelShiftTimer();
    });
  }

  void _startPixelShiftTimer() {
    _pixelShiftTimer?.cancel();
    _pixelShiftTimer = Timer.periodic(_pixelShiftInterval, (_) => _rerollPixelShift());
  }

  void _rerollPixelShift() {
    if (!mounted) return;
    final levels = _pixelShiftLevels;
    var currentIndex = _pixelShiftIndex.clamp(0, levels.length - 1);
    var nextIndex = currentIndex + _pixelShiftDirection;
    if (nextIndex >= levels.length) {
      nextIndex = (levels.length - 2).clamp(0, levels.length - 1);
      _pixelShiftDirection = -1;
    } else if (nextIndex < 0) {
      nextIndex = (levels.length > 1 ? 1 : 0);
      _pixelShiftDirection = 1;
    }
    setState(() {
      _pixelShiftIndex = nextIndex;
      _pixelShiftOffsetY = levels[nextIndex];
    });
  }

  void _togglePixelShift() {
    final enabled = !_pixelShiftEnabled;
    setState(() {
      _pixelShiftEnabled = enabled;
      if (!enabled) {
        _pixelShiftOffsetY = 0;
        _resetPixelShiftPosition();
      }
    });
    saveFocusPixelShift(enabled);
    if (enabled) {
      _startPixelShiftTimer();
    } else {
      _pixelShiftTimer?.cancel();
    }
    _scheduleControlsHide();
  }

  void _resetPixelShiftPosition() {
    final levels = _pixelShiftLevels;
    _pixelShiftIndex = levels.length ~/ 2;
    _pixelShiftOffsetY = levels[_pixelShiftIndex];
    _pixelShiftDirection = 1;
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
            : kDefaultFocusBrightness;
      }
    } catch (_) {
      initial = kDefaultFocusBrightness;
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

  void _toggleSeconds() {
    setState(() => _showSeconds = !_showSeconds);
    _showControls();
  }

  ({String line1, String line2}) _currentDisplay() {
    final app = EpochApp.of(context);

    // For swatchBeats, override showSeconds with volatile _showSeconds:
    final effectiveTimeValue = (
        widget.timeValue.valueType == ValueType.swatchBeats
    ) ? widget.timeValue.withShowSeconds(_showSeconds)
        : widget.timeValue;

    return TimeStringRow.computeDisplay(
      effectiveTimeValue,
      _now,
      widget.locale,
      AppLocalizations.of(context)!,
      localIanaZone: app.localIanaZone,
      hourFormat24: app.hourFormat24,
      thousandsSep: app.thousandsSep,
      showDateDetails: app.dateWithDetails,
      dateFormat: app.dateFormat,
      timeFormat: app.timeFormat,
      zoneDisplayMode: app.zoneDisplayMode,
      longitude: app.lmstLongitude,
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
    _pixelShiftTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _remeasureContent());

    final l10n = AppLocalizations.of(context)!;
    final display = _currentDisplay();
    final hasLine2 = display.line2.isNotEmpty
        && !widget.timeValue.valueType.isGraphical;
    final handleSeconds =
      widget.timeValue.valueType == ValueType.swatchBeats
        ? 'swatchBeats'
        : widget.timeValue.valueType.isGraphical
          ? 'isGraphical'
          : '';

    if (_brightness == null) {
      return const Scaffold(backgroundColor: Colors.black);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: _exit,
        onTap: _showControls,
        onLongPress:
          handleSeconds == 'swatchBeats' || handleSeconds == 'isGraphical'
            ? _toggleSeconds : _toggleLine2,
        behavior: HitTestBehavior.opaque,
        child: OrientationBuilder(
          builder: (context, orientation) {
            // Reset hide timer on orientation change:
            if (_lastOrientation != null && _lastOrientation != orientation) {
              // Orientation changed – reset hide timer:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _scheduleControlsHide();
              });
              // Level set may differ (graphical clocks have tighter
              // portrait/landscape ranges) – recenter to stay safe:
              _pixelShiftIndex = _pixelShiftLevels.length ~/ 2;
              _pixelShiftOffsetY = 0;
              _pixelShiftDirection = 1;
            }
            _lastOrientation = orientation;
            final isLandscape = orientation == Orientation.landscape;
            final mediaPadding = MediaQuery.of(context).padding;
            return Stack(
              fit: StackFit.expand,
              children: [
                _pixelShiftDebugOverlay(),
                // Value display – ALWAYS visible, outside AnimatedOpacity:
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    transform: Matrix4.translationValues(
                        0, _pixelShiftOffsetY, 0),
                    child: _buildValueDisplay(isLandscape),
                  ),
                ),
                // Controls overlay – fades in/out:
                AnimatedOpacity(
                  opacity: _controlsVisible ? 1.0 : 0.0,
                  duration: _controlsHideDuration,
                  child: isLandscape
                      ? _buildLandscapeControls(
                      l10n, hasLine2, handleSeconds, mediaPadding)
                      : _buildPortraitControls(
                      l10n, hasLine2, handleSeconds, mediaPadding),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortraitControls(AppLocalizations l10n,
      bool hasLine2, String handleSeconds, EdgeInsets mediaPadding) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Color swatches – top center:
        Positioned(
          top: mediaPadding.top + 8,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._colorSwatches(),
              const SizedBox(width: 16),
              _pixelShiftToggle(l10n),
            ],
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
          child: _exitHint(
              hasLine2: hasLine2,
              handleSeconds: handleSeconds,
              l10n: l10n
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeControls(AppLocalizations l10n,
      bool hasLine2, String handleSeconds, EdgeInsets mediaPadding) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Color swatches – left side, vertically centered:
        Positioned(
          left: mediaPadding.left + 8,
          top: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _pixelShiftToggle(l10n),
              const SizedBox(height: 16),
              ..._colorSwatches(vertical: true),
            ]
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
          child: _exitHint(
              hasLine2: hasLine2,
              handleSeconds: handleSeconds,
              l10n: l10n
          ),
        ),
      ],
    );
  }

  Widget _pixelShiftToggle(AppLocalizations l10n) {
    return IconButton(
      icon: Icon(
        _pixelShiftEnabled ? Icons.blur_on : Icons.blur_off,
        color: _textColor,
        size: 28,
      ),
      tooltip: _pixelShiftEnabled
          ? l10n.hintPixelShiftOn
          : l10n.hintPixelShiftOff,
      onPressed: _togglePixelShift,
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

  Widget _exitHint(
        {required bool hasLine2, required String handleSeconds,
         required AppLocalizations l10n}
      ) {
    final String text;
    if (!hasLine2 && handleSeconds == 'swatchBeats') {
      text = !_showSeconds
          ? '${l10n.hintFocusScreenExit}  ·  ${l10n.hintFocusScreenToggleDecimalsOn}'
          : '${l10n.hintFocusScreenExit}  ·  ${l10n.hintFocusScreenToggleDecimalsOff}';
    } else if (!hasLine2 && handleSeconds == 'isGraphical') {
      text = !_showSeconds
          ? '${l10n.hintFocusScreenExit}  ·  ${l10n.hintFocusScreenToggleSecondsOn}'
          : '${l10n.hintFocusScreenExit}  ·  ${l10n.hintFocusScreenToggleSecondsOff}';
    }
    else if (hasLine2 && handleSeconds.isEmpty) {
      text = _showLine2
          ? '${l10n.hintFocusScreenExit}  ·  ${l10n.hintFocusScreenToggleToOneLine}'
          : '${l10n.hintFocusScreenExit}  ·  ${l10n.hintFocusScreenToggleToTwoLines}';
    } else {
      text = l10n.hintFocusScreenExit;
    }

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

      final Widget clock = switch (widget.timeValue.valueType) {
        ValueType.sevenSegmentClock =>
          SevenSegmentClock(
            now: zonedNow,
            l10n: l10n,
            digitHeight: kGraphicalSegmentClockHeightFocus,
            showSeconds: _showSeconds,
            hourFormat24: app.hourFormat24,
            color: _textColor,
          ),
        ValueType.binaryClockColumns =>
          BinaryColumnsClock(
            now: zonedNow,
            l10n: l10n,
            dotSize: kGraphicalBinaryClockDotSizeFocus,
            showSeconds: _showSeconds,
            showLabels: false,
          ),
        ValueType.binaryClockBcd =>
          BinaryCodedDecimalClock(
            now: zonedNow,
            l10n: l10n,
            dotSize: kGraphicalBinaryClockDotSizeFocus,
            showSeconds: _showSeconds,
            showLabels: false,
          ),
        _ => throw StateError(
            'Unhandled graphical ValueType: ${widget.timeValue.valueType}'),
      };
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: hPadding, vertical: vPadding),
        child: FittedBox(fit: BoxFit.contain, key: _valueDisplayKey, child: clock),
      );
    }

    final display = _currentDisplay();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: hPadding, vertical: vPadding),
      child: FittedBox(
        fit: BoxFit.contain,
        key: _valueDisplayKey,
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

  Widget _pixelShiftDebugOverlay() {
    if (!kDebugMode) return const SizedBox.shrink();
    return Positioned(
      left: 8,
      top: 100,
      child:
        Text(
          'idx ${_pixelShiftIndex}/${_pixelShiftLevels.length - 1}  |  '
          'off ${_pixelShiftOffsetY.toStringAsFixed(1)}  |  '
          'dir ${_pixelShiftDirection > 0 ? "↓" : "↑"}   |  '
           'h ${_measuredContentHeight?.toStringAsFixed(0) ?? "?"}',
          style: const TextStyle(color: Colors.yellow, fontSize: 16),
        ),
    );
  }
}
