import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_themes.dart';
import '../build_info.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../link_constants.dart';
import '../widgets/link_text.dart';

/// Shown instead of a blank screen when the app cannot start, e.g. because
/// the stored preferences are unreadable. Deliberately self-contained: it
/// needs neither preferences nor localization delegates nor app state.
class StartupErrorScreen extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;

  const StartupErrorScreen({
    super.key,
    required this.error,
    required this.stackTrace,
  });

  static AppLocalizations _localizations() {
    final languageCode = PlatformDispatcher.instance.locale.languageCode;
    return lookupAppLocalizations(Locale(languageCode == 'de' ? 'de' : 'en'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = _localizations();
    final textTheme = Theme.of(context).textTheme;
    final platform = kIsWeb
        ? 'web (${defaultTargetPlatform.name})' : defaultTargetPlatform.name;
    final details = '$kBuildInfo\n$platform\n\n$error\n\n$stackTrace';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kTabHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline,
                      color: Theme.of(context).colorScheme.error),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(l10n.startupErrorTitle,
                        style: textTheme.titleLarge),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(l10n.startupErrorHint),
              const SizedBox(height: 4),
              const LinkText(url: issuesLink),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    details,
                    style: const TextStyle(
                        fontFamily: fontFamilyDefault, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                icon: const Icon(Icons.copy),
                label: Text(l10n.startupErrorCopy),
                onPressed: () async {
                  await Clipboard.setData(
                      ClipboardData(text: '$issuesLink\n\n$details')
                  );
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(l10n.startupErrorCopied),
                    behavior: SnackBarBehavior.floating,
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Minimal app around [StartupErrorScreen], for failures before the regular
/// [EpochApp] exists (see main()).
class StartupErrorApp extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;

  const StartupErrorApp({
    super.key,
    required this.error,
    required this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: buildDarkTheme(),
      home: StartupErrorScreen(error: error, stackTrace: stackTrace),
    );
  }
}
