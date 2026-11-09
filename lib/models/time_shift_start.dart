import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import '../effective_clock.dart';
import 'time_value.dart';

const _kMomentKey = 'time_shift_moment';
const _kFrozenKey = 'time_shift_frozen';
const _kZoneKey = 'time_shift_zone';

/// A time shift the app starts with: the moment, whether time stands still
/// from there, and the zone the Time Shift page shows the moment in.
class TimeShiftStart {
  final DateTime momentUtc;
  final bool frozen;
  final ZoneSpec zone;

  const TimeShiftStart({
    required this.momentUtc,
    this.frozen = false,
    this.zone = const ZoneLocal(),
  });
}

/// "2026-12-24T18:00:00Z": whole seconds, always UTC.
String formatTimeShiftMoment(DateTime moment) =>
    '${moment.toUtc().toIso8601String().substring(0, 19)}Z';

/// Null unless [text] is an ISO 8601 moment with "Z" or a UTC offset
/// (without one, it would be unclear which zone is meant).
DateTime? parseTimeShiftMoment(String? text) {
  if (text == null) return null;
  final parsed = DateTime.tryParse(text.trim());
  if (parsed == null || !parsed.isUtc) return null;
  return DateTime.utc(parsed.year, parsed.month, parsed.day, parsed.hour,
      parsed.minute, parsed.second);
}

/// Empty = local, "UTC", or an IANA name.
String timeShiftZoneToConfig(ZoneSpec zone) => switch (zone) {
  ZoneLocal() => '',
  ZoneUtc() => 'UTC',
  ZoneNamed(ianaZone: final ianaZone) => ianaZone,
};

/// Unknown names fall back to local; the zone only affects how the Time
/// Shift page shows the moment. Needs the time zone data to be initialized.
ZoneSpec timeShiftZoneFromConfig(String? text) {
  if (text == null || text.isEmpty) return const ZoneLocal();
  if (!tz.timeZoneDatabase.locations.containsKey(text)) return const ZoneLocal();
  return canonicalZoneSpec(ZoneNamed(text));
}

/// The saved start value; null if there is none or it is not usable
/// (not a moment, outside the supported range).
Future<TimeShiftStart?> loadTimeShiftStart() async {
  final prefs = await SharedPreferences.getInstance();
  final momentText = prefs.get(_kMomentKey);
  final moment = parseTimeShiftMoment(momentText is String ? momentText : null);
  if (moment == null || !EffectiveClock.isSupported(moment)) return null;
  final frozen = prefs.get(_kFrozenKey);
  final zone = prefs.get(_kZoneKey);
  return TimeShiftStart(
    momentUtc: moment,
    frozen: frozen is bool && frozen,
    zone: timeShiftZoneFromConfig(zone is String ? zone : null),
  );
}

Future<void> saveTimeShiftStart(TimeShiftStart start) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kMomentKey, formatTimeShiftMoment(start.momentUtc));
  await prefs.setBool(_kFrozenKey, start.frozen);
  await prefs.setString(_kZoneKey, timeShiftZoneToConfig(start.zone));
}

Future<void> clearTimeShiftStart() async {
  final prefs = await SharedPreferences.getInstance();
  for (final key in [_kMomentKey, _kFrozenKey, _kZoneKey]) {
    await prefs.remove(key);
  }
}

/// Starts the clock at the saved moment, if there is a usable one.
Future<void> applyTimeShiftStart() async {
  final start = await loadTimeShiftStart();
  if (start == null) return;
  EffectiveClock.shiftTo(start.momentUtc, frozen: start.frozen);
}
