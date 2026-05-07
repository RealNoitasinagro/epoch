// Compact row with label and info button only – used for visual displays
// where copy-to-clipboard makes no sense.
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String info;

  const InfoRow({super.key, required this.label, required this.info});

  void _showInfo(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        content: Text(info),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.5,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.info_outline, size: 20),
          color: Colors.grey,
          tooltip: l10n.aboutThisValue,
          onPressed: () => _showInfo(context, l10n),
        ),
      ],
    );
  }
}