import 'dart:async';
import 'package:flutter/material.dart';
import '../effective_clock.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/generated/iana_links_snapshot.g.dart';
import '../models/time_shift_start.dart';
import '../models/time_value.dart';
import '../models/timezone_search_zones.dart';
import '../models/zone_rules.dart';
import '../wall_clock_in_zone.dart';
import '../widgets/dial_picker.dart';
import '../widgets/section_header.dart';
import '../widgets/zone_option_list.dart';

enum _TimeUnit { hour, minute, second }

class TimeShiftScreen extends StatefulWidget {
  const TimeShiftScreen({super.key});

  @override
  State<TimeShiftScreen> createState() => _TimeShiftScreenState();
}

class _TimeShiftScreenState extends State<TimeShiftScreen> {
  static final _firstSelectableDate = DateTime(1970, 1, 1);
  static final _lastSelectableDate = DateTime(2038, 1, 19);

  late final Timer _ticker;
  late bool _frozen;
  late bool _focusIndicatorEnabled;

  /// The zone the moment is entered and shown in. Not a setting of its own:
  /// it only becomes part of the preferences with a saved start value.
  late ZoneSpec _zone;

  TimeShiftStart? _savedStart;

  /// Wall-clock reading in [_zone] (a UTC-kind DateTime, only the fields
  /// count). Null as long as the user has not edited anything: the shown
  /// values then follow the live clock.
  DateTime? _editedWallClock;

  DateTime get _displayedWallClock =>
      _editedWallClock ?? wallClockOf(EffectiveClock.now().toUtc(), _zone);

  /// The shown moment as an instant, in whole seconds. For the live clock it
  /// is the real instant, which keeps the repeated hour of a clock change
  /// apart.
  DateTime get _displayedInstant {
    final edited = _editedWallClock;
    final instant = edited == null
        ? EffectiveClock.now().toUtc()
        : instantOfWallClock(edited, _zone);
    return DateTime.utc(instant.year, instant.month, instant.day, instant.hour,
        instant.minute, instant.second);
  }

  /// Apply would change something: values were edited, or the freeze
  /// setting differs from the one currently in effect.
  bool get _canSetAppClock =>
      _editedWallClock != null || _frozen != EffectiveClock.isFrozen;

  /// Reset would change something: the app clock is shifted, or the page
  /// holds unapplied edits.
  bool get _canReturnToSystemTime =>
      EffectiveClock.isShifted || _editedWallClock != null;

  @override
  void initState() {
    super.initState();
    _focusIndicatorEnabled = EpochApp.of(context).focusTimeShiftIndicator;
    _frozen = EffectiveClock.isFrozen;
    _zone = EffectiveClock.isShifted ? activeTimeShiftZone : const ZoneLocal();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _editedWallClock == null) setState(() {});
    });
    _loadSavedStart();
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  Future<void> _loadSavedStart() async {
    final savedStart = await loadTimeShiftStart();
    if (!mounted) return;
    setState(() => _savedStart = savedStart);
  }

  static String _wallClockText(DateTime moment) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${moment.year.toString().padLeft(4, '0')}-${twoDigits(moment.month)}-'
        '${twoDigits(moment.day)} ${twoDigits(moment.hour)}:'
        '${twoDigits(moment.minute)}:${twoDigits(moment.second)}';
  }

  void _showSnackBar(String text, {Duration? duration}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text(text),
        duration: duration ?? const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ));
  }

  void _showOutOfRange() {
    _showSnackBar(AppLocalizations.of(context)!.timeShiftOutOfRange(
        EffectiveClock.earliestMomentText, EffectiveClock.latestMomentText));
  }

  void _updateMoment({
    int? year, int? month, int? day, int? hour, int? minute, int? second,
  }) {
    final current = _displayedWallClock;
    // UTC has no clock changes, so this keeps exactly what was requested:
    final requested = DateTime.utc(
      year ?? current.year, month ?? current.month, day ?? current.day,
      hour ?? current.hour, minute ?? current.minute, second ?? current.second,
    );
    // A zone with clock changes may not know that reading:
    final used = wallClockOf(instantOfWallClock(requested, _zone), _zone);
    setState(() => _editedWallClock = used);
    final requestedText = _wallClockText(requested);
    final usedText = _wallClockText(used);
    if (requestedText != usedText) {
      _showSnackBar(
        AppLocalizations.of(context)!
            .timeShiftSkippedTime(requestedText, usedText),
        duration: const Duration(seconds: 6),
      );
    }
  }

  Future<void> _pickZone() async {
    final zone = await showZonePicker(context);
    if (zone == null || !mounted) return;
    setState(() {
      // The same moment, read in the new zone (nothing to convert while the
      // live clock is shown):
      final edited = _editedWallClock;
      if (edited != null) {
        _editedWallClock = wallClockOf(instantOfWallClock(edited, _zone), zone);
      }
      _zone = zone;
    });
  }

  Future<void> _editDate({required bool startWithYear}) async {
    final current = _displayedWallClock;
    final currentDate = DateTime(current.year, current.month, current.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate.isBefore(_firstSelectableDate)
          ? _firstSelectableDate
          : currentDate.isAfter(_lastSelectableDate)
            ? _lastSelectableDate
            : currentDate,
      firstDate: _firstSelectableDate,
      lastDate: _lastSelectableDate,
      initialDatePickerMode:
          startWithYear ? DatePickerMode.year : DatePickerMode.day,
    );
    if (picked == null || !mounted) return;
    _updateMoment(year: picked.year, month: picked.month, day: picked.day);
  }

  Future<void> _editTimeUnit(_TimeUnit unit) async {
    final l10n = AppLocalizations.of(context)!;
    final current = _displayedWallClock;
    final (title, scale, initialValue) = switch (unit) {
      _TimeUnit.hour   => (l10n.timeShiftHours, DialScale.hours24, current.hour),
      _TimeUnit.minute => (l10n.timeShiftMinutes, DialScale.sixty, current.minute),
      _TimeUnit.second => (l10n.timeShiftSeconds, DialScale.sixty, current.second),
    };
    final picked = await showDialPicker(
        context, title: title, scale: scale, initialValue: initialValue);
    if (picked == null || !mounted) return;
    _updateMoment(
      hour:   unit == _TimeUnit.hour   ? picked : null,
      minute: unit == _TimeUnit.minute ? picked : null,
      second: unit == _TimeUnit.second ? picked : null,
    );
  }

  void _apply() {
    final instant = _displayedInstant;
    if (!EffectiveClock.isSupported(instant)) {
      _showOutOfRange();
      return;
    }
    activeTimeShiftZone = _zone;
    EffectiveClock.shiftTo(instant, frozen: _frozen);
    Navigator.pop(context);
  }

  void _resetToSystemTime() {
    EffectiveClock.reset();
    Navigator.pop(context);
  }

  Future<void> _saveStartValue() async {
    final l10n = AppLocalizations.of(context)!;
    final instant = _displayedInstant;
    if (!EffectiveClock.isSupported(instant)) {
      _showOutOfRange();
      return;
    }
    final start =
        TimeShiftStart(momentUtc: instant, frozen: _frozen, zone: _zone);
    await saveTimeShiftStart(start);
    if (!mounted) return;
    setState(() => _savedStart = start);
    _showSnackBar(l10n.timeShiftStartSaved);
  }

  Future<void> _removeStartValue() async {
    final l10n = AppLocalizations.of(context)!;
    await clearTimeShiftStart();
    if (!mounted) return;
    setState(() => _savedStart = null);
    _showSnackBar(l10n.timeShiftStartRemoved);
  }

  Widget _segmentRow(List<Widget> segments, String separator) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var index = 0; index < segments.length; index++) ...[
          if (index > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 14, left: 4, right: 4),
              child: Text(separator,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          segments[index],
        ],
      ],
    );
  }

  /// Sets the date (or the time of day) back to the current system values
  /// (read in the chosen zone), leaving the other part as configured.
  void _adoptSystemValues({required bool date}) {
    final system = wallClockOf(EffectiveClock.systemTime().toUtc(), _zone);
    if (date) {
      _updateMoment(
          year: system.year, month: system.month, day: system.day);
    } else {
      _updateMoment(
          hour: system.hour, minute: system.minute, second: system.second);
    }
  }

  Widget _plainSectionHeader(String label) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: kTabHorizontalPadding),
    child: SectionHeader(label: label),
  );

  /// Section header of the date or the time, with the button that takes over
  /// the system values.
  Widget _momentSectionHeader(String label, {required bool date}) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kTabHorizontalPadding),
      child: Row(
        children: [
          Expanded(child: SectionHeader(label: label)),
          Tooltip(
            message: date
                ? l10n.timeShiftHintResetToSystemDate(l10n.timeShiftApply)
                : l10n.timeShiftHintResetToSystemTime(l10n.timeShiftApply),
            child: IconButton(
              icon: const Icon(Icons.restart_alt),
              onPressed: () => _adoptSystemValues(date: date),
            ),
          ),
        ],
      ),
    );
  }

  String _zoneTitle(ZoneSpec zone, AppLocalizations l10n) => switch (zone) {
    ZoneLocal() => l10n.actionZoneLocal,
    ZoneUtc() => l10n.actionZoneUtc,
    ZoneNamed(ianaZone: final ianaZone) =>
        _namedZoneTitle(ianaZone, l10n.localeName),
  };

  String _namedZoneTitle(String ianaZone, String locale) {
    final canonicalZone = ianaLinksSnapshot[ianaZone] ?? ianaZone;
    final entry = tzDatabase
        .where((entry) => entry.ianaZoneId == canonicalZone)
        .firstOrNull;
    return entry?.displayTitle(locale) ?? ianaZone;
  }

  /// IANA name (also for the system zone) and the offset at the shown moment.
  String _zoneSubtitle() {
    final ianaZone = switch (_zone) {
      ZoneLocal() => EpochApp.of(context).localIanaZone,
      ZoneUtc() => null,
      ZoneNamed(ianaZone: final name) => name,
    };
    final offsetText = formatUtcOffset(
        offsetInZone(_displayedInstant, _zone), withUtcPrefix: true);
    return ianaZone == null ? offsetText : '$ianaZone  ·  $offsetText';
  }

  Widget _zoneTile(AppLocalizations l10n) {
    return ListTile(
      leading: const Icon(kIconTimeZoneIndicator),
      title: Text(_zoneTitle(_zone, l10n)),
      subtitle: Text(_zoneSubtitle(),
          style: const TextStyle(fontFamily: fontFamilyDefault)),
      trailing: const Icon(Icons.edit_outlined),
      onTap: _pickZone,
    );
  }

  /// The zone of a saved start value as the config knows it: "Local", "UTC"
  /// or the IANA name.
  String _startZoneText(ZoneSpec zone, AppLocalizations l10n) => switch (zone) {
    ZoneLocal() => l10n.labelLocal,
    ZoneUtc() => l10n.actionZoneUtc,
    ZoneNamed(ianaZone: final ianaZone) => ianaZone,
  };

  String _startSummary(AppLocalizations l10n, TimeShiftStart start) {
    final moment = _wallClockText(wallClockOf(start.momentUtc, start.zone));
    final zone = _startZoneText(start.zone, l10n);
    return start.frozen
        ? l10n.timeShiftStartSummaryFrozen(moment, zone)
        : l10n.timeShiftStartSummaryRunning(moment, zone);
  }

  Widget _buildStartValue(AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final savedStart = _savedStart;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kTabHorizontalPadding, vertical: kTabVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.timeShiftStartHint,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onSurface.withAlpha(170)),
          ),
          const SizedBox(height: 12),
          Text(
            savedStart == null
                ? l10n.timeShiftStartNone
                : _startSummary(l10n, savedStart),
            style: const TextStyle(fontFamily: fontFamilyDefault),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  icon: const Icon(Icons.save_outlined),
                  label: Text(l10n.timeShiftStartSave),
                  onPressed: _saveStartValue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.timeShiftStartRemove),
                  onPressed: savedStart != null ? _removeStartValue : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHint(AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(color: colorScheme.onSurface.withAlpha(170));
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kTabHorizontalPadding, vertical: kTabVerticalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: kIconSizeDefault,
              color: colorScheme.onSurface.withAlpha(150)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    l10n.timeShiftHint(l10n.timeShiftApply, l10n.timeShiftReset),
                    style: textStyle
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.timeShiftHintRange(EffectiveClock.earliestMomentText,
                      EffectiveClock.latestMomentText),
                  style: textStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final moment = _displayedWallClock;
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    const sectionPadding = EdgeInsets.symmetric(horizontal: kTabHorizontalPadding);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pageTimeShift)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: kTabVerticalPadding),
        children: [
          _buildHint(l10n),
          const Divider(height: kDividerHeight),
          _plainSectionHeader(l10n.timeShiftZone),
          const SizedBox(height: 8),
          _zoneTile(l10n),
          _momentSectionHeader(l10n.timeShiftDate, date: true),
          const SizedBox(height: 8),
          _segmentRow([
            _ValueSegment(caption: l10n.labelYear, value: moment.year.toString().padLeft(4, '0'),
                width: 104, onPressed: () => _editDate(startWithYear: true)),
            _ValueSegment(caption: l10n.labelMonth, value: twoDigits(moment.month),
                onPressed: () => _editDate(startWithYear: false)),
            _ValueSegment(caption: l10n.labelDay, value: twoDigits(moment.day),
                onPressed: () => _editDate(startWithYear: false)),
          ], '-'),
          _momentSectionHeader(l10n.timeShiftTime, date: false),
          const SizedBox(height: 8),
          _segmentRow([
            _ValueSegment(caption: l10n.labelHours, value: twoDigits(moment.hour),
                onPressed: () => _editTimeUnit(_TimeUnit.hour)),
            _ValueSegment(caption: l10n.labelMinutes, value: twoDigits(moment.minute),
                onPressed: () => _editTimeUnit(_TimeUnit.minute)),
            _ValueSegment(caption: l10n.labelSeconds, value: twoDigits(moment.second),
                onPressed: () => _editTimeUnit(_TimeUnit.second)),
          ], ':'),
          const SizedBox(height: 16),
          SwitchListTile(
            secondary: const Icon(Icons.pause_circle_outline),
            title: Text(l10n.timeShiftFrozen),
            subtitle: Text(_frozen
                ? l10n.timeShiftFrozenSubOn
                : l10n.timeShiftFrozenSubOff),
            value: _frozen,
            onChanged: (value) => setState(() => _frozen = value),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: sectionPadding,
            child: Row(
              children: [
                Expanded(
                  child: Tooltip(
                    message: l10n.timeShiftHintApply,
                    child: FilledButton.icon(
                      icon: const Icon(kIconTimeShift),
                      label: Text(l10n.timeShiftApply),
                      onPressed: _canSetAppClock ? _apply : null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Tooltip(
                    message: l10n.timeShiftHintReset,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.restart_alt),
                      label: Text(l10n.timeShiftReset),
                      onPressed: _canReturnToSystemTime ? _resetToSystemTime : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: kDividerHeight),
          SwitchListTile(
            secondary: const Icon(Icons.fullscreen),
            title: Text(l10n.timeShiftFocusIndicator),
            subtitle: Text(l10n.timeShiftFocusIndicatorSub),
            value: _focusIndicatorEnabled,
            onChanged: (value) {
              setState(() => _focusIndicatorEnabled = value);
              EpochApp.of(context).setFocusTimeShiftIndicator(value);
            },
          ),
          const SizedBox(height: 16),
          _plainSectionHeader(l10n.timeShiftStartSection),
          _buildStartValue(l10n),
        ],
      ),
    );
  }
}

/// One tappable part of a date or time (e.g. "2026" or "14"), with a caption.
class _ValueSegment extends StatelessWidget {
  final String caption;
  final String value;
  final double width;
  final VoidCallback onPressed;

  const _ValueSegment({
    required this.caption,
    required this.value,
    required this.onPressed,
    this.width = 72,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(caption,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                letterSpacing: 1.5,
                color: colorScheme.onSurface.withAlpha(150))),
        const SizedBox(height: 4),
        SizedBox(
          width: width,
          height: 56,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: fontFamilyDefault,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }
}
