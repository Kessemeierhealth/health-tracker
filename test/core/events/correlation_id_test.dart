import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/events/correlation_id.dart';

void main() {
  group('CorrelationId', () {
    test('generates distinct canonical UUIDv7 values', () {
      final first = CorrelationId.generate().value!;
      final second = CorrelationId.generate().value!;
      expect(first.value, matches(_uuidV7));
      expect(second.value, matches(_uuidV7));
      expect(first, isNot(second));
    });
    test('trims, canonicalizes, compares, and renders values', () {
      final first =
          CorrelationId.fromString(' 01890F3E-7B5A-7CC4-98C2-1A2B3C4D5E6F ')
              .value!;
      final same =
          CorrelationId.fromString('01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f')
              .value!;
      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first.toString(),
          'CorrelationId(01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f)');
    });
    test('returns required, blank, malformed, and wrong-version errors', () {
      expect(CorrelationId.fromString(null).errors.single.code.value,
          'PRO-VAL-CORRID-001');
      expect(CorrelationId.fromString(' ').errors.single.code.value,
          'PRO-VAL-CORRID-002');
      for (final value in ['invalid', '550e8400-e29b-41d4-a716-446655440000']) {
        final error = CorrelationId.fromString(value).errors.single;
        expect(error.code.value, 'PRO-VAL-CORRID-003');
        expect(error.parameters,
            const <String, Object>{'expectedFormat': 'UUIDv7'});
        expect(error.parameters, isNot(contains('value')));
      }
    });
  });
}

final _uuidV7 = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$');
