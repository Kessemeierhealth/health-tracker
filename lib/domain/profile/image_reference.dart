import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class ImageReference {
  const ImageReference._(this.value);

  static const String expectedPattern = r'^img_[a-z0-9]{26}$';
  static const int expectedLength = 30;
  static final RegExp _pattern = RegExp(expectedPattern);

  final String value;

  static DomainResult<ImageReference> create(String? value) {
    if (value == null) {
      return DomainResult<ImageReference>.fromError(
        _error(
          code: 'PRO-VAL-IMGREF-001',
          messageKey: 'validation.imageReference.required',
          constraint: ConstraintType.required,
        ),
      );
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<ImageReference>.fromError(
        _error(
          code: 'PRO-VAL-IMGREF-002',
          messageKey: 'validation.imageReference.blank',
          constraint: ConstraintType.blank,
        ),
      );
    }
    if (!_pattern.hasMatch(normalized)) {
      return DomainResult<ImageReference>.fromError(
        _error(
          code: 'PRO-VAL-IMGREF-003',
          messageKey: 'validation.imageReference.invalidFormat',
          constraint: ConstraintType.format,
          parameters: const <String, Object>{
            'expectedPattern': expectedPattern,
            'expectedLength': expectedLength,
          },
        ),
      );
    }
    return DomainResult<ImageReference>.success(ImageReference._(normalized));
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
      identical(this, other) || other is ImageReference && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
