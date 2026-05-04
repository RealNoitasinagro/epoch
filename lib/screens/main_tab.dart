import 'package:flutter/material.dart';
import '../models/time_value.dart';
import '../models/main_tab_config.dart';
import '../widgets/time_row.dart';

class MainTab extends StatefulWidget {
  final DateTime now;
  final String ianaZone;

  const MainTab({
    super.key,
    required this.now,
    this.ianaZone = 'local',
  });

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  List<TimeValueId> _activeIds = [];
  bool _editMode = false;
  bool _loaded = false;
  // Tracks which rows are checked in edit mode.
  final Set<TimeValueId> _checked = {};

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final ids = await loadMainTabIds();
    setState(() {
      _activeIds = ids;
      _loaded = true;
    });
  }

  Future<void> _persistConfig() async {
    await saveMainTabIds(_activeIds);
  }

  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
      if (!_editMode) _checked.clear();
    });
  }

  void _toggleCheck(TimeValueId id) {
    setState(() {
      if (_checked.contains(id)) {
        _checked.remove(id);
      } else {
        _checked.add(id);
      }
    });
  }

  // Returns true if all active rows are checked.
  bool get _allChecked =>
      _activeIds.isNotEmpty && _checked.containsAll(_activeIds);

  void _toggleMasterCheck() {
    setState(() {
      if (_allChecked) {
        _checked.clear();
      } else {
        _checked.addAll(_activeIds);
      }
    });
  }

  void _removeChecked() {
    setState(() {
      _activeIds.removeWhere((id) => _checked.contains(id));
      _checked.clear();
    });
    _persistConfig();
  }

  void _moveUp(int index) {
    if (index <= 0) return;
    setState(() {
      final item = _activeIds.removeAt(index);
      _activeIds.insert(index - 1, item);
    });
    _persistConfig();
  }

  void _moveDown(int index) {
    if (index >= _activeIds.length - 1) return;
    setState(() {
      final item = _activeIds.removeAt(index);
      _activeIds.insert(index + 1, item);
    });
    _persistConfig();
  }

  void _showAddDialog(Map<TimeValueId, TimeValue> allValues) {
    final available =
        allValues.keys.where((id) => !_activeIds.contains(id)).toList();

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All available values are already displayed.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add value'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: available.map((id) {
              final tv = allValues[id]!;
              return ListTile(
                title: Text(tv.label),
                subtitle: tv.info != null
                    ? Text(
                        tv.info!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      )
                    : null,
                onTap: () {
                  setState(() => _activeIds.add(id));
                  _persistConfig();
                  Navigator.pop(ctx);
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Center(child: CircularProgressIndicator());
    }

    final locale = Localizations.localeOf(context).toString();
    final allValuesList =
        computeAllValues(widget.now, locale, widget.ianaZone);
    final allValues = {for (final v in allValuesList) v.id: v};

    return Column(
      children: [
        // Toolbar row – always visible, avoids Stack/ListView conflict.
        _EditToolbar(
          editMode: _editMode,
          allChecked: _allChecked,
          anyChecked: _checked.isNotEmpty,
          onToggleEditMode: _toggleEditMode,
          onToggleMasterCheck: _toggleMasterCheck,
          onDeleteChecked: _removeChecked,
        ),

        // Scrollable content.
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
            itemCount: _activeIds.length,
            separatorBuilder: (_, __) => const Divider(height: 32),
            itemBuilder: (context, index) {
              final id = _activeIds[index];
              final tv = allValues[id];
              if (tv == null) return const SizedBox.shrink();

              if (_editMode) {
                return _EditRow(
                  label: tv.label,
                  checked: _checked.contains(id),
                  index: index,
                  total: _activeIds.length,
                  onToggleCheck: () => _toggleCheck(id),
                  onMoveUp: () => _moveUp(index),
                  onMoveDown: () => _moveDown(index),
                );
              }

              return TimeRow(
                label: tv.label,
                value: tv.value,
                info: tv.info,
                useThousands: tv.useThousands,
              );
            },
          ),
        ),

        // Add button – only in edit mode, as a bottom bar button.
        if (_editMode)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  tooltip: 'Add value',
                  onPressed: () => _showAddDialog(allValues),
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Toolbar shown above the list, handles edit/done toggle,
// master checkbox and delete button.
class _EditToolbar extends StatelessWidget {
  final bool editMode;
  final bool allChecked;
  final bool anyChecked;
  final VoidCallback onToggleEditMode;
  final VoidCallback onToggleMasterCheck;
  final VoidCallback onDeleteChecked;

  const _EditToolbar({
    required this.editMode,
    required this.allChecked,
    required this.anyChecked,
    required this.onToggleEditMode,
    required this.onToggleMasterCheck,
    required this.onDeleteChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Row(
        children: [
          // Master checkbox – only visible in edit mode.
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

          // Trashcan – only visible when at least one row is checked.
          if (editMode && anyChecked)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.redAccent,
              tooltip: 'Remove selected',
              onPressed: onDeleteChecked,
            ),

          // Edit / Done toggle.
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

// A single row in edit mode: checkbox left, label centre,
// move-up/down arrows right.
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