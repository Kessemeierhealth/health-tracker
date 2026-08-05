import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/domain/profile/measurement_system.dart';

void main() {
  test('MeasurementSystem contains exactly the documented stable values', () {
    expect(
      MeasurementSystem.values,
      <MeasurementSystem>[
        MeasurementSystem.metric,
        MeasurementSystem.imperial,
      ],
    );
    expect(
      MeasurementSystem.values.map((system) => system.name),
      <String>['metric', 'imperial'],
    );
  });
}
