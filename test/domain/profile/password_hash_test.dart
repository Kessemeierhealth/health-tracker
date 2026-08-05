import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/password_hash.dart';

void main() {
  group('PasswordHash', () {
    test('reconstructs and trims an opaque value without other changes', () {
      final result = PasswordHash.fromPersistedValue('  HASH-Value+/=  ');

      expect(result.isSuccess, isTrue);
      expect(result.value!.value, 'HASH-Value+/=');
    });

    test('returns required for a missing value', () {
      final error = PasswordHash.fromPersistedValue(null).errors.single;

      expect(error.code.value, 'PRO-VAL-PHASH-001');
      expect(error.messageKey.value, 'validation.passwordHash.required');
      expect(error.constraint, ConstraintType.required);
      expect(error.parameters, isEmpty);
    });

    test('returns blank without disclosing the input', () {
      final error = PasswordHash.fromPersistedValue('   ').errors.single;

      expect(error.code.value, 'PRO-VAL-PHASH-002');
      expect(error.messageKey.value, 'validation.passwordHash.blank');
      expect(error.constraint, ConstraintType.blank);
      expect(error.parameters, isEmpty);
    });

    test('uses value equality and always redacts toString', () {
      const secret = 'sensitive-hash';
      final first = PasswordHash.fromPersistedValue(secret).value!;
      final same = PasswordHash.fromPersistedValue(secret).value!;
      final different = PasswordHash.fromPersistedValue('different').value!;

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
      expect(first.toString(), 'PasswordHash(<redacted>)');
      expect(first.toString(), isNot(contains(secret)));
    });

    test('validation failures do not throw', () {
      expect(() => PasswordHash.fromPersistedValue(' '), returnsNormally);
    });
  });
}
