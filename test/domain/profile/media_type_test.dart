import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/media_type.dart';

void main() {
  group('MediaType', () {
    test('contains exactly the supported media types', () {
      expect(MediaType.values, <MediaType>[
        MediaType.jpeg,
        MediaType.png,
        MediaType.webp,
      ]);
      expect(MediaType.values.map((value) => value.toString()),
          MediaType.allowedValues);
    });

    test('reconstructs each exact value after trimming', () {
      for (final mediaType in MediaType.values) {
        final result = MediaType.fromString('  ${mediaType.value}  ');
        expect(result.isSuccess, isTrue);
        expect(result.value, mediaType);
      }
    });

    test('returns required only for a missing value', () {
      _expectError(
        MediaType.fromString(null),
        'PRO-VAL-MTYPE-001',
        'validation.mediaType.required',
        ConstraintType.required,
        const {},
      );
    });

    test('returns blank only for empty normalized values', () {
      for (final value in <String>['', '   ']) {
        _expectError(
          MediaType.fromString(value),
          'PRO-VAL-MTYPE-002',
          'validation.mediaType.blank',
          ConstraintType.blank,
          const {},
        );
      }
    });

    test('rejects unsupported and differently cased values', () {
      for (final value in <String>['image/gif', 'IMAGE/PNG', '.png']) {
        final result = MediaType.fromString(value);
        _expectError(
          result,
          'PRO-VAL-MTYPE-003',
          'validation.mediaType.invalid',
          ConstraintType.enumeration,
          const <String, Object>{
            'allowedValues': MediaType.allowedValues,
          },
        );
        expect(result.errors.single.toString(), isNot(contains(value)));
      }
    });

    test('expected validation failures do not throw', () {
      expect(() => MediaType.fromString(null), returnsNormally);
      expect(() => MediaType.fromString('unknown'), returnsNormally);
    });
  });
}

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
