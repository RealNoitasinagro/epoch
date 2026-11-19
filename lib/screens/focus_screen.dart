import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../app/day_quarter_color.dart';
import '../app/epoch_app.dart';
import '../app/layout_constants.dart';
import '../l10n/app_localizations.dart';
import '../models/time_value.dart';
import '../settings/app_settings.dart';
import '../settings/focus_colors.dart';
import '../time/effective_clock.dart';
import '../time/seconds_ticker.dart';
import '../time/zoned_moment.dart';
import '../widgets/clocks/graphical_clock.dart';
import '../widgets/time_shift_indicator.dart';
import '../widgets/value_tiles/time_string_row.dart';
import 'home_screen.dart';

class FocusScreen extends StatefulWidget {
  final TimeValue timeValue;
  final String locale;

  const FocusScreen({super.key, required this.timeValue, required this.locale});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  static const _controlsAutoHideDelay = Duration(seconds: 8);
  static const _controlsHideDuration = Duration(milliseconds: 500);
  static const _pixelShiftInterval = Duration(seconds: 180);
  static const _safetyMargin = 8.0; // extra breathing room, both ends

  late DateTime _now;

  Color _fixedColor = Colors.white;
  FocusColorMode _colorMode = FocusColorMode.fixed;
  Color _randomColor = Colors.white;
  bool _paletteOpen = false;
  static Color?
  _lastRandomColor; // different color at every start (within one session)

  bool? _showLine2; // null until the first build, then follows the button
  late bool _showOptionalPart;

  double? _brightness;
  bool _controlsVisible = true;
  Timer? _controlsHideTimer;

  final _valueDisplayKey = GlobalKey();
  bool _pixelShiftEnabled = kDefaultFocusPixelShift;
  int _pixelShiftDirection = 1; // +1 or -1
  int _pixelShiftIndex = 0;
  bool _pixelShiftInitialized = false;
  double _pixelShiftOffsetY = 0;
  Timer? _pixelShiftTimer;

  ValueNotifier<bool>? _nightModeNotifier;

  double? _measuredContentHeight;
  double get _topReservedForShift =>
      _lastOrientation == Orientation.landscape ? 40.0 : 80.0;
  double get _bottomReservedForShift =>
      _lastOrientation == Orientation.landscape ? 56.0 : 64.0;

  List<double> get _pixelShiftLevels {
    final screenHeight = MediaQuery.of(context).size.height;
    final contentHeight = _measuredContentHeight ?? 0;
    final available =
        screenHeight -
        _topReservedForShift -
        _bottomReservedForShift -
        contentHeight;
    final maxOffset = ((available / 2) - _safetyMargin).clamp(
      0.0,
      double.infinity,
    );

    if (maxOffset < 2) return const [0.0];
    const targetStepSize = 18.0; // aim for ~18px between adjacent levels
    final halfSteps = (maxOffset / targetStepSize).floor().clamp(1, 6);
    final steps = halfSteps * 2 + 1; // odd count, always includes center (0.0)
    return List.generate(
      steps,
      (i) => -maxOffset + (2 * maxOffset * i / (steps - 1)),
    );
  }

  bool get _showBrightnessSlider =>
      !kIsWeb && Platform.isAndroid && _brightness != null;
  bool _sliderActive = false;

  Orientation? _lastOrientation;

  bool get _showTimeShiftIndicator =>
      EpochApp.of(context).focusTimeShiftIndicator;

  /// The color of the value and the controls.
  Color get _textColor => switch (_colorMode) {
    FocusColorMode.fixed => _fixedColor,
    FocusColorMode.dayQuarter => dayQuarterColorOfHour(_quarterHour()),
    FocusColorMode.random => _randomColor,
  };

  /// Hour of the wall clock that decides the quarter of the day: that of the
  /// value's zone, or of "local" for values without a zone.
  int _quarterHour() {
    final localIanaZone = EpochApp.of(context).localIanaZone;
    if (widget.timeValue.isZoneIndependent) {
      return localWallClockAt(_now, localIanaZone).hour;
    }
    return ZonedMoment.of(
      widget.timeValue,
      _now.toUtc(),
      localIanaZone,
    ).wallClock.hour;
  }

  void _updateNow() {
    if (!mounted) return;
    setState(() => _now = EffectiveClock.now());
  }

  @override
  void initState() {
    super.initState();
    final app = EpochApp.of(context);
    _nightModeNotifier = app.nightModeNotifier
      ..addListener(_onNightModeChanged);
    _showOptionalPart = app.formatSettings.showsOptionalPart(widget.timeValue);
    _now = EffectiveClock.now();
    SecondsTicker.instance.addListener(_updateNow);
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

  /// Night mode begins or ends while the screen is open: take over the
  /// color and brightness for the new mode (day values were never
  /// overwritten, night values are not saved).
  void _onNightModeChanged() {
    if (mounted) _initBrightness();
  }

  void _remeasureContent() {
    final box =
        _valueDisplayKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final height = (box.size.height / 4).round() * 4.0; // quantize to 4px steps
    if (height != _measuredContentHeight) {
      setState(() {
        _measuredContentHeight = height;
        if (_pixelShiftEnabled && _pixelShiftInitialized)
          _resetPixelShiftPosition();
      });
    }
  }

  Future<void> _initPixelShift() async {
    final enabled = await loadFocusPixelShift();
    if (!mounted) return;
    setState(() => _pixelShiftEnabled = enabled);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _resetPixelShiftPosition(); // context/MediaQuery is safe here
      _pixelShiftInitialized = true;
      if (enabled) _startPixelShiftTimer();
    });
  }

  void _startPixelShiftTimer() {
    _pixelShiftTimer?.cancel();
    _pixelShiftTimer = Timer.periodic(
      _pixelShiftInterval,
      (_) => _rerollPixelShift(),
    );
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
    final isNightMode = EpochApp.of(context).isNightMode;
    var fixedColor = isNightMode
        ? kDefaultFocusColorNight
        : kDefaultFocusColorLight;
    var colorMode = FocusColorMode.fixed;
    var initial = kDefaultFocusBrightness;
    try {
      fixedColor = await loadFocusColor(isNightMode);
      colorMode = await loadFocusColorMode(isNightMode);
      initial = await loadFocusBrightness(isNightMode);
      if (!kIsWeb && !Platform.isLinux) {
        await ScreenBrightness().setApplicationScreenBrightness(initial);
      }
    } catch (_) {
      // Defaults stay: the screen must always come up and be left again.
    }
    if (mounted)
      setState(() {
        _brightness = initial;
        _fixedColor = fixedColor;
        _colorMode = colorMode;
        if (colorMode == FocusColorMode.random) _pickRandomColor();
      });
  }

  void _pickRandomColor() {
    _randomColor = pickRandomFocusColor(Random(), exclude: _lastRandomColor);
    _lastRandomColor = _randomColor;
  }

  /// A solid [color], or one of the automatic modes. In night mode this only
  /// holds for the session.
  void _selectColor({
    Color? color,
    FocusColorMode mode = FocusColorMode.fixed,
  }) {
    setState(() {
      _colorMode = mode;
      if (color != null) _fixedColor = color;
      if (mode == FocusColorMode.random) _pickRandomColor();
      _paletteOpen = false;
    });
    if (!EpochApp.of(context).isNightMode) {
      if (color != null) saveFocusColor(color);
      saveFocusColorMode(mode);
    }
    _scheduleControlsHide();
  }

  Future<void> _saveBrightness(double value) async {
    // In night mode, changes last for this session only.
    final persist = !EpochApp.of(context).isNightMode;
    try {
      await ScreenBrightness().setApplicationScreenBrightness(value);
      if (persist) await saveFocusBrightness(value);
    } catch (_) {}
  }

  double _horizontalPadding(bool isLandscape) => isLandscape ? 80.0 : 24.0;

  void _scheduleControlsHide() {
    _controlsHideTimer?.cancel();
    _controlsHideTimer = Timer(_controlsAutoHideDelay, () {
      if (mounted) {
        setState(() {
          _controlsVisible = false;
          _paletteOpen = false;
        });
      }
    });
  }

  void _showControls() {
    setState(() => _controlsVisible = true);
    _scheduleControlsHide();
  }

  void _toggleLine2() {
    if (_sliderActive) return;
    setState(() => _showLine2 = !(_showLine2 ?? false));
    _showControls();
  }

  Widget _detailsToggle(AppLocalizations l10n) {
    return IconButton(
      icon: Icon(
        _showLine2 == true ? Icons.subtitles : Icons.subtitles_off_outlined,
        color: _textColor,
        size: 28,
      ),
      tooltip: _showLine2 == true
          ? l10n.hintFocusScreenDetailsOff
          : l10n.hintFocusScreenDetailsOn,
      onPressed: _toggleLine2,
    );
  }

  void _toggleOptionalPart() {
    setState(() => _showOptionalPart = !_showOptionalPart);
    _showControls();
  }

  /// The display with the sessions's seconds setting; [withDetails] switches
  /// the details line on whatever the tab says, for values that have one.
  ({String line1, String line2}) _display({required bool withDetails}) {
    final app = EpochApp.of(context);
    var timeValue = widget.timeValue;
    if (timeValue.valueType.optionalPart != OptionalPart.none) {
      timeValue = timeValue.withShowOptionalPart(_showOptionalPart);
    }
    if (withDetails && timeValue.valueType.hasDetailsLine) {
      timeValue = timeValue.withShowDetails(true);
    }
    return TimeStringRow.computeDisplay(
      timeValue,
      _now,
      widget.locale,
      AppLocalizations.of(context)!,
      settings: app.formatSettings,
    );
  }

  void _exit() {
    WakelockPlus.disable();
    if (!kIsWeb && !Platform.isLinux)
      ScreenBrightness().resetApplicationScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      // FocusScreen was the initial route (startup focus value set) –
      // there's nothing to pop back to, so replace with HomeScreen instead:
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  void dispose() {
    SecondsTicker.instance.removeListener(_updateNow);
    _controlsHideTimer?.cancel();
    _pixelShiftTimer?.cancel();
    _nightModeNotifier?.removeListener(_onNightModeChanged);
    // Cleanup is in _exit(); if disposed without _exit (e.g. back button),
    // restore here too:
    WakelockPlus.disable();
    if (!kIsWeb && !Platform.isLinux)
      ScreenBrightness().resetApplicationScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Widget _paletteButton(AppLocalizations l10n) {
    return IconButton(
      icon: Icon(Icons.palette, color: _textColor, size: 28),
      tooltip: l10n.hintFocusScreenColor,
      onPressed: () {
        setState(() => _paletteOpen = !_paletteOpen);
        _scheduleControlsHide();
      },
    );
  }

  /// Four fields in the colors of the quarters of the day.
  Widget _dayQuarterSwatch() {
    Widget quarter(int hour) => Expanded(
      child: ColoredBox(
        color: dayQuarterColorOfHour(hour),
        child: const SizedBox.expand(),
      ),
    );
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [quarter(0), quarter(6)],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [quarter(12), quarter(18)],
          ),
        ),
      ],
    );
  }

  Widget _palettePanel(AppLocalizations l10n) {
    Widget cell({
      required Widget content,
      required bool selected,
      required VoidCallback onTap,
      String? tooltip,
      Color? glowColor,
    }) {
      final field = GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: selected ? Colors.white : Colors.white24,
              width: selected ? 2.5 : 1,
            ),
            boxShadow: selected && glowColor != null
                ? [
                    BoxShadow(
                      color: glowColor.withAlpha(200),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: content,
          ),
        ),
      );
      return tooltip == null ? field : Tooltip(message: tooltip, child: field);
    }

    return Material(
      color: Colors.black.withAlpha(230),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 6 * 44 + 5 * 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final color in focusSolidColors)
                cell(
                  content: ColoredBox(color: color),
                  selected:
                      _colorMode == FocusColorMode.fixed &&
                      _fixedColor == color,
                  glowColor: color,
                  onTap: () => _selectColor(color: color),
                ),
              cell(
                content: _dayQuarterSwatch(),
                selected: _colorMode == FocusColorMode.dayQuarter,
                tooltip: l10n.hintFocusScreenColorDayQuarter,
                onTap: () => _selectColor(mode: FocusColorMode.dayQuarter),
              ),
              cell(
                content: const ColoredBox(
                  color: Color(0xFF2A2A2A),
                  child: Center(
                    child: Icon(Icons.shuffle, color: Colors.white70),
                  ),
                ),
                selected: _colorMode == FocusColorMode.random,
                tooltip: l10n.hintFocusScreenColorRandom,
                onTap: () => _selectColor(mode: FocusColorMode.random),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _remeasureContent());

    final l10n = AppLocalizations.of(context)!;
    final tabDisplay = _display(withDetails: false);
    final fullDisplay = _display(withDetails: true);
    _showLine2 ??= tabDisplay.line2.isNotEmpty;
    final hasLine2 =
        fullDisplay.line2.isNotEmpty && !widget.timeValue.valueType.isGraphical;
    final optionalPart = widget.timeValue.valueType.optionalPart;

    if (_brightness == null) {
      return const Scaffold(backgroundColor: Colors.black);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: _exit,
        onTap: () {
          if (_paletteOpen) setState(() => _paletteOpen = false);
          _showControls();
        },
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
                      0,
                      _pixelShiftOffsetY,
                      0,
                    ),
                    child: GestureDetector(
                      onLongPress: optionalPart != OptionalPart.none
                          ? _toggleOptionalPart
                          : null,
                      child: _buildValueDisplay(isLandscape),
                    ),
                  ),
                ),
                // Controls overlay – fades in/out:
                IgnorePointer(
                  ignoring: !_controlsVisible,
                  child: AnimatedOpacity(
                    opacity: _controlsVisible ? 1.0 : 0.0,
                    duration: _controlsHideDuration,
                    child: isLandscape
                        ? _buildLandscapeControls(
                            l10n,
                            hasLine2,
                            optionalPart,
                            mediaPadding,
                          )
                        : _buildPortraitControls(
                            l10n,
                            hasLine2,
                            optionalPart,
                            mediaPadding,
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortraitControls(
    AppLocalizations l10n,
    bool hasLine2,
    OptionalPart? optionalPart,
    EdgeInsets mediaPadding,
  ) {
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
              _paletteButton(l10n),
              _pixelShiftToggle(l10n),
              if (hasLine2) _detailsToggle(l10n),
            ],
          ),
        ),
        if (_paletteOpen)
          Positioned(
            top: mediaPadding.top + 8 + 56,
            left: 16,
            right: 16,
            child: Center(child: _palettePanel(l10n)),
          ),
        // Brightness slider – bottom, above hint:
        if (_showBrightnessSlider)
          Positioned(
            left: 32,
            right: 32,
            bottom: mediaPadding.bottom + 44, // above hint text
            child: _brightnessSliderHorizontal(),
          ),
        // Exit hint – bottom center:
        Positioned(
          left: 0,
          right: 0,
          bottom: mediaPadding.bottom + 12,
          child: _exitHint(optionalPart: optionalPart, l10n: l10n),
        ),
      ],
    );
  }

  Widget _buildLandscapeControls(
    AppLocalizations l10n,
    bool hasLine2,
    OptionalPart? optionalPart,
    EdgeInsets mediaPadding,
  ) {
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
              if (hasLine2) _detailsToggle(l10n),
              _pixelShiftToggle(l10n),
              _paletteButton(l10n),
            ],
          ),
        ),
        if (_paletteOpen)
          Positioned(
            left: mediaPadding.left + 8 + 56,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _palettePanel(l10n),
            ),
          ),
        // Brightness slider – right side, vertically centered:
        if (_showBrightnessSlider)
          Positioned(
            right: mediaPadding.right + 8,
            top: 8,
            bottom: 40, // above hint
            child: _brightnessSliderVertical(),
          ),
        // Exit hint – bottom center:
        Positioned(
          left: 0,
          right: 0,
          bottom: mediaPadding.bottom + 12,
          child: _exitHint(optionalPart: optionalPart, l10n: l10n),
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
            quarterTurns: 3, // bottom=dark, top=bright
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
        ),
        Icon(Icons.brightness_low, color: _textColor, size: kIconSizeDefault),
      ],
    );
  }

  Widget _exitHint({
    required OptionalPart? optionalPart,
    required AppLocalizations l10n,
  }) {
    final exit = l10n.hintFocusScreenExit;
    final toggleHint = switch (optionalPart) {
      OptionalPart.decimals =>
        _showOptionalPart
            ? l10n.hintFocusScreenToggleDecimalsOff
            : l10n.hintFocusScreenToggleDecimalsOn,
      OptionalPart.seconds =>
        _showOptionalPart
            ? l10n.hintFocusScreenToggleSecondsOff
            : l10n.hintFocusScreenToggleSecondsOn,
      _ => null,
    };
    return Text(
      toggleHint == null ? exit : '$exit  ·  $toggleHint',
      style: TextStyle(color: _textColor.withAlpha(150), fontSize: 12),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildValueDisplay(bool isLandscape) {
    final valueContent = _buildValueContent(isLandscape);
    if (!_showTimeShiftIndicator || !EffectiveClock.isShifted) {
      return valueContent;
    }
    // The badge sits above the value and moves with it, so the pixel shift
    // protects it from burn-in as well.
    const badgeSize = kIconSizeDefault + 8;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        valueContent,
        Positioned(
          top: -badgeSize,
          left: _horizontalPadding(isLandscape),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              for (final icon in timeShiftIcons())
                Icon(icon, size: badgeSize, color: _textColor.withAlpha(150)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueContent(bool isLandscape) {
    final app = EpochApp.of(context);

    // Horizontal padding: make room for side controls in landscape:
    final hPadding = _horizontalPadding(isLandscape);
    final vPadding = 24.0;

    if (widget.timeValue.valueType.isGraphical) {
      final localIanaZone = EpochApp.of(context).localIanaZone;
      final wallClock = ZonedMoment.of(
        widget.timeValue,
        _now.toUtc(),
        localIanaZone,
      ).wallClock;
      final l10n = AppLocalizations.of(context)!;

      final Widget clock = buildGraphicalClock(
        valueType: widget.timeValue.valueType,
        now: wallClock,
        l10n: l10n,
        showSeconds: _showOptionalPart,
        hourFormat24: app.formatSettings.hourFormat24,
        segmentColor: _textColor,
        focusSize: true,
      );
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        child: FittedBox(
          fit: BoxFit.contain,
          key: _valueDisplayKey,
          child: clock,
        ),
      );
    }

    final display = _display(withDetails: true);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
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
            if (_showLine2 == true && display.line2.isNotEmpty) ...[
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
      child: Text(
        'idx ${_pixelShiftIndex}/${_pixelShiftLevels.length - 1}  |  '
        'off ${_pixelShiftOffsetY.toStringAsFixed(1)}  |  '
        'dir ${_pixelShiftDirection > 0 ? "↓" : "↑"}   |  '
        'h ${_measuredContentHeight?.toStringAsFixed(0) ?? "?"}',
        style: const TextStyle(color: Colors.yellow, fontSize: 16),
      ),
    );
  }
}
