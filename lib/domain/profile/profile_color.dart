import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class ProfileColor {
  const ProfileColor._(this._argb);

  static const int _minimumArgb = 0x00000000;
  static const int _maximumArgb = 0xFFFFFFFF;
  static final RegExp _hexPattern = RegExp(r'^[0-9a-fA-F]{8}$');

  final int _argb;

  static DomainResult<ProfileColor> fromArgb(int? value) {
    if (value == null) {
      return DomainResult<ProfileColor>.fromError(_requiredError());
    }
    if (value < _minimumArgb || value > _maximumArgb) {
      return DomainResult<ProfileColor>.fromError(_invalidError());
    }
    return DomainResult<ProfileColor>.success(ProfileColor._(value));
  }

  static DomainResult<ProfileColor> fromHex(String? value) {
    if (value == null || value.isEmpty) {
      return DomainResult<ProfileColor>.fromError(_requiredError());
    }
    if (!_hexPattern.hasMatch(value)) {
      return DomainResult<ProfileColor>.fromError(_invalidError());
    }
    return DomainResult<ProfileColor>.success(
      ProfileColor._(int.parse(value, radix: 16)),
    );
  }

  int toArgb() => _argb;

  String toHex() => _argb.toRadixString(16).padLeft(8, '0').toUpperCase();

  static DomainError _requiredError() => _error(
        code: 'PRO-VAL-COLOR-001',
        messageKey: 'validation.profile.color.required',
        constraint: ConstraintType.required,
      );

  static DomainError _invalidError() => _error(
        code: 'PRO-VAL-COLOR-002',
        messageKey: 'validation.profile.color.invalid',
        constraint: ConstraintType.format,
      );

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
        field: FieldReference.create('color'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProfileColor && _argb == other._argb;

  @override
  int get hashCode => _argb.hashCode;

  @override
  String toString() => 'ProfileColor(${toHex()})';
}
