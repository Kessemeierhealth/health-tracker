import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/events/event_schema_version.dart';

void main() {
  group('EventSchemaVersion', () {
    test('creates initial and reconstructs inclusive boundaries', () {
      expect(EventSchemaVersion.createInitial().value!.value, 1);
      expect(EventSchemaVersion.fromValue(1).isSuccess, isTrue);
      expect(EventSchemaVersion.fromValue(2147483647).isSuccess, isTrue);
    });
    test('returns required, minimum, and maximum errors', () {
      expect(EventSchemaVersion.fromValue(null).errors.single.code.value,
          'PRO-VAL-EVSCHEMA-001');
      expect(EventSchemaVersion.fromValue(0).errors.single.code.value,
          'PRO-VAL-EVSCHEMA-002');
      expect(EventSchemaVersion.fromValue(2147483648).errors.single.code.value,
          'PRO-VAL-EVSCHEMA-003');
    });
    test('next increments immutably and prevents overflow', () {
      final initial = EventSchemaVersion.createInitial().value!;
      final next = initial.next().value!;
      expect(initial.value, 1);
      expect(next.value, 2);
      final maximum = EventSchemaVersion.fromValue(2147483647).value!;
      expect(maximum.next().errors.single.code.value, 'PRO-VAL-EVSCHEMA-004');
      expect(maximum.value, 2147483647);
    });
    test('uses value equality, hashCode, and documented rendering', () {
      final first = EventSchemaVersion.fromValue(2).value!;
      final same = EventSchemaVersion.fromValue(2).value!;
      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first.toString(), 'EventSchemaVersion(2)');
    });
  });
}
