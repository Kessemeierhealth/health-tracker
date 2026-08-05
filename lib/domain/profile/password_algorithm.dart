import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

enum PasswordAlgorithm {
  argon2id;

  static DomainResult<PasswordAlgorithm> fromString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return DomainResult<PasswordAlgorithm>.fromError(
        _error(
          code: 'PRO-VAL-PALG-001',
          messageKey: 'validation.passwordAlgorithm.required',
          constraint: ConstraintType.required,
        ),
      );
    }

    final normalizedValue = value.trim();
    if (normalizedValue != argon2id.name) {
      return DomainResult<PasswordAlgorithm>.fromError(
        _error(
          code: 'PRO-VAL-PALG-002',
          messageKey: 'validation.passwordAlgorithm.invalid',
          constraint: ConstraintType.enumeration,
          parameters: const <String, Object>{
            'allowedValues': <String>['argon2id'],
          },
        ),
      );
    }

    return DomainResult<PasswordAlgorithm>.success(argon2id);
  }

  static DomainError _error({
    required String code,
    required String messageKey,
    required ConstraintType constraint,
    Map<String, Object> parameters = const {},
  }) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(messageKey)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: parameters,
        field: FieldReference.create('value'),
        constraint: constraint,
      );

  @override
  String toString() => name;
}
