import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'password_algorithm.dart';
import 'password_hash.dart';
import 'password_hash_parameters.dart';
import 'timestamp.dart';

final class PasswordCredential {
  const PasswordCredential._({
    required this.hash,
    required this.algorithm,
    required this.parameters,
    required this.createdAt,
  });

  final PasswordHash hash;
  final PasswordAlgorithm algorithm;
  final PasswordHashParameters parameters;
  final Timestamp createdAt;

  static DomainResult<PasswordCredential> create(
    PasswordHash? hash,
    PasswordAlgorithm? algorithm,
    PasswordHashParameters? parameters,
    Timestamp? createdAt,
  ) {
    final errors = <DomainError>[
      if (hash == null)
        _requiredError(
          code: 'PRO-VAL-PCRED-001',
          messageKey: 'validation.passwordCredential.hash.required',
          field: 'hash',
        ),
      if (algorithm == null)
        _requiredError(
          code: 'PRO-VAL-PCRED-002',
          messageKey: 'validation.passwordCredential.algorithm.required',
          field: 'algorithm',
        ),
      if (parameters == null)
        _requiredError(
          code: 'PRO-VAL-PCRED-003',
          messageKey: 'validation.passwordCredential.parameters.required',
          field: 'parameters',
        ),
      if (createdAt == null)
        _requiredError(
          code: 'PRO-VAL-PCRED-004',
          messageKey: 'validation.passwordCredential.createdAt.required',
          field: 'createdAt',
        ),
    ];

    if (errors.isNotEmpty) {
      return DomainResult<PasswordCredential>.failure(errors);
    }

    return DomainResult<PasswordCredential>.success(
      PasswordCredential._(
        hash: hash!,
        algorithm: algorithm!,
        parameters: parameters!,
        createdAt: createdAt!,
      ),
    );
  }

  static DomainError _requiredError({
    required String code,
    required String messageKey,
    required String field,
  }) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(messageKey)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: const {},
        field: FieldReference.create(field),
        constraint: ConstraintType.required,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordCredential &&
          hash == other.hash &&
          algorithm == other.algorithm &&
          parameters == other.parameters &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(hash, algorithm, parameters, createdAt);

  @override
  String toString() => 'PasswordCredential('
      'algorithm: $algorithm, '
      'createdAt: $createdAt, '
      'hash: <redacted>, '
      'parameters: <redacted>)';
}
