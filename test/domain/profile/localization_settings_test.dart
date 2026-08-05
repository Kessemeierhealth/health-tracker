import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/constraint_type.dart';
import 'package:healthtracker/core/errors/domain_message.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_severity.dart';
import 'package:healthtracker/domain/profile/language.dart';
import 'package:healthtracker/domain/profile/localization_settings.dart';
import 'package:healthtracker/domain/profile/measurement_system.dart';

void main() {
  group('LocalizationSettings', () {
    for (final language in Language.values) {
      for (final measurementSystem in MeasurementSystem.values) {
        test('creates ${language.name} with ${measurementSystem.name}', () {
          final result = LocalizationSettings.create(
            language,
            measurementSystem,
          );

          expect(result.isSuccess, isTrue);
          expect(result.isFailure, isFalse);
          expect(result.errors, isEmpty);
          expect(result.value?.language, language);
          expect(result.value?.measurementSystem, measurementSystem);
        });
      }
    }

    test('returns the documented error for a missing language', () {
      final result = LocalizationSettings.create(
        null,
        MeasurementSystem.metric,
      );

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      _expectRequiredError(
        result.errors.single,
        code: 'PRO-VAL-LOC-001',
        messageKey: 'validation.localization.language.required',
        field: 'language',
      );
    });

    test('returns the documented error for a missing measurement system', () {
      final result = LocalizationSettings.create(Language.de, null);

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      _expectRequiredError(
        result.errors.single,
        code: 'PRO-VAL-LOC-003',
        messageKey: 'validation.localization.measurementSystem.required',
        field: 'measurementSystem',
      );
    });

    test('reports both missing values in validation order', () {
      final result = LocalizationSettings.create(null, null);

      expect(result.isFailure, isTrue);
      expect(result.value, isNull);
      expect(
        result.errors.map((error) => error.code.value),
        <String>['PRO-VAL-LOC-001', 'PRO-VAL-LOC-003'],
      );
      expect(
        result.errors.map((error) => error.field?.value),
        <String?>['language', 'measurementSystem'],
      );
      expect(
        result.errors.any(
          (error) =>
              error.code.value == 'PRO-VAL-LOC-002' ||
              error.code.value == 'PRO-VAL-LOC-004',
        ),
        isFalse,
      );
    });

    test('implements value equality and consistent hash codes', () {
      final first = LocalizationSettings.create(
        Language.de,
        MeasurementSystem.metric,
      ).value!;
      final equal = LocalizationSettings.create(
        Language.de,
        MeasurementSystem.metric,
      ).value!;

      expect(first, equal);
      expect(first.hashCode, equal.hashCode);
    });

    test('is unequal when language or measurement system differs', () {
      final baseline = LocalizationSettings.create(
        Language.de,
        MeasurementSystem.metric,
      ).value!;
      final otherLanguage = LocalizationSettings.create(
        Language.en,
        MeasurementSystem.metric,
      ).value!;
      final otherSystem = LocalizationSettings.create(
        Language.de,
        MeasurementSystem.imperial,
      ).value!;

      expect(baseline, isNot(otherLanguage));
      expect(baseline, isNot(otherSystem));
    });

    test('is immutable and has a meaningful string representation', () {
      final settings = LocalizationSettings.create(
        Language.en,
        MeasurementSystem.imperial,
      ).value!;

      expect(settings.language, Language.en);
      expect(settings.measurementSystem, MeasurementSystem.imperial);
      expect(
        settings.toString(),
        'LocalizationSettings('
        'language: Language.en, '
        'measurementSystem: MeasurementSystem.imperial)',
      );
    });

    test('returns validation failures without throwing exceptions', () {
      expect(() => LocalizationSettings.create(null, null), returnsNormally);
      expect(LocalizationSettings.create(null, null).isFailure, isTrue);
    });
  });
}

void _expectRequiredError(
  DomainError error, {
  required String code,
  required String messageKey,
  required String field,
}) {
  expect(error.code.value, code);
  expect(error.messageKey.value, messageKey);
  expect(error.severity, MessageSeverity.error);
  expect(error.category, MessageCategory.validation);
  expect(error.field?.value, field);
  expect(error.constraint, ConstraintType.required);
  expect(error.parameters, isEmpty);
}
