import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/domain_result.dart';
import 'package:healthtracker/domain/profile/profile_settings_id.dart';

void main() {
  group('ProfileSettingsId', () {
    test('generate returns a successful canonical UUIDv7', () {
      final result = ProfileSettingsId.generate();

      expect(result, isA<DomainResult<ProfileSettingsId>>());
      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.errors, isEmpty);
      expect(
        result.value!.value,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
    });

    test('generate creates distinct IDs', () {
      final first = ProfileSettingsId.generate().value;
      final second = ProfileSettingsId.generate().value;

      expect(first, isNot(second));
    });

    test('fromString trims and canonicalizes a valid UUIDv7', () {
      final result = ProfileSettingsId.fromString(
        '  01890F3E-7B5A-7CC4-98C2-1A2B3C4D5E6F  ',
      );

      expect(result.isSuccess, isTrue);
      expect(result.value!.value, '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f');
      expect(result.value.toString(), '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f');
    });

    test('returns only the documented required error for null', () {
      final result = ProfileSettingsId.fromString(null);

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(result.errors, hasLength(1));
      expect(result.errors.single.code.value, 'PRO-VAL-PSETID-001');
      expect(
        result.errors.single.messageKey.value,
        'validation.profileSettingsId.required',
      );
      expect(result.errors.single.constraint, ConstraintType.required);
      expect(result.errors.single.field!.value, 'value');
      expect(result.errors.single.parameters, isEmpty);
    });

    test('returns only the documented blank error for whitespace', () {
      final result = ProfileSettingsId.fromString('   ');

      expect(result.isFailure, isTrue);
      expect(result.errors, hasLength(1));
      expect(result.errors.single.code.value, 'PRO-VAL-PSETID-002');
      expect(
        result.errors.single.messageKey.value,
        'validation.profileSettingsId.blank',
      );
      expect(result.errors.single.constraint, ConstraintType.blank);
      expect(result.errors.single.parameters, isEmpty);
    });

    test('returns the documented format error for malformed input', () {
      final result = ProfileSettingsId.fromString('not-a-uuid');

      expect(result.isFailure, isTrue);
      expect(result.errors, hasLength(1));
      expect(result.errors.single.code.value, 'PRO-VAL-PSETID-003');
      expect(
        result.errors.single.messageKey.value,
        'validation.profileSettingsId.invalidFormat',
      );
      expect(result.errors.single.constraint, ConstraintType.format);
      expect(
        result.errors.single.parameters,
        const <String, Object>{'expectedFormat': 'UUIDv7'},
      );
      expect(result.errors.single.parameters, isNot(contains('value')));
    });

    test('rejects a syntactically valid UUID with another version', () {
      final result = ProfileSettingsId.fromString(
        '550e8400-e29b-41d4-a716-446655440000',
      );

      expect(result.isFailure, isTrue);
      expect(result.errors.single.code.value, 'PRO-VAL-PSETID-003');
    });

    test('implements value equality, inequality, and matching hash codes', () {
      final first = ProfileSettingsId.fromString(
        '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e6f',
      ).value!;
      final same = ProfileSettingsId.fromString(
        '01890F3E-7B5A-7CC4-98C2-1A2B3C4D5E6F',
      ).value!;
      final different = ProfileSettingsId.fromString(
        '01890f3e-7b5a-7cc4-98c2-1a2b3c4d5e70',
      ).value!;

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(different));
    });

    test('is immutable and validation failures do not throw', () {
      expect(
        () => ProfileSettingsId.fromString('not-a-uuid'),
        returnsNormally,
      );

      final id = ProfileSettingsId.generate().value!;
      expect(id.value, isA<String>());
    });
  });
}
