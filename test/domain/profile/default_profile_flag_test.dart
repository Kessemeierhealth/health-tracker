import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/domain/profile/default_profile_flag.dart';

void main() {
  group('DefaultProfileFlag', () {
    test('creates the enabled state through DomainResult', () {
      final result = DefaultProfileFlag.createEnabled();
      expect(result.isSuccess, isTrue);
      expect(result.value!.isDefault, isTrue);
      expect(result.value.toString(), 'default');
    });

    test('creates the disabled state through DomainResult', () {
      final result = DefaultProfileFlag.createDisabled();
      expect(result.isSuccess, isTrue);
      expect(result.value!.isDefault, isFalse);
      expect(result.value.toString(), 'notDefault');
    });

    test('implements immutable value equality and hashCode', () {
      final enabled = DefaultProfileFlag.createEnabled().value!;
      final same = DefaultProfileFlag.createEnabled().value!;
      final disabled = DefaultProfileFlag.createDisabled().value!;
      expect(enabled, same);
      expect(enabled.hashCode, same.hashCode);
      expect(enabled, isNot(disabled));
    });
  });
}
