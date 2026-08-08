import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/image_reference.dart';

void main() {
  const valid = 'img_0123456789abcdefghijklmnop';

  group('ImageReference', () {
    test('creates and trims the documented opaque reference', () {
      final result = ImageReference.create('  $valid  ');
      expect(result.isSuccess, isTrue);
      expect(result.value!.value, valid);
      expect(result.value.toString(), valid);
    });

    test('returns the documented required error', () {
      _expectError(
          ImageReference.create(null),
          'PRO-VAL-IMGREF-001',
          'validation.imageReference.required',
          ConstraintType.required, const {});
    });

    test('returns the documented blank error', () {
      _expectError(ImageReference.create('   '), 'PRO-VAL-IMGREF-002',
          'validation.imageReference.blank', ConstraintType.blank, const {});
    });

    test('rejects wrong lengths, characters, case and exposed locations', () {
      for (final value in <String>[
        'img_short',
        'IMG_0123456789abcdefghijklmnop',
        'img_0123456789abcdefghijklmno-',
        'https://example.test/image.jpg',
        '/home/user/profile.jpg',
      ]) {
        _expectError(
          ImageReference.create(value),
          'PRO-VAL-IMGREF-003',
          'validation.imageReference.invalidFormat',
          ConstraintType.format,
          const <String, Object>{
            'expectedPattern': ImageReference.expectedPattern,
            'expectedLength': ImageReference.expectedLength,
          },
        );
      }
    });

    test('does not disclose invalid input in errors', () {
      final result = ImageReference.create('secret-token');
      expect(result.errors.single.parameters, isNot(contains('value')));
      expect(result.errors.single.toString(), isNot(contains('secret-token')));
    });

    test('implements immutable value equality and hashCode', () {
      final first = ImageReference.create(valid).value!;
      final same = ImageReference.create(' $valid ').value!;
      final different = ImageReference.create(
        'img_1123456789abcdefghijklmnop',
      ).value!;
      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
    });

    test('expected validation failures do not throw', () {
      expect(() => ImageReference.create(null), returnsNormally);
      expect(() => ImageReference.create('invalid'), returnsNormally);
    });
  });
}

void _expectError(dynamic result, String code, String key,
    ConstraintType constraint, Map<String, Object> parameters) {
  expect(result.isFailure, isTrue);
  expect(result.value, isNull);
  final error = result.errors.single;
  expect(error.code.value, code);
  expect(error.messageKey.value, key);
  expect(error.field!.value, 'value');
  expect(error.constraint, constraint);
  expect(error.parameters, parameters);
}
