import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/domain/profile/height.dart';

void main() {
  group('Height', () {
    test('accepts integer centimeter boundaries', () {
      expect(Height.fromCentimeters(20).value?.inCentimeters(), 20);
      expect(Height.fromCentimeters(300).value?.inCentimeters(), 300);
    });

    test('stores whole centimeters as an integer without rounding', () {
      final height = Height.fromCentimeters(181).value!;

      expect(height.inCentimeters(), isA<int>());
      expect(height.inCentimeters(), 181);
    });

    test('returns required error for a missing value', () {
      final error = Height.fromCentimeters(null).errors.single;

      expect(error.code.value, 'PRO-VAL-HEIGHT-001');
      expect(error.messageKey.value, 'validation.profile.height.required');
      expect(error.constraint, ConstraintType.required);
      expect(error.parameters, isEmpty);
    });

    test('returns maximum error above 300 centimeters', () {
      final error = Height.fromCentimeters(301).errors.single;

      expect(error.code.value, 'PRO-VAL-HEIGHT-002');
      expect(error.messageKey.value, 'validation.profile.height.maximum');
      expect(error.constraint, ConstraintType.maximum);
      expect(
        error.parameters,
        <String, Object>{'maximum': 300, 'unit': 'cm'},
      );
    });

    test('returns minimum error below 20 centimeters', () {
      final error = Height.fromCentimeters(19).errors.single;

      expect(error.code.value, 'PRO-VAL-HEIGHT-003');
      expect(error.messageKey.value, 'validation.profile.height.minimum');
      expect(error.constraint, ConstraintType.minimum);
      expect(
        error.parameters,
        <String, Object>{'minimum': 20, 'unit': 'cm'},
      );
    });

    test('implements value equality, inequality and string representation', () {
      final first = Height.fromCentimeters(180).value;
      final equal = Height.fromCentimeters(180).value;
      final different = Height.fromCentimeters(181).value;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
      expect(first, isNot(different));
      expect(first.toString(), 'Height(180cm)');
    });

    test('returns failures instead of throwing business exceptions', () {
      expect(() => Height.fromCentimeters(19), returnsNormally);
      expect(Height.fromCentimeters(19).isFailure, isTrue);
      expect(() => Height.fromCentimeters(301), returnsNormally);
      expect(Height.fromCentimeters(301).isFailure, isTrue);
    });
  });
}
