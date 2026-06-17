import 'package:epoch/models/time_value.dart';
import 'custom_tab_model.dart';

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

class TabSection extends TabEntry {
  final String id;
  final String label;
  const TabSection({required this.id, required this.label});

  @override
  String get key => 'section:$id';

  @override
  String toPrefsString() => 'section:$id:$label';

  static TabSection? fromPrefsString(String s) {
    if (!s.startsWith('section:')) return null;
    final rest = s.substring(8);
    final colonIdx = rest.indexOf(':');
    if (colonIdx < 0) return null;
    return TabSection(
        id: rest.substring(0, colonIdx),
        label: rest.substring(colonIdx + 1));
  }

  static TabSection generateSectionId(String label) =>
      TabSection(id: generateId(), label: label);

  TabSection withLabel(String newLabel) =>
      TabSection(id: id, label: newLabel);
}
