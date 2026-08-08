import '../errors/constraint_type.dart';
import '../errors/domain_message.dart';
import '../errors/domain_result.dart';
import '../errors/error_code.dart';
import '../errors/field_reference.dart';
import '../errors/message_category.dart';
import '../errors/message_key.dart';
import '../errors/message_severity.dart';
import 'domain_event_id.dart';

final class CausationId {
  const CausationId._(this.value);
  static final RegExp _pattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );
  final String value;

  static DomainResult<CausationId> fromEventId(DomainEventId? eventId) {
    if (eventId == null) {
      return DomainResult<CausationId>.fromError(_required());
    }
    return DomainResult<CausationId>.success(CausationId._(eventId.value));
  }

  static DomainResult<CausationId> fromString(String? value) {
    if (value == null) {
      return DomainResult<CausationId>.fromError(_required());
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<CausationId>.fromError(
        _error('PRO-VAL-CAUSID-002', 'validation.causationId.blank',
            ConstraintType.blank),
      );
    }
    if (!_pattern.hasMatch(normalized)) {
      return DomainResult<CausationId>.fromError(
        _error(
            'PRO-VAL-CAUSID-003',
            'validation.causationId.invalidFormat',
            ConstraintType.format,
            const <String, Object>{'expectedFormat': 'UUIDv7'}),
      );
    }
    return DomainResult<CausationId>.success(
      CausationId._(normalized.toLowerCase()),
    );
  }

  static DomainError _required() => _error(
        'PRO-VAL-CAUSID-001',
        'validation.causationId.required',
        ConstraintType.required,
      );
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
      identical(this, other) || other is CausationId && value == other.value;
  @override
  int get hashCode => value.hashCode;
  @override
  String toString() => 'CausationId($value)';
}
