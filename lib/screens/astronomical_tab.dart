import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../time_utils.dart';
import '../widgets/section_header.dart';
import '../widgets/time_string_row.dart';

class AstronomicalTab extends StatelessWidget {
  final DateTime now;
  const AstronomicalTab({super.key, required this.now});

  String _formatDecimal(double value, String locale, int decimals) {
    final fmt = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: decimals,
    );
    return fmt.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final utcNow = now.toUtc();

    final gmst = TimeUtils.gmst(utcNow);
    final jd = TimeUtils.julianDate(utcNow);
    final mjd = TimeUtils.modifiedJulianDate(utcNow);

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        SectionHeader(label: l10n.sectionSidereal),
        const SizedBox(height: 8),
        TimeStringRow(
          label: l10n.labelGmst,
          value: TimeUtils.hoursToHms(gmst),
          info: l10n.infoGmst,
        ),
        const Divider(height: 40),
        SectionHeader(label: l10n.sectionJulian),
        const SizedBox(height: 8),
        TimeStringRow(
          label: l10n.labelJd,
          value: _formatDecimal(jd, locale, 5),
          info: l10n.infoJd,
        ),
        const SizedBox(height: 12),
        TimeStringRow(
          label: l10n.labelMjd,
          value: _formatDecimal(mjd, locale, 5),
          info: l10n.infoMjd,
        ),
      ],
    );
  }
}