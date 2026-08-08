import '../../domain/profile/aggregate_version.dart';
import '../../domain/profile/timestamp.dart';
import 'domain_event_id.dart';
import 'event_category.dart';
import 'event_metadata.dart';
import 'event_type.dart';

abstract class DomainEvent<TAggregateId> {
  const DomainEvent({
    required this.eventId,
    required this.eventType,
    required this.category,
    required this.aggregateVersion,
    required this.occurredAt,
    required this.metadata,
  });

  final DomainEventId eventId;
  final EventType eventType;
  final EventCategory category;
  final AggregateVersion aggregateVersion;
  final Timestamp occurredAt;
  final EventMetadata<TAggregateId> metadata;

  TAggregateId get aggregateId => metadata.aggregateId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DomainEvent && eventId == other.eventId;
  @override
  int get hashCode => eventId.hashCode;
  @override
  String toString() => 'DomainEvent(eventId: $eventId, eventType: $eventType, '
      'category: $category, aggregateId: $aggregateId, '
      'aggregateVersion: $aggregateVersion, occurredAt: $occurredAt)';
}
