import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../models/time_value.dart';

abstract class TimeValueRow extends StatelessWidget {
  final TimeValue timeValue;
  final DateTime now;
  final String? infoLinkOverride;

  const TimeValueRow({
    super.key,
    required this.timeValue,
    required this.now,
    this.infoLinkOverride,
  });

  void showInfo(BuildContext context, AppLocalizations l10n) {
    final link = infoLinkOverride ?? timeValue.localizedInfoLink(l10n);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(timeValue.localizedLabel(l10n)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(timeValue.localizedInfoText(l10n)),
            if (link != null) ...[
              const SizedBox(height: 12),
              InkWell(
                onTap: () async => launchUrl(Uri.parse(link),
                    mode: LaunchMode.externalApplication),
                child: Text(link,
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
}