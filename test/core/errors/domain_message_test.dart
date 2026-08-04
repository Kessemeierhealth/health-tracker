import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/domain_message.dart';
import 'package:healthtracker/core/errors/error_code.dart';
import 'package:healthtracker/core/errors/field_reference.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_key.dart';
import 'package:healthtracker/core/errors/message_severity.dart';

void main() {
  final code = ErrorCode.create('PRO-VAL-HEIGHT-003')!;
  final messageKey = MessageKey.create('validation.profile.height.minimum')!;
  final field = FieldReference.create('height')!;

  DomainError error({
    MessageSeverity severity = MessageSeverity.error,
    Map<String, Object> parameters = const <String, Object>{
      'minimum': 20,
      'unit': 'cm',
    },
  }) =>
      DomainError(
        code: code,
        messageKey: messageKey,
        severity: severity,
        category: MessageCategory.validation,
        parameters: parameters,
        field: field,
        constraint: ConstraintType.minimum,
      );

  test('DomainMessage contains required and optional fields', () {
    final message = error();

    expect(message.code, code);
    expect(message.messageKey, messageKey);
    expect(message.severity, MessageSeverity.error);
    expect(message.category, MessageCategory.validation);
    expect(message.parameters, <String, Object>{'minimum': 20, 'unit': 'cm'});
    expect(message.field, field);
    expect(message.constraint, ConstraintType.minimum);
  });

  test('DomainMessage permits absent optional fields', () {
    final message = DomainError(
      code: code,
      messageKey: messageKey,
      severity: MessageSeverity.error,
      category: MessageCategory.validation,
      parameters: const {},
    );

    expect(message.field, isNull);
    expect(message.constraint, isNull);
  });

  test('parameters are defensively copied and deeply immutable', () {
    final nested = <Object>[20];
    final source = <String, Object>{'values': nested};
    final message = error(parameters: source);

    nested.add(300);
    source['unit'] = 'cm';

    expect(message.parameters, <String, Object>{
      'values': <Object>[20],
    });
    expect(
      () => message.parameters['other'] = true,
      throwsUnsupportedError,
    );
    expect(
      () => (message.parameters['values']! as List<Object>).add(300),
      throwsUnsupportedError,
    );
  });

  test('messages use value equality including deep parameters', () {
    final first = error(parameters: <String, Object>{
      'allowed': <Object>[20, 300],
    });
    final equal = error(parameters: <String, Object>{
      'allowed': <Object>[20, 300],
    });
    final different = error(parameters: <String, Object>{
      'allowed': <Object>[20],
    });

    expect(first, equal);
    expect(first.hashCode, equal.hashCode);
    expect(first, isNot(different));
  });

  test('DomainError accepts ERROR and CRITICAL', () {
    expect(error, returnsNormally);
    expect(
      () => error(severity: MessageSeverity.critical),
      returnsNormally,
    );
  });

  test('DomainError rejects WARNING and INFORMATION', () {
    expect(
      () => error(severity: MessageSeverity.warning),
      throwsArgumentError,
    );
    expect(
      () => error(severity: MessageSeverity.information),
      throwsArgumentError,
    );
  });

  test('DomainWarning accepts only WARNING', () {
    DomainWarning create(MessageSeverity severity) => DomainWarning(
          code: code,
          messageKey: messageKey,
          severity: severity,
          category: MessageCategory.validation,
          parameters: const {},
        );

    expect(() => create(MessageSeverity.warning), returnsNormally);
    for (final severity in <MessageSeverity>[
      MessageSeverity.information,
      MessageSeverity.error,
      MessageSeverity.critical,
    ]) {
      expect(() => create(severity), throwsArgumentError);
    }
  });

  test('DomainInformation accepts only INFORMATION', () {
    DomainInformation create(MessageSeverity severity) => DomainInformation(
          code: code,
          messageKey: messageKey,
          severity: severity,
          category: MessageCategory.validation,
          parameters: const {},
        );

    expect(() => create(MessageSeverity.information), returnsNormally);
    for (final severity in <MessageSeverity>[
      MessageSeverity.warning,
      MessageSeverity.error,
      MessageSeverity.critical,
    ]) {
      expect(() => create(severity), throwsArgumentError);
    }
  });
}
