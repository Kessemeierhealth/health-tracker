import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/events/event_category.dart';

void main() {
  group('EventCategory', () {
    test('contains and reconstructs exactly the canonical categories', () {
      expect(EventCategory.values.map((value) => value.toString()),
          EventCategory.allowedValues);
      for (final value in EventCategory.values) {
        expect(EventCategory.fromString(' ${value.name} ').value, value);
      }
    });
    test('returns the three documented errors without case normalization', () {
      expect(EventCategory.fromString(null).errors.single.code.value,
          'PRO-VAL-EVCAT-001');
      expect(EventCategory.fromString(' ').errors.single.code.value,
          'PRO-VAL-EVCAT-002');
      final invalid = EventCategory.fromString('Lifecycle');
      expect(invalid.errors.single.code.value, 'PRO-VAL-EVCAT-003');
      expect(invalid.errors.single.parameters,
          const <String, Object>{'allowedValues': EventCategory.allowedValues});
      expect(invalid.errors.single.toString(), isNot(contains('Lifecycle')));
    });
  });
}
