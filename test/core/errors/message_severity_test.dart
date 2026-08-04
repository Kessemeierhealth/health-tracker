import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/message_severity.dart';

void main() {
  test('contains exactly the documented severity values', () {
    expect(
      MessageSeverity.values,
      <MessageSeverity>[
        MessageSeverity.information,
        MessageSeverity.warning,
        MessageSeverity.error,
        MessageSeverity.critical,
      ],
    );
    expect(MessageSeverity.error.toString(), 'MessageSeverity.error');
  });
}
