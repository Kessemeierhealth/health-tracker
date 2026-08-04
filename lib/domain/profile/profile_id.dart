import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class ProfileId {
  const ProfileId._(this.value);

  static final RegExp _uuidV7Pattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  final String value;

  static DomainResult<ProfileId> fromString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return DomainResult<ProfileId>.fromError(
        _error(
          code: 'PRO-VAL-ID-001',
          messageKey: 'validation.profile.id.required',
          constraint: ConstraintType.required,
        ),
      );
    }
    if (!_uuidV7Pattern.hasMatch(value)) {
      return DomainResult<ProfileId>.fromError(
        _error(
          code: 'PRO-VAL-ID-002',
          messageKey: 'validation.profile.id.invalidFormat',
          constraint: ConstraintType.format,
          parameters: const <String, Object>{'expectedFormat': 'UUIDv7'},
        ),
      );
    }
    return DomainResult<ProfileId>.success(ProfileId._(value.toLowerCase()));
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
        field: FieldReference.create('profileId'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProfileId && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ProfileId($value)';
}
