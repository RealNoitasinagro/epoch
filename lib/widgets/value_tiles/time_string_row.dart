import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/day_quarter_color.dart';
import '../../app/epoch_app.dart';
import '../../app/layout_constants.dart';
import '../../formatting/value_display.dart';
import '../../l10n/app_localizations.dart';
import '../../settings/app_settings.dart';
import '../../time/zoned_moment.dart';
import '../app_snack_bar.dart';
import 'dst_status_icon.dart';
import 'time_value_row.dart';
import 'value_tile.dart';

class TimeStringRow extends TimeValueRow {
  final String locale;

  const TimeStringRow({
    super.key,
    required super.timeValue,
    required super.now,
    required this.locale,
    super.infoLinkOverride,
  });

  void _copyToClipboard(
    BuildContext context,
    AppLocalizations l10n,
    String label,
    String displayValue, {
    bool copyValueWithLabel = true,
  }) {
    String clipboardText = copyValueWithLabel
        ? '$label: $displayValue'
        : displayValue;
    Clipboard.setData(ClipboardData(text: clipboardText));
    showAppSnackBar(
      context,
      l10n.messageCopiedToClipboard(label),
      duration: kSnackBarShort,
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = EpochApp.of(context);
    final settings = app.formatSettings;
    final l10n = AppLocalizations.of(context)!;
    final localIanaZone = EpochApp.of(context).localIanaZone;

    final display = computeDisplay(
      timeValue,
      now,
      locale,
      l10n,
      settings: settings,
    );
    String label = computeLabel(l10n, timeValue, settings.longitude);
    String clipboardValue = computeClipboardDisplay(timeValue, display);

    final moment = ZonedMoment.of(timeValue, now, localIanaZone);

    final Color? dayQuarterColor =
        app.dayQuarterColor &&
            app.themeMode != AppThemeMode.night &&
            !timeValue.isZoneIndependent
        ? dayQuarterColorOfHour(moment.wallClock.hour)
        : null;

    return ValueTile(
      label: label,
      showZoneIndicator: !timeValue.isZoneIndependent,
      showPinnedIndicator: timeValue.isPinned(now.toUtc(), localIanaZone),
      dstStatusIndicator: timeValue.dstStatusIcon(now.toUtc(), localIanaZone),
      content: Tooltip(
        message: l10n.hintFocusScreenOpen,
        waitDuration: const Duration(milliseconds: 1000),
        child: TextValueContent(
          line1: display.line1,
          line2: display.line2,
          dayQuarterColor: dayQuarterColor,
          onDoubleTap: () => openFocusScreen(context, locale),
        ),
      ),
      actionSlots: [
        IconButton(
          icon: const Icon(Icons.info_outline, size: kIconSizeDefault),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.hintAboutThisValue,
          onPressed: () => showInfo(context, l10n),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: kIconSizeDefault),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          tooltip: l10n.hintCopyToClipboard,
          onPressed: () =>
              _copyToClipboard(context, l10n, label, clipboardValue),
          onLongPress: () => _copyToClipboard(
            context,
            l10n,
            label,
            clipboardValue,
            copyValueWithLabel: false,
          ),
        ),
        null,
      ],
    );
  }
}
