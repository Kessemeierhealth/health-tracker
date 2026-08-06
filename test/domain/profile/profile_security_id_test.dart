import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/profile_security_id.dart';

void main() {
  const valid = '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f';

  group('ProfileSecurityId', () {
    test('generate creates distinct canonical UUIDv7 values', () {
      final first = ProfileSecurityId.generate();
      final second = ProfileSecurityId.generate();
      expect(first.isSuccess, isTrue);
      expect(
          first.value!.value,
          matches(RegExp(
              r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$')));
      expect(first.value, isNot(second.value));
    });

    test('fromString trims and canonicalizes to lowercase', () {
      final result = ProfileSecurityId.fromString('  ${valid.toUpperCase()}  ');
      expect(result.isSuccess, isTrue);
      expect(result.value!.value, valid);
      expect(result.value.toString(), valid);
    });

    test('returns required, blank and format errors without exceptions', () {
      final required = ProfileSecurityId.fromString(null);
      final blank = ProfileSecurityId.fromString('  ');
      final invalid = ProfileSecurityId.fromString('not-a-uuid');
      expect(required.errors.single.code.value, 'PRO-VAL-PSECID-001');
      expect(required.errors.single.constraint, ConstraintType.required);
      expect(blank.errors.single.code.value, 'PRO-VAL-PSECID-002');
      expect(blank.errors.single.constraint, ConstraintType.blank);
      expect(invalid.errors.single.code.value, 'PRO-VAL-PSECID-003');
      expect(invalid.errors.single.constraint, ConstraintType.format);
      expect(invalid.errors.single.parameters,
          const <String, Object>{'expectedFormat': 'UUIDv7'});
      expect(invalid.errors.single.parameters, isNot(contains('value')));
    });

    test('rejects non-v7 UUID and implements immutable value equality', () {
      expect(
          ProfileSecurityId.fromString('550e8400-e29b-41d4-a716-446655440000')
              .isFailure,
          isTrue);
      final first = ProfileSecurityId.fromString(valid).value!;
      final sameId = ProfileSecurityId.fromString(valid.toUpperCase()).value!;
      final different =
          ProfileSecurityId.fromString('01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e70')
              .value!;
      expect(first, sameId);
      expect(first.hashCode, sameId.hashCode);
      expect(first, isNot(different));
    });
  });
}
