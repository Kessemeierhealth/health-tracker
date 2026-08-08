import 'package:uuid/uuid.dart';

import '../errors/constraint_type.dart';
import '../errors/domain_message.dart';
import '../errors/domain_result.dart';
import '../errors/error_code.dart';
import '../errors/field_reference.dart';
import '../errors/message_category.dart';
import '../errors/message_key.dart';
import '../errors/message_severity.dart';

final class DomainEventId {
  const DomainEventId._(this.value);

  static const Uuid _uuid = Uuid();
  static final RegExp _uuidV7Pattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );

  final String value;

  static DomainResult<DomainEventId> generate() =>
      DomainResult<DomainEventId>.success(
        DomainEventId._(_uuid.v7().toLowerCase()),
      );

  static DomainResult<DomainEventId> fromString(String? value) {
    if (value == null) {
      return DomainResult<DomainEventId>.fromError(
        _error(
          code: 'PRO-VAL-EVTID-001',
          messageKey: 'validation.domainEventId.required',
          constraint: ConstraintType.required,
        ),
      );
    }

    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<DomainEventId>.fromError(
        _error(
          code: 'PRO-VAL-EVTID-002',
          messageKey: 'validation.domainEventId.blank',
          constraint: ConstraintType.blank,
        ),
      );
    }

    if (!_uuidV7Pattern.hasMatch(normalized)) {
      return DomainResult<DomainEventId>.fromError(
        _error(
          code: 'PRO-VAL-EVTID-003',
          messageKey: 'validation.domainEventId.invalidFormat',
          constraint: ConstraintType.format,
          parameters: const <String, Object>{'expectedFormat': 'UUIDv7'},
        ),
      );
    }

    return DomainResult<DomainEventId>.success(
      DomainEventId._(normalized.toLowerCase()),
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
      identical(this, other) || other is DomainEventId && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'DomainEventId($value)';
}
