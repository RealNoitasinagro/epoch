import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../time_utils.dart';

// The three displayable value types.
enum ValueType { date, time, daySecond }

// Zone specification: system local, UTC, or a named IANA zone.
sealed class ZoneSpec {
  const ZoneSpec();
}

class ZoneLocal extends ZoneSpec {
  const ZoneLocal();
}

class ZoneUtc extends ZoneSpec {
  const ZoneUtc();
}

class ZoneNamed extends ZoneSpec {
  final String ianaZone;
  const ZoneNamed(this.ianaZone);
}

// A single entry on the Main tab: a value type combined with a zone.
class MainTabEntry {
  final ValueType type;
  final ZoneSpec zone;

  const MainTabEntry({required this.type, required this.zone});

  // Unique string key used for persistence and duplicate detection.
  String get key {
    final typeStr = type.name;
    final zoneStr = switch (zone) {
      ZoneLocal() => 'local',
      ZoneUtc() => 'utc',
      ZoneNamed(ianaZone: final z) => 'named:$z',
    };
    return '$typeStr/$zoneStr';
  }

  // Serialise to a plain string for SharedPreferences.
  String toPrefsString() => key;

  // Deserialise from a plain string.
  static MainTabEntry? fromPrefsString(String s) {
    final parts = s.split('/');
    if (parts.length < 2) return null;
    final type = ValueType.values.where((e) => e.name == parts[0]).firstOrNull;
    if (type == null) return null;

    final ZoneSpec zone;
    final zoneStr = parts.sublist(1).join('/'); // re-join for IANA names
    if (zoneStr == 'local') {
      zone = const ZoneLocal();
    } else if (zoneStr == 'utc') {
      zone = const ZoneUtc();
    } else if (zoneStr.startsWith('named:')) {
      zone = ZoneNamed(zoneStr.substring(6));
    } else {
      return null;
    }
    return MainTabEntry(type: type, zone: zone);
  }

  // Internal key-based label, used for persistence only.
  String get _rawLabel {
    final typeStr = switch (type) {
      ValueType.date      => 'Date',
      ValueType.time      => 'Time',
      ValueType.daySecond => 'Day second',
    };
    final zoneStr = switch (zone) {
      ZoneLocal()                    => 'local',
      ZoneUtc()                      => 'UTC',
      ZoneNamed(ianaZone: final z)   =>
          z.split('/').last.replaceAll('_', ' '),
    };
    return '$typeStr ($zoneStr)';
  }

  // Localized label for display in the UI.
  String localizedLabel(AppLocalizations l10n) {
    final typeLabel = switch (type) {
      ValueType.date      => l10n.valueTypeDate,
      ValueType.time      => l10n.valueTypeTime,
      ValueType.daySecond => l10n.labelDaySecond,
    };
    final zoneLabel = switch (zone) {
      ZoneLocal()                    => l10n.labelLocal.toLowerCase(),
      ZoneUtc()                      => l10n.zoneUtc,
      ZoneNamed(ianaZone: final z)   =>
          z.split('/').last.replaceAll('_', ' '),
    };
    return '$typeLabel ($zoneLabel)';
  }

  // Localized info text for the (i) dialog.
  String localizedInfo(AppLocalizations l10n) => switch (type) {
    ValueType.date      => l10n.infoLocalDate,
    ValueType.time      => l10n.infoLocalTime,
    ValueType.daySecond => l10n.infoDaySecond,
  };

  // Computes the current display value for this entry.
  String computeValue(DateTime now, String locale, {bool hourFormat24 = true}) {
    final utcNow = now.toUtc();

    final DateTime dt;
    final String tzLabel;
    final Duration offset;

    switch (zone) {
      case ZoneLocal():
        dt = now;
        tzLabel = now.timeZoneName;
        offset = now.timeZoneOffset;
      case ZoneUtc():
        dt = utcNow;
        tzLabel = 'UTC';
        offset = Duration.zero;
      case ZoneNamed(ianaZone: final z):
        final tzDt = TimeUtils.inZone(utcNow, z);
        dt = tzDt;
        tzLabel = tzDt.timeZone.abbreviation;
        offset = tzDt.timeZoneOffset;
    }

    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    final ss = dt.second.toString().padLeft(2, '0');
    final tzSuffix = zone is ZoneUtc
        ? 'UTC'
        : '$tzLabel (${TimeUtils.utcOffsetString(offset)})';

    if (type == ValueType.time && !hourFormat24) {
      // 12-hour format with AM/PM.
      final hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final period = dt.hour < 12 ? 'AM' : 'PM';
      final h12 = hour12.toString().padLeft(2, '0');
      return '$h12:$mm:$ss $period $tzSuffix';
    }

    return switch (type) {
      ValueType.date =>
          DateFormat('EEE, yyyy-MM-dd', locale).format(dt),
      ValueType.time =>
      '$hh:$mm:$ss $tzSuffix',
      ValueType.daySecond =>
          TimeUtils.daySecond(dt).toString(),
    };
  }

  // Whether this entry's value should use thousands formatting.
  bool get useThousands => type == ValueType.daySecond;
}

// Default entries shown on the Main tab at first launch.
const defaultMainTabEntries = [
  MainTabEntry(type: ValueType.date,      zone: ZoneLocal()),
  MainTabEntry(type: ValueType.time,      zone: ZoneLocal()),
  MainTabEntry(type: ValueType.daySecond, zone: ZoneLocal()),
  MainTabEntry(type: ValueType.date,      zone: ZoneUtc()),
  MainTabEntry(type: ValueType.time,      zone: ZoneUtc()),
  MainTabEntry(type: ValueType.daySecond, zone: ZoneUtc()),
];

