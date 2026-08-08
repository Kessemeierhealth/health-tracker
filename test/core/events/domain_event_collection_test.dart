import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/events/domain_event.dart';
import 'package:healthtracker/core/events/domain_event_collection.dart';
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
  group('DomainEventCollection', () {
    test('empty has the documented state and safe rendering', () {
      final collection = DomainEventCollection<ProfileId>.empty();
      expect(collection.isEmpty, isTrue);
      expect(collection.count, 0);
      expect(collection.all(), isEmpty);
      expect(collection.toString(), 'DomainEventCollection(count: 0)');
    });
    test('add preserves insertion order and the original collection', () {
      final empty = DomainEventCollection<ProfileId>.empty();
      final first = _event('ProfileCreated');
      final second = _event('ProfileUpdated');
      final one = empty.add(first);
      final two = one.add(second);
      expect(empty.count, 0);
      expect(one.all(), [first]);
      expect(two.all(), [first, second]);
    });
    test('all is externally immutable', () {
      final collection = DomainEventCollection<ProfileId>.empty()
          .add(_event('ProfileCreated'));
      expect(() => collection.all().clear(), throwsUnsupportedError);
      expect(collection.count, 1);
    });
    test('clear returns a new empty collection without changing the source',
        () {
      final source = DomainEventCollection<ProfileId>.empty()
          .add(_event('ProfileCreated'));
      final cleared = source.clear();
      expect(source.count, 1);
      expect(cleared.isEmpty, isTrue);
      expect(source.toString(), 'DomainEventCollection(count: 1)');
    });
  });
}

_Event _event(String type) {
  final aggregateId =
      ProfileId.fromString('01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f').value!;
  return _Event(
    eventId: DomainEventId.generate().value!,
    eventType: EventType.fromString(type).value!,
    category: EventCategory.general,
    aggregateVersion: AggregateVersion.fromValue(1).value!,
    occurredAt: Timestamp.parseIso8601('2026-08-08T10:00:00Z').value!,
    metadata: EventMetadata.create<ProfileId>(
            aggregateId,
            null,
            null,
            EventProducer.fromString('profile').value!,
            EventSchemaVersion.createInitial().value!)
        .value!,
  );
}

final class _Event extends DomainEvent<ProfileId> {
  const _Event({
    required super.eventId,
    required super.eventType,
    required super.category,
    required super.aggregateVersion,
    required super.occurredAt,
    required super.metadata,
  });
}
