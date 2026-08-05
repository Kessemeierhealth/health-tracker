import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'language.dart';
import 'measurement_system.dart';

final class LocalizationSettings {
  const LocalizationSettings._({
    required this.language,
    required this.measurementSystem,
  });

  final Language language;
  final MeasurementSystem measurementSystem;

  static DomainResult<LocalizationSettings> create(
    Language? language,
    MeasurementSystem? measurementSystem,
  ) {
    final errors = <DomainError>[];
    if (language == null) {
      errors.add(
        _requiredError(
          code: 'PRO-VAL-LOC-001',
          messageKey: 'validation.localization.language.required',
          field: 'language',
        ),
      );
    }
    if (measurementSystem == null) {
      errors.add(
        _requiredError(
          code: 'PRO-VAL-LOC-003',
          messageKey: 'validation.localization.measurementSystem.required',
          field: 'measurementSystem',
        ),
      );
    }
    if (errors.isNotEmpty) {
      return DomainResult<LocalizationSettings>.failure(errors);
    }

    return DomainResult<LocalizationSettings>.success(
      LocalizationSettings._(
        language: language!,
        measurementSystem: measurementSystem!,
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
      other is LocalizationSettings &&
          language == other.language &&
          measurementSystem == other.measurementSystem;

  @override
  int get hashCode => Object.hash(language, measurementSystem);

  @override
  String toString() => 'LocalizationSettings('
      'language: $language, '
      'measurementSystem: $measurementSystem)';
}
