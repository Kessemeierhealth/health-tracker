import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/profile_status.dart';

void main() {
  group('ProfileStatus', () {
    test('contains exactly the documented stable values', () {
      expect(ProfileStatus.values, <ProfileStatus>[
        ProfileStatus.inactive,
        ProfileStatus.active,
        ProfileStatus.archived,
      ]);
      expect(ProfileStatus.values.map((value) => value.toString()),
          <String>['inactive', 'active', 'archived']);
    });

    test('reconstructs exact values after trimming', () {
      for (final status in ProfileStatus.values) {
        final result = ProfileStatus.fromString('  ${status.name}  ');
        expect(result.isSuccess, isTrue);
        expect(result.value, status);
      }
    });

    test('returns required for null, empty and blank values', () {
      for (final value in <String?>[null, '', '   ']) {
        final result = ProfileStatus.fromString(value);
        final error = result.errors.single;
        expect(error.code.value, 'PRO-VAL-STATUS-001');
        expect(error.messageKey.value, 'validation.profile.status.required');
        expect(error.severity, MessageSeverity.error);
        expect(error.category, MessageCategory.validation);
        expect(error.field!.value, 'status');
        expect(error.constraint, ConstraintType.required);
        expect(error.parameters, isEmpty);
      }
    });

    test('rejects unsupported, security and differently cased values', () {
      for (final value in <String>['unknown', 'locked', 'unlocked', 'Active']) {
        final result = ProfileStatus.fromString(value);
        final error = result.errors.single;
        expect(error.code.value, 'PRO-VAL-STATUS-002');
        expect(error.messageKey.value, 'validation.profile.status.invalid');
        expect(error.field!.value, 'status');
        expect(error.constraint, ConstraintType.enumeration);
        expect(error.parameters, const <String, Object>{
          'allowedValues': <String>['inactive', 'active', 'archived'],
        });
        expect(error.parameters, isNot(contains('value')));
      }
    });

    test('validation failures do not throw', () {
      expect(() => ProfileStatus.fromString(null), returnsNormally);
      expect(() => ProfileStatus.fromString('unknown'), returnsNormally);
    });
  });
}
