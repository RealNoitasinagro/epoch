import '../l10n/app_localizations.dart';
import 'tab_config.dart';
import 'time_value.dart';

abstract class TabEntry {
  const TabEntry();
  String get key;
  get valueType => null;
  String toPrefsString();

  static TabEntry? fromPrefsString(String s) {
    if (s.startsWith('divider:')) return TabDivider.fromPrefsString(s);
    if (s.startsWith('section:')) return TabSection.fromPrefsString(s);
    return TimeValue.fromPrefsString(s);
  }
}

class TabDivider extends TabEntry {
  final String id;
  const TabDivider({required this.id});

  @override
  String get key => 'divider:$id';

  @override
  String toPrefsString() => 'divider:$id';

  static TabDivider? fromPrefsString(String s) {
    if (!s.startsWith('divider:')) return null;
    return TabDivider(id: s.substring(8));
  }

  static TabDivider generateDividerId() => TabDivider(id: generateId());
}

enum BuiltinSectionKey {
  local, other,                               // Civil
  unix, atomic, gps,                          // Technical
  sidereal, julian,                           // Astronomical
  alternative, numberSystems, doomsdayClock,  // Curiosities
}

class TabSection extends TabEntry {
  final String id;
  final String label;  // ignored when builtinKey != null
  final BuiltinSectionKey? builtinKey;

  const TabSection({
    required this.id,
    required this.label,
    this.builtinKey,
  });

  @override
  String get key => 'section:$id';

  // Returns the label to display: live-localized for builtin sections,
  // the stored label otherwise.
  String localizedLabel(AppLocalizations l10n) {
    if (builtinKey == null) return label;
    return switch (builtinKey!) {
      BuiltinSectionKey.local         => l10n.sectionLocal,
      BuiltinSectionKey.other         => l10n.sectionOther,
      BuiltinSectionKey.unix          => l10n.sectionUnix,
      BuiltinSectionKey.atomic        => l10n.sectionAtomic,
      BuiltinSectionKey.gps           => l10n.sectionGps,
      BuiltinSectionKey.sidereal      => l10n.sectionSidereal,
      BuiltinSectionKey.julian        => l10n.sectionJulian,
      BuiltinSectionKey.alternative   => l10n.sectionAlternative,
      BuiltinSectionKey.numberSystems => l10n.sectionNumberSystems,
      BuiltinSectionKey.doomsdayClock => l10n.sectionDoomsdayClock,
    };
  }

  // Builtin sections serialize just their key, not the (irrelevant,
  // possibly stale) label – so a language switch never leaves a
  // mismatched label lingering in storage.
  @override
  String toPrefsString() => builtinKey != null
      ? 'section:$id:@${builtinKey!.name}'
      : 'section:$id:$label';

  static TabSection? fromPrefsString(String s) {
    if (!s.startsWith('section:')) return null;
    final rest = s.substring(8);
    final colonIdx = rest.indexOf(':');
    if (colonIdx < 0) return null;
    final id = rest.substring(0, colonIdx);
    final labelPart = rest.substring(colonIdx + 1);
    if (labelPart.startsWith('@')) {
      final keyName = labelPart.substring(1);
      final key = BuiltinSectionKey.values.where((k) => k.name == keyName).firstOrNull;
      if (key != null) return TabSection(id: id, label: '', builtinKey: key);
      // Not a recognized builtin key (e.g. a user section that happens to
      // start with '@', or an unknown key from a future app version) –
      // fall back to treating the whole string as a literal label instead
      // of silently dropping the entry:
    }
    return TabSection(id: id, label: labelPart);
  }

  static TabSection generateSectionId(String label) =>
      TabSection(id: generateId(), label: label);

  static TabSection generateBuiltinSectionId(BuiltinSectionKey key) =>
      TabSection(id: generateId(), label: '', builtinKey: key);

  TabSection withLabel(String newLabel) =>
      TabSection(id: id, label: newLabel, builtinKey: null);  // editing detaches from builtin
}
