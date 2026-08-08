import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/checksum_algorithm.dart';
import 'package:healthtracker/domain/profile/image_checksum.dart';

void main() {
  const valid =
      'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';

  group('ImageChecksum', () {
    test('creates and trims a canonical sha256 checksum', () {
      final result =
          ImageChecksum.create(ChecksumAlgorithm.sha256, '  $valid  ');

      expect(result.isSuccess, isTrue);
      expect(result.value!.algorithm, ChecksumAlgorithm.sha256);
      expect(result.value!.value, valid);
    });

    test('reports both missing fields in documented order', () {
      final result = ImageChecksum.create(null, null);

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(result.errors.map((error) => error.code.value), <String>[
        'PRO-VAL-IMGCHK-001',
        'PRO-VAL-IMGCHK-002',
      ]);
      expect(result.errors[0].field!.value, 'algorithm');
      expect(result.errors[1].field!.value, 'value');
      expect(
          result.errors
              .every((error) => error.constraint == ConstraintType.required),
          isTrue);
    });

    test('reports blank independently from a missing algorithm', () {
      final result = ImageChecksum.create(null, '   ');

      expect(result.errors.map((error) => error.code.value), <String>[
        'PRO-VAL-IMGCHK-001',
        'PRO-VAL-IMGCHK-003',
      ]);
      expect(result.errors[1].messageKey.value,
          'validation.imageChecksum.value.blank');
      expect(result.errors[1].constraint, ConstraintType.blank);
    });

    test('does not format-check without an algorithm', () {
      final result = ImageChecksum.create(null, 'invalid');
      expect(result.errors.map((error) => error.code.value),
          <String>['PRO-VAL-IMGCHK-001']);
    });

    test('rejects every non-canonical sha256 representation', () {
      for (final value in <String>[
        valid.substring(0, 63),
        '${valid}0',
        valid.toUpperCase(),
        'sha256:$valid',
        '${valid.substring(0, 32)} ${valid.substring(32)}',
        '${valid.substring(0, 63)}g',
      ]) {
        final result = ImageChecksum.create(ChecksumAlgorithm.sha256, value);
        final error = result.errors.single;
        expect(error.code.value, 'PRO-VAL-IMGCHK-004');
        expect(error.messageKey.value,
            'validation.imageChecksum.value.invalidFormat');
        expect(error.field!.value, 'value');
        expect(error.constraint, ConstraintType.format);
        expect(error.parameters, const <String, Object>{
          'algorithm': 'sha256',
          'expectedPattern': ImageChecksum.sha256Pattern,
          'expectedLength': ImageChecksum.sha256Length,
        });
        expect(error.toString(), isNot(contains(value)));
      }
    });

    test('implements value equality and a matching hashCode', () {
      final first =
          ImageChecksum.create(ChecksumAlgorithm.sha256, valid).value!;
      final same = ImageChecksum.create(
        ChecksumAlgorithm.sha256,
        ' $valid ',
      ).value!;

      expect(first, same);
      expect(first.hashCode, same.hashCode);
    });

    test('redacts the checksum in its string representation', () {
      final checksum =
          ImageChecksum.create(ChecksumAlgorithm.sha256, valid).value!;

      expect(
        checksum.toString(),
        'ImageChecksum(\n  algorithm: sha256,\n  value: <redacted>\n)',
      );
      expect(checksum.toString(), isNot(contains(valid)));
    });

    test('expected validation failures do not throw', () {
      expect(() => ImageChecksum.create(null, null), returnsNormally);
      expect(
        () => ImageChecksum.create(ChecksumAlgorithm.sha256, 'invalid'),
        returnsNormally,
      );
    });
  });
}
