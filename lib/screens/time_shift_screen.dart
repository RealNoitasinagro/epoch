import 'dart:async';
import 'package:flutter/material.dart';
import '../effective_clock.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
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

  /// Null as long as the user has not edited anything: the shown values then
  /// follow the live clock. After the first edit they stay as configured.
  DateTime? _editedMoment;

  DateTime get _displayedMoment => _editedMoment ?? EffectiveClock.now();

  @override
  void initState() {
    super.initState();
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

  void _updateMoment({
    int? year, int? month, int? day, int? hour, int? minute, int? second,
  }) {
    final current = _displayedMoment;
    setState(() {
      _editedMoment = DateTime(
        year ?? current.year, month ?? current.month, day ?? current.day,
        hour ?? current.hour, minute ?? current.minute, second ?? current.second,
      );
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
        content: Text(AppLocalizations.of(context)!.timeShiftOutOfRange),
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
          Padding(padding: sectionPadding,
              child: SectionHeader(label: l10n.timeShiftDate)),
          const SizedBox(height: 8),
          _segmentRow([
            _ValueSegment(caption: 'YYYY', value: moment.year.toString().padLeft(4, '0'),
                width: 104, onPressed: () => _editDate(startWithYear: true)),
            _ValueSegment(caption: 'MM', value: twoDigits(moment.month),
                onPressed: () => _editDate(startWithYear: false)),
            _ValueSegment(caption: 'DD', value: twoDigits(moment.day),
                onPressed: () => _editDate(startWithYear: false)),
          ], '-'),
          const Divider(height: kDividerHeight),
          Padding(padding: sectionPadding,
              child: SectionHeader(label: l10n.timeShiftTime)),
          const SizedBox(height: 8),
          _segmentRow([
            _ValueSegment(caption: 'HH', value: twoDigits(moment.hour),
                onPressed: () => _editTimeUnit(_TimeUnit.hour)),
            _ValueSegment(caption: 'mm', value: twoDigits(moment.minute),
                onPressed: () => _editTimeUnit(_TimeUnit.minute)),
            _ValueSegment(caption: 'ss', value: twoDigits(moment.second),
                onPressed: () => _editTimeUnit(_TimeUnit.second)),
          ], ':'),
          const Divider(height: kDividerHeight),
          SwitchListTile(
            secondary: const Icon(Icons.pause_circle_outline),
            title: Text(l10n.timeShiftFrozen),
            subtitle: Text(l10n.timeShiftFrozenSub),
            value: _frozen,
            onChanged: (value) => setState(() => _frozen = value),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: sectionPadding,
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(kIconTimeShift),
                    label: Text(l10n.timeShiftApply),
                    onPressed: _apply,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.restart_alt),
                    label: Text(l10n.timeShiftReset),
                    onPressed: EffectiveClock.isShifted ? _resetToSystemTime : null,
                  ),
                ),
              ],
            ),
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
