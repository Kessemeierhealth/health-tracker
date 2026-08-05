import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class PasswordHashParameters {
  const PasswordHashParameters._({
    required this.memoryCostKiB,
    required this.iterations,
    required this.parallelism,
    required this.salt,
  });

  static const int _minimum = 1;

  final int memoryCostKiB;
  final int iterations;
  final int parallelism;
  final String salt;

  static DomainResult<PasswordHashParameters> create(
    int? memoryCostKiB,
    int? iterations,
    int? parallelism,
    String? salt,
  ) =>
      _build(memoryCostKiB, iterations, parallelism, salt);

  static DomainResult<PasswordHashParameters> fromPersistedValues(
    int? memoryCostKiB,
    int? iterations,
    int? parallelism,
    String? salt,
  ) =>
      _build(memoryCostKiB, iterations, parallelism, salt);

  static DomainResult<PasswordHashParameters> _build(
    int? memoryCostKiB,
    int? iterations,
    int? parallelism,
    String? salt,
  ) {
    final errors = <DomainError>[];
    _validateNumber(
      errors,
      value: memoryCostKiB,
      field: 'memoryCostKiB',
      requiredCode: 'PRO-VAL-PHPAR-001',
      requiredMessageKey:
          'validation.passwordHashParameters.memoryCostKiB.required',
      minimumCode: 'PRO-VAL-PHPAR-002',
      minimumMessageKey:
          'validation.passwordHashParameters.memoryCostKiB.minimum',
    );
    _validateNumber(
      errors,
      value: iterations,
      field: 'iterations',
      requiredCode: 'PRO-VAL-PHPAR-003',
      requiredMessageKey:
          'validation.passwordHashParameters.iterations.required',
      minimumCode: 'PRO-VAL-PHPAR-004',
      minimumMessageKey: 'validation.passwordHashParameters.iterations.minimum',
    );
    _validateNumber(
      errors,
      value: parallelism,
      field: 'parallelism',
      requiredCode: 'PRO-VAL-PHPAR-005',
      requiredMessageKey:
          'validation.passwordHashParameters.parallelism.required',
      minimumCode: 'PRO-VAL-PHPAR-006',
      minimumMessageKey:
          'validation.passwordHashParameters.parallelism.minimum',
    );

    final normalizedSalt = salt?.trim();
    if (salt == null) {
      errors.add(
        _error(
          code: 'PRO-VAL-PHPAR-007',
          messageKey: 'validation.passwordHashParameters.salt.required',
          field: 'salt',
          constraint: ConstraintType.required,
        ),
      );
    } else if (normalizedSalt!.isEmpty) {
      errors.add(
        _error(
          code: 'PRO-VAL-PHPAR-008',
          messageKey: 'validation.passwordHashParameters.salt.blank',
          field: 'salt',
          constraint: ConstraintType.blank,
        ),
      );
    }

    if (errors.isNotEmpty) {
      return DomainResult<PasswordHashParameters>.failure(errors);
    }

    return DomainResult<PasswordHashParameters>.success(
      PasswordHashParameters._(
        memoryCostKiB: memoryCostKiB!,
        iterations: iterations!,
        parallelism: parallelism!,
        salt: normalizedSalt!,
      ),
    );
  }

  static void _validateNumber(
    List<DomainError> errors, {
    required int? value,
    required String field,
    required String requiredCode,
    required String requiredMessageKey,
    required String minimumCode,
    required String minimumMessageKey,
  }) {
    if (value == null) {
      errors.add(
        _error(
          code: requiredCode,
          messageKey: requiredMessageKey,
          field: field,
          constraint: ConstraintType.required,
        ),
      );
    } else if (value < _minimum) {
      errors.add(
        _error(
          code: minimumCode,
          messageKey: minimumMessageKey,
          field: field,
          constraint: ConstraintType.minimum,
          parameters: <String, Object>{
            'minimum': _minimum,
            'actual': value,
          },
        ),
      );
    }
  }

  static DomainError _error({
    required String code,
    required String messageKey,
    required String field,
    required ConstraintType constraint,
    Map<String, Object> parameters = const {},
  }) =>
      DomainError(
        code: ErrorCode.create(code)!,
        messageKey: MessageKey.create(messageKey)!,
        severity: MessageSeverity.error,
        category: MessageCategory.validation,
        parameters: parameters,
        field: FieldReference.create(field),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordHashParameters &&
          memoryCostKiB == other.memoryCostKiB &&
          iterations == other.iterations &&
          parallelism == other.parallelism &&
          salt == other.salt;

  @override
  int get hashCode => Object.hash(
        memoryCostKiB,
        iterations,
        parallelism,
        salt,
      );

  @override
  String toString() => 'PasswordHashParameters('
      'memoryCostKiB: $memoryCostKiB, '
      'iterations: $iterations, '
      'parallelism: $parallelism, '
      'salt: <redacted>)';
}
