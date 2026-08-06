import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

enum Gender {
  male,
  female,
  diverse,
  unspecified;

  static DomainResult<Gender> fromString(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return DomainResult<Gender>.success(unspecified);
    }

    for (final gender in values) {
      if (gender.name == normalized) {
        return DomainResult<Gender>.success(gender);
      }
    }

    return DomainResult<Gender>.fromError(
      DomainError(
        code: ErrorCode.create('PRO-VAL-GENDER-001')!,
        messageKey: MessageKey.create('validation.profile.gender.invalid')!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: const <String, Object>{
          'allowedValues': <String>[
            'male',
            'female',
            'diverse',
            'unspecified',
          ],
        },
        field: FieldReference.create('value'),
        constraint: ConstraintType.enumeration,
      ),
    );
  }

  @override
  String toString() => name;
}
