import 'package:epoch/screens/timezone_search_screen.dart';
import 'package:flutter/material.dart';
import '../models/time_value.dart';
import '../models/main_tab_config.dart';
import '../widgets/time_row.dart';
import '../l10n/app_localizations.dart';

class MainTab extends StatefulWidget {
  final DateTime now;
  final bool thousandsSep;
  final bool hourFormat24;

  const MainTab({
    super.key,
    required this.now,
    this.thousandsSep = true,
    this.hourFormat24 = true,
  });

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  List<MainTabEntry> _entries = [];
  bool _editMode = false;
  bool _loaded = false;
  final Set<String> _checked = {};

  static const int _maxEntries = 20;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final entries = await loadMainTabEntries();
    setState(() {
      _entries = entries;
      _loaded = true;
    });
  }

  Future<void> _persist() async {
    await saveMainTabEntries(_entries);
  }

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
      _entries.isNotEmpty &&
          _entries.every((e) => _checked.contains(e.key));

  void _toggleMasterCheck() {
    setState(() {
      if (_allChecked) {
        _checked.clear();
      } else {
        _checked.addAll(_entries.map((e) => e.key));
      }
    });
  }

  void _removeChecked() {
    setState(() {
      _entries.removeWhere((e) => _checked.contains(e.key));
      _checked.clear();
    });
    _persist();
  }

  void _resetToDefaults() {
    setState(() {
      _entries = List.of(defaultMainTabEntries);
      _checked.clear();
    });
    _persist();
  }

  void _moveUp(int index) {
    if (index <= 0) return;
    setState(() {
      final item = _entries.removeAt(index);
      _entries.insert(index - 1, item);
    });
    _persist();
  }

  void _moveDown(int index) {
    if (index >= _entries.length - 1) return;
    setState(() {
      final item = _entries.removeAt(index);
      _entries.insert(index + 1, item);
    });
    _persist();
  }

  Future<void> _showAddDialog() async {
    final l10n = AppLocalizations.of(context)!;
    if (_entries.length >= _maxEntries) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.maxValuesReached(_maxEntries)),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final result = await showDialog<MainTabEntry>(
      context: context,
      builder: (ctx) => const _EntryPicker(),
    );
    if (result == null) return;

    if (_entries.any((e) => e.key == result.key)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.alreadyDisplayed),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _entries.add(result));
    _persist();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (!_loaded) {
      return const Center(child: CircularProgressIndicator());
    }

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
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
            itemCount: _entries.length,
            separatorBuilder: (_, __) => const Divider(height: 32),
            itemBuilder: (context, index) {
              final entry = _entries[index];

              if (_editMode) {
                return _EditRow(
                  //label: entry.label(entry.key),
                  label: entry.localizedLabel(l10n),
                  checked: _checked.contains(entry.key),
                  index: index,
                  total: _entries.length,
                  onToggleCheck: () => _toggleCheck(entry.key),
                  onMoveUp: () => _moveUp(index),
                  onMoveDown: () => _moveDown(index),
                );
              }

              return TimeRow(
                label: entry.localizedLabel(l10n),
                value: entry.computeValue(
                  widget.now,
                  locale,
                  hourFormat24: widget.hourFormat24,
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
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
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

// A self-contained three-step dialog:
// Step 1: choose value type (Date / Time / Day second)
// Step 2: choose zone (Local / UTC / region list)
// Step 3: choose city within region
class _EntryPicker extends StatefulWidget {
  const _EntryPicker();

  @override
  State<_EntryPicker> createState() => _EntryPickerState();
}

enum _Step { valueType, zone }

class _EntryPickerState extends State<_EntryPicker> {
  _Step _step = _Step.valueType;
  ValueType? _type;

  String _typeLabel(AppLocalizations l10n) =>
      switch (_type) {
        ValueType.date => l10n.valueTypeDate,
        ValueType.time => l10n.valueTypeTime,
        ValueType.daySecond => l10n.valueTypeDaySecond,
        ValueType.binaryClockString => l10n.valueTypeBinaryClockString,
        null => '',
      };

  void _selectType(ValueType t) {
    setState(() {
      _type = t;
      _step = _Step.zone;
    });
  }

  void _goBack() {
    setState(() {
      if (_step == _Step.zone) {
        _step = _Step.valueType;
        _type = null;
      }
    });
  }

  void _confirm(ZoneSpec zone) {
    Navigator.pop(context, MainTabEntry(type: _type!, zone: zone));
  }

  @override
  Widget build(BuildContext context) {
    return switch (_step) {
      _Step.valueType => _buildValueTypeStep(),
      _Step.zone => _buildZoneStep(),
    };
  }

  // Step 1 – no back button, Cancel only.
  Widget _buildValueTypeStep() {
    final l10n = AppLocalizations.of(context)!;
    return SimpleDialog(
      title: Text(l10n.selectValueType),
      children: [
        ...ValueType.values.map((t) {
          final label = switch (t) {
            ValueType.date => l10n.valueTypeDate,
            ValueType.time => l10n.valueTypeTime,
            ValueType.daySecond => l10n.valueTypeDaySecond,
            ValueType.binaryClockString => l10n.valueTypeBinaryClockString
          };
          return SimpleDialogOption(
            onPressed: () => _selectType(t),
            child: Text(label),
          );
        }),
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ),
      ],
    );
  }

  // Step 2 – back goes to Step 1.
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
}

// Reusable title row with optional back button and a small super-label.
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
            Text(
              superLabel,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ],
    );
  }
}