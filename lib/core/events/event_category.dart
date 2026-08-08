import '../errors/constraint_type.dart';
import '../errors/domain_message.dart';
import '../errors/domain_result.dart';
import '../errors/error_code.dart';
import '../errors/field_reference.dart';
import '../errors/message_category.dart';
import '../errors/message_key.dart';
import '../errors/message_severity.dart';

enum EventCategory {
  lifecycle,
  masterData,
  preferences,
  security,
  media,
  general;

  static const List<String> allowedValues = <String>[
    'lifecycle',
    'masterData',
    'preferences',
    'security',
    'media',
    'general'
  ];

  static DomainResult<EventCategory> fromString(String? value) {
    if (value == null) {
      return DomainResult<EventCategory>.fromError(_error(
        code: 'PRO-VAL-EVCAT-001',
        key: 'validation.eventCategory.required',
        constraint: ConstraintType.required,
      ));
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<EventCategory>.fromError(_error(
        code: 'PRO-VAL-EVCAT-002',
        key: 'validation.eventCategory.blank',
        constraint: ConstraintType.blank,
      ));
    }
    for (final category in values) {
      if (category.name == normalized) {
        return DomainResult<EventCategory>.success(category);
      }
    }
    return DomainResult<EventCategory>.fromError(_error(
      code: 'PRO-VAL-EVCAT-003',
      key: 'validation.eventCategory.invalid',
      constraint: ConstraintType.enumeration,
      parameters: const <String, Object>{'allowedValues': allowedValues},
    ));
  }

  static DomainError _error(
          {required String code,
          required String key,
          required ConstraintType constraint,
          Map<String, Object> parameters = const {}}) =>
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
  String toString() => name;
}
