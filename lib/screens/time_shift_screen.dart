import 'dart:async';
import 'package:flutter/material.dart';
import '../effective_clock.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../widgets/dial_picker.dart';
import '../widgets/section_header.dart';

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

  /// Null as long as the user has not edited anything: the shown values then
  /// follow the live clock. After the first edit they stay as configured.
  DateTime? _editedMoment;

  DateTime get _displayedMoment => _editedMoment ?? EffectiveClock.now();

  /// Apply would change something: values were edited, or the freeze
  /// setting differs from the one currently in effect.
  bool get _canSetAppClock =>
      _editedMoment != null || _frozen != EffectiveClock.isFrozen;

  /// Reset would change something: the app clock is shifted, or the page
  /// holds unapplied edits.
  bool get _canReturnToSystemTime =>
      EffectiveClock.isShifted || _editedMoment != null;

  @override
  void initState() {
    super.initState();
    _focusIndicatorEnabled = EpochApp.of(context).focusTimeShiftIndicator;
    _frozen = EffectiveClock.isFrozen;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _editedMoment == null) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  static String _wallClockText(DateTime moment) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${moment.year.toString().padLeft(4, '0')}-${twoDigits(moment.month)}-'
        '${twoDigits(moment.day)} ${twoDigits(moment.hour)}:'
        '${twoDigits(moment.minute)}:${twoDigits(moment.second)}';
  }

  void _updateMoment({
    int? year, int? month, int? day, int? hour, int? minute, int? second,
  }) {
    final current = _displayedMoment;
    // UTC has no clock changes, so this keeps exactly what was requested:
    final requested = DateTime.utc(
      year ?? current.year, month ?? current.month, day ?? current.day,
      hour ?? current.hour, minute ?? current.minute, second ?? current.second,
    );
    final moment = DateTime(requested.year, requested.month, requested.day,
        requested.hour, requested.minute, requested.second);
    final requestedText = _wallClockText(requested);
    final usedText = _wallClockText(moment);
    setState(() {
      _editedMoment = moment;
      setState(() => _editedMoment = moment);
      if (requestedText != usedText) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!
                .timeShiftSkippedTime(requestedText, usedText)),
            duration: const Duration(seconds: 6),
            behavior: SnackBarBehavior.floating,
          ));
      }
    });
  }

  Future<void> _editDate({required bool startWithYear}) async {
    final current = _displayedMoment;
    final currentDate = DateTime(current.year, current.month, current.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate.isBefore(_firstSelectableDate)
          ? _firstSelectableDate
          : currentDate.isAfter(_lastSelectableDate)
          ? _lastSelectableDate : currentDate,
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
    final current = _displayedMoment;
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
    final moment = _displayedMoment;
    if (!EffectiveClock.isSupported(moment)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.timeShiftOutOfRange(
            EffectiveClock.earliestMomentText, EffectiveClock.latestMomentText)),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    EffectiveClock.shiftTo(moment, frozen: _frozen);
    Navigator.pop(context);
  }

  void _resetToSystemTime() {
    EffectiveClock.reset();
    Navigator.pop(context);
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

  /// Sets the date (or the time of day) back to the current system values,
  /// leaving the other part as configured.
  void _adoptSystemValues({required bool date}) {
    final system = DateTime.now();
    if (date) {
      _updateMoment(year: system.year, month: system.month, day: system.day);
    } else {
      _updateMoment(
          hour: system.hour, minute: system.minute, second: system.second);
    }
  }

  Widget _sectionHeader(String label, {required bool date}) {
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
    final moment = _displayedMoment;
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    const sectionPadding = EdgeInsets.symmetric(horizontal: kTabHorizontalPadding);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pageTimeShift)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: kTabVerticalPadding),
        children: [
          _buildHint(l10n),
          const Divider(height: kDividerHeight),
          _sectionHeader(l10n.timeShiftDate, date: true),
          const SizedBox(height: 8),
          _segmentRow([
            _ValueSegment(caption: l10n.labelYear, value: moment.year.toString().padLeft(4, '0'),
                width: 104, onPressed: () => _editDate(startWithYear: true)),
            _ValueSegment(caption: l10n.labelMonth, value: twoDigits(moment.month),
                onPressed: () => _editDate(startWithYear: false)),
            _ValueSegment(caption: l10n.labelDay, value: twoDigits(moment.day),
                onPressed: () => _editDate(startWithYear: false)),
          ], '-'),
          _sectionHeader(l10n.timeShiftTime, date: false),
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
