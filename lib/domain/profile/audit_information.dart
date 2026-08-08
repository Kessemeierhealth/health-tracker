import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'aggregate_version.dart';
import 'timestamp.dart';

final class AuditInformation {
  const AuditInformation._(this.createdAt, this.updatedAt, this.version);

  final Timestamp createdAt;
  final Timestamp updatedAt;
  final AggregateVersion version;

  static DomainResult<AuditInformation> createInitial(Timestamp? now) {
    if (now == null) {
      return DomainResult<AuditInformation>.fromError(
        _requiredError(
          code: 'PRO-VAL-AUDIT-004',
          messageKey: 'validation.auditInformation.now.required',
          field: 'now',
        ),
      );
    }
    final version = AggregateVersion.createInitial().value!;
    return DomainResult<AuditInformation>.success(
      AuditInformation._(now, now, version),
    );
  }

  static DomainResult<AuditInformation> reconstruct(
    Timestamp? createdAt,
    Timestamp? updatedAt,
    AggregateVersion? version,
  ) {
    final errors = <DomainError>[
      if (createdAt == null)
        _requiredError(
          code: 'PRO-VAL-AUDIT-001',
          messageKey: 'validation.auditInformation.createdAt.required',
          field: 'createdAt',
        ),
      if (updatedAt == null)
        _requiredError(
          code: 'PRO-VAL-AUDIT-002',
          messageKey: 'validation.auditInformation.updatedAt.required',
          field: 'updatedAt',
        ),
      if (version == null)
        _requiredError(
          code: 'PRO-VAL-AUDIT-003',
          messageKey: 'validation.auditInformation.version.required',
          field: 'version',
        ),
    ];
    if (createdAt != null &&
        updatedAt != null &&
        updatedAt.isBefore(createdAt)) {
      errors.add(
        _chronologicalError(
          code: 'PRO-VAL-AUDIT-007',
          messageKey: 'validation.auditInformation.updatedAt.beforeCreatedAt',
          field: 'updatedAt',
          comparison: 'updatedAtBeforeCreatedAt',
        ),
      );
    }
    if (errors.isNotEmpty) {
      return DomainResult<AuditInformation>.failure(errors);
    }
    return DomainResult<AuditInformation>.success(
      AuditInformation._(createdAt!, updatedAt!, version!),
    );
  }

  DomainResult<AuditInformation> touchAndIncrement(Timestamp? now) {
    if (now == null) {
      return DomainResult<AuditInformation>.fromError(
        _requiredError(
          code: 'PRO-VAL-AUDIT-004',
          messageKey: 'validation.auditInformation.now.required',
          field: 'now',
        ),
      );
    }
    if (now.isBefore(createdAt)) {
      return DomainResult<AuditInformation>.fromError(
        _chronologicalError(
          code: 'PRO-VAL-AUDIT-005',
          messageKey: 'validation.auditInformation.now.beforeCreatedAt',
          field: 'now',
          comparison: 'nowBeforeCreatedAt',
        ),
      );
    }
    if (now.isBefore(updatedAt)) {
      return DomainResult<AuditInformation>.fromError(
        _chronologicalError(
          code: 'PRO-VAL-AUDIT-006',
          messageKey: 'validation.auditInformation.now.beforeUpdatedAt',
          field: 'now',
          comparison: 'nowBeforeUpdatedAt',
        ),
      );
    }
    final nextVersion = version.next();
    if (nextVersion.isFailure) {
      return DomainResult<AuditInformation>.failure(nextVersion.errors);
    }
    return DomainResult<AuditInformation>.success(
      AuditInformation._(createdAt, now, nextVersion.value!),
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

  static DomainError _chronologicalError({
    required String code,
    required String messageKey,
    required String field,
    required String comparison,
  }) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(messageKey)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: <String, Object>{'comparison': comparison},
        field: FieldReference.create(field),
        constraint: ConstraintType.chronological,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditInformation &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          version == other.version;

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, version);

  @override
  String toString() => 'AuditInformation(createdAt: $createdAt, '
      'updatedAt: $updatedAt, version: $version)';
}
