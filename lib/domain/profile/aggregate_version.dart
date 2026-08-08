import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class AggregateVersion {
  const AggregateVersion._(this.value);

  static const int initialValue = 0;
  static const int maximumValue = 9223372036854775807;

  final int value;

  static DomainResult<AggregateVersion> createInitial() =>
      DomainResult<AggregateVersion>.success(
        const AggregateVersion._(initialValue),
      );

  static DomainResult<AggregateVersion> fromValue(int? value) {
    if (value == null) {
      return DomainResult<AggregateVersion>.fromError(
        _error(
          code: 'PRO-VAL-AGGVER-001',
          messageKey: 'validation.aggregateVersion.required',
          constraint: ConstraintType.required,
        ),
      );
    }
    if (value < initialValue) {
      return DomainResult<AggregateVersion>.fromError(
        _error(
          code: 'PRO-VAL-AGGVER-002',
          messageKey: 'validation.aggregateVersion.minimum',
          constraint: ConstraintType.minimum,
          parameters: const <String, Object>{'minimum': initialValue},
        ),
      );
    }
    if (value > maximumValue) {
      return DomainResult<AggregateVersion>.fromError(
        _error(
          code: 'PRO-VAL-AGGVER-003',
          messageKey: 'validation.aggregateVersion.maximum',
          constraint: ConstraintType.maximum,
          parameters: const <String, Object>{'maximum': maximumValue},
        ),
      );
    }
    return DomainResult<AggregateVersion>.success(AggregateVersion._(value));
  }

  DomainResult<AggregateVersion> next() {
    if (value == maximumValue) {
      return DomainResult<AggregateVersion>.fromError(
        _error(
          code: 'PRO-VAL-AGGVER-004',
          messageKey: 'validation.aggregateVersion.overflow',
          constraint: ConstraintType.overflow,
          parameters: const <String, Object>{'maximum': maximumValue},
        ),
      );
    }
    return DomainResult<AggregateVersion>.success(
      AggregateVersion._(value + 1),
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
      other is AggregateVersion && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}
