import 'package:flutter_test/flutter_test.dart';
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

    test('represents a missing gender with unspecified', () {
      const missingGender = Gender.unspecified;

      expect(missingGender, Gender.unspecified);
    });

    test('has a meaningful string representation', () {
      expect(Gender.diverse.toString(), 'Gender.diverse');
    });
  });
}
