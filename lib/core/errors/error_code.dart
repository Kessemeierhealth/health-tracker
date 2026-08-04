final class ErrorCode {
  const ErrorCode._(this.value);

  final String value;

  static ErrorCode? create(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    return ErrorCode._(value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ErrorCode && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ErrorCode($value)';
}
