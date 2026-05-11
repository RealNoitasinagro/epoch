import 'package:flutter/material.dart';
import '../models/time_entry.dart';
import '../l10n/app_localizations.dart';
import '../time_utils.dart';
import '../widgets/graphical_row.dart';
import '../widgets/time_row.dart';
import 'entry_picker.dart';
import 'timezone_search_screen.dart';

// A fully configurable tab used by both Civil and custom Watchlist tabs.
// [entries] and [onEntriesChanged] are managed by the parent.
class ConfigurableTab extends StatefulWidget {
  final DateTime now;
  final List<TimeEntry> entries;
  final bool thousandsSep;
  final bool hourFormat24;
  final int maxEntries;
  final ValueChanged<List<TimeEntry>> onEntriesChanged;
  final List<ValueType>? allowedTypes; // null = all types allowed

  const ConfigurableTab({
    super.key,
    required this.now,
    required this.entries,
    required this.onEntriesChanged,
    this.thousandsSep = true,
    this.hourFormat24 = true,
    this.maxEntries = 20,
    this.allowedTypes,
  });

  @override
  State<ConfigurableTab> createState() => _ConfigurableTabState();
}

class _ConfigurableTabState extends State<ConfigurableTab> {
  bool _editMode = false;
  final Set<String> _checked = {};

  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
      if (!_editMode) _checked.clear();
    });
  }

  void _toggleCheck(String key) {
    setState(() {
      if (_checked.contains(key)) {
        _checked.remove(key);
      } else {
        _checked.add(key);
      }
    });
  }

  bool get _allChecked =>
      widget.entries.isNotEmpty &&
          widget.entries.every((e) => _checked.contains(e.key));

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
    widget.onEntriesChanged(List.of(defaultCivilEntries));
    setState(() {});
  }

  void _moveUp(int index) {
    if (index <= 0) return;
    final updated = List<TimeEntry>.of(widget.entries);
    final item = updated.removeAt(index);
    updated.insert(index - 1, item);
    widget.onEntriesChanged(updated);
  }

  void _moveDown(int index) {
    if (index >= widget.entries.length - 1) return;
    final updated = List<TimeEntry>.of(widget.entries);
    final item = updated.removeAt(index);
    updated.insert(index + 1, item);
    widget.onEntriesChanged(updated);
  }

  Future<void> _showAddDialog() async {
    final l10n = AppLocalizations.of(context)!;
    if (widget.entries.length >= widget.maxEntries) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l10n.maxValuesReached(widget.maxEntries)),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    final result = await showEntryPicker(
      context,
      allowedTypes: widget.allowedTypes,
    );
    if (result == null) return;

    if (widget.entries.any((e) => e.key == result.key)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l10n.alreadyDisplayed),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    widget.onEntriesChanged([...widget.entries, result]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Localizations.localeOf(context).toString();

    return Column(
      children: [
        _EditToolbar(
          editMode: _editMode,
          allChecked: _allChecked,
          anyChecked: _checked.isNotEmpty,
          onToggleEditMode: _toggleEditMode,
          onToggleMasterCheck: _toggleMasterCheck,
          onDeleteChecked: _removeChecked,
          onResetDefaults: _resetToDefaults,
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
            itemCount: widget.entries.length,
            separatorBuilder: (_, __) => const Divider(height: 32),
            itemBuilder: (context, index) {
              final entry = widget.entries[index];
              final l10n = AppLocalizations.of(context)!;
              final locale = Localizations.localeOf(context).toString();

              if (_editMode) {
                return _EditRow(
                  label: entry.localizedLabel(l10n),
                  checked: _checked.contains(entry.key),
                  index: index,
                  total: widget.entries.length,
                  onToggleCheck: () => _toggleCheck(entry.key),
                  onMoveUp: () => _moveUp(index),
                  onMoveDown: () => _moveDown(index),
                );
              }

              // Graphical binary clocks get special rendering.
              if (entry.type == ValueType.binaryClockColumns) {
                return GraphicalRow(
                  label: entry.localizedLabel(l10n),
                  info: entry.localizedInfo(l10n),
                  value: _ColumnBinaryClockWidget(now: widget.now),
                );
              }
              if (entry.type == ValueType.binaryClockBcd) {
                return GraphicalRow(
                  label: entry.localizedLabel(l10n),
                  info: entry.localizedInfo(l10n),
                  value: _BcdBinaryClockWidget(now: widget.now),
                );
              }

              return TimeRow(
                label: entry.localizedLabel(l10n),
                value: entry.computeValue(
                  widget.now,
                  locale,
                  hourFormat24: widget.hourFormat24,
                  thousandsSep: widget.thousandsSep,
                ),
                info: entry.localizedInfo(l10n),
                useThousands: entry.useThousands && widget.thousandsSep,
              );
            },
          ),
        ),
        if (_editMode)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  tooltip: l10n.addValue,
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
  final VoidCallback onToggleEditMode;
  final VoidCallback onToggleMasterCheck;
  final VoidCallback onDeleteChecked;
  final VoidCallback onResetDefaults;

  const _EditToolbar({
    required this.editMode,
    required this.allChecked,
    required this.anyChecked,
    required this.onToggleEditMode,
    required this.onToggleMasterCheck,
    required this.onDeleteChecked,
    required this.onResetDefaults,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Row(
        children: [
          if (editMode)
            Tooltip(
              message: allChecked ? l10n.deselectAll : l10n.selectAll,
              child: Checkbox(
                value: allChecked,
                tristate: false,
                onChanged: (_) => onToggleMasterCheck(),
              ),
            ),
          const Spacer(),
          if (editMode) ...[
            if (anyChecked)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: Colors.redAccent,
                tooltip: l10n.removeSelected,
                onPressed: onDeleteChecked,
              ),
            IconButton(
              icon: const Icon(Icons.restart_alt),
              tooltip: l10n.resetToDefaults,
              onPressed: onResetDefaults,
            ),
          ],
          IconButton(
            icon: Icon(editMode ? Icons.check : Icons.edit),
            tooltip: editMode ? l10n.doneEditing : l10n.editLayout,
            onPressed: onToggleEditMode,
          ),
        ],
      ),
    );
  }
}

// ── Edit row ──────────────────────────────────────────────────────────────────

class _EditRow extends StatelessWidget {
  final String label;
  final bool checked;
  final int index;
  final int total;
  final VoidCallback onToggleCheck;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const _EditRow({
    required this.label,
    required this.checked,
    required this.index,
    required this.total,
    required this.onToggleCheck,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Tooltip(
          message: checked ? l10n.deselect : l10n.selectForRemoval,
          child: Checkbox(
            value: checked,
            onChanged: (_) => onToggleCheck(),
          ),
        ),
        Expanded(
          child: Text(label,
              style: Theme.of(context).textTheme.titleMedium),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_upward, size: 20),
          tooltip: l10n.moveUp,
          onPressed: index > 0 ? onMoveUp : null,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_downward, size: 20),
          tooltip: l10n.moveDown,
          onPressed: index < total - 1 ? onMoveDown : null,
        ),
      ],
    );
  }
}

// ── Entry picker ──────────────────────────────────────────────────────────────

class _EntryPicker extends StatefulWidget {
  const _EntryPicker();

  @override
  State<_EntryPicker> createState() => _EntryPickerState();
}

enum _Step { valueType, zone }

class _EntryPickerState extends State<_EntryPicker> {
  _Step _step = _Step.valueType;
  ValueType? _type;

  String _typeLabel(AppLocalizations l10n) => switch (_type) {
    ValueType.date               => l10n.valueTypeDate,
    ValueType.time               => l10n.valueTypeTime,
    ValueType.daySecond          => l10n.valueTypeDaySecond,
    ValueType.binaryClockString  => l10n.valueTypeBinaryClockString,
    ValueType.binaryClockColumns => l10n.valueTypeBinaryClockColumns,
    ValueType.binaryClockBcd     => l10n.valueTypeBinaryClockBcd,
    ValueType.unixSeconds        => l10n.labelUnixSeconds,
    ValueType.tai                => l10n.labelTai,
    ValueType.gps                => l10n.labelGps,
    ValueType.gmst               => l10n.labelGmst,
    ValueType.julianDate         => l10n.labelJd,
    ValueType.modifiedJulianDate => l10n.labelMjd,
    ValueType.swatchBeats        => l10n.labelSwatchBeats,
    null                         => '',
  };

  void _selectType(ValueType t) {
    if (t.isZoneIndependentStatic) {
      // Zone-independent: confirm immediately with UTC as placeholder zone.
      Navigator.pop(context,
          TimeEntry(type: t, zone: const ZoneUtc()));
    } else {
      setState(() {
        _type = t;
        _step = _Step.zone;
      });
    }
  }

  void _goBack() {
    setState(() {
      _step = _Step.valueType;
      _type = null;
    });
  }

  void _confirm(ZoneSpec zone) {
    Navigator.pop(context, TimeEntry(type: _type!, zone: zone));
  }

  @override
  Widget build(BuildContext context) {
    return switch (_step) {
      _Step.valueType => _buildValueTypeStep(),
      _Step.zone      => _buildZoneStep(),
    };
  }

  Widget _buildValueTypeStep() {
    final l10n = AppLocalizations.of(context)!;
    return SimpleDialog(
      title: Text(l10n.selectValueType),
      children: [
        // Zone-dependent types.
        _sectionLabel(context, l10n.sectionCivil),
        ...[ ValueType.date, ValueType.time, ValueType.daySecond,
          ValueType.binaryClockString,
        ].map((t) => SimpleDialogOption(
          onPressed: () => _selectType(t),
          child: Text(_typeLabelStatic(t, l10n)),
        )),
        const Divider(),
        _sectionLabel(context, l10n.sectionTechnical),
        ...[ ValueType.unixSeconds, ValueType.tai, ValueType.gps,
        ].map((t) => SimpleDialogOption(
          onPressed: () => _selectType(t),
          child: Text(_typeLabelStatic(t, l10n)),
        )),
        const Divider(),
        _sectionLabel(context, l10n.sectionAstronomy),
        ...[ ValueType.gmst, ValueType.julianDate,
          ValueType.modifiedJulianDate,
        ].map((t) => SimpleDialogOption(
          onPressed: () => _selectType(t),
          child: Text(_typeLabelStatic(t, l10n)),
        )),
        const Divider(),
        _sectionLabel(context, l10n.sectionCuriosities),
        ...[ ValueType.swatchBeats,
        ].map((t) => SimpleDialogOption(
          onPressed: () => _selectType(t),
          child: Text(_typeLabelStatic(t, l10n)),
        )),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ),
      ],
    );
  }

  Widget _buildZoneStep() {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(8, 16, 24, 0),
      title: _DialogTitle(
        superLabel: _typeLabel(l10n),
        title: l10n.selectTimezone,
        onBack: _goBack,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(l10n.zoneLocal),
              onTap: () => _confirm(const ZoneLocal()),
            ),
            ListTile(
              title: Text(l10n.zoneUtc),
              onTap: () => _confirm(const ZoneUtc()),
            ),
            ListTile(
              title: Text(l10n.zoneOther),
              trailing: const Icon(Icons.search),
              onTap: () async {
                final zone = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TimezoneSearchScreen(),
                  ),
                );
                if (zone != null) _confirm(ZoneNamed(zone));
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }

  // Static helper – same mapping without instance state.
  String _typeLabelStatic(ValueType t, AppLocalizations l10n) =>
      switch (t) {
        ValueType.date               => l10n.valueTypeDate,
        ValueType.time               => l10n.valueTypeTime,
        ValueType.daySecond          => l10n.valueTypeDaySecond,
        ValueType.binaryClockString  => l10n.valueTypeBinaryClockString,
        ValueType.binaryClockColumns => l10n.valueTypeBinaryClockColumns,
        ValueType.binaryClockBcd     => l10n.valueTypeBinaryClockBcd,
        ValueType.unixSeconds        => l10n.labelUnixSeconds,
        ValueType.tai                => l10n.labelTai,
        ValueType.gps                => l10n.labelGps,
        ValueType.gmst               => l10n.labelGmst,
        ValueType.julianDate         => l10n.labelJd,
        ValueType.modifiedJulianDate => l10n.labelMjd,
        ValueType.swatchBeats        => l10n.labelSwatchBeats,
      };

  Widget _sectionLabel(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
    child: Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 1.5,
      ),
    ),
  );
}

// ── Zone-independent check as extension ──────────────────────────────────────

extension on ValueType {
  bool get isZoneIndependentStatic => switch (this) {
    ValueType.date              => false,
    ValueType.time              => false,
    ValueType.daySecond         => false,
    ValueType.binaryClockString => false,
    _                           => true,
  };
}

// ── Shared dialog title with back button ──────────────────────────────────────

class _DialogTitle extends StatelessWidget {
  final String superLabel;
  final String title;
  final VoidCallback onBack;

  const _DialogTitle({
    required this.superLabel,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n.back,
          onPressed: onBack,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(superLabel,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.grey)),
            Text(title,
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ],
    );
  }
}

// Minimal column binary clock for use in configurable tabs.
class _ColumnBinaryClockWidget extends StatelessWidget {
  final DateTime now;
  const _ColumnBinaryClockWidget({required this.now});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bin = TimeUtils.binaryTime(now);
    final litColor = Theme.of(context).colorScheme.primary;
    final dimColor = Theme.of(context).colorScheme.outline;

    Widget bitColumn(String bits, String header, int totalRows) {
      final padding = totalRows - bits.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(header,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              )),
          const SizedBox(height: 6),
          ...List.generate(padding, (_) => const SizedBox(height: 28)),
          ...bits.split('').map((b) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Container(
              width: 22, height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: b == '1' ? litColor : dimColor.withAlpha(60),
                border: Border.all(
                    color: b == '1' ? litColor : dimColor, width: 1.5),
              ),
            ),
          )),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bitColumn(bin.hours,   l10n.labelHours,   6),
        const SizedBox(width: 16),
        bitColumn(bin.minutes, l10n.labelMinutes, 6),
        const SizedBox(width: 16),
        bitColumn(bin.seconds, l10n.labelSeconds, 6),
      ],
    );
  }
}

// Minimal BCD binary clock for use in configurable tabs.
class _BcdBinaryClockWidget extends StatelessWidget {
  final DateTime now;
  const _BcdBinaryClockWidget({required this.now});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bcd = TimeUtils.bcdTime(now);
    final litColor = Theme.of(context).colorScheme.primary;
    final dimColor = Theme.of(context).colorScheme.outline;

    Widget bitColumn(String bits) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: bits.split('').map((b) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Container(
            width: 22, height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: b == '1' ? litColor : dimColor.withAlpha(60),
              border: Border.all(
                  color: b == '1' ? litColor : dimColor, width: 1.5),
            ),
          ),
        )).toList(),
      );
    }

    Widget groupLabel(String label) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
        ),
        textAlign: TextAlign.center,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 50, child: groupLabel(l10n.labelHours)),
            const SizedBox(width: 8),
            SizedBox(width: 50, child: groupLabel(l10n.labelMinutes)),
            const SizedBox(width: 8),
            SizedBox(width: 50, child: groupLabel(l10n.labelSeconds)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            bitColumn(bcd.hourTens),  const SizedBox(width: 6),
            bitColumn(bcd.hourUnits), const SizedBox(width: 8),
            bitColumn(bcd.minTens),   const SizedBox(width: 6),
            bitColumn(bcd.minUnits),  const SizedBox(width: 8),
            bitColumn(bcd.secTens),   const SizedBox(width: 6),
            bitColumn(bcd.secUnits),
          ],
        ),
      ],
    );
  }
}