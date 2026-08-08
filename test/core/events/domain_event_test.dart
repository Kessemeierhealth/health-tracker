import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/events/domain_event.dart';
import 'package:healthtracker/core/events/domain_event_id.dart';
import 'package:healthtracker/core/events/event_category.dart';
import 'package:healthtracker/core/events/event_metadata.dart';
import 'package:healthtracker/core/events/event_producer.dart';
import 'package:healthtracker/core/events/event_schema_version.dart';
import 'package:healthtracker/core/events/event_type.dart';
import 'package:healthtracker/domain/profile/aggregate_version.dart';
import 'package:healthtracker/domain/profile/profile_id.dart';
import 'package:healthtracker/domain/profile/timestamp.dart';

void main() {
  group('DomainEvent', () {
    test('exposes immutable common attributes and derives aggregateId', () {
      final event = _event('secret-payload');
      expect(event.aggregateId, event.metadata.aggregateId);
      expect(event.eventType.toString(), 'ProfileCreated');
      expect(event.category, EventCategory.lifecycle);
      expect(event.aggregateVersion.value, 1);
    });
    test('identity and hashCode use only eventId', () {
      final id = DomainEventId.generate().value!;
      final first = _event('first', id: id);
      final sameIdentity = _event('second', id: id);
      expect(first, sameIdentity);
      expect(first.hashCode, sameIdentity.hashCode);
    });
    test('safe string output does not include subclass payload', () {
      final event = _event('secret-payload');
      expect(event.toString(), contains('ProfileCreated'));
      expect(event.toString(), isNot(contains('secret-payload')));
    });
  });
}

_TestEvent _event(String payload, {DomainEventId? id}) {
  final aggregateId =
      ProfileId.fromString('01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f').value!;
  final metadata = EventMetadata.create<ProfileId>(
          aggregateId,
          null,
          null,
          EventProducer.fromString('profile').value!,
          EventSchemaVersion.createInitial().value!)
      .value!;
  return _TestEvent(
    eventId: id ?? DomainEventId.generate().value!,
    eventType: EventType.fromString('ProfileCreated').value!,
    category: EventCategory.lifecycle,
    aggregateVersion: AggregateVersion.fromValue(1).value!,
    occurredAt: Timestamp.parseIso8601('2026-08-08T10:00:00Z').value!,
    metadata: metadata,
    payload: payload,
  );
}

final class _TestEvent extends DomainEvent<ProfileId> {
  const _TestEvent({
    required super.eventId,
    required super.eventType,
    required super.category,
    required super.aggregateVersion,
    required super.occurredAt,
    required super.metadata,
    required this.payload,
  });
  final String payload;
}
