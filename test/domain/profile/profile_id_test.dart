import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/profile_id.dart';

void main() {
  group('ProfileId', () {
    test('creates and normalizes a valid UUIDv7', () {
      final result = ProfileId.fromString(
        '01890F3E-7B5A-7CC4-98C2-1A2B3C4D5E6F',
      );

      expect(result.isSuccess, isTrue);
      expect(result.value?.value, '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f');
    });

    test('returns required error for missing and blank values', () {
      for (final value in <String?>[null, '', '   ']) {
        final result = ProfileId.fromString(value);

        expect(result.errors.single.code.value, 'PRO-VAL-ID-001');
        expect(
          result.errors.single.messageKey.value,
          'validation.profile.id.required',
        );
        expect(result.errors.single.constraint, ConstraintType.required);
        expect(result.errors.single.parameters, isEmpty);
      }
    });

    test('returns format error for malformed and non-v7 UUIDs', () {
      for (final value in <String>[
        'not-a-uuid',
        '01890f3e-7b5a-4cc4-98c2-1a2b3c4d5e6f',
      ]) {
        final result = ProfileId.fromString(value);

        expect(result.errors.single.code.value, 'PRO-VAL-ID-002');
        expect(
          result.errors.single.messageKey.value,
          'validation.profile.id.invalidFormat',
        );
        expect(result.errors.single.constraint, ConstraintType.format);
        expect(
          result.errors.single.parameters,
          <String, Object>{'expectedFormat': 'UUIDv7'},
        );
      }
    });

    test('implements normalized value equality and inequality', () {
      final lower = ProfileId.fromString(
        '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f',
      ).value;
      final upper = ProfileId.fromString(
        '01890F3E-7B5A-7CC4-98C2-1A2B3C4D5E6F',
      ).value;
      final different = ProfileId.fromString(
        '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e60',
      ).value;

      expect(lower, upper);
      expect(lower.hashCode, upper.hashCode);
      expect(lower, isNot(different));
      expect(
        lower.toString(),
        'ProfileId(01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f)',
      );
    });

    test('returns failures instead of throwing business exceptions', () {
      expect(() => ProfileId.fromString(null), returnsNormally);
      expect(ProfileId.fromString(null).isFailure, isTrue);
      expect(() => ProfileId.fromString('not-a-uuid'), returnsNormally);
      expect(ProfileId.fromString('not-a-uuid').isFailure, isTrue);
    });
  });
}
