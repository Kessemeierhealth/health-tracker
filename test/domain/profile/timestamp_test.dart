import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/timestamp.dart';

void main() {
  group('Timestamp', () {
    test('fromUtc accepts an existing UTC DateTime', () {
      final value = DateTime.utc(2026, 8, 5, 14, 37, 21, 123);
      final result = Timestamp.fromUtc(value);

      expect(result.isSuccess, isTrue);
      expect(result.value!.value, value);
      expect(result.value.toString(), '2026-08-05T14:37:21.123Z');
    });

    test('returns required for missing values in both factories', () {
      for (final error in <dynamic>[
        Timestamp.fromUtc(null).errors.single,
        Timestamp.parseIso8601(null).errors.single,
      ]) {
        expect(error.code.value, 'PRO-VAL-TS-001');
        expect(error.messageKey.value, 'validation.timestamp.required');
        expect(error.constraint, ConstraintType.required);
        expect(error.parameters, isEmpty);
      }
    });

    test('fromUtc rejects local DateTime without conversion', () {
      final error = Timestamp.fromUtc(DateTime(2026, 8, 5)).errors.single;

      expect(error.code.value, 'PRO-VAL-TS-002');
      expect(error.messageKey.value, 'validation.timestamp.notUtc');
      expect(error.constraint, ConstraintType.utc);
      expect(
        error.parameters,
        const <String, Object>{'expectedTimezone': 'UTC'},
      );
    });

    test('parseIso8601 trims and accepts explicit UTC', () {
      final result = Timestamp.parseIso8601(
        '  2026-08-05T14:37:21.123Z  ',
      );

      expect(result.isSuccess, isTrue);
      expect(result.value.toString(), '2026-08-05T14:37:21.123Z');
    });

    test('parseIso8601 returns blank before other errors', () {
      final error = Timestamp.parseIso8601('   ').errors.single;

      expect(error.code.value, 'PRO-VAL-TS-004');
      expect(error.constraint, ConstraintType.blank);
      expect(error.parameters, isEmpty);
    });

    test('parseIso8601 rejects malformed or impossible dates', () {
      for (final value in <String>['not-a-date', '2026-02-30T12:00:00Z']) {
        final error = Timestamp.parseIso8601(value).errors.single;
        expect(error.code.value, 'PRO-VAL-TS-003');
        expect(error.messageKey.value, 'validation.timestamp.invalidFormat');
        expect(error.constraint, ConstraintType.format);
        expect(
          error.parameters,
          const <String, Object>{'expectedFormat': 'ISO-8601 UTC'},
        );
        expect(error.toString(), isNot(contains(value)));
      }
    });

    test('parseIso8601 rejects local and offset timestamps as not UTC', () {
      for (final value in <String>[
        '2026-08-05T14:37:21.123',
        '2026-08-05T16:37:21.123+02:00',
      ]) {
        final error = Timestamp.parseIso8601(value).errors.single;
        expect(error.code.value, 'PRO-VAL-TS-002');
        expect(error.constraint, ConstraintType.utc);
      }
    });

    test('supports equality and chronological comparisons', () {
      final first = Timestamp.parseIso8601('2026-08-05T14:00:00.000Z').value!;
      final same = Timestamp.fromUtc(DateTime.utc(2026, 8, 5, 14)).value!;
      final later = Timestamp.parseIso8601('2026-08-05T15:00:00.000Z').value!;

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first.isEqualTo(same), isTrue);
      expect(first.isBefore(later), isTrue);
      expect(later.isAfter(first), isTrue);
      expect(first.compareTo(later), lessThan(0));
    });

    test('validation failures do not throw', () {
      expect(() => Timestamp.parseIso8601('invalid'), returnsNormally);
    });
  });
}
