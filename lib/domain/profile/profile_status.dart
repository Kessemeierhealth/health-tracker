import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

enum ProfileStatus {
  inactive,
  active,
  archived;

  static DomainResult<ProfileStatus> fromString(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return DomainResult<ProfileStatus>.fromError(
        _error(
          code: 'PRO-VAL-STATUS-001',
          messageKey: 'validation.profile.status.required',
          constraint: ConstraintType.required,
        ),
      );
    }

    for (final status in values) {
      if (status.name == normalized) {
        return DomainResult<ProfileStatus>.success(status);
      }
    }

    return DomainResult<ProfileStatus>.fromError(
      _error(
        code: 'PRO-VAL-STATUS-002',
        messageKey: 'validation.profile.status.invalid',
        constraint: ConstraintType.enumeration,
        parameters: const <String, Object>{
          'allowedValues': <String>['inactive', 'active', 'archived'],
        },
      ),
    );
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
        field: FieldReference.create('status'),
        constraint: constraint,
      );

  @override
  String toString() => name;
}
