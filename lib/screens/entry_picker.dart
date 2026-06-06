import 'package:epoch/models/astronomical_tab_config.dart';
import 'package:epoch/models/civil_tab_config.dart';
import 'package:epoch/models/curiosities_tab_config.dart';
import 'package:epoch/models/technical_tab_config.dart';
import 'package:flutter/material.dart';
import '../layout_constants.dart';
import '../models/time_value.dart';
import '../l10n/app_localizations.dart';
import 'timezone_search_screen.dart';

// Displays a two-step dialog: value type → timezone (if zone-dependent).
// [allowedTypes] restricts which types are shown; null means all types.
Future<TimeValue?> showEntryPicker(
    BuildContext context, {
      List<ValueType>? allowedTypes,
      List<TimeValue> existingEntries = const [],
    }) {
  return showDialog<TimeValue>(
    context: context,
    builder: (ctx) => _EntryPicker(
      allowedTypes: allowedTypes,
      existingEntries: existingEntries,
    ),
  );
}

class _EntryPicker extends StatefulWidget {
  final List<ValueType>? allowedTypes;
  final List<TimeValue> existingEntries;

  const _EntryPicker({
    this.allowedTypes,
    this.existingEntries = const [],
  });

  @override
  State<_EntryPicker> createState() => _EntryPickerState();
}

enum _Step { valueType, zone }

class _EntryPickerState extends State<_EntryPicker> {
  _Step _step = _Step.valueType;
  ValueType? _type;

  bool _isAllowed(ValueType t) =>
      widget.allowedTypes == null || widget.allowedTypes!.contains(t);

  // Zone-independent types can only appear once.
  // Zone-dependent types can always be added (different zones allowed).
  bool _isDisabled(ValueType t) {
    if (!t.isZoneIndependent) return false;
    return widget.existingEntries.any((e) => e.type == t);
  }

  String _typeLabelFor(ValueType t, AppLocalizations l10n) => switch (t) {
    ValueType.date               => l10n.valueTypeDate,
    ValueType.time               => l10n.valueTypeTime,
    ValueType.dateTime           => l10n.valueTypeDateTime,
    ValueType.daySecond          => l10n.valueTypeDaySecond,
    ValueType.dayPercent         => l10n.valueTypeDayPercent,
    ValueType.binaryClockString  => l10n.valueTypeBinaryClockString,
    ValueType.binaryClockColumns => l10n.valueTypeBinaryClockColumns,
    ValueType.binaryClockBcd     => l10n.valueTypeBinaryClockBcd,
    ValueType.unixSeconds        => l10n.valueTypeUnixSeconds,
    ValueType.tai                => l10n.valueTypeTai,
    ValueType.gps                => l10n.valueTypeGps,
    ValueType.gmst               => l10n.valueTypeGmst,
    ValueType.julianDate         => l10n.valueTypeJulianDate,
    ValueType.modifiedJulianDate => l10n.valueTypeModifiedJulianDate,
    ValueType.swatchBeats        => l10n.valueTypeSwatchBeats,
    ValueType.doomsdayClock      => l10n.valueTypeDoomsdayClock,
  };

  void _selectType(ValueType t) {
    if (t.isZoneIndependent) {
      Navigator.pop(context, TimeValue(type: t, zone: const ZoneUtc()));
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
    Navigator.pop(context, TimeValue(type: _type!, zone: zone));
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

    return SimpleDialog(
      title: Text(l10n.selectValueType),
      children: [
        if (civilTypesAllowed.isNotEmpty) ...[
          _sectionLabel(context, l10n.tabCivil),
          ...civilTypesAllowed.map((t) {
            final disabled = _isDisabled(t);
            return SimpleDialogOption(
              onPressed: disabled ? null : () => _selectType(t),
              child: Text(
                _typeLabelFor(t, l10n),
                style: disabled
                    ? TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(80),
                )
                    : null,
              ),
            );
          }),
        ],
        if (technicalTypesAllowed.isNotEmpty) ...[
          const Divider(),
          _sectionLabel(context, l10n.tabTechnical),
          ...technicalTypesAllowed.map((t) {
            final disabled = _isDisabled(t);
            return SimpleDialogOption(
              onPressed: disabled ? null : () => _selectType(t),
              child: Text(
                _typeLabelFor(t, l10n),
                style: disabled
                    ? TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(80),
                )
                    : null,
              ),
            );
          }),
        ],
        if (astronomicalTypesAllowed.isNotEmpty) ...[
          const Divider(),
          _sectionLabel(context, l10n.tabAstronomical),
          ...astronomicalTypesAllowed.map((t) {
            final disabled = _isDisabled(t);
            return SimpleDialogOption(
              onPressed: disabled ? null : () => _selectType(t),
              child: Text(
                _typeLabelFor(t, l10n),
                style: disabled
                    ? TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(80),
                )
                    : null,
              ),
            );
          }),
        ],
        if (curiosityTypesAllowed.isNotEmpty) ...[
          const Divider(),
          _sectionLabel(context, l10n.tabCuriosities),
          ...curiosityTypesAllowed.map((t) {
            final disabled = _isDisabled(t);
            return SimpleDialogOption(
              onPressed: disabled ? null : () => _selectType(t),
              child: Text(
                _typeLabelFor(t, l10n),
                style: disabled
                    ? TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(80),
                )
                    : null,
              ),
            );
          }),
        ],
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
      titlePadding: const EdgeInsets.fromLTRB(
          kTabHorizontalPadding, kTabVerticalPadding,
          kTabHorizontalPadding, kTabVerticalPadding),
      title: EntryPickerDialogTitle(
        superLabel: _typeLabelFor(_type!, l10n),
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

  Widget _sectionLabel(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.fromLTRB(
        kTabHorizontalPadding, kTabVerticalPadding,
        kTabHorizontalPadding, kTabVerticalPadding),
    child: Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 1.5,
      ),
    ),
  );
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
          tooltip: l10n.back,
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