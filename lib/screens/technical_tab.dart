import 'package:flutter/material.dart';
import '../models/time_value.dart';
import '../widgets/time_row.dart';
import '../widgets/section_header.dart';
import '../strings.dart';

class TechnicalTab extends StatelessWidget {
  final DateTime now;

  const TechnicalTab({super.key, required this.now});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final allValues = {
      for (final v in computeAllValues(now, locale, 'local')) v.id: v
    };

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        const SectionHeader(label: AppStrings.sectionEpoch),
        const SizedBox(height: 8),
        TimeRow(
          label: allValues[TimeValueId.unixSeconds]!.label,
          value: allValues[TimeValueId.unixSeconds]!.value,
          info: allValues[TimeValueId.unixSeconds]!.info,
          useThousands: true,
        ),
        //const SizedBox(height: 12),
        const Divider(height: 40),
        const SectionHeader(label: AppStrings.sectionAtomicGps),
        const SizedBox(height: 8),
        TimeRow(
          label: allValues[TimeValueId.tai]!.label,
          value: allValues[TimeValueId.tai]!.value,
          info: allValues[TimeValueId.tai]!.info,
          useThousands: true,
        ),
        const SizedBox(height: 12),
        TimeRow(
          label: allValues[TimeValueId.gps]!.label,
          value: allValues[TimeValueId.gps]!.value,
          info: allValues[TimeValueId.gps]!.info,
          useThousands: true,
        ),
      ],
    );
  }
}