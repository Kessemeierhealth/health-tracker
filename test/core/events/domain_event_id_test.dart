import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/events/domain_event_id.dart';

void main() {
  group('DomainEventId', () {
    test('generate creates distinct canonical UUIDv7 values', () {
      final first = DomainEventId.generate();
      final second = DomainEventId.generate();

      expect(first.isSuccess, isTrue);
      expect(first.errors, isEmpty);
      expect(first.value!.value, matches(_uuidV7Pattern));
      expect(second.value!.value, matches(_uuidV7Pattern));
      expect(first.value, isNot(second.value));
    });

    test('fromString trims and canonicalizes a UUIDv7', () {
      final result = DomainEventId.fromString(
        '  01890F3E-7B5A-7CC4-98C2-1A2B3C4D5E6F  ',
      );

      expect(result.isSuccess, isTrue);
      expect(result.value!.value, '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f');
      expect(
        result.value.toString(),
        'DomainEventId(01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f)',
      );
    });

    test('returns only the required error for null', () {
      _expectError(
        DomainEventId.fromString(null),
        'PRO-VAL-EVTID-001',
        'validation.domainEventId.required',
        ConstraintType.required,
        const {},
      );
    });

    test('returns only the blank error for empty normalized values', () {
      for (final value in <String>['', '   ']) {
        _expectError(
          DomainEventId.fromString(value),
          'PRO-VAL-EVTID-002',
          'validation.domainEventId.blank',
          ConstraintType.blank,
          const {},
        );
      }
    });

    test('maps malformed and non-v7 UUIDs to the format error', () {
      for (final value in <String>[
        'not-a-uuid',
        '550e8400-e29b-41d4-a716-446655440000',
      ]) {
        final result = DomainEventId.fromString(value);
        _expectError(
          result,
          'PRO-VAL-EVTID-003',
          'validation.domainEventId.invalidFormat',
          ConstraintType.format,
          const <String, Object>{'expectedFormat': 'UUIDv7'},
        );
        expect(result.errors.single.toString(), isNot(contains(value)));
      }
    });

    test('implements canonical value equality and hashCode', () {
      final first = DomainEventId.fromString(
        '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f',
      ).value!;
      final same = DomainEventId.fromString(
        '01890F3E-7B5A-7CC4-98C2-1A2B3C4D5E6F',
      ).value!;
      final different = DomainEventId.fromString(
        '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e70',
      ).value!;

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
    });

    test('expected validation failures do not throw', () {
      expect(() => DomainEventId.fromString(null), returnsNormally);
      expect(() => DomainEventId.fromString('invalid'), returnsNormally);
    });
  });
}

final RegExp _uuidV7Pattern = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);

void _expectError(dynamic result, String code, String key,
    ConstraintType constraint, Map<String, Object> parameters) {
  expect(result.isFailure, isTrue);
  expect(result.value, isNull);
  expect(result.errors, hasLength(1));
  final error = result.errors.single;
  expect(error.code.value, code);
  expect(error.messageKey.value, key);
  expect(error.field!.value, 'value');
  expect(error.constraint, constraint);
  expect(error.parameters, parameters);
}
