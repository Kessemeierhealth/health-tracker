import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/image_dimensions.dart';

void main() {
  group('ImageDimensions', () {
    test('accepts inclusive boundaries', () {
      final minimum = ImageDimensions.create(1, 1);
      final maximum = ImageDimensions.create(4096, 4096);

      expect(minimum.isSuccess, isTrue);
      expect(minimum.value!.width, 1);
      expect(minimum.value!.height, 1);
      expect(maximum.isSuccess, isTrue);
    });

    test('returns required errors in documented order', () {
      final result = ImageDimensions.create(null, null);

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(result.errors.map((error) => error.code.value), <String>[
        'PRO-VAL-IMGDIM-001',
        'PRO-VAL-IMGDIM-002',
      ]);
      _expectError(
          result.errors[0],
          'validation.imageDimensions.width.required',
          'width',
          ConstraintType.required, const {});
      _expectError(
          result.errors[1],
          'validation.imageDimensions.height.required',
          'height',
          ConstraintType.required, const {});
    });

    test('returns independent minimum errors in documented order', () {
      final result = ImageDimensions.create(0, -1);

      expect(result.errors.map((error) => error.code.value), <String>[
        'PRO-VAL-IMGDIM-003',
        'PRO-VAL-IMGDIM-004',
      ]);
      for (final error in result.errors) {
        expect(error.constraint, ConstraintType.minimum);
        expect(error.parameters,
            const <String, Object>{'minimum': 1, 'unit': 'pixels'});
      }
    });

    test('returns independent maximum errors in documented order', () {
      final result = ImageDimensions.create(4097, 5000);

      expect(result.errors.map((error) => error.code.value), <String>[
        'PRO-VAL-IMGDIM-005',
        'PRO-VAL-IMGDIM-006',
      ]);
      for (final error in result.errors) {
        expect(error.constraint, ConstraintType.maximum);
        expect(error.parameters,
            const <String, Object>{'maximum': 4096, 'unit': 'pixels'});
      }
    });

    test('does not add range errors for missing values', () {
      final result = ImageDimensions.create(null, 4097);
      expect(result.errors.map((error) => error.code.value), <String>[
        'PRO-VAL-IMGDIM-001',
        'PRO-VAL-IMGDIM-006',
      ]);
    });

    test('calculates the unrounded aspect ratio', () {
      expect(ImageDimensions.create(1600, 1200).value!.aspectRatio(),
          1.3333333333333333);
      expect(ImageDimensions.create(1200, 1600).value!.aspectRatio(), 0.75);
    });

    test('implements value equality, hashCode and documented string output',
        () {
      final first = ImageDimensions.create(1024, 768).value!;
      final same = ImageDimensions.create(1024, 768).value!;
      final different = ImageDimensions.create(768, 1024).value!;

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
      expect(first.toString(),
          'ImageDimensions(\n  width: 1024,\n  height: 768\n)');
    });

    test('expected validation failures do not throw', () {
      expect(() => ImageDimensions.create(null, null), returnsNormally);
      expect(() => ImageDimensions.create(0, 4097), returnsNormally);
    });
  });
}

void _expectError(dynamic error, String key, String field,
    ConstraintType constraint, Map<String, Object> parameters) {
  expect(error.messageKey.value, key);
  expect(error.field!.value, field);
  expect(error.constraint, constraint);
  expect(error.parameters, parameters);
}
