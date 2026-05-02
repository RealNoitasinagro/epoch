import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const EpochApp());
}

class EpochApp extends StatelessWidget {
  const EpochApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epoch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TimeDisplay(),
    );
  }
}

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({super.key});

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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

  int _localDaySecond(DateTime dt) {
    return dt.hour * 3600 + dt.minute * 60 + dt.second;
  }

  int _utcDaySecond(DateTime dt) {
    final u = dt.toUtc();
    return u.hour * 3600 + u.minute * 60 + u.second;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Epoch'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TimeRow(
              label: 'Date',
              value: _formatDate(_now),
              textTheme: textTheme,
            ),
            const Divider(height: 32),
            _TimeRow(
              label: 'Local time',
              value: _formatTime(_now),
              sub: 'Day second: ${_localDaySecond(_now)}',
              textTheme: textTheme,
            ),
            const Divider(height: 32),
            _TimeRow(
              label: 'UTC',
              value: _formatUtc(_now),
              sub: 'Day second: ${_utcDaySecond(_now)}',
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  final String label;
  final String value;
  final String? sub;
  final TextTheme textTheme;

  const _TimeRow({
    required this.label,
    required this.value,
    required this.textTheme,
    this.sub,
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
        if (sub != null) ...[
          const SizedBox(height: 2),
          Text(
            sub!,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.grey,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ],
    );
  }
}
