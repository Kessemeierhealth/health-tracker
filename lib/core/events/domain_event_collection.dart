import 'dart:collection';

import 'domain_event.dart';

final class DomainEventCollection<TAggregateId> {
  DomainEventCollection._(List<DomainEvent<TAggregateId>> events)
      : _events = List<DomainEvent<TAggregateId>>.unmodifiable(events);

  final List<DomainEvent<TAggregateId>> _events;

  factory DomainEventCollection.empty() =>
      DomainEventCollection<TAggregateId>._(<DomainEvent<TAggregateId>>[]);

  DomainEventCollection<TAggregateId> add(DomainEvent<TAggregateId> event) =>
      DomainEventCollection<TAggregateId>._(
        <DomainEvent<TAggregateId>>[..._events, event],
      );

  List<DomainEvent<TAggregateId>> all() =>
      UnmodifiableListView<DomainEvent<TAggregateId>>(_events);

  int get count => _events.length;
  bool get isEmpty => _events.isEmpty;

  DomainEventCollection<TAggregateId> clear() =>
      DomainEventCollection<TAggregateId>.empty();

  @override
  String toString() => 'DomainEventCollection(count: $count)';
}
