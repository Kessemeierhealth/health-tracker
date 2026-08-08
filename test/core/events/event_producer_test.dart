import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/events/event_producer.dart';

void main() {
  group('EventProducer', () {
    test('accepts canonical values at both length boundaries', () {
      for (final value in ['ab', 'a${'1' * 63}', 'profile-lifecycle']) {
        final producer = EventProducer.fromString(' $value ').value!;
        expect(producer.value, value);
        expect(producer.toString(), 'EventProducer($value)');
      }
    });
    test('rejects invalid lengths, starts, case, spaces, and symbols', () {
      for (final value in [
        'a',
        'a${'1' * 64}',
        '1profile',
        '-profile',
        'Profile',
        'profile host',
        'profile_host',
      ]) {
        final result = EventProducer.fromString(value);
        expect(result.errors.single.code.value, 'PRO-VAL-EVPROD-003');
        expect(result.errors.single.parameters, isNot(contains('value')));
      }
    });
    test('returns required and blank errors', () {
      expect(EventProducer.fromString(null).errors.single.code.value,
          'PRO-VAL-EVPROD-001');
      expect(EventProducer.fromString(' ').errors.single.code.value,
          'PRO-VAL-EVPROD-002');
    });
    test('uses value equality and hashCode', () {
      final first = EventProducer.fromString('profile').value!;
      final same = EventProducer.fromString(' profile ').value!;
      expect(first, same);
      expect(first.hashCode, same.hashCode);
    });
  });
}
