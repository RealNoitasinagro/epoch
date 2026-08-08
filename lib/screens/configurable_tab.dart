import 'package:epoch/models/tab_entry.dart';
import 'package:epoch/widgets/time_string_row.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/app_settings.dart';
import '../models/civil_tab_config.dart';
import '../models/time_value.dart';
import '../time_utils.dart';
import '../widgets/clocks/binary_coded_decimal_clock.dart';
import '../widgets/clocks/binary_columns_clock.dart';
import '../widgets/clocks/seven_segment_clock.dart';
import '../widgets/section_header.dart';
import '../widgets/time_graphical_row.dart';
import '../widgets/value_tile.dart';
import 'entry_picker.dart';

// A fully configurable tab used by both Civil and custom Watchlist tabs.
// [entries] and [onEntriesChanged] are managed by the parent.
class ConfigurableTab extends StatefulWidget {
  final DateTime now;
  final List<TabEntry> entries;
  final bool hourFormat24;
  final bool thousandsSep;
  final bool showDateDetails;
  final int maxEntries;
  final ValueChanged<List<TabEntry>> onEntriesChanged;
  final List<ValueType>? allowedTypes; // null = all types allowed

  const ConfigurableTab({
    super.key,
    required this.now,
    required this.entries,
    required this.onEntriesChanged,
    this.thousandsSep = true,
    this.hourFormat24 = true,
    this.showDateDetails = true,
    this.maxEntries = 30,
    this.allowedTypes,
  });

  @override
  State<ConfigurableTab> createState() => _ConfigurableTabState();
}

class _ConfigurableTabState extends State<ConfigurableTab> {
  bool _editMode = false;
  final Set<String> _checked = {};
  final ScrollController _scrollController = ScrollController();
  double _savedScrollOffset = 0.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    if (_editMode) {
      // leaving edit mode: clean trailing entries
      final cleaned = _cleanTrailing(widget.entries.toList());
      if (cleaned.length != widget.entries.length) {
        widget.onEntriesChanged(cleaned);
      }
    }
    setState(() {
      // Save position before switching.
      _savedScrollOffset = _scrollController.hasClients
          ? _scrollController.offset
          : 0.0;
      _editMode = !_editMode;
      if (!_editMode) _checked.clear();
    });
    // Restore position after the new list has been built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _savedScrollOffset.clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
        );
      }
    });
  }

  bool get _allChecked =>
      widget.entries.isNotEmpty &&
          widget.entries.every((e) => _checked.contains(e.key));

  int get _valueCount => widget.entries.whereType<TimeValue>().length;

  void _toggleMasterCheck() {
    setState(() {
      if (_allChecked) {
        _checked.clear();
      } else {
        _checked.addAll(widget.entries.map((e) => e.key));
      }
    });
  }

  void _removeChecked() {
    final updated = widget.entries
        .where((e) => !_checked.contains(e.key))
        .toList();
    _checked.clear();
    widget.onEntriesChanged(updated);
    setState(() {});
  }

  void _resetToDefaults() {
    _checked.clear();
    widget.onEntriesChanged(_cleanTrailing(List.of(defaultCivilEntries)));
    setState(() {});
  }

  void _removeEntry(TabEntry entry, int index) {
    final updated = List<TabEntry>.of(widget.entries);
    updated.removeAt(index);
    _checked.remove(entry.key);
    widget.onEntriesChanged(updated);
  }

  Widget _entryCheckbox(BuildContext context, TabEntry entry) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: 40,
      height: 40,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() {
          if (_checked.contains(entry.key)) {
            _checked.remove(entry.key);
          } else {
            _checked.add(entry.key);
          }
        }),
        child: Tooltip(
          message: _checked.contains(entry.key)
              ? l10n.hintDeselect : l10n.hintSelect,
          child: Checkbox(
            value: _checked.contains(entry.key),
            tristate: false,
            // onChanged: null disables the checkbox's own tap handling;
            // taps are handled by the GestureDetector above for a larger hit area.
            onChanged: null,
          ),
        ),
      ),
    );
  }

  Future<void> _showLabelDialog(
      BuildContext context,
      AppLocalizations l10n, {
        required String title,
        required String labelText,
        required String initialText,
        required String hintText,
        String? resetLabel,
        required ValueChanged<String?> onResult,
      }) async {
    final controller = TextEditingController(text: initialText);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
          if (resetLabel != null)
            TextButton(
              onPressed: () => Navigator.pop(ctx, ''),
              child: Text(resetLabel),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (result == null) return;
    onResult(result);
  }

  Future<void> _editLabel(
      BuildContext context, TimeValue timeValue, AppLocalizations l10n, int index
    ) async {
    final localIanaZone = EpochApp.of(context).localIanaZone;
    final ianaZone = switch (timeValue.zone) {
      ZoneLocal()                  => localIanaZone,
      ZoneNamed(ianaZone: final z) => z,
      ZoneUtc()                    => 'UTC',
    };
    final hasDst = TimeUtils.hasDaylightSavingTime(ianaZone);
    final isZoneDependent = !timeValue.isZoneIndependent;
    bool selectedShowSeconds = timeValue.showSeconds;

    // Modes already used by other TimeValues with the same key (same type/zone):
    final existingModes = widget.entries
        .whereType<TimeValue>()
        .where((e) => e.sameZoneAndType(timeValue) &&
        e.timezoneClockChangeMode != timeValue.timezoneClockChangeMode)
        .map((e) => e.timezoneClockChangeMode)
        .toSet();

    final controller = TextEditingController(
        text: timeValue.customLabel ?? timeValue.localizedDisplayLabel(l10n));
    var selectedMode = timeValue.timezoneClockChangeMode;

    final result = await showDialog<
      ({String? label, TimezoneClockChangeMode mode, bool reset, bool showSeconds})
    >(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.hintEditTimeValue),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                autofocus: !hasDst,
                decoration: InputDecoration(
                  labelText: l10n.labelNewLabel,
                  hintText: timeValue.localizedDisplayLabel(l10n),
                ),
              ),
              if (isZoneDependent && hasDst && timeValue.zone is ZoneNamed) ...[
                const SizedBox(height: 16),
                Text(l10n.settingsDstMode,
                    style: Theme.of(ctx).textTheme.labelMedium?.copyWith(
                      color: Theme.of(ctx).colorScheme.primary,
                      letterSpacing: 1.5,
                    )),
                const SizedBox(height: 4),
                RadioGroup<TimezoneClockChangeMode>(
                  groupValue: selectedMode,
                  onChanged: (v) {
                    if (v == null || existingModes.contains(v)) return;
                    setDialogState(() => selectedMode = v);
                  },
                  child: Column(
                    children: [
                      RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(l10n.settingsDstAuto,
                          style: existingModes.contains(TimezoneClockChangeMode.auto)
                              ? TextStyle(color: Theme.of(ctx)
                                .colorScheme.onSurface.withAlpha(80))
                              : null,
                        ),
                        value: TimezoneClockChangeMode.auto,
                        enabled: !existingModes.contains(TimezoneClockChangeMode.auto),
                      ),
                      RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(l10n.settingsDstAlwaysOn,
                          style: existingModes.contains(TimezoneClockChangeMode.forceDst)
                              ? TextStyle(color: Theme.of(ctx)
                                .colorScheme.onSurface.withAlpha(80))
                              : null,
                        ),
                        value: TimezoneClockChangeMode.forceDst,
                        enabled: !existingModes.contains(TimezoneClockChangeMode.forceDst),
                      ),
                      RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(l10n.settingsDstAlwaysOff,
                          style: existingModes.contains(TimezoneClockChangeMode.forceStandard)
                              ? TextStyle(color: Theme.of(ctx)
                                .colorScheme.onSurface.withAlpha(80))
                              : null,
                        ),
                        value: TimezoneClockChangeMode.forceStandard,
                        enabled: !existingModes.contains(TimezoneClockChangeMode.forceStandard),
                      ),
                    ]
                  )
                ),
              ],
              if (timeValue.valueType.isGraphical ||
                  timeValue.valueType == ValueType.swatchBeats) ...<Widget>[
                const SizedBox(height: 12),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                      timeValue.valueType == ValueType.swatchBeats
                          ? l10n.labelShowDecimals
                          : l10n.labelShowSeconds
                  ),
                  value: selectedShowSeconds,
                  onChanged: (v) => setDialogState(() => selectedShowSeconds = v ?? true),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx,
                  (label: null, mode: TimezoneClockChangeMode.auto,
                  reset: true, showSeconds: true)
              ),
              child: Text(l10n.hintResetToDefaults),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx),  // null = cancel
              child: Text(l10n.actionCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx,
                  (label: controller.text.trim(), mode: selectedMode,
                  reset: false, showSeconds: selectedShowSeconds)
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
    if (result == null) return;
    final newLabel = result.reset
        ? null
        : (timeValue.customLabel == null &&
            result.label == timeValue.localizedDisplayLabel(l10n)
            ||
            result.label!.isEmpty)
            ? null
            : result.label;
    final newMode = result.reset ? TimezoneClockChangeMode.auto : result.mode;
    final newShowSeconds = result.reset ? true : result.showSeconds;

    final updated = List<TabEntry>.of(widget.entries);
    updated[index] = timeValue
        .withCustomLabel(newLabel)
        .withTimezoneClockChangeMode(newMode)
        .withShowSeconds(newShowSeconds);
    widget.onEntriesChanged(updated);
  }

  Future<void> _editSectionLabel(
      BuildContext context, TabSection s, AppLocalizations l10n) async {
    await _showLabelDialog(
      context, l10n,
      title: l10n.hintEditSectionHeader,
      labelText: l10n.labelNewSectionName,
      initialText: s.label,
      hintText: s.label,
      onResult: (result) {
        if (result == null || result.isEmpty) return;
        final updated = List<TabEntry>.of(widget.entries);
        final index = updated.indexWhere((e) => e.key == s.key);
        if (index == -1) return;
        updated[index] = s.withLabel(result);
        widget.onEntriesChanged(updated);
      },
    );
  }

  Future<void> _showAddDialog() async {
    final l10n = AppLocalizations.of(context)!;
    int timeValueEntries = widget.entries.where( (e) => e is TimeValue ).length;
    if (timeValueEntries >= widget.maxEntries) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l10n.messageMaxValues(widget.maxEntries)),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    final app = EpochApp.of(context);
    final result = await showEntryPicker(
      context,
      allowedTypes: widget.allowedTypes,
      existingEntries: widget.entries,
      lmstMode: app.lmstMode,
      lmstLongitude: app.lmstLongitude,
    );
    if (result == null) return;

    if (result is TimeValue &&
        widget.entries.any((e) => e is TimeValue && e.key == result.key)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l10n.messageAlreadyDisplayed),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    widget.onEntriesChanged([...widget.entries, result]);
  }

  Widget _buildDisplayList(AppLocalizations l10n, String locale) {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(
          kTabHorizontalPadding, kTabVerticalPadding,
          kTabHorizontalPadding, 80),
      itemCount: widget.entries.length,
      separatorBuilder: (_, __) => const SizedBox.shrink(),
      itemBuilder: (context, index) {
        final entry = widget.entries[index];
        final bottomPadding = _getItemPadding(index, widget.entries);
        return Padding(
          key: ValueKey(entry.key),
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: _buildTabEntry(context, entry, null, l10n, locale),
        );
      },
    );
  }

  Widget _buildEditList(AppLocalizations l10n, String locale) {
    return ReorderableListView.builder(
      scrollController: _scrollController,
      buildDefaultDragHandles: false,
      padding: const EdgeInsets.fromLTRB(
          kTabHorizontalPadding, kTabVerticalPadding,
          kTabHorizontalPadding, 80),
      itemCount: widget.entries.length,
      onReorderItem: (oldIndex, newIndex) {
        final updated = List<TabEntry>.of(widget.entries);
        final item = updated.removeAt(oldIndex);
        updated.insert(newIndex, item);
        widget.onEntriesChanged(updated);
      },
      itemBuilder: (context, index) {
        final entry = widget.entries[index];
        final bottomPadding = _getItemPadding(index, widget.entries);
        return Padding(
          key: ValueKey(entry.key),
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: _buildTabEntry(context, entry, index, l10n, locale),
        );
      },
    );
  }

  double _getItemPadding(int index, List<TabEntry> entries) {
    if (index >= entries.length - 1) return 0.0;
    final currentEntry = entries[index];
    final nextEntry = entries[index + 1];
    if (currentEntry is TabDivider || nextEntry is TabDivider) return 0.0;
    return kEntrySpacing;
  }

  Widget _buildTabEntry(
      BuildContext context,
      TabEntry entry,
      int? editIndex,
      AppLocalizations l10n,
      String locale,
      ) {
    return switch (entry) {
      TimeValue tv  => _buildRow(context, tv, editIndex, l10n, locale),
      TabDivider d  => _buildDividerEntry(context, d, editIndex),
      TabSection s  => _buildSectionEntry(context, s, editIndex, l10n),
      TabEntry() => throw StateError('Unknown TabEntry subtype: $entry'),
    };
  }

  Widget _buildDividerEntry(
      BuildContext context, TabDivider d, int? editIndex) {
    if (editIndex == null) {
      return const Divider(height: kDividerHeight);
    }
    return Dismissible(
      key: ValueKey(d.key),
      direction: DismissDirection.endToStart,
      background: _dismissBackground(),
      onDismissed: (_) => _removeEntry(d, editIndex),
      child: SizedBox(
        height: kDividerHeight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              kTabHorizontalPadding, 0,
              kTabHorizontalPadding, 0),
          child: Row(
            children: [
              const Expanded(
                child: Divider(height: 0),
              ),
              const SizedBox(width: 8),
              const SizedBox(width: 40),
              ReorderableDragStartListener(
                index: editIndex,
                child: SizedBox(
                  width: 40, height: kDividerHeight,
                  child: Icon(Icons.drag_handle, size: kIconSizeDefault,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
                ),
              ),
              _entryCheckbox(context, d),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionEntry(
      BuildContext context, TabSection s, int? editIndex,
      AppLocalizations l10n) {
    if (editIndex == null) {
      return SizedBox(
        height: kSectionHeaderHeight,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SectionHeader(label: s.label),
        ),
      );
    }
    return Dismissible(
      key: ValueKey(s.key),
      direction: DismissDirection.endToStart,
      background: _dismissBackground(),
      onDismissed: (_) => _removeEntry(s, editIndex),
      child: SizedBox(
        height: kSectionHeaderHeight,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              0, 0, kTabHorizontalPadding, 0
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: SectionHeader(label: s.label)),
              SizedBox(width: 40, height: kSectionHeaderHeight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.edit, size: kIconSizeDefault,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
                  tooltip: l10n.hintEditSectionHeader,
                  onPressed: () => _editSectionLabel(context, s, l10n),
                ),
              ),
              ReorderableDragStartListener(
                index: editIndex,
                child: SizedBox(
                  width: 40, height: kSectionHeaderHeight,
                  child: Icon(Icons.drag_handle, size: kIconSizeDefault,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
                ),
              ),
              _entryCheckbox(context, s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
      BuildContext context,
      TimeValue timeValue,
      int? editIndex,  // null = view mode
      AppLocalizations l10n,
      String locale,
      ) {
    final app = EpochApp.of(context);
    final isGraphical = timeValue.valueType.isGraphical;
    final longitude = EpochApp.of(context).lmstLongitude;
    final localIanaZone = EpochApp.of(context).localIanaZone;

    // View mode: delegate to Row widgets (they handle info/copy themselves)
    if (editIndex == null) {
      if (isGraphical) {
        return TimeGraphicalRow(
          key: ValueKey(timeValue.key),
          timeValue: timeValue,
          now: widget.now,
        );
      }
      return TimeStringRow(
        key: ValueKey(timeValue.key),
        timeValue: timeValue,
        now: widget.now,
        locale: locale,
        hourFormat24: widget.hourFormat24,
        thousandsSep: widget.thousandsSep,
        showDateDetails: widget.showDateDetails,
        longitude: longitude,
      );
    }

    // Edit mode: build ValueTile directly with edit action slots
    final zonedNow = TimeUtils.resolveLocalTime(
        timeValue, widget.now.toUtc(), localIanaZone);
    final display = TimeStringRow.computeDisplay(
      timeValue, widget.now, locale, l10n,
      localIanaZone: localIanaZone,
      hourFormat24: widget.hourFormat24,
      thousandsSep: widget.thousandsSep,
      showDateDetails: widget.showDateDetails,
      dateFormat: app.dateFormat,
      timeFormat: app.timeFormat,
      zoneDisplayMode: app.zoneDisplayMode,
      longitude: longitude,
    );
    final label = TimeStringRow.computeLabel(l10n, timeValue, longitude);

    final segmentColor = switch (app.themeMode) {
      AppThemeMode.light  => Colors.black,
      AppThemeMode.dark   => Colors.white,
      AppThemeMode.night  => kColorNightRed,
      AppThemeMode.system => Theme.of(context).brightness == Brightness.dark
          ? Colors.white : Colors.black,
    };

    late final Widget clock;
    if (isGraphical) {
      clock = switch (timeValue.valueType) {
        ValueType.sevenSegmentClock =>
            SevenSegmentClock(
              now: zonedNow,
              l10n: l10n,
              digitHeight: kGraphicalSegmentClockHeightDefault,
              showSeconds: timeValue.showSeconds,
              hourFormat24: app.hourFormat24,
              color: segmentColor,
            ),
        ValueType.binaryClockColumns =>
            BinaryColumnsClock(
              now: zonedNow,
              l10n: l10n,
              showSeconds: timeValue.showSeconds,
            ),
        ValueType.binaryClockBcd =>
            BinaryCodedDecimalClock(
              now: zonedNow,
              l10n: l10n,
              showSeconds: timeValue.showSeconds,
            ),
        _ => throw StateError(
            'Unhandled graphical ValueType: ${timeValue.valueType}'),
      };
    };

    String? ianaZone = TimeUtils.resolveIanaZone(timeValue, localIanaZone);

    final Color? dayQuarterColor = app.dayQuarterColor &&
        app.themeMode != AppThemeMode.night &&
        !timeValue.isZoneIndependent
        ? TimeUtils.dayQuarterColor(widget.now.toUtc(), ianaZone)
        : null;

    return Dismissible(
      key: ValueKey(timeValue.key),
      direction: DismissDirection.endToStart,
      background: _dismissBackground(),
      onDismissed: (_) {
        final updated = List<TabEntry>.of(widget.entries);
        updated.removeAt(editIndex);
        _checked.remove(timeValue.key);
        widget.onEntriesChanged(updated);
      },
      child: ValueTile(
        label: label,
        showZoneIndicator: !timeValue.isZoneIndependent,
        showPinnedIndicator: timeValue.timezoneClockChangeMode != TimezoneClockChangeMode.auto,
        dstStatusIndicator: timeValue.getDstStatusIndicator(widget.now.toUtc(), localIanaZone),
        height: isGraphical ? ValueTile.graphicTileHeight : null,
        content: isGraphical
            ? GraphicValueContent(
                clock: clock,
                dayQuarterColor: dayQuarterColor,
              )
            : TextValueContent(
                line1: display.line1,
                line2: display.line2,
                dayQuarterColor: dayQuarterColor,
              ),
        actionSlots: _editActionSlots(context, timeValue, editIndex, l10n),
      ),
    );
  }

  Widget _dismissBackground() => Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 16),
    color: Colors.redAccent.withAlpha(200),
    child: const Icon(Icons.delete_outline, color: Colors.white),
  );

  List<Widget?> _editActionSlots(
      BuildContext context, TimeValue timeValue,
      int index, AppLocalizations l10n) {
    return [
      IconButton(
        icon: const Icon(Icons.edit, size: kIconSizeDefault),
        color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
        tooltip: l10n.hintEditTimeValue,
        onPressed: () => _editLabel(context, timeValue, l10n, index),
      ),
      ReorderableDragStartListener(
        index: index,
        child: Icon(Icons.drag_handle, size: kIconSizeDefault,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
      ),
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() {
          if (_checked.contains(timeValue.key)) {
            _checked.remove(timeValue.key);
          } else {
            _checked.add(timeValue.key);
          }
        }),
        child: Tooltip(
          message: _checked.contains(timeValue.key)
              ? l10n.hintDeselect : l10n.hintSelect,
          child: Checkbox(
            value: _checked.contains(timeValue.key),
            tristate: false,
            onChanged: null,
          ),
        ),
      ),
    ];
  }

  List<TabEntry> _cleanTrailing(List<TabEntry> entries) {
    final result = entries.toList();
    while (result.isNotEmpty && result.last is! TimeValue) {
      result.removeLast();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return Column(
      children: [
        _EditToolbar(
          editMode: _editMode,
          allChecked: _allChecked,
          anyChecked: _checked.isNotEmpty,
          timeValueCount: _valueCount,
          onToggleEditMode: _toggleEditMode,
          onToggleMasterCheck: _toggleMasterCheck,
          onDeleteChecked: _removeChecked,
          onResetDefaults: _resetToDefaults,
        ),
        Expanded(
          child:
            widget.entries.isEmpty && !_editMode
              ? const _EmptyTabHint()
                : _editMode
                  ? _buildEditList(l10n, locale)
                  : _buildDisplayList(l10n, locale)
        ),
        if (_editMode)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  tooltip: l10n.hintAddValue,
                  onPressed: _showAddDialog,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Toolbar ───────────────────────────────────────────────────────────────────

class _EditToolbar extends StatelessWidget {
  final bool editMode;
  final bool allChecked;
  final bool anyChecked;
  final int timeValueCount;
  final VoidCallback onToggleEditMode;
  final VoidCallback onToggleMasterCheck;
  final VoidCallback onDeleteChecked;
  final VoidCallback onResetDefaults;

  const _EditToolbar({
    required this.editMode,
    required this.allChecked,
    required this.anyChecked,
    required this.timeValueCount,
    required this.onToggleEditMode,
    required this.onToggleMasterCheck,
    required this.onDeleteChecked,
    required this.onResetDefaults,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kTabHorizontalPadding, kTabVerticalPadding,
          kTabHorizontalPadding, kTabVerticalPadding),
      child: Row(
        children: [
          Text(
            l10n.dataTabValueCount(timeValueCount),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ),
          const Spacer(),
          if (editMode && anyChecked)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.redAccent,
              tooltip: l10n.hintRemoveSelected,
              onPressed: onDeleteChecked,
            ),
          if (editMode)
            IconButton(
              icon: const Icon(Icons.restart_alt),
              tooltip: l10n.hintResetToDefaults,
              onPressed: onResetDefaults,
            ),
          IconButton(
            icon: Icon(editMode ? Icons.check : Icons.edit),
            tooltip: editMode ? l10n.hintDoneEditing : l10n.hintEditLayout,
            onPressed: onToggleEditMode,
          ),
          if (editMode)
            Tooltip(
              message: allChecked ? l10n.hintDeselectAll : l10n.hintSelectAll,
              child: Checkbox(
                value: allChecked,
                tristate: false,
                onChanged: (_) => onToggleMasterCheck(),
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyTabHint extends StatelessWidget {
  const _EmptyTabHint();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          l10n.messageEmptyTab,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
          ),
        ),
      ),
    );
  }
}