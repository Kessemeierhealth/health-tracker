import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

enum MediaType {
  jpeg('image/jpeg'),
  png('image/png'),
  webp('image/webp');

  const MediaType(this.value);

  static const List<String> allowedValues = <String>[
    'image/jpeg',
    'image/png',
    'image/webp',
  ];

  final String value;

  static DomainResult<MediaType> fromString(String? value) {
    if (value == null) {
      return DomainResult<MediaType>.fromError(
        _error(
          code: 'PRO-VAL-MTYPE-001',
          messageKey: 'validation.mediaType.required',
          constraint: ConstraintType.required,
        ),
      );
    }

    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<MediaType>.fromError(
        _error(
          code: 'PRO-VAL-MTYPE-002',
          messageKey: 'validation.mediaType.blank',
          constraint: ConstraintType.blank,
        ),
      );
    }

    for (final mediaType in MediaType.values) {
      if (mediaType.value == normalized) {
        return DomainResult<MediaType>.success(mediaType);
      }
    }

    return DomainResult<MediaType>.fromError(
      _error(
        code: 'PRO-VAL-MTYPE-003',
        messageKey: 'validation.mediaType.invalid',
        constraint: ConstraintType.enumeration,
        parameters: const <String, Object>{
          'allowedValues': allowedValues,
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
        field: FieldReference.create('value'),
        constraint: constraint,
      );

  @override
  String toString() => value;
}
