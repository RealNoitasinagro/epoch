import 'package:flutter/material.dart';
import '../../strings.dart';

class MainTab extends StatelessWidget {
  final DateTime now;

  const MainTab({super.key, required this.now});

  String _formatDate(DateTime dt) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final wd = weekdays[dt.weekday - 1];
    final mo = months[dt.month - 1];
    final d = dt.day.toString().padLeft(2, '0');
    return '$wd, ${dt.year}-$mo-$d';
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    final offset = dt.timeZoneOffset;
    final sign = offset.isNegative ? '−' : '+';
    final oh = offset.inHours.abs().toString().padLeft(2, '0');
    final om = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final tz = dt.timeZoneName;
    return '$h:$m:$s $tz (UTC$sign$oh:$om)';
  }

  String _formatUtc(DateTime dt) {
    final u = dt.toUtc();
    final h = u.hour.toString().padLeft(2, '0');
    final m = u.minute.toString().padLeft(2, '0');
    final s = u.second.toString().padLeft(2, '0');
    return '$h:$m:$s UTC';
  }

  int _localDaySecond(DateTime dt) =>
      dt.hour * 3600 + dt.minute * 60 + dt.second;

  int _utcDaySecond(DateTime dt) {
    final u = dt.toUtc();
    return u.hour * 3600 + u.minute * 60 + u.second;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        _TimeRow(
          label: AppStrings.labelDate,
          value: _formatDate(now),
          textTheme: textTheme,
        ),
        const Divider(height: 32),
        _TimeRow(
          label: AppStrings.labelLocalTime,
          value: _formatTime(now),
          textTheme: textTheme,
        ),
        const Divider(height: 32),
        _TimeRow(
          label: AppStrings.labelDaySecondLocal,
          value: _localDaySecond(now).toString(),
          textTheme: textTheme,
        ),
        const Divider(height: 32),
        _TimeRow(
          label: AppStrings.labelUtc,
          value: _formatUtc(now),
          textTheme: textTheme,
        ),
        const Divider(height: 32),
        _TimeRow(
          label: AppStrings.labelDaySecondUtc,
          value: _utcDaySecond(now).toString(),
          textTheme: textTheme,
        ),
      ],
    );
  }
}

class _TimeRow extends StatelessWidget {
  final String label;
  final String value;
  final TextTheme textTheme;

  const _TimeRow({
    required this.label,
    required this.value,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          value,
          style: textTheme.headlineSmall?.copyWith(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}