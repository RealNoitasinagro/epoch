import 'package:epoch/main.dart';
import 'package:epoch/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';

class TimeStringRow extends StatelessWidget {
  final String label;
  final String value;
  final String? info;
  final String? infoLink;
  final bool useThousands;

  const TimeStringRow({
    super.key,
    required this.label,
    required this.value,
    this.info,
    this.infoLink,
    this.useThousands = false,
  });

  String _displayValue(BuildContext context) {
    if (!useThousands) return value;
    final n = int.tryParse(value);
    if (n == null) return value;
    final locale = Localizations.localeOf(context).toString();
    return NumberFormat.decimalPattern(locale).format(n);
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(info ?? l10n.noDescription),
            if (infoLink != null) ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final uri = Uri.parse(infoLink!);
                  await launchUrl(uri,
                      mode: LaunchMode.externalApplication);
                },
                child: Text(
                  infoLink!,
                  style: TextStyle(
                    color: Theme.of(ctx).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ],
        ),
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
    final display = _displayValue(context);
    final split = StringValueDisplay.splitZoneOffset(display);

    return ValueTile(
      label: label,
      content: TextValueContent(line1: split.line1, line2: split.line2),
      actionSlots: [
        IconButton(
          icon: const Icon(Icons.info_outline, size: 20),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.aboutThisValue,
          onPressed: () => _showInfo(context, l10n),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 20),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.copyToClipboard,
          onPressed: () => _copyToClipboard(context, l10n),
        ),
        null, // third slot empty in view mode
      ],
    );
  }
}

// Three-layer tile: outer tile (solid bg) > inner text field (darker bg) > text.
// Label sits inside the tile above the text field.
// Action buttons sit inside the tile, vertically centered to the text field.
class StringValueDisplay extends StatelessWidget {
  final String label;
  final String line1;
  final String line2;
  final List<Widget> actions;

  const StringValueDisplay({
    super.key,
    required this.label,
    required this.line1,
    this.line2 = '',
    this.actions = const [],
  });

  static ({String line1, String line2}) splitZoneOffset(String value) {
    final match = RegExp(
      r'\b\w+\s+\(UTC[+−][0-9]{2}:[0-9]{2}\)',
    ).firstMatch(value);
    if (match == null) return (line1: value, line2: '');
    return (
      line1: value.substring(0, match.start).trim(),
      line2: match.group(0)!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Layer 1: tile background – slightly tinted.
    // Layer 2: text field – more opaque, rounded.
    // Layer 3: text content.
    final tileBg   = colorScheme.onSurface.withAlpha(12);
    final fieldBg  = colorScheme.onSurface.withAlpha(30);

    return Container(
      decoration: BoxDecoration(
        color: tileBg,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.fromLTRB(10, 6, 4, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label above text field, inside tile.
                Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.5,
                    color: colorScheme.onSurface.withAlpha(150),
                  ),
                ),
                const SizedBox(height: 4),
                // Text field – inner container.
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: fieldBg,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        line1,
                        style: textTheme.bodyLarge?.copyWith(
                          fontFamily: fontFamilyValues,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (line2.isNotEmpty) ...[
                        const SizedBox(height: 1),
                        Text(
                          line2,
                          style: textTheme.bodySmall?.copyWith(
                            fontFamily: fontFamilyValues,
                            color: colorScheme.onSurface.withAlpha(170),
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Action buttons – vertically centered to the whole tile.
          if (actions.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
        ],
      ),
    );
  }
}