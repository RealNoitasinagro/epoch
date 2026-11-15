import 'package:epoch/models/astronomical_tab_config.dart';
import 'package:epoch/models/civil_tab_config.dart';
import 'package:epoch/models/curiosities_tab_config.dart';
import 'package:epoch/models/technical_tab_config.dart';
import 'package:epoch/models/time_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every value type is in exactly one category list', () {
    const categoryLists = [
      civilTypes, technicalTypes, astronomicalTypes, curiosityTypes,
    ];
    for (final type in ValueType.values) {
      expect(categoryLists.where((list) => list.contains(type)).length, 1,
          reason: type.name);
    }
  });
}
