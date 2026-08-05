import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/domain/profile/dashboard_layout.dart';

void main() {
  test('DashboardLayout contains exactly the documented stable values', () {
    expect(
      DashboardLayout.values,
      <DashboardLayout>[
        DashboardLayout.standard,
        DashboardLayout.compact,
        DashboardLayout.comfortable,
      ],
    );
    expect(
      DashboardLayout.values.map((value) => value.name),
      <String>['standard', 'compact', 'comfortable'],
    );
  });
}
