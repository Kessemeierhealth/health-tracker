import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class DashboardConfigurationVersion {
  const DashboardConfigurationVersion._(this.value);

  static const int _minimum = 1;

  final int value;

  static DomainResult<DashboardConfigurationVersion> create(int? value) {
    if (value == null) {
      return DomainResult<DashboardConfigurationVersion>.fromError(
        _error(
          code: 'PRO-VAL-DCV-001',
          messageKey: 'validation.dashboardConfigurationVersion.required',
          constraint: ConstraintType.required,
        ),
      );
    }
    if (value < _minimum) {
      return DomainResult<DashboardConfigurationVersion>.fromError(
        _error(
          code: 'PRO-VAL-DCV-002',
          messageKey: 'validation.dashboardConfigurationVersion.minimum',
          constraint: ConstraintType.minimum,
          parameters: <String, Object>{
            'minimum': _minimum,
            'actual': value,
          },
        ),
      );
    }
    return DomainResult<DashboardConfigurationVersion>.success(
      DashboardConfigurationVersion._(value),
    );
  }

  static DomainError _error({
    required String code,
    required String messageKey,
    required ConstraintType constraint,
    Map<String, Object> parameters = const {},
  }) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(messageKey)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: parameters,
        field: FieldReference.create('value'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardConfigurationVersion && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'DashboardConfigurationVersion($value)';
}
