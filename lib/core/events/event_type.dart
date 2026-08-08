import '../errors/constraint_type.dart';
import '../errors/domain_message.dart';
import '../errors/domain_result.dart';
import '../errors/error_code.dart';
import '../errors/field_reference.dart';
import '../errors/message_category.dart';
import '../errors/message_key.dart';
import '../errors/message_severity.dart';

final class EventType {
  const EventType._(this.value);

  static const List<String> allowedValues = <String>[
    'ProfileCreated',
    'ProfileNameChanged',
    'ProfileBirthYearChanged',
    'ProfileHeightChanged',
    'ProfileGenderChanged',
    'ProfileColorChanged',
    'ProfileActivated',
    'ProfileDeactivated',
    'ProfileArchived',
    'ProfileRestored',
    'ProfileMarkedAsDefault',
    'ProfileDefaultRemoved',
    'ProfileLanguageChanged',
    'ProfileMeasurementSystemChanged',
    'ProfileDashboardSettingsChanged',
    'ProfileAppearanceSettingsChanged',
    'ProfilePasswordProtectionEnabled',
    'ProfilePasswordProtectionDisabled',
    'ProfilePasswordChanged',
    'ProfileLocked',
    'ProfileUnlocked',
    'ProfileImageReplaced',
    'ProfileImageRemoved',
    'ProfileDeleted',
    'ProfileUpdated',
  ];

  final String value;

  static DomainResult<EventType> fromString(String? value) {
    if (value == null) {
      return DomainResult<EventType>.fromError(_error(
        code: 'PRO-VAL-EVTYPE-001',
        key: 'validation.eventType.required',
        constraint: ConstraintType.required,
      ));
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<EventType>.fromError(_error(
        code: 'PRO-VAL-EVTYPE-002',
        key: 'validation.eventType.blank',
        constraint: ConstraintType.blank,
      ));
    }
    if (!allowedValues.contains(normalized)) {
      return DomainResult<EventType>.fromError(_error(
        code: 'PRO-VAL-EVTYPE-003',
        key: 'validation.eventType.invalid',
        constraint: ConstraintType.enumeration,
        parameters: const <String, Object>{'allowedValues': allowedValues},
      ));
    }
    return DomainResult<EventType>.success(EventType._(normalized));
  }

  static DomainError _error(
          {required String code,
          required String key,
          required ConstraintType constraint,
          Map<String, Object> parameters = const {}}) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(key)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: parameters,
        field: FieldReference.create('value'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is EventType && value == other.value;
  @override
  int get hashCode => value.hashCode;
  @override
  String toString() => value;
}
