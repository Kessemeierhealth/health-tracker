import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/dashboard_widget_selection.dart';

void main() {
  group('DashboardWidgetSelection', () {
    test('creates a normalized ordered selection through DomainResult', () {
      final result = DashboardWidgetSelection.create(
        <String>[' weight ', 'nutrition', ' Training '],
      );

      expect(result.isSuccess, isTrue);
      expect(result.errors, isEmpty);
      expect(
        result.value?.widgetKeys,
        <String>['weight', 'nutrition', 'Training'],
      );
    });

    test('accepts an empty list', () {
      final result = DashboardWidgetSelection.create(const <String>[]);

      expect(result.isSuccess, isTrue);
      expect(result.value?.widgetKeys, isEmpty);
    });

    test('returns the documented required error for a missing list', () {
      final result = DashboardWidgetSelection.create(null);
      final error = result.errors.single;

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(error.code.value, 'PRO-VAL-DWSEL-001');
      expect(
        error.messageKey.value,
        'validation.dashboardWidgetSelection.widgetKeys.required',
      );
      expect(error.severity, MessageSeverity.error);
      expect(error.category, MessageCategory.validation);
      expect(error.field?.value, 'widgetKeys');
      expect(error.constraint, ConstraintType.required);
      expect(error.parameters, isEmpty);
    });

    test('returns a blank error with the zero-based index', () {
      final result = DashboardWidgetSelection.create(
        <String>['weight', '   ', 'nutrition'],
      );
      final error = result.errors.single;

      expect(result.isFailure, isTrue);
      expect(error.code.value, 'PRO-VAL-DWSEL-002');
      expect(
        error.messageKey.value,
        'validation.dashboardWidgetSelection.widgetKey.blank',
      );
      expect(error.constraint, ConstraintType.blank);
      expect(error.parameters, <String, Object>{'index': 1});
      expect(error.parameters.toString(), isNot(contains('   ')));
    });

    test('returns duplicate details after normalization', () {
      final result = DashboardWidgetSelection.create(
        <String>['weight', 'nutrition', ' weight '],
      );
      final error = result.errors.single;

      expect(result.isFailure, isTrue);
      expect(error.code.value, 'PRO-VAL-DWSEL-003');
      expect(
        error.messageKey.value,
        'validation.dashboardWidgetSelection.widgetKey.duplicate',
      );
      expect(error.constraint, ConstraintType.duplicate);
      expect(error.parameters, <String, Object>{
        'widgetKey': 'weight',
        'firstIndex': 0,
        'duplicateIndex': 2,
      });
    });

    test('reports each additional duplicate and excludes blank keys', () {
      final result = DashboardWidgetSelection.create(
        <String>['weight', ' ', 'weight', ' weight '],
      );

      expect(
        result.errors.map((error) => error.code.value),
        <String>[
          'PRO-VAL-DWSEL-002',
          'PRO-VAL-DWSEL-003',
          'PRO-VAL-DWSEL-003',
        ],
      );
    });

    test('preserves case and treats differently cased keys as distinct', () {
      final result = DashboardWidgetSelection.create(
        <String>['Weight', 'weight'],
      );

      expect(result.isSuccess, isTrue);
      expect(result.value?.widgetKeys, <String>['Weight', 'weight']);
    });

    test('defensively copies input and exposes an immutable list', () {
      final source = <String>['weight'];
      final selection = DashboardWidgetSelection.create(source).value!;

      source.add('nutrition');

      expect(selection.widgetKeys, <String>['weight']);
      expect(
        () => selection.widgetKeys.add('training'),
        throwsUnsupportedError,
      );
    });

    test('implements ordered value equality and consistent hash codes', () {
      final first = DashboardWidgetSelection.create(
        <String>[' weight ', 'nutrition'],
      ).value!;
      final equal = DashboardWidgetSelection.create(
        <String>['weight', 'nutrition'],
      ).value!;
      final reordered = DashboardWidgetSelection.create(
        <String>['nutrition', 'weight'],
      ).value!;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
      expect(first, isNot(reordered));
      expect(
        first.toString(),
        'DashboardWidgetSelection([weight, nutrition])',
      );
    });

    test('returns failures without throwing validation exceptions', () {
      expect(() => DashboardWidgetSelection.create(null), returnsNormally);
      expect(
        () => DashboardWidgetSelection.create(<String>[' ']),
        returnsNormally,
      );
    });
  });
}
