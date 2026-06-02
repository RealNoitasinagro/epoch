import 'package:epoch/widgets/time_string_row.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/time_value.dart';
import '../time_utils.dart';
import '../widgets/clocks/binary_coded_decimal_clock.dart';
import '../widgets/clocks/binary_columns_clock.dart';
import '../widgets/time_entry_row.dart';
import '../widgets/value_tile.dart';
import 'entry_picker.dart';

// A fully configurable tab used by both Civil and custom Watchlist tabs.
// [entries] and [onEntriesChanged] are managed by the parent.
class ConfigurableTab extends StatefulWidget {
  final DateTime now;
  final List<TimeValue> entries;
  final bool thousandsSep;
  final bool hourFormat24;
  final int maxEntries;
  final ValueChanged<List<TimeValue>> onEntriesChanged;
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
  final ScrollController _scrollController = ScrollController();
  double _savedScrollOffset = 0.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
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

  Widget _buildDisplayList(AppLocalizations l10n, String locale) {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
      itemCount: widget.entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final entry = widget.entries[index];
        return _buildDisplayRow(context, entry, l10n, locale);
      },
    );
  }

  Widget _buildDisplayRow(
      BuildContext context,
      TimeValue entry,
      AppLocalizations l10n,
      String locale,
      ) {
    return TimeEntryRow(
      key: ValueKey(entry.key),
      entry: entry,
      now: widget.now,
      locale: locale,
      //infoLink: entry.localizedInfoLink(l10n),
      hourFormat24: widget.hourFormat24,
      thousandsSep: widget.thousandsSep,
    );
  }

  Widget _buildEditList(AppLocalizations l10n, String locale) {
    return ReorderableListView.builder(
      scrollController: _scrollController,
      buildDefaultDragHandles: false, // we provide our own via ReorderableDragStartListener
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      itemCount: widget.entries.length,
      onReorderItem: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex--;
        final updated = List<TimeValue>.of(widget.entries);
        final item = updated.removeAt(oldIndex);
        updated.insert(newIndex, item);
        widget.onEntriesChanged(updated);
      },
      itemBuilder: (context, index) {
        final entry = widget.entries[index];
        return Padding(
          key: ValueKey(entry.key),
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildEditRow(context, entry, index, l10n, locale),
        );
      },
    );
  }

  Widget _buildEditRow(
      BuildContext context,
      TimeValue entry,
      int index,
      AppLocalizations l10n,
      String locale,
      ) {
    String localIanaZone = EpochApp.of(context).localIanaZone;

    bool isGraphical =
      entry.type == ValueType.binaryClockColumns ||
      entry.type == ValueType.binaryClockBcd
      ? true
      : false;
    final displayValue =
      isGraphical
      ? '[${l10n.binaryClockPlaceholder}]'
      : entry.computeValue(
        widget.now,
        locale,
        hourFormat24: widget.hourFormat24,
        thousandsSep: widget.thousandsSep,
        localIanaZone: localIanaZone,
      );

    final DateTime zonedNow = switch (entry.zone) {
      ZoneLocal()                  => widget.now,
      ZoneUtc()                    => widget.now.toUtc(),
      ZoneNamed(ianaZone: final z) =>
          TimeUtils.inZone(widget.now.toUtc(), z),
    };

    final split = ValueDisplay.split(displayValue);

    return Dismissible(
      key: ValueKey(entry.key),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.redAccent.withAlpha(200),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) {
        final updated = List<TimeValue>.of(widget.entries);
        updated.removeAt(index);
        _checked.remove(entry.key);
        widget.onEntriesChanged(updated);
      },
      child: ValueTile(
        label: entry.localizedLabel(l10n),
        height: isGraphical ? ValueTile.graphicTileHeight : null,
        content: isGraphical
            ? GraphicValueContent(
          clock: entry.type == ValueType.binaryClockColumns
              ? BinaryColumnsClock(now: zonedNow, l10n: l10n)
              : BinaryCodedDecimalClock(now: zonedNow, l10n: l10n),
        )
            : TextValueContent(line1: split.line1, line2: split.line2),
        actionSlots: [
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            tooltip: l10n.editLabel,
            onPressed: () => _editLabel(context, entry, l10n),
          ),
          ReorderableDragStartListener(
            index: index,
            child: Icon(Icons.drag_handle, size: 20,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() {
              if (_checked.contains(entry.key)) {
                _checked.remove(entry.key);
              } else {
                _checked.add(entry.key);
              }
            }),
            child: Checkbox(
              value: _checked.contains(entry.key),
              onChanged: null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editLabel(
      BuildContext context,
      TimeValue entry,
      AppLocalizations l10n,
      ) async {
    // Pre-fill with custom label if set, otherwise official label.
    final controller = TextEditingController(
      text: entry.customLabel ?? entry.localizedLabel(l10n),
    );
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.editLabel),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: l10n.newLabelName,
            // Show official label as hint so user knows the default.
            hintText: entry.localizedLabel(l10n),
          ),
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
          // Clear custom label button.
          TextButton(
            onPressed: () => Navigator.pop(ctx, ''),
            child: Text(l10n.resetToDefaults),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(ctx, controller.text.trim()),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    // Note: controller.dispose() intentionally omitted – Linux assertion.
    if (result == null) return;

    final updated = List<TimeValue>.of(widget.entries);
    final idx = updated.indexWhere((e) => e.key == entry.key);
    if (idx == -1) return;

    // Empty string = clear custom label, restore official label.
    updated[idx] = entry.withLabel(result.isEmpty ? null : result);
    widget.onEntriesChanged(updated);
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
          const Spacer(),
          if (editMode && anyChecked)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.redAccent,
              tooltip: l10n.removeSelected,
              onPressed: onDeleteChecked,
            ),
          if (editMode)
            IconButton(
              icon: const Icon(Icons.restart_alt),
              tooltip: l10n.resetToDefaults,
              onPressed: onResetDefaults,
            ),
          IconButton(
            icon: Icon(editMode ? Icons.check : Icons.edit),
            tooltip: editMode ? l10n.doneEditing : l10n.editLayout,
            onPressed: onToggleEditMode,
          ),
          if (editMode)
            Tooltip(
              message: allChecked ? l10n.deselectAll : l10n.selectAll,
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