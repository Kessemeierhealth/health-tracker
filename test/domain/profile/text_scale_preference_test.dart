import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/domain/profile/text_scale_preference.dart';

void main() {
  test('TextScalePreference contains exactly the documented stable values', () {
    expect(
      TextScalePreference.values,
      <TextScalePreference>[
        TextScalePreference.system,
        TextScalePreference.small,
        TextScalePreference.standard,
        TextScalePreference.large,
      ],
    );
    expect(
      TextScalePreference.values.map((value) => value.name),
      <String>['system', 'small', 'standard', 'large'],
    );
  });
}
