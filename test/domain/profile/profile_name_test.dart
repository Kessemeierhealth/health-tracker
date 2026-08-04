import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/profile_name.dart';

void main() {
  group('ProfileName', () {
    test('creates a normal name through DomainResult', () {
      final result = ProfileName.create('Anna');

      expect(result.isSuccess, isTrue);
      expect(result.value?.value, 'Anna');
      expect(result.errors, isEmpty);
    });

    test('returns required error for null and empty input', () {
      for (final value in <String?>[null, '']) {
        final result = ProfileName.create(value);
        final error = result.errors.single;

        expect(result.isFailure, isTrue);
        expect(error.code.value, 'PRO-VAL-NAME-001');
        expect(error.messageKey.value, 'validation.profile.name.required');
        expect(error.constraint, ConstraintType.required);
        expect(error.parameters, isEmpty);
      }
    });

    test('returns blank error for whitespace-only input', () {
      final result = ProfileName.create('   ');
      final error = result.errors.single;

      expect(result.isFailure, isTrue);
      expect(error.code.value, 'PRO-VAL-NAME-002');
      expect(error.messageKey.value, 'validation.profile.name.blank');
      expect(error.constraint, ConstraintType.blank);
      expect(error.parameters, isEmpty);
    });

    test('trims only leading and trailing whitespace', () {
      final result = ProfileName.create('  Anna   Maria  ');

      expect(result.value?.value, 'Anna   Maria');
    });

    test('removes leading whitespace', () {
      expect(ProfileName.create('  Anna').value?.value, 'Anna');
    });

    test('removes trailing whitespace', () {
      expect(ProfileName.create('Anna  ').value?.value, 'Anna');
    });

    test('removes leading and trailing whitespace together', () {
      expect(ProfileName.create('  Anna  ').value?.value, 'Anna');
    });

    test('preserves inner multiple whitespace and case', () {
      expect(
        ProfileName.create('Anna   McKay').value?.value,
        'Anna   McKay',
      );
    });

    test('preserves case and has no maximum-length validation', () {
      final longName = 'AbC${'x' * 200}';
      final result = ProfileName.create(longName);

      expect(result.isSuccess, isTrue);
      expect(result.value?.value, longName);
    });

    test('implements immutable value equality and inequality', () {
      final first = ProfileName.create(' Anna ').value;
      final equal = ProfileName.create('Anna').value;
      final different = ProfileName.create('anna').value;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
      expect(first, isNot(different));
      expect(first.toString(), 'ProfileName(Anna)');
    });

    test('returns failures instead of throwing business exceptions', () {
      expect(() => ProfileName.create(null), returnsNormally);
      expect(ProfileName.create(null).isFailure, isTrue);
      expect(() => ProfileName.create('   '), returnsNormally);
      expect(ProfileName.create('   ').isFailure, isTrue);
    });
  });
}
