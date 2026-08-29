import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../models/app_settings.dart';
import '../models/astronomical_tab_config.dart';
import '../models/civil_tab_config.dart';
import '../models/curiosities_tab_config.dart';
import '../models/tab_entry.dart';
import '../models/technical_tab_config.dart';
import '../models/time_value.dart';
import 'timezone_search_screen.dart';

// Displays a two-step dialog: value type → timezone (if zone-dependent).
// [allowedTypes] restricts which types are shown; null means all types.
Future<TabEntry?> showEntryPicker(
    BuildContext context, {
      List<ValueType>? allowedTypes,
      List<TabEntry> existingEntries = const [],
      LmstMode lmstMode = LmstMode.off,
      double? lmstLongitude,
      bool valueTypesOnly = false,  // hide divider/section options, e.g. for startup focus value
    }) {
  return showDialog<TabEntry>(
    context: context,
    builder: (ctx) => _EntryPicker(
      allowedTypes: allowedTypes,
      existingEntries: existingEntries,
      lmstMode: lmstMode,
      lmstLongitude: lmstLongitude,
      valueTypesOnly: valueTypesOnly,
    ),
  );
}

class _EntryPicker extends StatefulWidget {
  final List<ValueType>? allowedTypes;
  final List<TabEntry> existingEntries;
  final LmstMode lmstMode;
  final double? lmstLongitude;
  final bool valueTypesOnly;

  const _EntryPicker({
    this.allowedTypes,
    this.existingEntries = const [],
    required this.lmstMode,
    this.lmstLongitude,
    this.valueTypesOnly = false,
  });

  @override
  State<_EntryPicker> createState() => _EntryPickerState();
}

enum _Step { valueType, zone }

class _EntryPickerState extends State<_EntryPicker> {
  _Step _step = _Step.valueType;
  ValueType? _type;
  final bool showZoneIndicator = true;

  bool _isAllowed(ValueType t) =>
      widget.allowedTypes == null || widget.allowedTypes!.contains(t);

  // Zone-independent types can only appear once.
  // Zone-dependent types can always be added (different zones allowed).
  bool _isDisabled(ValueType t) {
    if (t == ValueType.lmst) {
      // Grey out when LMST is turned off or longitude not configured
      final lmstMode = widget.lmstMode;
      if (lmstMode == LmstMode.off) return true;
      if (widget.lmstLongitude == null) return true;
    }
    if (!t.isZoneIndependent) return false;
    return widget.existingEntries.any((e) => e.valueType == t);
  }

  void _selectType(ValueType t) {
    if (t.isZoneIndependent) {
      Navigator.pop(context, TimeValue(valueType: t, zone: const ZoneUtc()));
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
    Navigator.pop(context, TimeValue(valueType: _type!, zone: zone));
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

    // Groups: only show a group if at least one type in it is allowed.
    final civilTypesAllowed = civilTypes.where(_isAllowed).toList();
    final technicalTypesAllowed = technicalTypes.where(_isAllowed).toList();
    final astronomicalTypesAllowed = astronomicalTypes.where(_isAllowed).toList();
    final curiosityTypesAllowed = curiosityTypes.where(_isAllowed).toList();
    final totalAllowed = civilTypesAllowed.length
        + technicalTypesAllowed.length
        + astronomicalTypesAllowed.length
        + curiosityTypesAllowed.length;

    return SimpleDialog(
      title: Text(l10n.hintSelectValueType + " (${totalAllowed})"),
      children: [
        if (civilTypesAllowed.isNotEmpty) ...[
          _sectionLabel(
              context,
              l10n.tabCivil,
              civilTypesAllowed.length
          ),
          ...civilTypesAllowed.map((type) {
            final disabled = _isDisabled(type);
            return SimpleDialogOption(
              onPressed: disabled ? null : () => _selectType(type),
              child: _typeLabel(
                  context,
                  TimeValue.localizedTypeLabel(type, l10n),
                  disabled,
                  !type.isZoneIndependent,
                  type.isGraphical,
              ),
            );
          }),
        ],
        if (technicalTypesAllowed.isNotEmpty) ...[
          const Divider(),
          _sectionLabel(
              context,
              l10n.tabTechnical,
              technicalTypesAllowed.length
          ),
          ...technicalTypesAllowed.map((type) {
            final disabled = _isDisabled(type);
            return SimpleDialogOption(
              onPressed: disabled ? null : () => _selectType(type),
              child: _typeLabel(
                  context,
                  TimeValue.localizedTypeLabel(type, l10n),
                  disabled,
                  !type.isZoneIndependent,
                  type.isGraphical,
              ),
            );
          }),
        ],
        if (astronomicalTypesAllowed.isNotEmpty) ...[
          const Divider(),
          _sectionLabel(
              context,
              l10n.tabAstronomical,
              astronomicalTypesAllowed.length
          ),
          ...astronomicalTypesAllowed.map((type) {
            final disabled = _isDisabled(type);
            return SimpleDialogOption(
              onPressed: disabled ? null : () => _selectType(type),
              child: _typeLabel(
                  context,
                  TimeValue.localizedTypeLabel(type, l10n),
                  disabled,
                  !type.isZoneIndependent,
                  type.isGraphical,
              ),
            );
          }),
        ],
        if (curiosityTypesAllowed.isNotEmpty) ...[
          const Divider(),
          _sectionLabel(
              context,
              l10n.tabCuriosities,
              curiosityTypesAllowed.length
          ),
          ...curiosityTypesAllowed.map((type) {
            final disabled = _isDisabled(type);
            return SimpleDialogOption(
              onPressed: disabled ? null : () => _selectType(type),
              child: _typeLabel(
                  context,
                  TimeValue.localizedTypeLabel(type, l10n),
                  disabled,
                  !type.isZoneIndependent,
                  type.isGraphical,
              ),
            );
          }),
        ],
        const Divider(),
        SimpleDialogOption(
          onPressed: widget.valueTypesOnly
              ? null
              : () => Navigator.pop(context, TabDivider.generateDividerId()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.horizontal_rule, size: 16,
                  color: widget.valueTypesOnly
                      ? Theme.of(context).colorScheme.onSurface.withAlpha(150)
                      : null),
              const SizedBox(width: 8),
              Text(l10n.hintAddDivider,
                  style: TextStyle(color: widget.valueTypesOnly
                      ? Theme.of(context).colorScheme.onSurface.withAlpha(150)
                      : null)),
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: widget.valueTypesOnly
              ? null
              : () => _addSection(context, l10n),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.title, size: 16,
                  color: widget.valueTypesOnly
                      ? Theme.of(context).colorScheme.onSurface.withAlpha(150)
                      : null),
              const SizedBox(width: 8),
              Text(l10n.hintAddSectionHeader,
                  style: TextStyle(color: widget.valueTypesOnly
                      ? Theme.of(context).colorScheme.onSurface.withAlpha(150)
                      : null)),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
        ),
      ],
    );
  }

  Widget _typeLabel(BuildContext context, String label,
      bool disabled, bool zoneDependent, bool isGraphical) {
    final color = disabled
        ? Theme.of(context).colorScheme.onSurface.withAlpha(80)
        : null;
    final fontStyle = isGraphical ? FontStyle.italic : FontStyle.normal;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(color: color, fontStyle: fontStyle)),
        if (zoneDependent) ...[
          const SizedBox(width: 4),
          Icon(kIconTimeZoneIndicator, size: kIconSizeLabel,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
        ],
      ],
    );
  }

  Widget _buildZoneStep() {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(
          kTabHorizontalPadding, kTabVerticalPadding,
          kTabHorizontalPadding, kTabVerticalPadding),
      title: EntryPickerDialogTitle(
        superLabel: TimeValue.localizedTypeLabel(_type!, l10n),
        title: l10n.hintSelectTimezone,
        onBack: _goBack,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(l10n.actionZoneLocal),
              onTap: () => _confirm(const ZoneLocal()),
            ),
            ListTile(
              title: Text(l10n.actionZoneUtc),
              onTap: () => _confirm(const ZoneUtc()),
            ),
            ListTile(
              title: Text(l10n.actionZoneNamed),
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
          child: Text(l10n.actionCancel),
        ),
      ],
    );
  }

  Widget _sectionLabel(BuildContext context, String text, int count) => Padding(
    padding: const EdgeInsets.fromLTRB(
        kTabHorizontalPadding, kTabVerticalPadding,
        kTabHorizontalPadding, kTabVerticalPadding),
    child: Text(
      text.toUpperCase() + " (${count})",
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 1.5,
      ),
    ),
  );

  Future<void> _addSection(
      BuildContext context, AppLocalizations l10n) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.hintAddSectionHeader),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: l10n.labelNewSectionName,
          ),
          onSubmitted: (v) => Navigator.pop(ctx, v.trim()),
        ),
        actions: [
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
    if (result == null || result.isEmpty) return;
    if (!context.mounted) return;
    Navigator.pop(context, TabSection.generateSectionId(result));
  }
}

// Shared dialog title widget, also used by timezone_search_screen.
class EntryPickerDialogTitle extends StatelessWidget {
  final String superLabel;
  final String title;
  final VoidCallback onBack;

  const EntryPickerDialogTitle({
    super.key,
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
          tooltip: l10n.hintBack,
          onPressed: onBack,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              superLabel,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              ),
            ),
            Text(title,
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ],
    );
  }
}
