import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/message_category.dart';

void main() {
  test('contains exactly the documented category values', () {
    expect(
      MessageCategory.values,
      <MessageCategory>[
        MessageCategory.validation,
        MessageCategory.business,
        MessageCategory.security,
        MessageCategory.persistence,
        MessageCategory.import,
        MessageCategory.export,
        MessageCategory.event,
        MessageCategory.infrastructure,
        MessageCategory.system,
      ],
    );
    expect(MessageCategory.validation.toString(), 'MessageCategory.validation');
  });
}
