import 'package:uuid/uuid.dart';

import '../errors/constraint_type.dart';
import '../errors/domain_message.dart';
import '../errors/domain_result.dart';
import '../errors/error_code.dart';
import '../errors/field_reference.dart';
import '../errors/message_category.dart';
import '../errors/message_key.dart';
import '../errors/message_severity.dart';

final class CorrelationId {
  const CorrelationId._(this.value);
  static const Uuid _uuid = Uuid();
  static final RegExp _pattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );
  final String value;

  static DomainResult<CorrelationId> generate() =>
      DomainResult<CorrelationId>.success(
        CorrelationId._(_uuid.v7().toLowerCase()),
      );

  static DomainResult<CorrelationId> fromString(String? value) {
    if (value == null) {
      return DomainResult<CorrelationId>.fromError(
        _error('PRO-VAL-CORRID-001', 'validation.correlationId.required',
            ConstraintType.required),
      );
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<CorrelationId>.fromError(
        _error('PRO-VAL-CORRID-002', 'validation.correlationId.blank',
            ConstraintType.blank),
      );
    }
    if (!_pattern.hasMatch(normalized)) {
      return DomainResult<CorrelationId>.fromError(
        _error(
            'PRO-VAL-CORRID-003',
            'validation.correlationId.invalidFormat',
            ConstraintType.format,
            const <String, Object>{'expectedFormat': 'UUIDv7'}),
      );
    }
    return DomainResult<CorrelationId>.success(
      CorrelationId._(normalized.toLowerCase()),
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
      identical(this, other) || other is CorrelationId && value == other.value;
  @override
  int get hashCode => value.hashCode;
  @override
  String toString() => 'CorrelationId($value)';
}
