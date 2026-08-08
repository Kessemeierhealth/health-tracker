import '../errors/constraint_type.dart';
import '../errors/domain_message.dart';
import '../errors/domain_result.dart';
import '../errors/error_code.dart';
import '../errors/field_reference.dart';
import '../errors/message_category.dart';
import '../errors/message_key.dart';
import '../errors/message_severity.dart';
import 'causation_id.dart';
import 'correlation_id.dart';
import 'event_producer.dart';
import 'event_schema_version.dart';

final class EventMetadata<TAggregateId> {
  const EventMetadata._({
    required this.aggregateId,
    required this.correlationId,
    required this.causationId,
    required this.producer,
    required this.schemaVersion,
  });

  final TAggregateId aggregateId;
  final CorrelationId? correlationId;
  final CausationId? causationId;
  final EventProducer producer;
  final EventSchemaVersion schemaVersion;

  static DomainResult<EventMetadata<TAggregateId>> create<TAggregateId>(
    TAggregateId? aggregateId,
    CorrelationId? correlationId,
    CausationId? causationId,
    EventProducer? producer,
    EventSchemaVersion? schemaVersion,
  ) {
    final errors = <DomainError>[];
    if (aggregateId == null) {
      errors.add(_error(
        'PRO-VAL-EVMETA-001',
        'validation.eventMetadata.aggregateId.required',
        'aggregateId',
      ));
    }
    if (producer == null) {
      errors.add(_error(
        'PRO-VAL-EVMETA-002',
        'validation.eventMetadata.producer.required',
        'producer',
      ));
    }
    if (schemaVersion == null) {
      errors.add(_error(
        'PRO-VAL-EVMETA-003',
        'validation.eventMetadata.schemaVersion.required',
        'schemaVersion',
      ));
    }
    if (errors.isNotEmpty) {
      return DomainResult<EventMetadata<TAggregateId>>.failure(errors);
    }
    return DomainResult<EventMetadata<TAggregateId>>.success(
      EventMetadata<TAggregateId>._(
        aggregateId: aggregateId as TAggregateId,
        correlationId: correlationId,
        causationId: causationId,
        producer: producer!,
        schemaVersion: schemaVersion!,
      ),
    );
  }

  static DomainError _error(String code, String key, String field) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(key)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: const {},
        field: FieldReference.create(field),
        constraint: ConstraintType.required,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventMetadata<TAggregateId> &&
          aggregateId == other.aggregateId &&
          correlationId == other.correlationId &&
          causationId == other.causationId &&
          producer == other.producer &&
          schemaVersion == other.schemaVersion;
  @override
  int get hashCode => Object.hash(
      aggregateId, correlationId, causationId, producer, schemaVersion);
  @override
  String toString() => 'EventMetadata(aggregateId: $aggregateId, '
      'correlationId: $correlationId, causationId: $causationId, '
      'producer: $producer, schemaVersion: $schemaVersion)';
}
