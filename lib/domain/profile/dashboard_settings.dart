import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'dashboard_configuration_version.dart';
import 'dashboard_layout.dart';
import 'dashboard_widget_selection.dart';

final class DashboardSettings {
  const DashboardSettings._({
    required this.layout,
    required this.visibleWidgets,
    required this.configurationVersion,
  });

  final DashboardLayout layout;
  final DashboardWidgetSelection visibleWidgets;
  final DashboardConfigurationVersion configurationVersion;

  static DomainResult<DashboardSettings> create(
    DashboardLayout? layout,
    DashboardWidgetSelection? visibleWidgets,
    DashboardConfigurationVersion? configurationVersion,
  ) {
    final errors = <DomainError>[];
    if (layout == null) {
      errors.add(
        _requiredError(
          code: 'PRO-VAL-DSET-001',
          messageKey: 'validation.dashboardSettings.layout.required',
          field: 'layout',
        ),
      );
    }
    if (visibleWidgets == null) {
      errors.add(
        _requiredError(
          code: 'PRO-VAL-DSET-003',
          messageKey: 'validation.dashboardSettings.visibleWidgets.required',
          field: 'visibleWidgets',
        ),
      );
    }
    if (configurationVersion == null) {
      errors.add(
        _requiredError(
          code: 'PRO-VAL-DSET-004',
          messageKey:
              'validation.dashboardSettings.configurationVersion.required',
          field: 'configurationVersion',
        ),
      );
    }
    if (errors.isNotEmpty) {
      return DomainResult<DashboardSettings>.failure(errors);
    }

    return DomainResult<DashboardSettings>.success(
      DashboardSettings._(
        layout: layout!,
        visibleWidgets: visibleWidgets!,
        configurationVersion: configurationVersion!,
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
      other is DashboardSettings &&
          layout == other.layout &&
          visibleWidgets == other.visibleWidgets &&
          configurationVersion == other.configurationVersion;

  @override
  int get hashCode => Object.hash(
        layout,
        visibleWidgets,
        configurationVersion,
      );

  @override
  String toString() => 'DashboardSettings('
      'layout: $layout, '
      'visibleWidgets: $visibleWidgets, '
      'configurationVersion: $configurationVersion)';
}
