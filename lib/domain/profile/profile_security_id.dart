import 'package:uuid/uuid.dart';

import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class ProfileSecurityId {
  const ProfileSecurityId._(this.value);

  static const Uuid _uuid = Uuid();
  static final RegExp _uuidV7Pattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  final String value;

  static DomainResult<ProfileSecurityId> generate() =>
      DomainResult<ProfileSecurityId>.success(
        ProfileSecurityId._(_uuid.v7().toLowerCase()),
      );

  static DomainResult<ProfileSecurityId> fromString(String? value) {
    if (value == null) {
      return DomainResult<ProfileSecurityId>.fromError(
        _error('PRO-VAL-PSECID-001', 'validation.profileSecurityId.required',
            ConstraintType.required),
      );
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<ProfileSecurityId>.fromError(
        _error('PRO-VAL-PSECID-002', 'validation.profileSecurityId.blank',
            ConstraintType.blank),
      );
    }
    if (!_uuidV7Pattern.hasMatch(normalized)) {
      return DomainResult<ProfileSecurityId>.fromError(
        _error(
          'PRO-VAL-PSECID-003',
          'validation.profileSecurityId.invalidFormat',
          ConstraintType.format,
          const <String, Object>{'expectedFormat': 'UUIDv7'},
        ),
      );
    }
    return DomainResult<ProfileSecurityId>.success(
      ProfileSecurityId._(normalized.toLowerCase()),
    );
  }

  static DomainError _error(
    String code,
    String key,
    ConstraintType constraint, [
    Map<String, Object> parameters = const {},
  ]) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(key)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: parameters,
        field: FieldReference.create('value'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileSecurityId && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
