import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/password_algorithm.dart';

void main() {
  group('PasswordAlgorithm', () {
    test('contains only argon2id and reconstructs it after trimming', () {
      expect(PasswordAlgorithm.values,
          <PasswordAlgorithm>[PasswordAlgorithm.argon2id]);

      final result = PasswordAlgorithm.fromString('  argon2id  ');

      expect(result.isSuccess, isTrue);
      expect(result.value, PasswordAlgorithm.argon2id);
      expect(result.value.toString(), 'argon2id');
    });

    test('returns required for null, empty, and whitespace', () {
      for (final value in <String?>[null, '', '   ']) {
        final error = PasswordAlgorithm.fromString(value).errors.single;
        expect(error.code.value, 'PRO-VAL-PALG-001');
        expect(error.messageKey.value, 'validation.passwordAlgorithm.required');
        expect(error.constraint, ConstraintType.required);
        expect(error.field!.value, 'value');
        expect(error.parameters, isEmpty);
      }
    });

    test('rejects unsupported values without normalization or disclosure', () {
      for (final value in <String>['ARGON2ID', 'bcrypt']) {
        final error = PasswordAlgorithm.fromString(value).errors.single;
        expect(error.code.value, 'PRO-VAL-PALG-002');
        expect(error.messageKey.value, 'validation.passwordAlgorithm.invalid');
        expect(error.constraint, ConstraintType.enumeration);
        expect(
          error.parameters,
          const <String, Object>{
            'allowedValues': <String>['argon2id']
          },
        );
        expect(error.toString(), isNot(contains(value)));
      }
    });

    test('validation failures do not throw', () {
      expect(() => PasswordAlgorithm.fromString('unknown'), returnsNormally);
    });
  });
}
