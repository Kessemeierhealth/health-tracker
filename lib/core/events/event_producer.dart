import '../errors/constraint_type.dart';
import '../errors/domain_message.dart';
import '../errors/domain_result.dart';
import '../errors/error_code.dart';
import '../errors/field_reference.dart';
import '../errors/message_category.dart';
import '../errors/message_key.dart';
import '../errors/message_severity.dart';

final class EventProducer {
  const EventProducer._(this.value);
  static const String expectedPattern = r'^[a-z][a-z0-9-]{1,63}$';
  static const int minimumLength = 2;
  static const int maximumLength = 64;
  static final RegExp _pattern = RegExp(expectedPattern);
  final String value;

  static DomainResult<EventProducer> fromString(String? value) {
    if (value == null) {
      return DomainResult<EventProducer>.fromError(
        _error('PRO-VAL-EVPROD-001', 'validation.eventProducer.required',
            ConstraintType.required),
      );
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<EventProducer>.fromError(
        _error('PRO-VAL-EVPROD-002', 'validation.eventProducer.blank',
            ConstraintType.blank),
      );
    }
    if (!_pattern.hasMatch(normalized)) {
      return DomainResult<EventProducer>.fromError(
        _error('PRO-VAL-EVPROD-003', 'validation.eventProducer.invalidFormat',
            ConstraintType.format, const <String, Object>{
          'expectedPattern': expectedPattern,
          'minimumLength': minimumLength,
          'maximumLength': maximumLength,
        }),
      );
    }
    return DomainResult<EventProducer>.success(EventProducer._(normalized));
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
      identical(this, other) || other is EventProducer && value == other.value;
  @override
  int get hashCode => value.hashCode;
  @override
  String toString() => 'EventProducer($value)';
}
