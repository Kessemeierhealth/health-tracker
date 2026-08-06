import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';

void main() {
  test('contains exactly the documented constraint values', () {
    expect(
      ConstraintType.values,
      <ConstraintType>[
        ConstraintType.required,
        ConstraintType.blank,
        ConstraintType.minimum,
        ConstraintType.maximum,
        ConstraintType.range,
        ConstraintType.format,
        ConstraintType.enumeration,
        ConstraintType.utc,
        ConstraintType.pattern,
        ConstraintType.duplicate,
        ConstraintType.immutable,
        ConstraintType.transition,
        ConstraintType.ownership,
        ConstraintType.authentication,
        ConstraintType.atomic,
        ConstraintType.forbidden,
        ConstraintType.consistency,
        ConstraintType.completeness,
        ConstraintType.chronological,
        ConstraintType.expired,
        ConstraintType.invalid,
      ],
    );
    expect(ConstraintType.required.toString(), 'ConstraintType.required');
  });
}
