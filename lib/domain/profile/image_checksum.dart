import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'checksum_algorithm.dart';

final class ImageChecksum {
  const ImageChecksum._({required this.algorithm, required this.value});

  static const String sha256Pattern = r'^[a-f0-9]{64}$';
  static const int sha256Length = 64;
  static final RegExp _sha256Pattern = RegExp(sha256Pattern);

  final ChecksumAlgorithm algorithm;
  final String value;

  static DomainResult<ImageChecksum> create(
    ChecksumAlgorithm? algorithm,
    String? value,
  ) {
    final errors = <DomainError>[];

    if (algorithm == null) {
      errors.add(_error(
        code: 'PRO-VAL-IMGCHK-001',
        messageKey: 'validation.imageChecksum.algorithm.required',
        field: 'algorithm',
        constraint: ConstraintType.required,
      ));
    }
    if (value == null) {
      errors.add(_error(
        code: 'PRO-VAL-IMGCHK-002',
        messageKey: 'validation.imageChecksum.value.required',
        field: 'value',
        constraint: ConstraintType.required,
      ));
    }

    final normalized = value?.trim();
    if (value != null && normalized!.isEmpty) {
      errors.add(_error(
        code: 'PRO-VAL-IMGCHK-003',
        messageKey: 'validation.imageChecksum.value.blank',
        field: 'value',
        constraint: ConstraintType.blank,
      ));
    }
    if (algorithm != null &&
        normalized != null &&
        normalized.isNotEmpty &&
        !_matchesFormat(algorithm, normalized)) {
      errors.add(_error(
        code: 'PRO-VAL-IMGCHK-004',
        messageKey: 'validation.imageChecksum.value.invalidFormat',
        field: 'value',
        constraint: ConstraintType.format,
        parameters: <String, Object>{
          'algorithm': algorithm.toString(),
          'expectedPattern': sha256Pattern,
          'expectedLength': sha256Length,
        },
      ));
    }

    if (errors.isNotEmpty) {
      return DomainResult<ImageChecksum>.failure(errors);
    }
    return DomainResult<ImageChecksum>.success(
      ImageChecksum._(algorithm: algorithm!, value: normalized!),
    );
  }

  static bool _matchesFormat(ChecksumAlgorithm algorithm, String value) {
    switch (algorithm) {
      case ChecksumAlgorithm.sha256:
        return _sha256Pattern.hasMatch(value);
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
      other is ImageChecksum &&
          algorithm == other.algorithm &&
          value == other.value;

  @override
  int get hashCode => Object.hash(algorithm, value);

  @override
  String toString() =>
      'ImageChecksum(\n  algorithm: $algorithm,\n  value: <redacted>\n)';
}
