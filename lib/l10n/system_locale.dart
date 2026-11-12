import 'package:flutter/widgets.dart';
import 'app_localizations.dart';

/// The system language if Epoch is translated into it, otherwise [fallback].
/// Needs the Flutter binding, but nothing else: also usable by the startup
/// error screen.
Locale supportedSystemLocale({required Locale fallback}) {
  final systemLanguage =
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  return AppLocalizations.supportedLocales
      .where((locale) => locale.languageCode == systemLanguage)
      .firstOrNull ??
      fallback;
}
