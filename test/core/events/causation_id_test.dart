import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/events/causation_id.dart';
import 'package:healthtracker/core/events/domain_event_id.dart';

void main() {
  group('CausationId', () {
    const value = '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f';
    test('creates a distinct domain type from DomainEventId', () {
      final eventId = DomainEventId.fromString(value).value!;
      final causationId = CausationId.fromEventId(eventId).value!;
      expect(causationId.value, eventId.value);
      expect(causationId, isNot(isA<DomainEventId>()));
    });
    test('reconstructs, canonicalizes, compares, and renders values', () {
      final first = CausationId.fromString(value.toUpperCase()).value!;
      final same = CausationId.fromString(' $value ').value!;
      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first.toString(), 'CausationId($value)');
    });
    test('returns documented required, blank, and format errors', () {
      expect(CausationId.fromEventId(null).errors.single.code.value,
          'PRO-VAL-CAUSID-001');
      expect(CausationId.fromString(null).errors.single.code.value,
          'PRO-VAL-CAUSID-001');
      expect(CausationId.fromString(' ').errors.single.code.value,
          'PRO-VAL-CAUSID-002');
      for (final invalid in ['bad', '550e8400-e29b-41d4-a716-446655440000']) {
        final error = CausationId.fromString(invalid).errors.single;
        expect(error.code.value, 'PRO-VAL-CAUSID-003');
        expect(error.toString(), isNot(contains(invalid)));
      }
    });
  });
}
