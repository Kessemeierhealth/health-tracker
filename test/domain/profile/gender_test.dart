import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/gender.dart';

void main() {
  group('Gender', () {
    test('contains exactly the documented values in their documented order',
        () {
      expect(
        Gender.values,
        <Gender>[
          Gender.male,
          Gender.female,
          Gender.diverse,
          Gender.unspecified,
        ],
      );
    });

    test('uses value equality', () {
      expect(Gender.male, Gender.male);
      expect(Gender.male, isNot(Gender.female));
    });

    test('reconstructs exact values after trimming', () {
      for (final gender in Gender.values) {
        final result = Gender.fromString('  ${gender.name}  ');
        expect(result.isSuccess, isTrue);
        expect(result.value, gender);
      }
    });

    test('maps null, empty and blank values to unspecified', () {
      for (final value in <String?>[null, '', '   ']) {
        final result = Gender.fromString(value);
        expect(result.isSuccess, isTrue);
        expect(result.value, Gender.unspecified);
        expect(result.errors, isEmpty);
      }
    });

    test('rejects unknown values and preserves case sensitivity', () {
      for (final value in <String>['unknown', 'Male']) {
        final result = Gender.fromString(value);
        final error = result.errors.single;
        expect(error.code.value, 'PRO-VAL-GENDER-001');
        expect(error.messageKey.value, 'validation.profile.gender.invalid');
        expect(error.severity, MessageSeverity.error);
        expect(error.category, MessageCategory.validation);
        expect(error.field!.value, 'value');
        expect(error.constraint, ConstraintType.enumeration);
        expect(error.parameters, const <String, Object>{
          'allowedValues': <String>['male', 'female', 'diverse', 'unspecified'],
        });
        expect(error.parameters, isNot(contains('value')));
      }
    });

    test('has a meaningful string representation', () {
      expect(Gender.diverse.toString(), 'diverse');
    });
  });
}
