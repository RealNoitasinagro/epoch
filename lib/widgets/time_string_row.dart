import 'package:epoch/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

class TimeStringRow extends StatelessWidget {
  final String label;
  final String value;
  final String? info;
  final bool useThousands;

  const TimeStringRow({
    super.key,
    required this.label,
    required this.value,
    this.info,
    this.useThousands = true,
  });

  String _displayValue(BuildContext context) {
    if (!useThousands) return value;
    final n = int.tryParse(value);
    if (n == null) return value;
    final locale = Localizations.localeOf(context).toString();
    return NumberFormat.decimalPattern(locale).format(n);
  }

  // Splits a time+zone string into two lines.
  // e.g. "09:18:05 CEST (UTC+02:00)" →
  //   line1: "09:18:05 CEST"
  //   line2: "(UTC+02:00)"
  // If no zone info present, line2 is empty.
  ({String line1, String line2}) _splitValue(String v) {
    // Match UTC offset pattern (UTC+xx:xx or UTC−xx:xx).
    //final offsetMatch = RegExp(r'\(UTC[+−][0-9]{2}:[0-9]{2}\)').firstMatch(v);
    final offsetMatch = RegExp(r'\b\w+\s+\(UTC[+−][0-9]{2}:[0-9]{2}\)').firstMatch(v);
    if (offsetMatch == null) return (line1: v, line2: '');
    final line1 = v.substring(0, offsetMatch.start).trim();
    final line2 = offsetMatch.group(0)!;
    return (line1: line1, line2: line2);
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
    final colorScheme = Theme.of(context).colorScheme;
    final display = _displayValue(context);
    final split = _splitValue(display);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label
              Text(
                //label.toUpperCase(),
                label,
                style: textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.5,
                  color: colorScheme.onSurface.withAlpha(150),
                ),
              ),
              const SizedBox(height: 4),
              // Value container – fixed two-line layout.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withAlpha(30),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: split.line2.isEmpty
                    ? _ValueText(split.line1, textTheme)
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ValueText(split.line1, textTheme),
                    const SizedBox(height: 1),
                    _ZoneText(split.line2, textTheme, colorScheme),
                  ],
                ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     _ValueText(split.line1, textTheme),
                //     const SizedBox(height: 1),
                //     _ZoneText(split.line2, textTheme, colorScheme)
                //   ],
                // ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        // Buttons column – vertically centered next to container.
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.info_outline, size: 20),
                  color: colorScheme.onSurface.withAlpha(150),
                  tooltip: l10n.aboutThisValue,
                  onPressed: () => _showInfo(context, l10n),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  color: colorScheme.onSurface.withAlpha(150),
                  tooltip: l10n.copyToClipboard,
                  onPressed: () => _copyToClipboard(context, l10n),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ValueText extends StatelessWidget {
  final String text;
  final TextTheme textTheme;
  const _ValueText(this.text, this.textTheme);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textTheme.bodyLarge?.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ZoneText extends StatelessWidget {
  final String text;
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  const _ZoneText(this.text, this.textTheme, this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textTheme.bodySmall?.copyWith(
        fontFamily: fontFamily,
        color: colorScheme.onSurface.withAlpha(170),
        height: 1.2,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}