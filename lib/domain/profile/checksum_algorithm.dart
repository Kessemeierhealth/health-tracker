import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

enum ChecksumAlgorithm {
  sha256;

  static const List<String> allowedValues = <String>['sha256'];

  static DomainResult<ChecksumAlgorithm> fromString(String? value) {
    if (value == null) {
      return DomainResult<ChecksumAlgorithm>.fromError(
        _error(
          code: 'PRO-VAL-CHKALG-001',
          messageKey: 'validation.checksumAlgorithm.required',
          constraint: ConstraintType.required,
        ),
      );
    }

    final normalized = value.trim();
    if (normalized.isEmpty) {
      return DomainResult<ChecksumAlgorithm>.fromError(
        _error(
          code: 'PRO-VAL-CHKALG-002',
          messageKey: 'validation.checksumAlgorithm.blank',
          constraint: ConstraintType.blank,
        ),
      );
    }

    if (normalized != sha256.name) {
      return DomainResult<ChecksumAlgorithm>.fromError(
        _error(
          code: 'PRO-VAL-CHKALG-003',
          messageKey: 'validation.checksumAlgorithm.invalid',
          constraint: ConstraintType.enumeration,
          parameters: const <String, Object>{
            'allowedValues': allowedValues,
          },
        ),
      );
    }

    return DomainResult<ChecksumAlgorithm>.success(sha256);
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
  String toString() => name;
}
