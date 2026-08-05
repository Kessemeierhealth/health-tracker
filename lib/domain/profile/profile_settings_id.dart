import 'package:uuid/uuid.dart';

import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class ProfileSettingsId {
  const ProfileSettingsId._(this.value);

  static const Uuid _uuid = Uuid();

  static final RegExp _uuidV7Pattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  final String value;

  static DomainResult<ProfileSettingsId> generate() =>
      DomainResult<ProfileSettingsId>.success(
        ProfileSettingsId._(_uuid.v7().toLowerCase()),
      );

  static DomainResult<ProfileSettingsId> fromString(String? value) {
    if (value == null) {
      return DomainResult<ProfileSettingsId>.fromError(
        _error(
          code: 'PRO-VAL-PSETID-001',
          messageKey: 'validation.profileSettingsId.required',
          constraint: ConstraintType.required,
        ),
      );
    }

    final normalizedValue = value.trim();
    if (normalizedValue.isEmpty) {
      return DomainResult<ProfileSettingsId>.fromError(
        _error(
          code: 'PRO-VAL-PSETID-002',
          messageKey: 'validation.profileSettingsId.blank',
          constraint: ConstraintType.blank,
        ),
      );
    }

    if (!_uuidV7Pattern.hasMatch(normalizedValue)) {
      return DomainResult<ProfileSettingsId>.fromError(
        _error(
          code: 'PRO-VAL-PSETID-003',
          messageKey: 'validation.profileSettingsId.invalidFormat',
          constraint: ConstraintType.format,
          parameters: const <String, Object>{'expectedFormat': 'UUIDv7'},
        ),
      );
    }

    return DomainResult<ProfileSettingsId>.success(
      ProfileSettingsId._(normalizedValue.toLowerCase()),
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
        field: FieldReference.create('value'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileSettingsId && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
