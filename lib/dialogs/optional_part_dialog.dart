import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/time_value.dart';
import '../widgets/section_header.dart';

/// Dialog to choose per value type whether seconds or decimals are shown by
/// default. Returns the types whose optional part is hidden, or null when
/// cancelled.
class OptionalPartDialog extends StatefulWidget {
  final Set<ValueType> hiddenTypes;

  const OptionalPartDialog({super.key, required this.hiddenTypes});

  @override
  State<OptionalPartDialog> createState() => _OptionalPartDialogState();
}

class _OptionalPartDialogState extends State<OptionalPartDialog> {
  late final Set<ValueType> _hiddenTypes = {...widget.hiddenTypes};

  /// True: all shown, false: all hidden, null: mixed.
  bool? get _allShown {
    if (_hiddenTypes.isEmpty) return true;
    if (_hiddenTypes.length == globalOptionalPartTypes.length) return false;
    return null;
  }

  void _setAllShown(bool shown) {
    setState(() {
      _hiddenTypes.clear();
      if (!shown) _hiddenTypes.addAll(globalOptionalPartTypes);
    });
  }

  void _setShown(ValueType valueType, bool shown) {
    setState(() {
      if (shown) {
        _hiddenTypes.remove(valueType);
      } else {
        _hiddenTypes.add(valueType);
      }
    });
  }

  Widget _group(
      String title,
      OptionalPart optionalPart,
      AppLocalizations l10n,
      ) {
    final valueTypes = globalOptionalPartTypes.where(
          (valueType) => valueType.optionalPart == optionalPart,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 4),
          child: SectionHeader(label: '$title (${valueTypes.length})'),
        ),
        for (final valueType in valueTypes)
          CheckboxListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(TimeValue.localizedTypeLabel(valueType, l10n)),
            value: !_hiddenTypes.contains(valueType),
            onChanged: (shown) => _setShown(valueType, shown ?? true),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final numberOfOptionalPartTypes = globalOptionalPartTypes.length;
    return AlertDialog(
      title: Text('${l10n.settingsOptionalPart} ($numberOfOptionalPartTypes)'),
      scrollable: true,
      content: SizedBox(
        width: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              dense: true,
              tristate: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(l10n.settingsOptionalPartAll),
              value: _allShown,
              onChanged: (_) => _setAllShown(_allShown != true),
            ),
            const Divider(),
            _group(l10n.labelShowSeconds, OptionalPart.seconds, l10n),
            const SizedBox(height: 8),
            Text(
              l10n.settingsOptionalPartTimeNote,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(170),
              ),
            ),
            const Divider(),
            _group(l10n.labelShowDecimals, OptionalPart.decimals, l10n),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, Set.of(_hiddenTypes)),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
