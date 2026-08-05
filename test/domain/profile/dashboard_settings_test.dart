import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/domain_message.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/dashboard_configuration_version.dart';
import 'package:healthtracker/domain/profile/dashboard_layout.dart';
import 'package:healthtracker/domain/profile/dashboard_settings.dart';
import 'package:healthtracker/domain/profile/dashboard_widget_selection.dart';

void main() {
  final widgets = DashboardWidgetSelection.create(
    <String>['weight', 'nutrition'],
  ).value!;
  final emptyWidgets = DashboardWidgetSelection.create(const <String>[]).value!;
  final version = DashboardConfigurationVersion.create(1).value!;

  group('DashboardSettings', () {
    for (final layout in DashboardLayout.values) {
      test('creates valid settings with ${layout.name}', () {
        final result = DashboardSettings.create(layout, widgets, version);

        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
        expect(result.errors, isEmpty);
        expect(result.value?.layout, layout);
        expect(result.value?.visibleWidgets, widgets);
        expect(result.value?.configurationVersion, version);
      });
    }

    test('accepts an existing empty widget selection', () {
      final result = DashboardSettings.create(
        DashboardLayout.standard,
        emptyWidgets,
        version,
      );

      expect(result.isSuccess, isTrue);
      expect(result.value?.visibleWidgets.widgetKeys, isEmpty);
    });

    test('returns the documented error for a missing layout', () {
      final error =
          DashboardSettings.create(null, widgets, version).errors.single;

      _expectRequiredError(
        error,
        code: 'PRO-VAL-DSET-001',
        messageKey: 'validation.dashboardSettings.layout.required',
        field: 'layout',
      );
    });

    test('returns the documented error for missing visible widgets', () {
      final error = DashboardSettings.create(
        DashboardLayout.standard,
        null,
        version,
      ).errors.single;

      _expectRequiredError(
        error,
        code: 'PRO-VAL-DSET-003',
        messageKey: 'validation.dashboardSettings.visibleWidgets.required',
        field: 'visibleWidgets',
      );
    });

    test('returns the documented error for a missing version', () {
      final error = DashboardSettings.create(
        DashboardLayout.standard,
        widgets,
        null,
      ).errors.single;

      _expectRequiredError(
        error,
        code: 'PRO-VAL-DSET-004',
        messageKey:
            'validation.dashboardSettings.configurationVersion.required',
        field: 'configurationVersion',
      );
    });

    test('reports all missing fields without a duplicate aggregate error', () {
      final result = DashboardSettings.create(null, null, null);

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(
        result.errors.map((error) => error.code.value),
        <String>['PRO-VAL-DSET-001', 'PRO-VAL-DSET-003', 'PRO-VAL-DSET-004'],
      );
      expect(
        result.errors.any((error) => error.code.value == 'PRO-VAL-DSET-005'),
        isFalse,
      );
    });

    test('uses value equality and a consistent hash code', () {
      final first = DashboardSettings.create(
        DashboardLayout.standard,
        widgets,
        version,
      ).value!;
      final equal = DashboardSettings.create(
        DashboardLayout.standard,
        DashboardWidgetSelection.create(
          <String>['weight', 'nutrition'],
        ).value,
        DashboardConfigurationVersion.create(1).value,
      ).value!;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
    });

    test('is unequal when any component differs', () {
      final baseline = DashboardSettings.create(
        DashboardLayout.standard,
        widgets,
        version,
      ).value!;
      final otherLayout = DashboardSettings.create(
        DashboardLayout.compact,
        widgets,
        version,
      ).value!;
      final otherWidgets = DashboardSettings.create(
        DashboardLayout.standard,
        DashboardWidgetSelection.create(<String>['training']).value,
        version,
      ).value!;
      final otherVersion = DashboardSettings.create(
        DashboardLayout.standard,
        widgets,
        DashboardConfigurationVersion.create(2).value,
      ).value!;

      expect(baseline, isNot(otherLayout));
      expect(baseline, isNot(otherWidgets));
      expect(baseline, isNot(otherVersion));
    });

    test('is immutable and has a meaningful string representation', () {
      final settings = DashboardSettings.create(
        DashboardLayout.standard,
        widgets,
        version,
      ).value!;

      expect(settings.layout, DashboardLayout.standard);
      expect(
        settings.toString(),
        'DashboardSettings('
        'layout: DashboardLayout.standard, '
        'visibleWidgets: DashboardWidgetSelection([weight, nutrition]), '
        'configurationVersion: DashboardConfigurationVersion(1))',
      );
    });

    test('does not duplicate errors owned by contained value objects', () {
      final invalidWidgets = DashboardWidgetSelection.create(<String>[' ']);
      final invalidVersion = DashboardConfigurationVersion.create(0);

      expect(invalidWidgets.errors.single.code.value, 'PRO-VAL-DWSEL-002');
      expect(invalidVersion.errors.single.code.value, 'PRO-VAL-DCV-002');
      expect(
        DashboardSettings.create(
          DashboardLayout.standard,
          invalidWidgets.value,
          version,
        ).errors.single.code.value,
        'PRO-VAL-DSET-003',
      );
      expect(
        DashboardSettings.create(
          DashboardLayout.standard,
          widgets,
          invalidVersion.value,
        ).errors.single.code.value,
        'PRO-VAL-DSET-004',
      );
    });

    test('returns validation failures without throwing exceptions', () {
      expect(() => DashboardSettings.create(null, widgets, version),
          returnsNormally);
      expect(
          DashboardSettings.create(null, widgets, version).isFailure, isTrue);
    });
  });
}

void _expectRequiredError(
  DomainError error, {
  required String code,
  required String messageKey,
  required String field,
}) {
  expect(error.code.value, code);
  expect(error.messageKey.value, messageKey);
  expect(error.severity, MessageSeverity.error);
  expect(error.category, MessageCategory.validation);
  expect(error.field?.value, field);
  expect(error.constraint, ConstraintType.required);
  expect(error.parameters, isEmpty);
}
