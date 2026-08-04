import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/profile_color.dart';

void main() {
  group('ProfileColor', () {
    test('creates complete ARGB boundary values', () {
      final transparent = ProfileColor.fromArgb(0x00000000);
      final opaqueWhite = ProfileColor.fromArgb(0xFFFFFFFF);

      expect(transparent.isSuccess, isTrue);
      expect(transparent.value?.toArgb(), 0x00000000);
      expect(transparent.value?.toHex(), '00000000');
      expect(opaqueWhite.value?.toArgb(), 0xFFFFFFFF);
      expect(opaqueWhite.value?.toHex(), 'FFFFFFFF');
    });

    test('creates and normalizes an eight-digit ARGB hex value', () {
      final result = ProfileColor.fromHex('ff12ab34');

      expect(result.isSuccess, isTrue);
      expect(result.value?.toArgb(), 0xFF12AB34);
      expect(result.value?.toHex(), 'FF12AB34');
    });

    test('accepts arbitrary complete colors without a named color list', () {
      final purple = ProfileColor.fromHex('FF9C27B0');
      final orange = ProfileColor.fromArgb(0xFFFF6D00);

      expect(purple.isSuccess, isTrue);
      expect(orange.isSuccess, isTrue);
      expect(purple.value?.toHex(), 'FF9C27B0');
      expect(orange.value?.toHex(), 'FFFF6D00');
    });

    test('returns required error for missing values', () {
      for (final result in <dynamic>[
        ProfileColor.fromArgb(null),
        ProfileColor.fromHex(null),
        ProfileColor.fromHex(''),
      ]) {
        final error = result.errors.single;
        expect(result.isFailure, isTrue);
        expect(error.code.value, 'PRO-VAL-COLOR-001');
        expect(error.messageKey.value, 'validation.profile.color.required');
        expect(error.constraint, ConstraintType.required);
        expect(error.parameters, isEmpty);
      }
    });

    test('returns format error for invalid ARGB and hex values', () {
      for (final result in <dynamic>[
        ProfileColor.fromArgb(-1),
        ProfileColor.fromArgb(0x100000000),
        ProfileColor.fromHex('FFFFFF'),
        ProfileColor.fromHex('GGFFFFFF'),
      ]) {
        final error = result.errors.single;
        expect(result.isFailure, isTrue);
        expect(error.code.value, 'PRO-VAL-COLOR-002');
        expect(error.messageKey.value, 'validation.profile.color.invalid');
        expect(error.constraint, ConstraintType.format);
        expect(error.parameters, isEmpty);
      }
    });

    test('implements cross-factory value equality and inequality', () {
      final fromArgb = ProfileColor.fromArgb(0xFF12AB34).value;
      final fromHex = ProfileColor.fromHex('FF12AB34').value;
      final different = ProfileColor.fromHex('FF12AB35').value;

      expect(fromArgb, fromHex);
      expect(fromArgb.hashCode, fromHex.hashCode);
      expect(fromArgb, isNot(different));
      expect(fromArgb.toString(), 'ProfileColor(FF12AB34)');
    });

    test('returns failures instead of throwing business exceptions', () {
      expect(() => ProfileColor.fromArgb(-1), returnsNormally);
      expect(ProfileColor.fromArgb(-1).isFailure, isTrue);
      expect(() => ProfileColor.fromHex('invalid'), returnsNormally);
      expect(ProfileColor.fromHex('invalid').isFailure, isTrue);
    });
  });
}
