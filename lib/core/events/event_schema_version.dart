import '../errors/constraint_type.dart';
import '../errors/domain_message.dart';
import '../errors/domain_result.dart';
import '../errors/error_code.dart';
import '../errors/field_reference.dart';
import '../errors/message_category.dart';
import '../errors/message_key.dart';
import '../errors/message_severity.dart';

final class EventSchemaVersion {
  const EventSchemaVersion._(this.value);
  static const int initialValue = 1;
  static const int maximumValue = 2147483647;
  final int value;

  static DomainResult<EventSchemaVersion> createInitial() =>
      DomainResult<EventSchemaVersion>.success(
        const EventSchemaVersion._(initialValue),
      );

  static DomainResult<EventSchemaVersion> fromValue(int? value) {
    if (value == null) {
      return DomainResult<EventSchemaVersion>.fromError(
        _error('PRO-VAL-EVSCHEMA-001', 'validation.eventSchemaVersion.required',
            ConstraintType.required),
      );
    }
    if (value < initialValue) {
      return DomainResult<EventSchemaVersion>.fromError(
        _error(
            'PRO-VAL-EVSCHEMA-002',
            'validation.eventSchemaVersion.minimum',
            ConstraintType.minimum,
            const <String, Object>{'minimum': initialValue}),
      );
    }
    if (value > maximumValue) {
      return DomainResult<EventSchemaVersion>.fromError(
        _error(
            'PRO-VAL-EVSCHEMA-003',
            'validation.eventSchemaVersion.maximum',
            ConstraintType.maximum,
            const <String, Object>{'maximum': maximumValue}),
      );
    }
    return DomainResult<EventSchemaVersion>.success(
        EventSchemaVersion._(value));
  }

  DomainResult<EventSchemaVersion> next() {
    if (value == maximumValue) {
      return DomainResult<EventSchemaVersion>.fromError(
        _error(
            'PRO-VAL-EVSCHEMA-004',
            'validation.eventSchemaVersion.overflow',
            ConstraintType.overflow,
            const <String, Object>{'maximum': maximumValue}),
      );
    }
    return DomainResult<EventSchemaVersion>.success(
      EventSchemaVersion._(value + 1),
    );
  }

  static DomainError _error(String code, String key, ConstraintType constraint,
          [Map<String, Object> parameters = const {}]) =>
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
      other is EventSchemaVersion && value == other.value;
  @override
  int get hashCode => value.hashCode;
  @override
  String toString() => 'EventSchemaVersion($value)';
}
