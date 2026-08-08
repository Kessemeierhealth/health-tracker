import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/events/event_type.dart';

void main() {
  group('EventType', () {
    test('reconstructs every allowed canonical value', () {
      expect(EventType.allowedValues, hasLength(25));
      for (final value in EventType.allowedValues) {
        final result = EventType.fromString(' $value ');
        expect(result.value.toString(), value);
      }
    });
    test('returns required, blank, and invalid errors', () {
      _error(EventType.fromString(null), 'PRO-VAL-EVTYPE-001',
          ConstraintType.required, const {});
      _error(EventType.fromString('  '), 'PRO-VAL-EVTYPE-002',
          ConstraintType.blank, const {});
      final invalid = EventType.fromString('profilecreated');
      _error(invalid, 'PRO-VAL-EVTYPE-003', ConstraintType.enumeration,
          const <String, Object>{'allowedValues': EventType.allowedValues});
      expect(
          invalid.errors.single.toString(), isNot(contains('profilecreated')));
    });
    test('uses immutable value equality and hashCode', () {
      final first = EventType.fromString('ProfileCreated').value!;
      final same = EventType.fromString(' ProfileCreated ').value!;
      final other = EventType.fromString('ProfileDeleted').value!;
      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(other));
    });
  });
}

void _error(dynamic result, String code, ConstraintType constraint,
    Map<String, Object> parameters) {
  expect(result.isFailure, isTrue);
  final error = result.errors.single;
  expect(error.code.value, code);
  expect(error.field!.value, 'value');
  expect(error.constraint, constraint);
  expect(error.parameters, parameters);
}
