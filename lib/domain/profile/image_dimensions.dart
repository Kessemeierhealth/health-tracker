import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class ImageDimensions {
  const ImageDimensions._({required this.width, required this.height});

  static const int minimumValue = 1;
  static const int maximumValue = 4096;

  final int width;
  final int height;

  static DomainResult<ImageDimensions> create(int? width, int? height) {
    final errors = <DomainError>[];

    if (width == null) {
      errors.add(_error(
        code: 'PRO-VAL-IMGDIM-001',
        messageKey: 'validation.imageDimensions.width.required',
        field: 'width',
        constraint: ConstraintType.required,
      ));
    }
    if (height == null) {
      errors.add(_error(
        code: 'PRO-VAL-IMGDIM-002',
        messageKey: 'validation.imageDimensions.height.required',
        field: 'height',
        constraint: ConstraintType.required,
      ));
    }
    if (width != null && width < minimumValue) {
      errors.add(_error(
        code: 'PRO-VAL-IMGDIM-003',
        messageKey: 'validation.imageDimensions.width.minimum',
        field: 'width',
        constraint: ConstraintType.minimum,
        parameters: const <String, Object>{
          'minimum': minimumValue,
          'unit': 'pixels',
        },
      ));
    }
    if (height != null && height < minimumValue) {
      errors.add(_error(
        code: 'PRO-VAL-IMGDIM-004',
        messageKey: 'validation.imageDimensions.height.minimum',
        field: 'height',
        constraint: ConstraintType.minimum,
        parameters: const <String, Object>{
          'minimum': minimumValue,
          'unit': 'pixels',
        },
      ));
    }
    if (width != null && width > maximumValue) {
      errors.add(_error(
        code: 'PRO-VAL-IMGDIM-005',
        messageKey: 'validation.imageDimensions.width.maximum',
        field: 'width',
        constraint: ConstraintType.maximum,
        parameters: const <String, Object>{
          'maximum': maximumValue,
          'unit': 'pixels',
        },
      ));
    }
    if (height != null && height > maximumValue) {
      errors.add(_error(
        code: 'PRO-VAL-IMGDIM-006',
        messageKey: 'validation.imageDimensions.height.maximum',
        field: 'height',
        constraint: ConstraintType.maximum,
        parameters: const <String, Object>{
          'maximum': maximumValue,
          'unit': 'pixels',
        },
      ));
    }

    if (errors.isNotEmpty) {
      return DomainResult<ImageDimensions>.failure(errors);
    }
    return DomainResult<ImageDimensions>.success(
      ImageDimensions._(width: width!, height: height!),
    );
  }

  double aspectRatio() => width / height;

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
      other is ImageDimensions &&
          width == other.width &&
          height == other.height;

  @override
  int get hashCode => Object.hash(width, height);

  @override
  String toString() =>
      'ImageDimensions(\n  width: $width,\n  height: $height\n)';
}
