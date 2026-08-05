import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/domain_result.dart';
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
import 'package:healthtracker/domain/profile/profile_settings.dart';
import 'package:healthtracker/domain/profile/profile_settings_defaults.dart';
import 'package:healthtracker/domain/profile/profile_settings_id.dart';
import 'package:healthtracker/domain/profile/text_scale_preference.dart';
import 'package:healthtracker/domain/profile/theme_preference.dart';

void main() {
  group('ProfileSettings.create', () {
    test('creates a complete immutable entity through DomainResult', () {
      final fixture = _Fixture();

      final result = ProfileSettings.create(
        fixture.id,
        fixture.localization,
        fixture.dashboard,
        fixture.appearance,
      );

      expect(result, isA<DomainResult<ProfileSettings>>());
      expect(result.isSuccess, isTrue);
      expect(result.errors, isEmpty);
      expect(result.value!.settingsId, same(fixture.id));
      expect(result.value!.localization, same(fixture.localization));
      expect(result.value!.dashboard, same(fixture.dashboard));
      expect(result.value!.appearance, same(fixture.appearance));
    });

    test('returns the documented settingsId required error', () {
      final fixture = _Fixture();
      final result = ProfileSettings.create(
        null,
        fixture.localization,
        fixture.dashboard,
        fixture.appearance,
      );

      _expectRequiredError(
        result,
        code: 'PRO-VAL-PSET-001',
        messageKey: 'validation.profileSettings.settingsId.required',
        field: 'settingsId',
      );
    });

    test('returns the documented localization required error', () {
      final fixture = _Fixture();
      final result = ProfileSettings.create(
        fixture.id,
        null,
        fixture.dashboard,
        fixture.appearance,
      );

      _expectRequiredError(
        result,
        code: 'PRO-VAL-PSET-003',
        messageKey: 'validation.profileSettings.localization.required',
        field: 'localization',
      );
    });

    test('returns the documented dashboard required error', () {
      final fixture = _Fixture();
      final result = ProfileSettings.create(
        fixture.id,
        fixture.localization,
        null,
        fixture.appearance,
      );

      _expectRequiredError(
        result,
        code: 'PRO-VAL-PSET-004',
        messageKey: 'validation.profileSettings.dashboard.required',
        field: 'dashboard',
      );
    });

    test('returns the documented appearance required error', () {
      final fixture = _Fixture();
      final result = ProfileSettings.create(
        fixture.id,
        fixture.localization,
        fixture.dashboard,
        null,
      );

      _expectRequiredError(
        result,
        code: 'PRO-VAL-PSET-005',
        messageKey: 'validation.profileSettings.appearance.required',
        field: 'appearance',
      );
    });

    test('reports missing fields in order without redundant errors', () {
      final result = ProfileSettings.create(null, null, null, null);

      expect(result.isFailure, isTrue);
      expect(
        result.errors.map((error) => error.code.value),
        <String>[
          'PRO-VAL-PSET-001',
          'PRO-VAL-PSET-003',
          'PRO-VAL-PSET-004',
          'PRO-VAL-PSET-005',
        ],
      );
      expect(
        result.errors.map((error) => error.code.value),
        isNot(contains('PRO-VAL-PSET-006')),
      );
    });

    test('returns expected validation failures without exceptions', () {
      expect(
        () => ProfileSettings.create(null, null, null, null),
        returnsNormally,
      );
    });
  });

  group('ProfileSettings operations', () {
    test('changeLanguage replaces only language', () {
      final fixture = _Fixture();
      final original = fixture.settings;

      final result = original.changeLanguage(Language.en);

      expect(result.isSuccess, isTrue);
      expect(result.information, isEmpty);
      expect(result.value!.localization.language, Language.en);
      expect(
        result.value!.localization.measurementSystem,
        original.localization.measurementSystem,
      );
      _expectUnchangedAreas(result.value!, original, except: 'localization');
      expect(original.localization.language, Language.de);
    });

    test('changeLanguage returns documented no-change information', () {
      final original = _Fixture().settings;

      final result = original.changeLanguage(original.localization.language);

      _expectNoChange(result, original, 'changeLanguage');
    });

    test('changeMeasurementSystem replaces only measurement system', () {
      final fixture = _Fixture();
      final original = fixture.settings;

      final result = original.changeMeasurementSystem(
        MeasurementSystem.imperial,
      );

      expect(result.isSuccess, isTrue);
      expect(
          result.value!.localization.language, original.localization.language);
      expect(
        result.value!.localization.measurementSystem,
        MeasurementSystem.imperial,
      );
      _expectUnchangedAreas(result.value!, original, except: 'localization');
      expect(
        original.localization.measurementSystem,
        MeasurementSystem.metric,
      );
    });

    test('changeMeasurementSystem returns no-change information', () {
      final original = _Fixture().settings;

      final result = original.changeMeasurementSystem(
        original.localization.measurementSystem,
      );

      _expectNoChange(result, original, 'changeMeasurementSystem');
    });

    test('changeDashboardSettings fully replaces only dashboard', () {
      final fixture = _Fixture();
      final original = fixture.settings;
      final replacement = fixture.alternativeDashboard;

      final result = original.changeDashboardSettings(replacement);

      expect(result.isSuccess, isTrue);
      expect(result.value!.dashboard, same(replacement));
      _expectUnchangedAreas(result.value!, original, except: 'dashboard');
      expect(original.dashboard, same(fixture.dashboard));
    });

    test('changeDashboardSettings returns no-change information', () {
      final original = _Fixture().settings;

      final result = original.changeDashboardSettings(original.dashboard);

      _expectNoChange(result, original, 'changeDashboardSettings');
    });

    test('changeAppearanceSettings fully replaces only appearance', () {
      final fixture = _Fixture();
      final original = fixture.settings;
      final replacement = fixture.alternativeAppearance;

      final result = original.changeAppearanceSettings(replacement);

      expect(result.isSuccess, isTrue);
      expect(result.value!.appearance, same(replacement));
      _expectUnchangedAreas(result.value!, original, except: 'appearance');
      expect(original.appearance, same(fixture.appearance));
    });

    test('changeAppearanceSettings returns no-change information', () {
      final original = _Fixture().settings;

      final result = original.changeAppearanceSettings(original.appearance);

      _expectNoChange(result, original, 'changeAppearanceSettings');
    });

    test('resetToDefaults atomically replaces all settings areas', () {
      final fixture = _Fixture();
      final original = fixture.settings;
      final defaults = fixture.alternativeDefaults;

      final result = original.resetToDefaults(defaults);

      expect(result.isSuccess, isTrue);
      expect(result.value!.settingsId, same(original.settingsId));
      expect(result.value!.localization, same(defaults.localization));
      expect(result.value!.dashboard, same(defaults.dashboard));
      expect(result.value!.appearance, same(defaults.appearance));
      expect(original.localization, same(fixture.localization));
      expect(defaults.localization, same(fixture.alternativeLocalization));
    });

    test('resetToDefaults returns no-change information', () {
      final fixture = _Fixture();
      final original = fixture.settings;
      final defaults = ProfileSettingsDefaults.create(
        original.localization,
        original.dashboard,
        original.appearance,
      ).value!;

      final result = original.resetToDefaults(defaults);

      _expectNoChange(result, original, 'resetToDefaults');
    });
  });

  group('ProfileSettings entity semantics', () {
    test('uses settingsId identity equality and matching hash codes', () {
      final fixture = _Fixture();
      final original = fixture.settings;
      final changed = original.changeLanguage(Language.en).value!;

      expect(original, changed);
      expect(original.hashCode, changed.hashCode);
    });

    test('is unequal when settingsId differs', () {
      final first = _Fixture().settings;
      final secondFixture = _Fixture();
      final second = ProfileSettings.create(
        ProfileSettingsId.generate().value!,
        secondFixture.localization,
        secondFixture.dashboard,
        secondFixture.appearance,
      ).value!;

      expect(first, isNot(second));
    });

    test('is immutable and has a meaningful string representation', () {
      final settings = _Fixture().settings;

      expect(settings.toString(), contains('ProfileSettings('));
      expect(settings.toString(), contains(settings.settingsId.value));
      expect(settings.toString(), contains('localization:'));
      expect(settings.toString(), contains('dashboard:'));
      expect(settings.toString(), contains('appearance:'));
    });
  });
}

void _expectRequiredError(
  DomainResult<ProfileSettings> result, {
  required String code,
  required String messageKey,
  required String field,
}) {
  expect(result.isFailure, isTrue);
  expect(result.value, isNull);
  expect(result.errors, hasLength(1));
  final error = result.errors.single;
  expect(error.code.value, code);
  expect(error.messageKey.value, messageKey);
  expect(error.severity, MessageSeverity.error);
  expect(error.category, MessageCategory.validation);
  expect(error.field!.value, field);
  expect(error.constraint, ConstraintType.required);
  expect(error.parameters, isEmpty);
}

void _expectNoChange(
  DomainResult<ProfileSettings> result,
  ProfileSettings original,
  String operation,
) {
  expect(result.isSuccess, isTrue);
  expect(result.errors, isEmpty);
  expect(result.value, same(original));
  expect(result.information, hasLength(1));
  final information = result.information.single;
  expect(information.code.value, 'PRO-INF-PSET-001');
  expect(
    information.messageKey.value,
    'information.profileSettings.noChange',
  );
  expect(information.severity, MessageSeverity.information);
  expect(information.category, MessageCategory.business);
  expect(information.field, isNull);
  expect(information.constraint, isNull);
  expect(information.parameters, <String, Object>{'operation': operation});
}

void _expectUnchangedAreas(
  ProfileSettings changed,
  ProfileSettings original, {
  required String except,
}) {
  expect(changed.settingsId, same(original.settingsId));
  if (except != 'localization') {
    expect(changed.localization, same(original.localization));
  }
  if (except != 'dashboard') {
    expect(changed.dashboard, same(original.dashboard));
  }
  if (except != 'appearance') {
    expect(changed.appearance, same(original.appearance));
  }
}

final class _Fixture {
  _Fixture()
      : id = ProfileSettingsId.generate().value!,
        localization = LocalizationSettings.create(
          Language.de,
          MeasurementSystem.metric,
        ).value!,
        dashboard = _dashboard(DashboardLayout.standard, const <String>['a']),
        alternativeDashboard = _dashboard(
          DashboardLayout.compact,
          const <String>['b'],
        ),
        appearance = AppearanceSettings.create(
          ThemePreference.system,
          TextScalePreference.system,
        ).value!,
        alternativeAppearance = AppearanceSettings.create(
          ThemePreference.dark,
          TextScalePreference.large,
        ).value!,
        alternativeLocalization = LocalizationSettings.create(
          Language.en,
          MeasurementSystem.imperial,
        ).value! {
    settings = ProfileSettings.create(
      id,
      localization,
      dashboard,
      appearance,
    ).value!;
    alternativeDefaults = ProfileSettingsDefaults.create(
      alternativeLocalization,
      alternativeDashboard,
      alternativeAppearance,
    ).value!;
  }

  final ProfileSettingsId id;
  final LocalizationSettings localization;
  final DashboardSettings dashboard;
  final DashboardSettings alternativeDashboard;
  final AppearanceSettings appearance;
  final AppearanceSettings alternativeAppearance;
  final LocalizationSettings alternativeLocalization;
  late final ProfileSettings settings;
  late final ProfileSettingsDefaults alternativeDefaults;

  static DashboardSettings _dashboard(
    DashboardLayout layout,
    List<String> widgets,
  ) =>
      DashboardSettings.create(
        layout,
        DashboardWidgetSelection.create(widgets).value!,
        DashboardConfigurationVersion.create(1).value!,
      ).value!;
}
