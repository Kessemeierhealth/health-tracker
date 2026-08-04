final class MessageKey {
  const MessageKey._(this.value);

  final String value;

  static MessageKey? create(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    return MessageKey._(value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MessageKey && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'MessageKey($value)';
}
