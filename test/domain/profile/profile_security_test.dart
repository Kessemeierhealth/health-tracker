import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/authentication_proof.dart';
import 'package:healthtracker/domain/profile/lock_state.dart';
import 'package:healthtracker/domain/profile/password_algorithm.dart';
import 'package:healthtracker/domain/profile/password_credential.dart';
import 'package:healthtracker/domain/profile/password_hash.dart';
import 'package:healthtracker/domain/profile/password_hash_parameters.dart';
import 'package:healthtracker/domain/profile/profile_security.dart';
import 'package:healthtracker/domain/profile/profile_security_id.dart';
import 'package:healthtracker/domain/profile/timestamp.dart';

void main() {
  group('ProfileSecurity.create', () {
    test('creates complete protected and unprotected immutable states', () {
      final f = _Fixture();
      final protected = ProfileSecurity.create(f.id, f.credential, f.unlocked);
      final unprotected = ProfileSecurity.create(f.id, null, f.unlocked);
      expect(protected.isSuccess, isTrue);
      expect(protected.value!.securityId, same(f.id));
      expect(protected.value!.passwordCredential, same(f.credential));
      expect(protected.value!.lockState, same(f.unlocked));
      expect(unprotected.isSuccess, isTrue);
    });

    test('reports required fields in documented order without duplicates', () {
      final result = ProfileSecurity.create(null, null, null);
      expect(result.errors.map((e) => e.code.value),
          ['PRO-VAL-PSEC-001', 'PRO-VAL-PSEC-003']);
      expect(result.errors.map((e) => e.field!.value),
          ['securityId', 'lockState']);
      expect(result.errors.every((e) => e.severity == MessageSeverity.error),
          isTrue);
      expect(
          result.errors.every((e) => e.category == MessageCategory.validation),
          isTrue);
    });

    test('rejects locked state without credential with structured error', () {
      final f = _Fixture();
      final result = ProfileSecurity.create(f.id, null, f.locked);
      final error = result.errors.single;
      expect(error.code.value, 'PRO-VAL-PSEC-005');
      expect(error.field!.value, 'lockState');
      expect(error.constraint, ConstraintType.consistency);
      expect(error.parameters, const {'required': 'passwordCredential'});
      expect(
          () => ProfileSecurity.create(f.id, null, f.locked), returnsNormally);
    });
  });

  group('ProfileSecurity operations', () {
    test('enables protection and preserves identity and source state', () {
      final f = _Fixture();
      final original = f.unprotected;
      final result = original.enablePasswordProtection(f.credential);
      expect(result.isSuccess, isTrue);
      expect(result.value!.securityId, same(original.securityId));
      expect(result.value!.passwordCredential, same(f.credential));
      expect(original.passwordCredential, isNull);
    });

    test('rejects enabling already enabled protection', () {
      final f = _Fixture();
      final result = f.protected.enablePasswordProtection(f.otherCredential);
      _expectBusiness(result, 'PRO-BUS-PSEC-001', 'passwordCredential',
          ConstraintType.transition);
    });

    test('disables protection and unlocks at now', () {
      final f = _Fixture();
      final original = f.lockedProtected;
      final result = original.disablePasswordProtection(f.proof, f.now);
      expect(result.isSuccess, isTrue);
      expect(result.value!.passwordCredential, isNull);
      expect(result.value!.lockState.isUnlocked, isTrue);
      expect(result.value!.lockState.unlockedAt, f.now);
      expect(result.value!.securityId, same(original.securityId));
      expect(original.lockState.isLocked, isTrue);
    });

    test('disable returns documented no change when already disabled', () {
      final f = _Fixture();
      _expectNoChange(f.unprotected.disablePasswordProtection(f.proof, f.now),
          f.unprotected, 'PRO-INF-PSEC-001', 'disablePasswordProtection');
    });

    test('changes credential without changing lock state', () {
      final f = _Fixture();
      final result = f.protected
          .changePasswordCredential(f.otherCredential, f.proof, f.now);
      expect(result.isSuccess, isTrue);
      expect(result.value!.passwordCredential, same(f.otherCredential));
      expect(result.value!.lockState, same(f.protected.lockState));
      expect(result.value!.securityId, same(f.protected.securityId));
    });

    test('change rejects missing credential and detects identical credential',
        () {
      final f = _Fixture();
      _expectBusiness(
          f.unprotected.changePasswordCredential(f.credential, f.proof, f.now),
          'PRO-BUS-PSEC-003',
          'passwordCredential',
          ConstraintType.required);
      _expectNoChange(
          f.protected.changePasswordCredential(f.credential, f.proof, f.now),
          f.protected,
          'PRO-INF-PSEC-002',
          'changePasswordCredential');
    });

    test('locks protected state and rejects locking unprotected state', () {
      final f = _Fixture();
      final result = f.protected.lock(f.now);
      expect(result.value!.lockState.isLocked, isTrue);
      expect(result.value!.lockState.lockedAt, f.now);
      expect(result.value!.securityId, same(f.protected.securityId));
      _expectBusiness(f.unprotected.lock(f.now), 'PRO-BUS-PSEC-002',
          'passwordCredential', ConstraintType.required);
    });

    test('lock and unlock return documented no changes', () {
      final f = _Fixture();
      _expectNoChange(f.lockedProtected.lock(f.now), f.lockedProtected,
          'PRO-INF-PSEC-003', 'lock');
      _expectNoChange(f.protected.unlock(f.proof, f.now), f.protected,
          'PRO-INF-PSEC-004', 'unlock');
      _expectNoChange(f.unprotected.unlock(f.proof, f.now), f.unprotected,
          'PRO-INF-PSEC-004', 'unlock');
    });

    test('unlocks protected state and preserves source state', () {
      final f = _Fixture();
      final result = f.lockedProtected.unlock(f.proof, f.now);
      expect(result.value!.lockState.isUnlocked, isTrue);
      expect(result.value!.lockState.unlockedAt, f.now);
      expect(result.value!.securityId, same(f.lockedProtected.securityId));
      expect(f.lockedProtected.lockState.isLocked, isTrue);
    });
  });

  test('entity equality and hash code use only securityId', () {
    final f = _Fixture();
    final sameIdentity = ProfileSecurity.create(f.id, null, f.unlocked).value!;
    final different =
        ProfileSecurity.create(f.otherId, null, f.unlocked).value!;
    expect(f.protected, sameIdentity);
    expect(f.protected.hashCode, sameIdentity.hashCode);
    expect(f.protected, isNot(different));
  });

  test('toString contains only safe state information', () {
    final f = _Fixture();
    final text = f.protected.toString();
    expect(text, contains(f.id.value));
    expect(text, contains('passwordProtectionEnabled: true'));
    expect(text, isNot(contains('secret-hash')));
    expect(text, isNot(contains('secret-salt')));
    expect(text, isNot(contains(f.credential.toString())));
    expect(text, isNot(contains('AuthenticationProof')));
  });
}

void _expectBusiness(
    dynamic result, String code, String field, ConstraintType constraint) {
  expect(result.isFailure, isTrue);
  expect(result.errors.single.code.value, code);
  expect(result.errors.single.category, MessageCategory.business);
  expect(result.errors.single.field!.value, field);
  expect(result.errors.single.constraint, constraint);
  expect(result.errors.single.parameters, isEmpty);
}

void _expectNoChange(
    dynamic result, ProfileSecurity original, String code, String operation) {
  expect(result.isSuccess, isTrue);
  expect(result.value, same(original));
  expect(result.information.single.code.value, code);
  expect(result.information.single.severity, MessageSeverity.information);
  expect(result.information.single.category, MessageCategory.business);
  expect(result.information.single.parameters, {'operation': operation});
  expect(result.information.single.field, isNull);
  expect(result.information.single.constraint, isNull);
}

final class _Fixture {
  _Fixture() {
    id = ProfileSecurityId.fromString('01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f')
        .value!;
    otherId =
        ProfileSecurityId.fromString('01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e70')
            .value!;
    final created = _time(8);
    now = _time(10);
    unlocked = LockState.createUnlocked(created).value!;
    locked = LockState.createLocked(created).value!;
    credential = _credential('secret-hash', 'secret-salt', created);
    otherCredential = _credential('other-hash', 'other-salt', created);
    proof = AuthenticationProof.createVerified(id, created, _time(12)).value!;
    protected = ProfileSecurity.create(id, credential, unlocked).value!;
    unprotected = ProfileSecurity.create(id, null, unlocked).value!;
    lockedProtected = ProfileSecurity.create(id, credential, locked).value!;
  }

  late final ProfileSecurityId id;
  late final ProfileSecurityId otherId;
  late final Timestamp now;
  late final LockState unlocked;
  late final LockState locked;
  late final PasswordCredential credential;
  late final PasswordCredential otherCredential;
  late final AuthenticationProof proof;
  late final ProfileSecurity protected;
  late final ProfileSecurity unprotected;
  late final ProfileSecurity lockedProtected;

  Timestamp _time(int hour) =>
      Timestamp.fromUtc(DateTime.utc(2026, 8, 6, hour)).value!;

  PasswordCredential _credential(String hash, String salt, Timestamp at) =>
      PasswordCredential.create(
        PasswordHash.fromPersistedValue(hash).value!,
        PasswordAlgorithm.argon2id,
        PasswordHashParameters.create(65536, 3, 1, salt).value!,
        at,
      ).value!;
}
