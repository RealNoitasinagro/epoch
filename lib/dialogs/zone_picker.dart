import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/time_value.dart';
import '../screens/time_zone_search_screen.dart';

/// The three ways to choose a time zone: local, UTC, or a named zone found
/// with the search.
class ZonePicker extends StatelessWidget {
  final ValueChanged<ZoneSpec> onSelected;

  const ZonePicker({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(l10n.actionZoneLocal),
          onTap: () => onSelected(const ZoneLocal()),
        ),
        ListTile(
          title: Text(l10n.actionZoneUtc),
          onTap: () => onSelected(const ZoneUtc()),
        ),
        ListTile(
          title: Text(l10n.actionZoneNamed),
          trailing: const Icon(Icons.search),
          onTap: () async {
            final zone = await Navigator.push<String>(
              context,
              MaterialPageRoute(builder: (_) => const TimezoneSearchScreen()),
            );
            if (zone != null) onSelected(ZoneNamed(zone));
          },
        ),
      ],
    );
  }
}

/// Dialog with the three options; null if cancelled.
Future<ZoneSpec?> showZonePicker(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return showDialog<ZoneSpec>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.hintSelectTimezone),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      content: SizedBox(
        width: double.maxFinite,
        child: ZonePicker(
          onSelected: (zone) => Navigator.pop(ctx, canonicalZoneSpec(zone)),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(l10n.actionCancel),
        ),
      ],
    ),
  );
}
