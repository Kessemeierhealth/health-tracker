import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class Height {
  const Height._(this._centimeters);

  static const int minimumCentimeters = 20;
  static const int maximumCentimeters = 300;

  final int _centimeters;

  static DomainResult<Height> fromCentimeters(int? value) {
    if (value == null) {
      return DomainResult<Height>.fromError(
        _error(
          code: 'PRO-VAL-HEIGHT-001',
          messageKey: 'validation.profile.height.required',
          constraint: ConstraintType.required,
        ),
      );
    }
    if (value > maximumCentimeters) {
      return DomainResult<Height>.fromError(
        _error(
          code: 'PRO-VAL-HEIGHT-002',
          messageKey: 'validation.profile.height.maximum',
          constraint: ConstraintType.maximum,
          parameters: const <String, Object>{
            'maximum': maximumCentimeters,
            'unit': 'cm',
          },
        ),
      );
    }
    if (value < minimumCentimeters) {
      return DomainResult<Height>.fromError(
        _error(
          code: 'PRO-VAL-HEIGHT-003',
          messageKey: 'validation.profile.height.minimum',
          constraint: ConstraintType.minimum,
          parameters: const <String, Object>{
            'minimum': minimumCentimeters,
            'unit': 'cm',
          },
        ),
      );
    }
    return DomainResult<Height>.success(Height._(value));
  }

  int inCentimeters() => _centimeters;

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
        field: FieldReference.create('height'),
        constraint: constraint,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Height && _centimeters == other._centimeters;

  @override
  int get hashCode => _centimeters.hashCode;

  @override
  String toString() => 'Height(${_centimeters}cm)';
}
