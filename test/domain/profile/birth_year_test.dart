import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/birth_year.dart';

void main() {
  const currentYear = 2026;

  group('BirthYear', () {
    test('accepts minimum and current year boundaries', () {
      expect(BirthYear.create(1900, currentYear).value?.value, 1900);
      expect(
          BirthYear.create(currentYear, currentYear).value?.value, currentYear);
    });

    test('returns required error for a missing value', () {
      final error = BirthYear.create(null, currentYear).errors.single;

      expect(error.code.value, 'PRO-VAL-BIRTHYEAR-001');
      expect(error.messageKey.value, 'validation.profile.birthYear.required');
      expect(error.constraint, ConstraintType.required);
      expect(error.parameters, isEmpty);
    });

    test('returns format error for a non-four-digit year', () {
      final error = BirthYear.create(999, currentYear).errors.single;

      expect(error.code.value, 'PRO-VAL-BIRTHYEAR-002');
      expect(error.messageKey.value, 'validation.profile.birthYear.format');
      expect(error.constraint, ConstraintType.format);
      expect(error.parameters, <String, Object>{'expectedFormat': 'YYYY'});
    });

    test('returns minimum error below 1900', () {
      final error = BirthYear.create(1899, currentYear).errors.single;

      expect(error.code.value, 'PRO-VAL-BIRTHYEAR-003');
      expect(error.messageKey.value, 'validation.profile.birthYear.minimum');
      expect(error.constraint, ConstraintType.minimum);
      expect(error.parameters, <String, Object>{'minimum': 1900});
    });

    test('uses the supplied current year deterministically', () {
      final error = BirthYear.create(2027, currentYear).errors.single;

      expect(error.code.value, 'PRO-VAL-BIRTHYEAR-004');
      expect(error.messageKey.value, 'validation.profile.birthYear.future');
      expect(error.constraint, ConstraintType.maximum);
      expect(error.parameters, <String, Object>{'maximum': currentYear});
      expect(BirthYear.create(2027, 2027).isSuccess, isTrue);
    });

    test('implements value equality, inequality and string representation', () {
      final first = BirthYear.create(1990, currentYear).value;
      final equal = BirthYear.create(1990, currentYear).value;
      final different = BirthYear.create(1991, currentYear).value;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
      expect(first, isNot(different));
      expect(first.toString(), 'BirthYear(1990)');
    });

    test('returns failures instead of throwing business exceptions', () {
      expect(() => BirthYear.create(1899, currentYear), returnsNormally);
      expect(BirthYear.create(1899, currentYear).isFailure, isTrue);
      expect(() => BirthYear.create(2027, currentYear), returnsNormally);
      expect(BirthYear.create(2027, currentYear).isFailure, isTrue);
    });
  });
}
