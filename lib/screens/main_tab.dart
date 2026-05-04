import 'package:flutter/material.dart';
import '../models/time_value.dart';
import '../models/main_tab_config.dart';
import '../models/timezone_data.dart';
import '../widgets/time_row.dart';

class MainTab extends StatefulWidget {
  final DateTime now;

  const MainTab({super.key, required this.now});

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

  // Step 1: choose value type.
  Future<ValueType?> _pickValueType() {
    return showDialog<ValueType>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select value type'),
        children: ValueType.values.map((t) {
          final label = switch (t) {
            ValueType.date      => 'Date',
            ValueType.time      => 'Time',
            ValueType.daySecond => 'Day second',
          };
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, t),
            child: Text(label),
          );
        }).toList(),
      ),
    );
  }

  // Step 2: choose zone (Local / UTC / Other → region → city).
  Future<ZoneSpec?> _pickZone() async {
    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select timezone'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 'local'),
            child: const Text('Local (system timezone)'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 'utc'),
            child: const Text('UTC'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 'other'),
            child: const Text('Other…'),
          ),
        ],
      ),
    );
    if (choice == null) return null;
    if (choice == 'local') return const ZoneLocal();
    if (choice == 'utc') return const ZoneUtc();

    // "Other" → region picker.
    if (!mounted) return null;
    final region = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select region'),
        children: timezonesByRegion.keys.map((r) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, r),
            child: Text(r),
          );
        }).toList(),
      ),
    );
    if (region == null || !mounted) return null;

    // Region → city picker.
    final zones = timezonesByRegion[region]!;
    final zone = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(region),
        children: zones.map((z) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, z),
            child: Text(friendlyZoneName(z)),
          );
        }).toList(),
      ),
    );
    if (zone == null) return null;
    return ZoneNamed(zone);
  }

  Future<void> _showAddDialog() async {
    if (_entries.length >= _maxEntries) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maximum of $_maxEntries values reached.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final type = await _pickValueType();
    if (type == null || !mounted) return;

    final zone = await _pickZone();
    if (zone == null) return;

    final entry = MainTabEntry(type: type, zone: zone);

    // Prevent duplicates.
    if (_entries.any((e) => e.key == entry.key)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This value is already displayed.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _entries.add(entry));
    _persist();
  }

  @override
  Widget build(BuildContext context) {
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
              final locale0 = locale;

              if (_editMode) {
                return _EditRow(
                  label: entry.label(entry.key),
                  checked: _checked.contains(entry.key),
                  index: index,
                  total: _entries.length,
                  onToggleCheck: () => _toggleCheck(entry.key),
                  onMoveUp: () => _moveUp(index),
                  onMoveDown: () => _moveDown(index),
                );
              }

              return TimeRow(
                label: entry.label(entry.key),
                value: entry.computeValue(widget.now, locale0),
                info: entry.info,
                useThousands: entry.useThousands,
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
                  tooltip: 'Add value',
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Row(
        children: [
          if (editMode)
            Tooltip(
              message: allChecked ? 'Deselect all' : 'Select all',
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
                tooltip: 'Remove selected',
                onPressed: onDeleteChecked,
              ),
            IconButton(
              icon: const Icon(Icons.restart_alt),
              tooltip: 'Reset to defaults',
              onPressed: onResetDefaults,
            ),
          ],
          IconButton(
            icon: Icon(editMode ? Icons.check : Icons.edit),
            tooltip: editMode ? 'Done editing' : 'Edit layout',
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
    return Row(
      children: [
        Tooltip(
          message: checked ? 'Deselect' : 'Select for removal',
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
          tooltip: 'Move up',
          onPressed: index > 0 ? onMoveUp : null,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_downward, size: 20),
          tooltip: 'Move down',
          onPressed: index < total - 1 ? onMoveDown : null,
        ),
      ],
    );
  }
}