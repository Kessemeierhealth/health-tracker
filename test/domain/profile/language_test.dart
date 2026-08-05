import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/domain/profile/language.dart';

void main() {
  test('Language contains exactly the documented stable codes', () {
    expect(Language.values, <Language>[Language.de, Language.en]);
    expect(
      Language.values.map((language) => language.name),
      <String>['de', 'en'],
    );
  });
}
