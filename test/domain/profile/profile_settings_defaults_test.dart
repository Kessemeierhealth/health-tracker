import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/domain_message.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/appearance_settings.dart';
import 'package:healthtracker/domain/profile/dashboard_configuration_version.dart';
import 'package:healthtracker/domain/profile/dashboard_layout.dart';
import 'package:healthtracker/domain/profile/dashboard_settings.dart';
import 'package:healthtracker/domain/profile/dashboard_widget_selection.dart';
import 'package:healthtracker/domain/profile/language.dart';
import 'package:healthtracker/domain/profile/localization_settings.dart';
import 'package:healthtracker/domain/profile/measurement_system.dart';
import 'package:healthtracker/domain/profile/profile_settings_defaults.dart';
import 'package:healthtracker/domain/profile/text_scale_preference.dart';
import 'package:healthtracker/domain/profile/theme_preference.dart';

void main() {
  final localization = _localization();
  final dashboard = _dashboard();
  final appearance = _appearance();

  group('ProfileSettingsDefaults', () {
    test('creates a complete valid default state through DomainResult', () {
      final result = ProfileSettingsDefaults.create(
        localization,
        dashboard,
        appearance,
      );

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.errors, isEmpty);
      expect(result.value?.localization, localization);
      expect(result.value?.dashboard, dashboard);
      expect(result.value?.appearance, appearance);
    });

    test('returns the documented error for missing localization', () {
      final result = ProfileSettingsDefaults.create(
        null,
        dashboard,
        appearance,
      );

      _expectRequiredError(
        result.errors.single,
        code: 'PRO-VAL-PDEF-001',
        messageKey: 'validation.profileSettingsDefaults.localization.required',
        field: 'localization',
      );
      expect(result.value, isNull);
    });

    test('returns the documented error for a missing dashboard', () {
      final result = ProfileSettingsDefaults.create(
        localization,
        null,
        appearance,
      );

      _expectRequiredError(
        result.errors.single,
        code: 'PRO-VAL-PDEF-002',
        messageKey: 'validation.profileSettingsDefaults.dashboard.required',
        field: 'dashboard',
      );
    });

    test('returns the documented error for missing appearance', () {
      final result = ProfileSettingsDefaults.create(
        localization,
        dashboard,
        null,
      );

      _expectRequiredError(
        result.errors.single,
        code: 'PRO-VAL-PDEF-003',
        messageKey: 'validation.profileSettingsDefaults.appearance.required',
        field: 'appearance',
      );
    });

    test('reports missing values in the documented order', () {
      final result = ProfileSettingsDefaults.create(null, null, null);

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(
        result.errors.map((error) => error.code.value),
        <String>[
          'PRO-VAL-PDEF-001',
          'PRO-VAL-PDEF-002',
          'PRO-VAL-PDEF-003',
        ],
      );
      expect(
        result.errors.map((error) => error.field?.value),
        <String?>['localization', 'dashboard', 'appearance'],
      );
    });

    test('does not add a redundant incomplete-state error', () {
      final result = ProfileSettingsDefaults.create(null, null, null);

      expect(
        result.errors.any((error) => error.code.value == 'PRO-VAL-PDEF-004'),
        isFalse,
      );
    });

    test('does not duplicate errors owned by contained value objects', () {
      final invalidLocalization = LocalizationSettings.create(null, null);

      expect(invalidLocalization.errors, hasLength(2));
      final result = ProfileSettingsDefaults.create(
        invalidLocalization.value,
        dashboard,
        appearance,
      );

      expect(result.errors, hasLength(1));
      expect(result.errors.single.code.value, 'PRO-VAL-PDEF-001');
    });

    test('implements value equality and consistent hash codes', () {
      final first = ProfileSettingsDefaults.create(
        localization,
        dashboard,
        appearance,
      ).value!;
      final equal = ProfileSettingsDefaults.create(
        _localization(),
        _dashboard(),
        _appearance(),
      ).value!;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
    });

    test('is unequal when any settings area differs', () {
      final baseline = ProfileSettingsDefaults.create(
        localization,
        dashboard,
        appearance,
      ).value!;
      final otherLocalization = ProfileSettingsDefaults.create(
        LocalizationSettings.create(
          Language.en,
          MeasurementSystem.metric,
        ).value,
        dashboard,
        appearance,
      ).value!;
      final otherDashboard = ProfileSettingsDefaults.create(
        localization,
        DashboardSettings.create(
          DashboardLayout.compact,
          dashboard.visibleWidgets,
          dashboard.configurationVersion,
        ).value,
        appearance,
      ).value!;
      final otherAppearance = ProfileSettingsDefaults.create(
        localization,
        dashboard,
        AppearanceSettings.create(ThemePreference.light, null).value,
      ).value!;

      expect(baseline, isNot(otherLocalization));
      expect(baseline, isNot(otherDashboard));
      expect(baseline, isNot(otherAppearance));
    });

    test('is immutable and has a meaningful string representation', () {
      final defaults = ProfileSettingsDefaults.create(
        localization,
        dashboard,
        appearance,
      ).value!;

      expect(defaults.localization, localization);
      expect(defaults.dashboard, dashboard);
      expect(defaults.appearance, appearance);
      expect(defaults.toString(), startsWith('ProfileSettingsDefaults('));
      expect(defaults.toString(), contains('localization:'));
      expect(defaults.toString(), contains('dashboard:'));
      expect(defaults.toString(), contains('appearance:'));
    });

    test('returns validation failures without throwing exceptions', () {
      expect(
        () => ProfileSettingsDefaults.create(null, null, null),
        returnsNormally,
      );
      expect(
        ProfileSettingsDefaults.create(null, null, null).isFailure,
        isTrue,
      );
    });
  });
}

LocalizationSettings _localization() => LocalizationSettings.create(
      Language.de,
      MeasurementSystem.metric,
    ).value!;

DashboardSettings _dashboard() => DashboardSettings.create(
      DashboardLayout.standard,
      DashboardWidgetSelection.create(<String>['weight']).value,
      DashboardConfigurationVersion.create(1).value,
    ).value!;

AppearanceSettings _appearance() => AppearanceSettings.create(
      ThemePreference.system,
      TextScalePreference.system,
    ).value!;

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
