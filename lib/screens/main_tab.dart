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

    final result = await showDialog<MainTabEntry>(
      context: context,
      builder: (ctx) => const _EntryPicker(),
    );
    if (result == null) return;

    if (_entries.any((e) => e.key == result.key)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This value is already displayed.'),
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

// A self-contained three-step dialog:
// Step 1: choose value type (Date / Time / Day second)
// Step 2: choose zone (Local / UTC / region list)
// Step 3: choose city within region
class _EntryPicker extends StatefulWidget {
  const _EntryPicker();

  @override
  State<_EntryPicker> createState() => _EntryPickerState();
}

enum _Step { valueType, zone, city }

class _EntryPickerState extends State<_EntryPicker> {
  _Step _step = _Step.valueType;
  ValueType? _type;
  String? _region;

  String get _typeLabel => switch (_type) {
    ValueType.date => 'Date',
    ValueType.time => 'Time',
    ValueType.daySecond => 'Day second',
    null => '',
  };

  void _selectType(ValueType t) {
    setState(() {
      _type = t;
      _step = _Step.zone;
    });
  }

  void _selectRegion(String region) {
    setState(() {
      _region = region;
      _step = _Step.city;
    });
  }

  void _goBack() {
    setState(() {
      if (_step == _Step.city) {
        _step = _Step.zone;
        _region = null;
      } else if (_step == _Step.zone) {
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
      _Step.zone      => _buildZoneStep(),
      _Step.city      => _buildCityStep(),
    };
  }

  // Step 1 – no back button, Cancel only.
  Widget _buildValueTypeStep() {
    return SimpleDialog(
      title: const Text('Select value type'),
      children: [
        ...ValueType.values.map((t) {
          final label = switch (t) {
            ValueType.date      => 'Date',
            ValueType.time      => 'Time',
            ValueType.daySecond => 'Day second',
          };
          return SimpleDialogOption(
            onPressed: () => _selectType(t),
            child: Text(label),
          );
        }),
        const Divider(),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  // Step 2 – back goes to Step 1.
  Widget _buildZoneStep() {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(8, 16, 24, 0),
      title: _DialogTitle(
        superLabel: _typeLabel,
        title: 'Select timezone',
        onBack: _goBack,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Local (system timezone)'),
              onTap: () => _confirm(const ZoneLocal()),
            ),
            ListTile(
              title: const Text('UTC'),
              onTap: () => _confirm(const ZoneUtc()),
            ),
            const Divider(),
            ...timezonesByRegion.keys.map((region) => ListTile(
              title: Text(region),
              trailing: const Icon(
                Icons.chevron_right,
                size: 18,
                color: Colors.grey,
              ),
              onTap: () => _selectRegion(region),
            )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  // Step 3 – back goes to Step 2.
  Widget _buildCityStep() {
    final zones = timezonesByRegion[_region]!;
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(8, 16, 24, 0),
      title: _DialogTitle(
        superLabel: _typeLabel,
        title: _region!,
        onBack: _goBack,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: zones
              .map((z) => ListTile(
            title: Text(friendlyZoneName(z)),
            onTap: () => _confirm(ZoneNamed(z)),
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
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
                  ?.copyWith(color: Colors.grey),
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