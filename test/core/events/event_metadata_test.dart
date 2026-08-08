import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/events/causation_id.dart';
import 'package:healthtracker/core/events/correlation_id.dart';
import 'package:healthtracker/core/events/domain_event_id.dart';
import 'package:healthtracker/core/events/event_metadata.dart';
import 'package:healthtracker/core/events/event_producer.dart';
import 'package:healthtracker/core/events/event_schema_version.dart';
import 'package:healthtracker/domain/profile/profile_id.dart';

void main() {
  group('EventMetadata', () {
    final aggregateId =
        ProfileId.fromString('01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f').value!;
    final producer = EventProducer.fromString('profile').value!;
    final schema = EventSchemaVersion.createInitial().value!;

    test('creates complete metadata with optional IDs absent', () {
      final result = EventMetadata.create<ProfileId>(
          aggregateId, null, null, producer, schema);
      expect(result.isSuccess, isTrue);
      expect(result.value!.aggregateId, aggregateId);
      expect(result.value!.correlationId, isNull);
      expect(result.value!.causationId, isNull);
    });
    test('creates, compares, hashes, and safely renders full metadata', () {
      final correlation = CorrelationId.generate().value!;
      final causation =
          CausationId.fromEventId(DomainEventId.generate().value!).value!;
      final first = EventMetadata.create<ProfileId>(
              aggregateId, correlation, causation, producer, schema)
          .value!;
      final same = EventMetadata.create<ProfileId>(
              aggregateId, correlation, causation, producer, schema)
          .value!;
      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first.toString(), contains('aggregateId:'));
      expect(first.toString(), isNot(contains('payload')));
    });
    test('reports missing fields independently in deterministic order', () {
      final result =
          EventMetadata.create<ProfileId>(null, null, null, null, null);
      expect(result.errors.map((error) => error.code.value),
          ['PRO-VAL-EVMETA-001', 'PRO-VAL-EVMETA-002', 'PRO-VAL-EVMETA-003']);
      expect(result.errors.map((error) => error.field!.value),
          ['aggregateId', 'producer', 'schemaVersion']);
    });
  });
}
