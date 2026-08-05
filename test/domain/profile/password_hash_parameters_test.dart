import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/password_hash_parameters.dart';

void main() {
  group('PasswordHashParameters', () {
    test('create accepts minimum values and trims only salt boundaries', () {
      final result = PasswordHashParameters.create(1, 1, 1, '  Salt+/=  ');

      expect(result.isSuccess, isTrue);
      expect(result.value!.memoryCostKiB, 1);
      expect(result.value!.iterations, 1);
      expect(result.value!.parallelism, 1);
      expect(result.value!.salt, 'Salt+/=');
    });

    test('reconstruction applies the same validation', () {
      final result = PasswordHashParameters.fromPersistedValues(
        65536,
        3,
        2,
        'salt',
      );

      expect(result.isSuccess, isTrue);
      expect(result.value!.memoryCostKiB, 65536);
    });

    test('reports all missing values in documented order', () {
      final result = PasswordHashParameters.create(null, null, null, null);

      expect(
        result.errors.map((error) => error.code.value),
        <String>[
          'PRO-VAL-PHPAR-001',
          'PRO-VAL-PHPAR-003',
          'PRO-VAL-PHPAR-005',
          'PRO-VAL-PHPAR-007',
        ],
      );
      expect(result.errors.every((error) => error.parameters.isEmpty), isTrue);
    });

    test('reports all minimum violations with actual values', () {
      final result = PasswordHashParameters.create(0, -1, 0, 'salt');

      expect(
        result.errors.map((error) => error.code.value),
        <String>[
          'PRO-VAL-PHPAR-002',
          'PRO-VAL-PHPAR-004',
          'PRO-VAL-PHPAR-006',
        ],
      );
      for (final error in result.errors) {
        expect(error.constraint, ConstraintType.minimum);
        expect(error.parameters['minimum'], 1);
      }
      expect(result.errors[0].parameters['actual'], 0);
      expect(result.errors[1].parameters['actual'], -1);
    });

    test('reports blank salt without disclosing it', () {
      final error = PasswordHashParameters.create(1, 1, 1, '   ').errors.single;

      expect(error.code.value, 'PRO-VAL-PHPAR-008');
      expect(
        error.messageKey.value,
        'validation.passwordHashParameters.salt.blank',
      );
      expect(error.constraint, ConstraintType.blank);
      expect(error.parameters, isEmpty);
    });

    test('uses value equality and redacts salt in toString', () {
      const salt = 'sensitive-salt';
      final first = PasswordHashParameters.create(8, 2, 1, salt).value!;
      final same = PasswordHashParameters.create(8, 2, 1, salt).value!;
      final different = PasswordHashParameters.create(8, 3, 1, salt).value!;

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
      expect(first.toString(), contains('memoryCostKiB: 8'));
      expect(first.toString(), contains('salt: <redacted>'));
      expect(first.toString(), isNot(contains(salt)));
    });

    test('validation failures do not throw', () {
      expect(
        () => PasswordHashParameters.create(0, 0, 0, ' '),
        returnsNormally,
      );
    });
  });
}
