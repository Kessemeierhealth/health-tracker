import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class PasswordHash {
  const PasswordHash._(this.value);

  final String value;

  static DomainResult<PasswordHash> fromPersistedValue(String? value) {
    if (value == null) {
      return DomainResult<PasswordHash>.fromError(
        _error(
          code: 'PRO-VAL-PHASH-001',
          messageKey: 'validation.passwordHash.required',
          constraint: ConstraintType.required,
        ),
      );
    }

    final normalizedValue = value.trim();
    if (normalizedValue.isEmpty) {
      return DomainResult<PasswordHash>.fromError(
        _error(
          code: 'PRO-VAL-PHASH-002',
          messageKey: 'validation.passwordHash.blank',
          constraint: ConstraintType.blank,
        ),
      );
    }

    return DomainResult<PasswordHash>.success(PasswordHash._(normalizedValue));
  }

  static DomainError _error({
    required String code,
    required String messageKey,
    required ConstraintType constraint,
  }) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(messageKey)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: const {},
        field: FieldReference.create('value'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PasswordHash && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'PasswordHash(<redacted>)';
}
