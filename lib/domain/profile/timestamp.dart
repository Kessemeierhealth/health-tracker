import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';

final class Timestamp implements Comparable<Timestamp> {
  const Timestamp._(this.value);

  final DateTime value;

  static DomainResult<Timestamp> fromUtc(DateTime? value) {
    if (value == null) {
      return DomainResult<Timestamp>.fromError(_requiredError());
    }
    if (!value.isUtc) {
      return DomainResult<Timestamp>.fromError(_notUtcError());
    }
    return DomainResult<Timestamp>.success(Timestamp._(value));
  }

  static DomainResult<Timestamp> parseIso8601(String? value) {
    if (value == null) {
      return DomainResult<Timestamp>.fromError(_requiredError());
    }

    final normalizedValue = value.trim();
    if (normalizedValue.isEmpty) {
      return DomainResult<Timestamp>.fromError(
        _error(
          code: 'PRO-VAL-TS-004',
          messageKey: 'validation.timestamp.blank',
          constraint: ConstraintType.blank,
        ),
      );
    }

    final parsed = DateTime.tryParse(normalizedValue);
    if (parsed == null || !_hasValidComponents(normalizedValue, parsed)) {
      return DomainResult<Timestamp>.fromError(
        _error(
          code: 'PRO-VAL-TS-003',
          messageKey: 'validation.timestamp.invalidFormat',
          constraint: ConstraintType.format,
          parameters: const <String, Object>{
            'expectedFormat': 'ISO-8601 UTC',
          },
        ),
      );
    }

    if (!normalizedValue.endsWith('Z')) {
      return DomainResult<Timestamp>.fromError(_notUtcError());
    }

    return DomainResult<Timestamp>.success(Timestamp._(parsed));
  }

  static bool _hasValidComponents(String source, DateTime parsed) {
    final match = RegExp(
      r'^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(?:\.\d+)?(?:Z|[+-]\d{2}:?\d{2})?$',
    ).firstMatch(source);
    if (match == null) return false;
    if (!source.endsWith('Z')) return true;
    return parsed.year == int.parse(match.group(1)!) &&
        parsed.month == int.parse(match.group(2)!) &&
        parsed.day == int.parse(match.group(3)!) &&
        parsed.hour == int.parse(match.group(4)!) &&
        parsed.minute == int.parse(match.group(5)!) &&
        parsed.second == int.parse(match.group(6)!);
  }

  static DomainError _requiredError() => _error(
        code: 'PRO-VAL-TS-001',
        messageKey: 'validation.timestamp.required',
        constraint: ConstraintType.required,
      );

  static DomainError _notUtcError() => _error(
        code: 'PRO-VAL-TS-002',
        messageKey: 'validation.timestamp.notUtc',
        constraint: ConstraintType.utc,
        parameters: const <String, Object>{'expectedTimezone': 'UTC'},
      );

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

  bool isBefore(Timestamp other) => value.isBefore(other.value);
  bool isAfter(Timestamp other) => value.isAfter(other.value);
  bool isEqualTo(Timestamp other) => value.isAtSameMomentAs(other.value);

  @override
  int compareTo(Timestamp other) => value.compareTo(other.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Timestamp && value.isAtSameMomentAs(other.value);

  @override
  int get hashCode => value.microsecondsSinceEpoch.hashCode;

  @override
  String toString() => value.toIso8601String();
}
