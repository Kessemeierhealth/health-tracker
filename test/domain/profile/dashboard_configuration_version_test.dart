import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/dashboard_configuration_version.dart';

void main() {
  group('DashboardConfigurationVersion', () {
    test('creates the initial boundary version through DomainResult', () {
      final result = DashboardConfigurationVersion.create(1);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.value?.value, 1);
      expect(result.errors, isEmpty);
    });

    test('accepts versions greater than the initial value', () {
      final result = DashboardConfigurationVersion.create(42);

      expect(result.isSuccess, isTrue);
      expect(result.value?.value, 42);
    });

    test('returns the documented required error for a missing value', () {
      final result = DashboardConfigurationVersion.create(null);
      final error = result.errors.single;

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(error.code.value, 'PRO-VAL-DCV-001');
      expect(
        error.messageKey.value,
        'validation.dashboardConfigurationVersion.required',
      );
      expect(error.severity, MessageSeverity.error);
      expect(error.category, MessageCategory.validation);
      expect(error.field?.value, 'value');
      expect(error.constraint, ConstraintType.required);
      expect(error.parameters, isEmpty);
    });

    test('returns the documented minimum error for zero', () {
      final result = DashboardConfigurationVersion.create(0);
      final error = result.errors.single;

      expect(result.isFailure, isTrue);
      expect(error.code.value, 'PRO-VAL-DCV-002');
      expect(
        error.messageKey.value,
        'validation.dashboardConfigurationVersion.minimum',
      );
      expect(error.severity, MessageSeverity.error);
      expect(error.category, MessageCategory.validation);
      expect(error.field?.value, 'value');
      expect(error.constraint, ConstraintType.minimum);
      expect(
        error.parameters,
        <String, Object>{'minimum': 1, 'actual': 0},
      );
    });

    test('returns the actual negative value in the minimum error', () {
      final error = DashboardConfigurationVersion.create(-7).errors.single;

      expect(error.code.value, 'PRO-VAL-DCV-002');
      expect(
        error.parameters,
        <String, Object>{'minimum': 1, 'actual': -7},
      );
    });

    test('implements value equality and consistent hash codes', () {
      final first = DashboardConfigurationVersion.create(3).value!;
      final equal = DashboardConfigurationVersion.create(3).value!;
      final different = DashboardConfigurationVersion.create(4).value!;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
      expect(first, isNot(different));
    });

    test('has an immutable value and meaningful string representation', () {
      final version = DashboardConfigurationVersion.create(5).value!;

      expect(version.value, 5);
      expect(version.toString(), 'DashboardConfigurationVersion(5)');
    });

    test('returns validation failures without throwing exceptions', () {
      expect(
        () => DashboardConfigurationVersion.create(null),
        returnsNormally,
      );
      expect(() => DashboardConfigurationVersion.create(0), returnsNormally);
      expect(DashboardConfigurationVersion.create(null).isFailure, isTrue);
      expect(DashboardConfigurationVersion.create(0).isFailure, isTrue);
    });
  });
}
