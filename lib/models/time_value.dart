import 'package:intl/intl.dart';
import '../time_utils.dart';

// Unique identifiers for every displayable value in the app.
enum TimeValueId {
  localDate,
  localTime,
  localDaySecond,
  utcDate,
  utcTime,
  utcDaySecond,
  unixSeconds,
  tai,
  gps,
}

// A single displayable time value: its label, current value string,
// optional info text, and whether to apply thousands formatting.
class TimeValue {
  final TimeValueId id;
  final String label;
  final String value;
  final String? info;
  final bool useThousands;

  const TimeValue({
    required this.id,
    required this.label,
    required this.value,
    this.info,
    this.useThousands = false,
  });
}

// Computes all available TimeValues for a given moment and locale.
// ianaZone may be 'local' to use the system timezone.
List<TimeValue> computeAllValues(
    DateTime now,
    String locale,
    String ianaZone,
    ) {
  final utcNow = now.toUtc();

  final DateTime localDt;
  final String tzLabel;
  final Duration offset;

  if (ianaZone == 'local') {
    localDt = now;
    tzLabel = now.timeZoneName;
    offset = now.timeZoneOffset;
  } else {
    final tzDt = TimeUtils.inZone(utcNow, ianaZone);
    localDt = tzDt;
    tzLabel = tzDt.timeZone.abbreviation;
    offset = tzDt.timeZoneOffset;
  }

  final localTimeStr =
      '${localDt.hour.toString().padLeft(2, '0')}:'
      '${localDt.minute.toString().padLeft(2, '0')}:'
      '${localDt.second.toString().padLeft(2, '0')} '
      '$tzLabel (${TimeUtils.utcOffsetString(offset)})';

  final utcTimeStr =
      '${utcNow.hour.toString().padLeft(2, '0')}:'
      '${utcNow.minute.toString().padLeft(2, '0')}:'
      '${utcNow.second.toString().padLeft(2, '0')} UTC';

  return [
    TimeValue(
      id: TimeValueId.localDate,
      label: 'Date (local)',
      value: DateFormat('EEE, yyyy-MM-dd', locale).format(localDt),
      info: 'The current date in the selected local timezone.',
    ),
    TimeValue(
      id: TimeValueId.localTime,
      label: 'Time (local)',
      value: localTimeStr,
      info: 'Current time in the selected local timezone, '
          'with timezone abbreviation and UTC offset.',
    ),
    TimeValue(
      id: TimeValueId.localDaySecond,
      label: 'Day second (local)',
      value: TimeUtils.daySecond(localDt).toString(),
      useThousands: true,
      info: 'Seconds elapsed since local midnight. Resets to 0 at midnight '
          'in the selected timezone.',
    ),
    TimeValue(
      id: TimeValueId.utcDate,
      label: 'Date (UTC)',
      value: DateFormat('EEE, yyyy-MM-dd', locale).format(utcNow),
      info: 'The current date in Coordinated Universal Time (UTC).',
    ),
    TimeValue(
      id: TimeValueId.utcTime,
      label: 'Time (UTC)',
      value: utcTimeStr,
      info: 'Current time in Coordinated Universal Time (UTC).',
    ),
    TimeValue(
      id: TimeValueId.utcDaySecond,
      label: 'Day second (UTC)',
      value: TimeUtils.daySecond(utcNow).toString(),
      useThousands: true,
      info: 'Seconds elapsed since UTC midnight. Resets to 0 at 00:00:00 UTC.',
    ),
    TimeValue(
      id: TimeValueId.unixSeconds,
      label: 'Unix time (s)',
      value: TimeUtils.unixTimestamp(utcNow).toString(),
      useThousands: true,
      info: 'Seconds elapsed since the Unix epoch: 1970-01-01 00:00:00 UTC. '
          'Does not count leap seconds.',
    ),
    TimeValue(
      id: TimeValueId.tai,
      label: 'TAI (s since epoch)',
      value: TimeUtils.taiSeconds(utcNow).toString(),
      useThousands: true,
      info: 'International Atomic Time (TAI) counts seconds since '
          '1958-01-01 and currently runs 37 seconds ahead of UTC.',
    ),
    TimeValue(
      id: TimeValueId.gps,
      label: 'GPS time (s)',
      value: TimeUtils.gpsTime(utcNow).toString(),
      useThousands: true,
      info: 'Seconds since 1980-01-06 00:00:00 UTC. GPS time does not '
          'include leap seconds and currently runs 18 seconds ahead of UTC.',
    ),
  ];
}

// Default set of value IDs shown on the Main tab at first launch.
const defaultMainTabIds = [
  TimeValueId.localDate,
  TimeValueId.localTime,
  TimeValueId.localDaySecond,
  TimeValueId.utcDate,
  TimeValueId.utcTime,
  TimeValueId.utcDaySecond,
];