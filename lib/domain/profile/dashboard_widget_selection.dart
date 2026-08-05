import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class DashboardWidgetSelection {
  DashboardWidgetSelection._(List<String> widgetKeys)
      : widgetKeys = List<String>.unmodifiable(widgetKeys);

  final List<String> widgetKeys;

  static DomainResult<DashboardWidgetSelection> create(
    List<String>? widgetKeys,
  ) {
    if (widgetKeys == null) {
      return DomainResult<DashboardWidgetSelection>.fromError(
        _error(
          code: 'PRO-VAL-DWSEL-001',
          messageKey: 'validation.dashboardWidgetSelection.widgetKeys.required',
          constraint: ConstraintType.required,
        ),
      );
    }

    final normalized = <String>[];
    final errors = <DomainError>[];
    final firstIndices = <String, int>{};

    for (var index = 0; index < widgetKeys.length; index++) {
      final widgetKey = widgetKeys[index].trim();
      normalized.add(widgetKey);

      if (widgetKey.isEmpty) {
        errors.add(
          _error(
            code: 'PRO-VAL-DWSEL-002',
            messageKey: 'validation.dashboardWidgetSelection.widgetKey.blank',
            constraint: ConstraintType.blank,
            parameters: <String, Object>{'index': index},
          ),
        );
        continue;
      }

      final firstIndex = firstIndices[widgetKey];
      if (firstIndex == null) {
        firstIndices[widgetKey] = index;
      } else {
        errors.add(
          _error(
            code: 'PRO-VAL-DWSEL-003',
            messageKey:
                'validation.dashboardWidgetSelection.widgetKey.duplicate',
            constraint: ConstraintType.duplicate,
            parameters: <String, Object>{
              'widgetKey': widgetKey,
              'firstIndex': firstIndex,
              'duplicateIndex': index,
            },
          ),
        );
      }
    }

    if (errors.isNotEmpty) {
      return DomainResult<DashboardWidgetSelection>.failure(errors);
    }

    return DomainResult<DashboardWidgetSelection>.success(
      DashboardWidgetSelection._(normalized),
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
        field: FieldReference.create('widgetKeys'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DashboardWidgetSelection ||
        widgetKeys.length != other.widgetKeys.length) {
      return false;
    }
    for (var index = 0; index < widgetKeys.length; index++) {
      if (widgetKeys[index] != other.widgetKeys[index]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hashAll(widgetKeys);

  @override
  String toString() => 'DashboardWidgetSelection($widgetKeys)';
}
