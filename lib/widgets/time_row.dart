import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

class TimeRow extends StatelessWidget {
  final String label;
  final String value;
  final String? info;          // explanation text for the (i) button
  final bool useThousands;     // whether to format value with thousands separator

  const TimeRow({
    super.key,
    required this.label,
    required this.value,
    this.info,
    this.useThousands = true,
  });

  // Formats a numeric string with thousands separators if useThousands is set
  // and the value is a plain integer. Non-numeric values are returned as-is.
  String _displayValue() {
    if (!useThousands) return value;
    final n = int.tryParse(value);
    if (n == null) return value;
    return NumberFormat('#,###').format(n);
  }

  void _copyToClipboard(BuildContext context, AppLocalizations l10n) {
    Clipboard.setData(ClipboardData(text: '$label: $value'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.copiedToClipboard(label)),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showInfo(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(label),
        content: Text(info ?? l10n.noDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
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
              const SizedBox(height: 4),
              Text(
                _displayValue(),
                style: textTheme.headlineSmall?.copyWith(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
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
        IconButton(
          icon: const Icon(Icons.copy, size: 20),
          color: Colors.grey,
          tooltip: l10n.copyToClipboard,
          onPressed: () => _copyToClipboard(context, l10n),
        ),
      ],
    );
  }
}