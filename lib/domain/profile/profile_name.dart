import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class ProfileName {
  const ProfileName._(this.value);

  final String value;

  static DomainResult<ProfileName> create(String? value) {
    if (value == null || value.isEmpty) {
      return DomainResult<ProfileName>.fromError(
        _error(
          code: 'PRO-VAL-NAME-001',
          messageKey: 'validation.profile.name.required',
          constraint: ConstraintType.required,
        ),
      );
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<ProfileName>.fromError(
        _error(
          code: 'PRO-VAL-NAME-002',
          messageKey: 'validation.profile.name.blank',
          constraint: ConstraintType.blank,
        ),
      );
    }
    return DomainResult<ProfileName>.success(ProfileName._(normalized));
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
        field: FieldReference.create('name'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProfileName && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ProfileName($value)';
}
