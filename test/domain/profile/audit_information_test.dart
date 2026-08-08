import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/aggregate_version.dart';
import 'package:healthtracker/domain/profile/audit_information.dart';
import 'package:healthtracker/domain/profile/timestamp.dart';

void main() {
  final createdAt = _time(8);
  final updatedAt = _time(9);
  final now = _time(10);

  group('AuditInformation.createInitial', () {
    test('creates equal timestamps and initial version', () {
      final result = AuditInformation.createInitial(createdAt);
      expect(result.isSuccess, isTrue);
      expect(result.value!.createdAt, same(createdAt));
      expect(result.value!.updatedAt, same(createdAt));
      expect(result.value!.version.value, 0);
    });

    test('returns the documented now required error', () {
      _expectError(AuditInformation.createInitial(null), 'PRO-VAL-AUDIT-004',
          'now', ConstraintType.required, const {});
    });
  });

  group('AuditInformation.reconstruct', () {
    test('reconstructs a complete chronological state', () {
      final version = AggregateVersion.fromValue(7).value!;
      final result =
          AuditInformation.reconstruct(createdAt, updatedAt, version);
      expect(result.isSuccess, isTrue);
      expect(result.value!.createdAt, same(createdAt));
      expect(result.value!.updatedAt, same(updatedAt));
      expect(result.value!.version, same(version));
    });

    test('reports missing fields in deterministic order', () {
      final result = AuditInformation.reconstruct(null, null, null);
      expect(result.errors.map((error) => error.code.value), <String>[
        'PRO-VAL-AUDIT-001',
        'PRO-VAL-AUDIT-002',
        'PRO-VAL-AUDIT-003',
      ]);
      expect(result.errors.map((error) => error.field!.value),
          <String>['createdAt', 'updatedAt', 'version']);
    });

    test('rejects updatedAt before createdAt without exposing timestamps', () {
      final result = AuditInformation.reconstruct(
        updatedAt,
        createdAt,
        AggregateVersion.createInitial().value!,
      );
      _expectError(
          result,
          'PRO-VAL-AUDIT-007',
          'updatedAt',
          ConstraintType.chronological,
          const {'comparison': 'updatedAtBeforeCreatedAt'});
    });
  });

  group('AuditInformation.touchAndIncrement', () {
    test('updates atomically while preserving createdAt', () {
      final original = AuditInformation.reconstruct(
        createdAt,
        updatedAt,
        AggregateVersion.fromValue(4).value!,
      ).value!;
      final result = original.touchAndIncrement(now);
      expect(result.isSuccess, isTrue);
      expect(result.value!.createdAt, same(createdAt));
      expect(result.value!.updatedAt, same(now));
      expect(result.value!.version.value, 5);
      expect(original.updatedAt, same(updatedAt));
      expect(original.version.value, 4);
    });

    test('returns now required before chronological checks', () {
      final original = AuditInformation.createInitial(createdAt).value!;
      _expectError(original.touchAndIncrement(null), 'PRO-VAL-AUDIT-004', 'now',
          ConstraintType.required, const {});
    });

    test('checks createdAt before updatedAt', () {
      final original = AuditInformation.reconstruct(
        createdAt,
        updatedAt,
        AggregateVersion.createInitial().value!,
      ).value!;
      _expectError(
          original.touchAndIncrement(_time(7)),
          'PRO-VAL-AUDIT-005',
          'now',
          ConstraintType.chronological,
          const {'comparison': 'nowBeforeCreatedAt'});
      _expectError(
          original.touchAndIncrement(_time(8, 30)),
          'PRO-VAL-AUDIT-006',
          'now',
          ConstraintType.chronological,
          const {'comparison': 'nowBeforeUpdatedAt'});
      expect(original.version.value, 0);
      expect(original.updatedAt, same(updatedAt));
    });

    test('forwards version overflow unchanged and remains atomic', () {
      final original = AuditInformation.reconstruct(
        createdAt,
        updatedAt,
        AggregateVersion.fromValue(AggregateVersion.maximumValue).value!,
      ).value!;
      final result = original.touchAndIncrement(now);
      expect(result.errors.single.code.value, 'PRO-VAL-AGGVER-004');
      expect(result.errors.single.field!.value, 'value');
      expect(original.version.value, AggregateVersion.maximumValue);
      expect(original.updatedAt, same(updatedAt));
    });
  });

  test('implements value equality, hashCode, immutability and toString', () {
    final first = AuditInformation.reconstruct(
            createdAt, updatedAt, AggregateVersion.fromValue(2).value!)
        .value!;
    final same = AuditInformation.reconstruct(
            createdAt, updatedAt, AggregateVersion.fromValue(2).value!)
        .value!;
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first.toString(), contains('version: 2'));
    expect(
        () => AuditInformation.reconstruct(null, null, null), returnsNormally);
  });
}

Timestamp _time(int hour, [int minute = 0]) =>
    Timestamp.fromUtc(DateTime.utc(2026, 8, 6, hour, minute)).value!;

void _expectError(dynamic result, String code, String field,
    ConstraintType constraint, Map<String, Object> parameters) {
  expect(result.isFailure, isTrue);
  expect(result.value, isNull);
  final error = result.errors.single;
  expect(error.code.value, code);
  expect(error.field!.value, field);
  expect(error.constraint, constraint);
  expect(error.parameters, parameters);
}
