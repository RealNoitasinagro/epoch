import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';

class TabValueCount extends StatelessWidget {
  final int count;
  const TabValueCount({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kTabHorizontalPadding, kTabVerticalPadding + 12,
          kTabHorizontalPadding, kTabVerticalPadding + 12),
      child: Row(
        children: [
          Text(
            l10n.tabValueCount(count),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}