import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/checksum_algorithm.dart';

void main() {
  group('ChecksumAlgorithm', () {
    test('contains only sha256 and reconstructs it after trimming', () {
      expect(ChecksumAlgorithm.values,
          <ChecksumAlgorithm>[ChecksumAlgorithm.sha256]);

      final result = ChecksumAlgorithm.fromString('  sha256  ');

      expect(result.isSuccess, isTrue);
      expect(result.value, ChecksumAlgorithm.sha256);
      expect(result.value.toString(), 'sha256');
    });

    test('returns required only for a missing value', () {
      _expectError(
        ChecksumAlgorithm.fromString(null),
        'PRO-VAL-CHKALG-001',
        'validation.checksumAlgorithm.required',
        ConstraintType.required,
        const {},
      );
    });

    test('returns blank only for empty normalized values', () {
      for (final value in <String>['', '   ']) {
        _expectError(
          ChecksumAlgorithm.fromString(value),
          'PRO-VAL-CHKALG-002',
          'validation.checksumAlgorithm.blank',
          ConstraintType.blank,
          const {},
        );
      }
    });

    test('rejects unsupported and differently cased values', () {
      for (final value in <String>['SHA256', 'sha512', 'md5']) {
        final result = ChecksumAlgorithm.fromString(value);
        _expectError(
          result,
          'PRO-VAL-CHKALG-003',
          'validation.checksumAlgorithm.invalid',
          ConstraintType.enumeration,
          const <String, Object>{
            'allowedValues': ChecksumAlgorithm.allowedValues,
          },
        );
        expect(result.errors.single.toString(), isNot(contains(value)));
      }
    });

    test('expected validation failures do not throw', () {
      expect(() => ChecksumAlgorithm.fromString(null), returnsNormally);
      expect(() => ChecksumAlgorithm.fromString('unknown'), returnsNormally);
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
