import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'appearance_settings.dart';
import 'dashboard_settings.dart';
import 'language.dart';
import 'localization_settings.dart';
import 'measurement_system.dart';
import 'profile_settings_defaults.dart';
import 'profile_settings_id.dart';

final class ProfileSettings {
  const ProfileSettings._({
    required this.settingsId,
    required this.localization,
    required this.dashboard,
    required this.appearance,
  });

  final ProfileSettingsId settingsId;
  final LocalizationSettings localization;
  final DashboardSettings dashboard;
  final AppearanceSettings appearance;

  static DomainResult<ProfileSettings> create(
    ProfileSettingsId? settingsId,
    LocalizationSettings? localization,
    DashboardSettings? dashboard,
    AppearanceSettings? appearance,
  ) {
    final errors = <DomainError>[
      if (settingsId == null)
        _requiredError(
          code: 'PRO-VAL-PSET-001',
          messageKey: 'validation.profileSettings.settingsId.required',
          field: 'settingsId',
        ),
      if (localization == null)
        _requiredError(
          code: 'PRO-VAL-PSET-003',
          messageKey: 'validation.profileSettings.localization.required',
          field: 'localization',
        ),
      if (dashboard == null)
        _requiredError(
          code: 'PRO-VAL-PSET-004',
          messageKey: 'validation.profileSettings.dashboard.required',
          field: 'dashboard',
        ),
      if (appearance == null)
        _requiredError(
          code: 'PRO-VAL-PSET-005',
          messageKey: 'validation.profileSettings.appearance.required',
          field: 'appearance',
        ),
    ];

    if (errors.isNotEmpty) {
      return DomainResult<ProfileSettings>.failure(errors);
    }

    return DomainResult<ProfileSettings>.success(
      ProfileSettings._(
        settingsId: settingsId!,
        localization: localization!,
        dashboard: dashboard!,
        appearance: appearance!,
      ),
    );
  }

  DomainResult<ProfileSettings> changeLanguage(Language newLanguage) {
    if (localization.language == newLanguage) {
      return _noChange('changeLanguage');
    }

    final newLocalization = LocalizationSettings.create(
      newLanguage,
      localization.measurementSystem,
    );
    if (newLocalization.isFailure) {
      return DomainResult<ProfileSettings>.failure(newLocalization.errors);
    }

    return DomainResult<ProfileSettings>.success(
      _copyWith(localization: newLocalization.value),
    );
  }

  DomainResult<ProfileSettings> changeMeasurementSystem(
    MeasurementSystem newMeasurementSystem,
  ) {
    if (localization.measurementSystem == newMeasurementSystem) {
      return _noChange('changeMeasurementSystem');
    }

    final newLocalization = LocalizationSettings.create(
      localization.language,
      newMeasurementSystem,
    );
    if (newLocalization.isFailure) {
      return DomainResult<ProfileSettings>.failure(newLocalization.errors);
    }

    return DomainResult<ProfileSettings>.success(
      _copyWith(localization: newLocalization.value),
    );
  }

  DomainResult<ProfileSettings> changeDashboardSettings(
    DashboardSettings newDashboardSettings,
  ) {
    if (dashboard == newDashboardSettings) {
      return _noChange('changeDashboardSettings');
    }

    return DomainResult<ProfileSettings>.success(
      _copyWith(dashboard: newDashboardSettings),
    );
  }

  DomainResult<ProfileSettings> changeAppearanceSettings(
    AppearanceSettings newAppearanceSettings,
  ) {
    if (appearance == newAppearanceSettings) {
      return _noChange('changeAppearanceSettings');
    }

    return DomainResult<ProfileSettings>.success(
      _copyWith(appearance: newAppearanceSettings),
    );
  }

  DomainResult<ProfileSettings> resetToDefaults(
    ProfileSettingsDefaults defaults,
  ) {
    if (localization == defaults.localization &&
        dashboard == defaults.dashboard &&
        appearance == defaults.appearance) {
      return _noChange('resetToDefaults');
    }

    return DomainResult<ProfileSettings>.success(
      ProfileSettings._(
        settingsId: settingsId,
        localization: defaults.localization,
        dashboard: defaults.dashboard,
        appearance: defaults.appearance,
      ),
    );
  }

  ProfileSettings _copyWith({
    LocalizationSettings? localization,
    DashboardSettings? dashboard,
    AppearanceSettings? appearance,
  }) =>
      ProfileSettings._(
        settingsId: settingsId,
        localization: localization ?? this.localization,
        dashboard: dashboard ?? this.dashboard,
        appearance: appearance ?? this.appearance,
      );

  DomainResult<ProfileSettings> _noChange(String operation) =>
      DomainResult<ProfileSettings>.success(
        this,
        information: <DomainInformation>[
          DomainInformation(
            code: ErrorCode.create('PRO-INF-PSET-001')!,
            messageKey: MessageKey.create(
              'information.profileSettings.noChange',
            )!,
            severity: MessageSeverity.information,
            category: MessageCategory.business,
            parameters: <String, Object>{'operation': operation},
          ),
        ],
      );

  static DomainError _requiredError({
    required String code,
    required String messageKey,
    required String field,
  }) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(messageKey)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: const {},
        field: FieldReference.create(field),
        constraint: ConstraintType.required,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileSettings && settingsId == other.settingsId;

  @override
  int get hashCode => settingsId.hashCode;

  @override
  String toString() => 'ProfileSettings('
      'settingsId: $settingsId, '
      'localization: $localization, '
      'dashboard: $dashboard, '
      'appearance: $appearance)';
}
