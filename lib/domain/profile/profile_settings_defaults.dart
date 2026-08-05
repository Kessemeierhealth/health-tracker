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
import 'localization_settings.dart';

final class ProfileSettingsDefaults {
  const ProfileSettingsDefaults._({
    required this.localization,
    required this.dashboard,
    required this.appearance,
  });

  final LocalizationSettings localization;
  final DashboardSettings dashboard;
  final AppearanceSettings appearance;

  static DomainResult<ProfileSettingsDefaults> create(
    LocalizationSettings? localization,
    DashboardSettings? dashboard,
    AppearanceSettings? appearance,
  ) {
    final errors = <DomainError>[];
    if (localization == null) {
      errors.add(
        _requiredError(
          code: 'PRO-VAL-PDEF-001',
          messageKey:
              'validation.profileSettingsDefaults.localization.required',
          field: 'localization',
        ),
      );
    }
    if (dashboard == null) {
      errors.add(
        _requiredError(
          code: 'PRO-VAL-PDEF-002',
          messageKey: 'validation.profileSettingsDefaults.dashboard.required',
          field: 'dashboard',
        ),
      );
    }
    if (appearance == null) {
      errors.add(
        _requiredError(
          code: 'PRO-VAL-PDEF-003',
          messageKey: 'validation.profileSettingsDefaults.appearance.required',
          field: 'appearance',
        ),
      );
    }
    if (errors.isNotEmpty) {
      return DomainResult<ProfileSettingsDefaults>.failure(errors);
    }

    return DomainResult<ProfileSettingsDefaults>.success(
      ProfileSettingsDefaults._(
        localization: localization!,
        dashboard: dashboard!,
        appearance: appearance!,
      ),
    );
  }

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
      other is ProfileSettingsDefaults &&
          localization == other.localization &&
          dashboard == other.dashboard &&
          appearance == other.appearance;

  @override
  int get hashCode => Object.hash(localization, dashboard, appearance);

  @override
  String toString() => 'ProfileSettingsDefaults('
      'localization: $localization, '
      'dashboard: $dashboard, '
      'appearance: $appearance)';
}
