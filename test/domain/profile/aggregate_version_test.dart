import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/aggregate_version.dart';

void main() {
  group('AggregateVersion', () {
    test('creates the documented initial value', () {
      final result = AggregateVersion.createInitial();
      expect(result.isSuccess, isTrue);
      expect(result.value!.value, 0);
    });

    test('reconstructs valid boundary values', () {
      for (final value in <int>[0, 1, AggregateVersion.maximumValue]) {
        final result = AggregateVersion.fromValue(value);
        expect(result.isSuccess, isTrue);
        expect(result.value!.value, value);
      }
    });

    test('returns required and minimum errors', () {
      _expectError(
          AggregateVersion.fromValue(null),
          'PRO-VAL-AGGVER-001',
          'validation.aggregateVersion.required',
          ConstraintType.required, const {});
      _expectError(
          AggregateVersion.fromValue(-1),
          'PRO-VAL-AGGVER-002',
          'validation.aggregateVersion.minimum',
          ConstraintType.minimum,
          const {'minimum': 0});
    });

    test('next increases exactly once without mutating the source', () {
      final original = AggregateVersion.fromValue(41).value!;
      final result = original.next();
      expect(result.value!.value, 42);
      expect(original.value, 41);
    });

    test('next prevents overflow and preserves the source', () {
      final maximum = AggregateVersion.fromValue(
        AggregateVersion.maximumValue,
      ).value!;
      _expectError(
          maximum.next(),
          'PRO-VAL-AGGVER-004',
          'validation.aggregateVersion.overflow',
          ConstraintType.overflow,
          const {'maximum': AggregateVersion.maximumValue});
      expect(maximum.value, AggregateVersion.maximumValue);
    });

    test('implements equality, hashCode, immutability and toString', () {
      final first = AggregateVersion.fromValue(7).value!;
      final same = AggregateVersion.fromValue(7).value!;
      final different = AggregateVersion.fromValue(8).value!;
      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
      expect(first.toString(), '7');
    });

    test('expected validation failures do not throw', () {
      expect(() => AggregateVersion.fromValue(null), returnsNormally);
      expect(() => AggregateVersion.fromValue(-1), returnsNormally);
      expect(
          () => AggregateVersion.fromValue(AggregateVersion.maximumValue)
              .value!
              .next(),
          returnsNormally);
    });
  });
}

void _expectError(dynamic result, String code, String key,
    ConstraintType constraint, Map<String, Object> parameters) {
  expect(result.isFailure, isTrue);
  expect(result.value, isNull);
  final error = result.errors.single;
  expect(error.code.value, code);
  expect(error.messageKey.value, key);
  expect(error.severity, MessageSeverity.error);
  expect(error.category, MessageCategory.validation);
  expect(error.field!.value, 'value');
  expect(error.constraint, constraint);
  expect(error.parameters, parameters);
}
