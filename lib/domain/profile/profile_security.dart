import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'authentication_proof.dart';
import 'lock_state.dart';
import 'password_credential.dart';
import 'profile_security_id.dart';
import 'timestamp.dart';

final class ProfileSecurity {
  const ProfileSecurity._(
      this.securityId, this.passwordCredential, this.lockState);

  final ProfileSecurityId securityId;
  final PasswordCredential? passwordCredential;
  final LockState lockState;

  static DomainResult<ProfileSecurity> create(
    ProfileSecurityId? securityId,
    PasswordCredential? passwordCredential,
    LockState? lockState,
  ) {
    final errors = <DomainError>[
      if (securityId == null)
        _validation(
            'PRO-VAL-PSEC-001',
            'validation.profileSecurity.securityId.required',
            'securityId',
            ConstraintType.required),
      if (lockState == null)
        _validation(
            'PRO-VAL-PSEC-003',
            'validation.profileSecurity.lockState.required',
            'lockState',
            ConstraintType.required),
    ];
    if (lockState != null && lockState.isLocked && passwordCredential == null) {
      errors.add(_validation(
        'PRO-VAL-PSEC-005',
        'validation.profileSecurity.lockState.requiresCredential',
        'lockState',
        ConstraintType.consistency,
        const {'required': 'passwordCredential'},
      ));
    }
    if (errors.isNotEmpty) return DomainResult<ProfileSecurity>.failure(errors);
    return DomainResult<ProfileSecurity>.success(
      ProfileSecurity._(securityId!, passwordCredential, lockState!),
    );
  }

  DomainResult<ProfileSecurity> enablePasswordProtection(
      PasswordCredential credential) {
    if (passwordCredential != null) {
      return DomainResult<ProfileSecurity>.fromError(_business(
        'PRO-BUS-PSEC-001',
        'business.profileSecurity.passwordProtection.alreadyEnabled',
        'passwordCredential',
        ConstraintType.transition,
      ));
    }
    return DomainResult<ProfileSecurity>.success(
      ProfileSecurity._(securityId, credential, lockState),
    );
  }

  DomainResult<ProfileSecurity> disablePasswordProtection(
    AuthenticationProof proof,
    Timestamp now,
  ) {
    if (passwordCredential == null) {
      return _noChange(
        'PRO-INF-PSEC-001',
        'information.profileSecurity.passwordProtection.alreadyDisabled',
        'disablePasswordProtection',
      );
    }
    final unlocked = LockState.createUnlocked(now);
    return DomainResult<ProfileSecurity>.success(
      ProfileSecurity._(securityId, null, unlocked.value!),
    );
  }

  DomainResult<ProfileSecurity> changePasswordCredential(
    PasswordCredential newCredential,
    AuthenticationProof proof,
    Timestamp now,
  ) {
    if (passwordCredential == null) {
      return DomainResult<ProfileSecurity>.fromError(_business(
        'PRO-BUS-PSEC-003',
        'business.profileSecurity.changePassword.requiresCredential',
        'passwordCredential',
        ConstraintType.required,
      ));
    }
    if (passwordCredential == newCredential) {
      return _noChange(
        'PRO-INF-PSEC-002',
        'information.profileSecurity.credential.unchanged',
        'changePasswordCredential',
      );
    }
    return DomainResult<ProfileSecurity>.success(
      ProfileSecurity._(securityId, newCredential, lockState),
    );
  }

  DomainResult<ProfileSecurity> lock(Timestamp now) {
    if (passwordCredential == null) {
      return DomainResult<ProfileSecurity>.fromError(_business(
        'PRO-BUS-PSEC-002',
        'business.profileSecurity.lock.requiresCredential',
        'passwordCredential',
        ConstraintType.required,
      ));
    }
    if (lockState.isLocked) {
      return _noChange('PRO-INF-PSEC-003',
          'information.profileSecurity.alreadyLocked', 'lock');
    }
    return DomainResult<ProfileSecurity>.success(
      ProfileSecurity._(
          securityId, passwordCredential, lockState.lock(now).value!),
    );
  }

  DomainResult<ProfileSecurity> unlock(
      AuthenticationProof proof, Timestamp now) {
    if (lockState.isUnlocked || passwordCredential == null) {
      return _noChange('PRO-INF-PSEC-004',
          'information.profileSecurity.alreadyUnlocked', 'unlock');
    }
    return DomainResult<ProfileSecurity>.success(
      ProfileSecurity._(
          securityId, passwordCredential, lockState.unlock(now).value!),
    );
  }

  DomainResult<ProfileSecurity> _noChange(
          String code, String key, String operation) =>
      DomainResult<ProfileSecurity>.success(this,
          information: <DomainInformation>[
            DomainInformation(
              code: ErrorCode.create(code)!,
              messageKey: MessageKey.create(key)!,
              severity: MessageSeverity.information,
              category: MessageCategory.business,
              parameters: <String, Object>{'operation': operation},
            ),
          ]);

  static DomainError _validation(
          String code, String key, String field, ConstraintType constraint,
          [Map<String, Object> parameters = const {}]) =>
      DomainError(
          code: ErrorCode.create(code)!,
          messageKey: MessageKey.create(key)!,
          severity: MessageSeverity.error,
          category: MessageCategory.validation,
          parameters: parameters,
          field: FieldReference.create(field),
          constraint: constraint);

  static DomainError _business(
          String code, String key, String field, ConstraintType constraint) =>
      DomainError(
          code: ErrorCode.create(code)!,
          messageKey: MessageKey.create(key)!,
          severity: MessageSeverity.error,
          category: MessageCategory.business,
          parameters: const {},
          field: FieldReference.create(field),
          constraint: constraint);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileSecurity && securityId == other.securityId;
  @override
  int get hashCode => securityId.hashCode;
  @override
  String toString() => 'ProfileSecurity(securityId: $securityId, '
      'passwordProtectionEnabled: ${passwordCredential != null}, lockState: $lockState)';
}
