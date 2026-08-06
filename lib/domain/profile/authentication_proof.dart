import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'profile_security_id.dart';
import 'timestamp.dart';

final class AuthenticationProof {
  const AuthenticationProof._(
      this.securityId, this.verifiedAt, this.validUntil);

  final ProfileSecurityId securityId;
  final Timestamp verifiedAt;
  final Timestamp validUntil;

  static DomainResult<AuthenticationProof> createVerified(
    ProfileSecurityId? securityId,
    Timestamp? verifiedAt,
    Timestamp? validUntil,
  ) {
    final errors = <DomainError>[
      if (securityId == null)
        _error(
            'PRO-VAL-AUTHPRF-001',
            'validation.authenticationProof.securityId.required',
            'securityId',
            ConstraintType.required),
      if (verifiedAt == null)
        _error(
            'PRO-VAL-AUTHPRF-002',
            'validation.authenticationProof.verifiedAt.required',
            'verifiedAt',
            ConstraintType.required),
      if (validUntil == null)
        _error(
            'PRO-VAL-AUTHPRF-003',
            'validation.authenticationProof.validUntil.required',
            'validUntil',
            ConstraintType.required),
    ];
    if (verifiedAt != null &&
        validUntil != null &&
        !validUntil.isAfter(verifiedAt)) {
      errors.add(_error(
        'PRO-VAL-AUTHPRF-004',
        'validation.authenticationProof.validityPeriod.invalid',
        'validUntil',
        ConstraintType.chronological,
        const {'comparison': 'validUntilNotAfterVerifiedAt'},
      ));
    }
    if (errors.isNotEmpty) {
      return DomainResult<AuthenticationProof>.failure(errors);
    }
    return DomainResult<AuthenticationProof>.success(
      AuthenticationProof._(securityId!, verifiedAt!, validUntil!),
    );
  }

  DomainResult<AuthenticationProof> validateFor(
    ProfileSecurityId? expectedSecurityId,
    Timestamp? now,
  ) {
    final errors = <DomainError>[
      if (expectedSecurityId == null)
        _error(
            'PRO-VAL-AUTHPRF-005',
            'validation.authenticationProof.expectedSecurityId.required',
            'expectedSecurityId',
            ConstraintType.required),
      if (now == null)
        _error(
            'PRO-VAL-AUTHPRF-006',
            'validation.authenticationProof.now.required',
            'now',
            ConstraintType.required),
    ];
    if (errors.isNotEmpty) {
      return DomainResult<AuthenticationProof>.failure(errors);
    }
    if (expectedSecurityId != securityId) {
      return DomainResult<AuthenticationProof>.fromError(_error(
        'PRO-VAL-AUTHPRF-007',
        'validation.authenticationProof.securityId.mismatch',
        'expectedSecurityId',
        ConstraintType.ownership,
      ));
    }
    if (now!.isBefore(verifiedAt)) {
      return DomainResult<AuthenticationProof>.fromError(_error(
        'PRO-VAL-AUTHPRF-008',
        'validation.authenticationProof.notYetValid',
        'now',
        ConstraintType.chronological,
        const {'comparison': 'nowBeforeVerifiedAt'},
      ));
    }
    if (now.isAfter(validUntil)) {
      return DomainResult<AuthenticationProof>.fromError(_error(
        'PRO-VAL-AUTHPRF-009',
        'validation.authenticationProof.expired',
        'now',
        ConstraintType.expired,
        const {'comparison': 'nowAfterValidUntil'},
      ));
    }
    return DomainResult<AuthenticationProof>.success(this);
  }

  static DomainError _error(
          String code, String key, String field, ConstraintType constraint,
          [Map<String, Object> parameters = const {}]) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(key)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: parameters,
        field: FieldReference.create(field),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticationProof &&
          securityId == other.securityId &&
          verifiedAt == other.verifiedAt &&
          validUntil == other.validUntil;
  @override
  int get hashCode => Object.hash(securityId, verifiedAt, validUntil);
  @override
  String toString() => 'AuthenticationProof(securityId: $securityId, '
      'verifiedAt: $verifiedAt, validUntil: $validUntil)';
}
