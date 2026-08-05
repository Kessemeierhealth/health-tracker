import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/appearance_settings.dart';
import 'package:healthtracker/domain/profile/text_scale_preference.dart';
import 'package:healthtracker/domain/profile/theme_preference.dart';

void main() {
  group('AppearanceSettings', () {
    for (final theme in ThemePreference.values) {
      test('creates valid settings with ${theme.name} theme', () {
        final result = AppearanceSettings.create(theme, null);

        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
        expect(result.errors, isEmpty);
        expect(result.value?.themePreference, theme);
        expect(result.value?.textScalePreference, isNull);
      });
    }

    test('accepts a missing text scale as the system default', () {
      final result = AppearanceSettings.create(ThemePreference.system, null);

      expect(result.isSuccess, isTrue);
      expect(result.errors, isEmpty);
      expect(result.value?.textScalePreference, isNull);
    });

    for (final scale in <TextScalePreference>[
      TextScalePreference.small,
      TextScalePreference.standard,
      TextScalePreference.large,
    ]) {
      test('creates valid settings with ${scale.name} text scale', () {
        final result = AppearanceSettings.create(ThemePreference.light, scale);

        expect(result.isSuccess, isTrue);
        expect(result.value?.textScalePreference, scale);
      });
    }

    test('also accepts the explicit system text scale', () {
      final result = AppearanceSettings.create(
        ThemePreference.dark,
        TextScalePreference.system,
      );

      expect(result.isSuccess, isTrue);
      expect(result.value?.textScalePreference, TextScalePreference.system);
    });

    test('returns the documented error for a missing theme', () {
      final result = AppearanceSettings.create(null, TextScalePreference.large);
      final error = result.errors.single;

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(error.code.value, 'PRO-VAL-APP-001');
      expect(
        error.messageKey.value,
        'validation.appearanceSettings.themePreference.required',
      );
      expect(error.severity, MessageSeverity.error);
      expect(error.category, MessageCategory.validation);
      expect(error.field?.value, 'themePreference');
      expect(error.constraint, ConstraintType.required);
      expect(error.parameters, isEmpty);
    });

    test('implements value equality and consistent hash codes', () {
      final first = AppearanceSettings.create(
        ThemePreference.light,
        TextScalePreference.large,
      ).value!;
      final equal = AppearanceSettings.create(
        ThemePreference.light,
        TextScalePreference.large,
      ).value!;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
    });

    test('is unequal when either preference differs', () {
      final baseline = AppearanceSettings.create(
        ThemePreference.light,
        TextScalePreference.standard,
      ).value!;
      final otherTheme = AppearanceSettings.create(
        ThemePreference.dark,
        TextScalePreference.standard,
      ).value!;
      final otherScale = AppearanceSettings.create(
        ThemePreference.light,
        TextScalePreference.large,
      ).value!;
      final systemScale = AppearanceSettings.create(
        ThemePreference.light,
        null,
      ).value!;

      expect(baseline, isNot(otherTheme));
      expect(baseline, isNot(otherScale));
      expect(baseline, isNot(systemScale));
    });

    test('is immutable and has a meaningful string representation', () {
      final settings = AppearanceSettings.create(
        ThemePreference.dark,
        TextScalePreference.large,
      ).value!;

      expect(settings.themePreference, ThemePreference.dark);
      expect(settings.textScalePreference, TextScalePreference.large);
      expect(
        settings.toString(),
        'AppearanceSettings('
        'themePreference: ThemePreference.dark, '
        'textScalePreference: TextScalePreference.large)',
      );
    });

    test('returns validation failures without throwing exceptions', () {
      expect(() => AppearanceSettings.create(null, null), returnsNormally);
      expect(AppearanceSettings.create(null, null).isFailure, isTrue);
    });
  });
}
