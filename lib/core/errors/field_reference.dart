final class FieldReference {
  const FieldReference._(this.value);

  final String value;

  static FieldReference? create(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    return FieldReference._(value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FieldReference && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'FieldReference($value)';
}
