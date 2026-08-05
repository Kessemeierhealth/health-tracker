import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/password_algorithm.dart';
import 'package:healthtracker/domain/profile/password_credential.dart';
import 'package:healthtracker/domain/profile/password_hash.dart';
import 'package:healthtracker/domain/profile/password_hash_parameters.dart';
import 'package:healthtracker/domain/profile/timestamp.dart';

void main() {
  group('PasswordCredential', () {
    test('creates a complete immutable credential', () {
      final fixture = _CredentialFixture();
      final result = PasswordCredential.create(
        fixture.hash,
        PasswordAlgorithm.argon2id,
        fixture.parameters,
        fixture.createdAt,
      );

      expect(result.isSuccess, isTrue);
      expect(result.value!.hash, same(fixture.hash));
      expect(result.value!.algorithm, PasswordAlgorithm.argon2id);
      expect(result.value!.parameters, same(fixture.parameters));
      expect(result.value!.createdAt, same(fixture.createdAt));
    });

    test('reports all missing components in documented order', () {
      final result = PasswordCredential.create(null, null, null, null);

      expect(
        result.errors.map((error) => error.code.value),
        <String>[
          'PRO-VAL-PCRED-001',
          'PRO-VAL-PCRED-002',
          'PRO-VAL-PCRED-003',
          'PRO-VAL-PCRED-004',
        ],
      );
      expect(
        result.errors.map((error) => error.messageKey.value),
        <String>[
          'validation.passwordCredential.hash.required',
          'validation.passwordCredential.algorithm.required',
          'validation.passwordCredential.parameters.required',
          'validation.passwordCredential.createdAt.required',
        ],
      );
      expect(
        result.errors.every(
          (error) =>
              error.constraint == ConstraintType.required &&
              error.parameters.isEmpty,
        ),
        isTrue,
      );
    });

    test('uses complete value equality and consistent hash codes', () {
      final fixture = _CredentialFixture();
      final first = fixture.create();
      final same = fixture.create();
      final otherHash = PasswordHash.fromPersistedValue('other-hash').value!;
      final different = PasswordCredential.create(
        otherHash,
        PasswordAlgorithm.argon2id,
        fixture.parameters,
        fixture.createdAt,
      ).value!;

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
    });

    test('toString redacts hash and parameters', () {
      const hashValue = 'sensitive-hash';
      const saltValue = 'sensitive-salt';
      final fixture = _CredentialFixture(
        hashValue: hashValue,
        saltValue: saltValue,
      );
      final text = fixture.create().toString();

      expect(text, contains('algorithm: argon2id'));
      expect(text, contains('hash: <redacted>'));
      expect(text, contains('parameters: <redacted>'));
      expect(text, isNot(contains(hashValue)));
      expect(text, isNot(contains(saltValue)));
    });

    test('validation errors expose no sensitive values and do not throw', () {
      expect(() => PasswordCredential.create(null, null, null, null),
          returnsNormally);
      final result = PasswordCredential.create(null, null, null, null);
      expect(result.errors.every((error) => error.parameters.isEmpty), isTrue);
    });
  });
}

final class _CredentialFixture {
  _CredentialFixture({
    this.hashValue = 'opaque-hash',
    this.saltValue = 'opaque-salt',
  })  : hash = PasswordHash.fromPersistedValue(hashValue).value!,
        parameters =
            PasswordHashParameters.create(65536, 3, 2, saltValue).value!,
        createdAt = Timestamp.fromUtc(DateTime.utc(2026, 8, 5)).value!;

  final String hashValue;
  final String saltValue;
  final PasswordHash hash;
  final PasswordHashParameters parameters;
  final Timestamp createdAt;

  PasswordCredential create() => PasswordCredential.create(
        hash,
        PasswordAlgorithm.argon2id,
        parameters,
        createdAt,
      ).value!;
}
