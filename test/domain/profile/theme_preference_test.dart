import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/domain/profile/theme_preference.dart';

void main() {
  test('ThemePreference contains exactly the documented stable values', () {
    expect(
      ThemePreference.values,
      <ThemePreference>[
        ThemePreference.system,
        ThemePreference.light,
        ThemePreference.dark,
      ],
    );
    expect(
      ThemePreference.values.map((value) => value.name),
      <String>['system', 'light', 'dark'],
    );
  });
}
