import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class BirthYear {
  const BirthYear._(this.value);

  static const int minimum = 1900;

  final int value;

  static DomainResult<BirthYear> create(int? value, int currentYear) {
    if (value == null) {
      return DomainResult<BirthYear>.fromError(
        _error(
          code: 'PRO-VAL-BIRTHYEAR-001',
          messageKey: 'validation.profile.birthYear.required',
          constraint: ConstraintType.required,
        ),
      );
    }
    if (value < 1000 || value > 9999) {
      return DomainResult<BirthYear>.fromError(
        _error(
          code: 'PRO-VAL-BIRTHYEAR-002',
          messageKey: 'validation.profile.birthYear.format',
          constraint: ConstraintType.format,
          parameters: const <String, Object>{'expectedFormat': 'YYYY'},
        ),
      );
    }
    if (value < minimum) {
      return DomainResult<BirthYear>.fromError(
        _error(
          code: 'PRO-VAL-BIRTHYEAR-003',
          messageKey: 'validation.profile.birthYear.minimum',
          constraint: ConstraintType.minimum,
          parameters: const <String, Object>{'minimum': minimum},
        ),
      );
    }
    if (value > currentYear) {
      return DomainResult<BirthYear>.fromError(
        _error(
          code: 'PRO-VAL-BIRTHYEAR-004',
          messageKey: 'validation.profile.birthYear.future',
          constraint: ConstraintType.maximum,
          parameters: <String, Object>{'maximum': currentYear},
        ),
      );
    }
    return DomainResult<BirthYear>.success(BirthYear._(value));
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
        field: FieldReference.create('birthYear'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BirthYear && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'BirthYear($value)';
}
