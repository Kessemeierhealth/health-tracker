import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/error_code.dart';
import 'package:healthtracker/core/errors/field_reference.dart';
import 'package:healthtracker/core/errors/message_key.dart';

void main() {
  group('ErrorCode', () {
    test('creates a valid immutable value', () {
      final code = ErrorCode.create('PRO-VAL-HEIGHT-003');

      expect(code?.value, 'PRO-VAL-HEIGHT-003');
      expect(code.toString(), 'ErrorCode(PRO-VAL-HEIGHT-003)');
    });

    test('rejects empty and whitespace-only values', () {
      expect(ErrorCode.create(''), isNull);
      expect(ErrorCode.create('   '), isNull);
    });

    test('implements value equality and consistent hash codes', () {
      final first = ErrorCode.create('PRO-VAL-HEIGHT-003');
      final equal = ErrorCode.create('PRO-VAL-HEIGHT-003');
      final different = ErrorCode.create('PRO-VAL-HEIGHT-002');

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
      expect(first, isNot(different));
    });
  });

  group('MessageKey', () {
    test('creates a valid value', () {
      final key = MessageKey.create('validation.profile.height.minimum');

      expect(key?.value, 'validation.profile.height.minimum');
      expect(
        key.toString(),
        'MessageKey(validation.profile.height.minimum)',
      );
    });

    test('rejects empty and whitespace-only values', () {
      expect(MessageKey.create(''), isNull);
      expect(MessageKey.create('   '), isNull);
    });

    test('implements value equality and inequality', () {
      expect(
        MessageKey.create('validation.profile.height.minimum'),
        MessageKey.create('validation.profile.height.minimum'),
      );
      expect(
        MessageKey.create('validation.profile.height.minimum'),
        isNot(MessageKey.create('validation.profile.height.maximum')),
      );
    });
  });

  group('FieldReference', () {
    test('creates a valid value', () {
      final field = FieldReference.create('height');

      expect(field?.value, 'height');
      expect(field.toString(), 'FieldReference(height)');
    });

    test('rejects empty and whitespace-only values', () {
      expect(FieldReference.create(''), isNull);
      expect(FieldReference.create('   '), isNull);
    });

    test('implements value equality and inequality', () {
      expect(FieldReference.create('height'), FieldReference.create('height'));
      expect(
        FieldReference.create('height'),
        isNot(FieldReference.create('name')),
      );
    });
  });
}
