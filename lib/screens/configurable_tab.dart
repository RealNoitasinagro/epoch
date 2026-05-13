import 'package:flutter/material.dart';
import '../models/time_entry.dart';
import '../l10n/app_localizations.dart';
import '../widgets/binary_columns_clock.dart';
import '../widgets/binary_coded_decimal_clock.dart';
import '../widgets/time_row.dart';
import 'entry_picker.dart';

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
      existingEntries: widget.entries,
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
          child:
            widget.entries.isEmpty && !_editMode
              ? _EmptyTabHint()
              : ListView.separated(
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
                return TimeRow(
                  label: entry.localizedLabel(l10n),
                  info: entry.localizedInfo(l10n),
                  value: '',
                  hideCopyButton: true,
                );
              }
              if (entry.type == ValueType.binaryClockBcd) {
                return TimeRow(
                  label: entry.localizedLabel(l10n),
                  info: entry.localizedInfo(l10n),
                  value: '',
                  hideCopyButton: true,
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

class _EmptyTabHint extends StatelessWidget {
  const _EmptyTabHint();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          l10n.emptyTabHint,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
          ),
        ),
      ),
    );
  }
}