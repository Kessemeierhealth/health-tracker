import 'constraint_type.dart';
import 'error_code.dart';
import 'field_reference.dart';
import 'message_category.dart';
import 'message_key.dart';
import 'message_severity.dart';

sealed class DomainMessage {
  DomainMessage._({
    required this.code,
    required this.messageKey,
    required this.severity,
    required this.category,
    required Map<String, Object> parameters,
    this.field,
    this.constraint,
  }) : parameters = _freezeParameters(parameters);

  final ErrorCode code;
  final MessageKey messageKey;
  final MessageSeverity severity;
  final MessageCategory category;
  final Map<String, Object> parameters;
  final FieldReference? field;
  final ConstraintType? constraint;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other.runtimeType == runtimeType &&
          other is DomainMessage &&
          code == other.code &&
          messageKey == other.messageKey &&
          severity == other.severity &&
          category == other.category &&
          _deepEquals(parameters, other.parameters) &&
          field == other.field &&
          constraint == other.constraint;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        code,
        messageKey,
        severity,
        category,
        _deepHash(parameters),
        field,
        constraint,
      );

  @override
  String toString() => '$runtimeType('
      'code: $code, '
      'messageKey: $messageKey, '
      'severity: $severity, '
      'category: $category, '
      'parameters: $parameters, '
      'field: $field, '
      'constraint: $constraint)';
}

final class DomainError extends DomainMessage {
  DomainError({
    required super.code,
    required super.messageKey,
    required super.severity,
    required super.category,
    required super.parameters,
    super.field,
    super.constraint,
  }) : super._() {
    if (severity != MessageSeverity.error &&
        severity != MessageSeverity.critical) {
      throw ArgumentError.value(severity, 'severity');
    }
  }
}

final class DomainWarning extends DomainMessage {
  DomainWarning({
    required super.code,
    required super.messageKey,
    required super.severity,
    required super.category,
    required super.parameters,
    super.field,
    super.constraint,
  }) : super._() {
    if (severity != MessageSeverity.warning) {
      throw ArgumentError.value(severity, 'severity');
    }
  }
}

final class DomainInformation extends DomainMessage {
  DomainInformation({
    required super.code,
    required super.messageKey,
    required super.severity,
    required super.category,
    required super.parameters,
    super.field,
    super.constraint,
  }) : super._() {
    if (severity != MessageSeverity.information) {
      throw ArgumentError.value(severity, 'severity');
    }
  }
}

Map<String, Object> _freezeParameters(Map<String, Object> source) =>
    Map<String, Object>.unmodifiable(
      source.map(
        (key, value) => MapEntry(key, _freezeValue(value)),
      ),
    );

Object _freezeValue(Object value) {
  if (value is Map<String, Object>) {
    return _freezeParameters(value);
  }
  if (value is List<Object>) {
    return List<Object>.unmodifiable(value.map(_freezeValue));
  }
  return value;
}

bool _deepEquals(Object? left, Object? right) {
  if (identical(left, right)) return true;
  if (left is Map && right is Map) {
    if (left.length != right.length) return false;
    for (final key in left.keys) {
      if (!right.containsKey(key) || !_deepEquals(left[key], right[key])) {
        return false;
      }
    }
    return true;
  }
  if (left is List && right is List) {
    if (left.length != right.length) return false;
    for (var index = 0; index < left.length; index++) {
      if (!_deepEquals(left[index], right[index])) return false;
    }
    return true;
  }
  return left == right;
}

int _deepHash(Object? value) {
  if (value is Map) {
    return Object.hashAllUnordered(
      value.entries
          .map((entry) => Object.hash(entry.key, _deepHash(entry.value))),
    );
  }
  if (value is List) {
    return Object.hashAll(value.map(_deepHash));
  }
  return value.hashCode;
}
