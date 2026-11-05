import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Underlined, tappable link text that opens [url] in the external browser.
class LinkText extends StatelessWidget {
  final String url;
  final String? label;  // defaults to the URL itself

  const LinkText({super.key, required this.url, this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } catch (_) {}  // no browser available: nothing to do
      },
      child: Text(
        label ?? url,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
