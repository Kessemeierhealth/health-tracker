import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/core/errors/domain_message.dart';
import 'package:healthtracker/core/errors/domain_result.dart';
import 'package:healthtracker/core/errors/error_code.dart';
import 'package:healthtracker/core/errors/message_category.dart';
import 'package:healthtracker/core/errors/message_key.dart';
import 'package:healthtracker/core/errors/message_severity.dart';

void main() {
  final code = ErrorCode.create('PRO-VAL-HEIGHT-003')!;
  final key = MessageKey.create('validation.profile.height.minimum')!;
  final error = DomainError(
    code: code,
    messageKey: key,
    severity: MessageSeverity.error,
    category: MessageCategory.validation,
    parameters: const {},
  );
  final warning = DomainWarning(
    code: code,
    messageKey: key,
    severity: MessageSeverity.warning,
    category: MessageCategory.validation,
    parameters: const {},
  );
  final information = DomainInformation(
    code: code,
    messageKey: key,
    severity: MessageSeverity.information,
    category: MessageCategory.validation,
    parameters: const {},
  );

  test('success contains a value and optional messages', () {
    final result = DomainResult<int>.success(
      20,
      warnings: <DomainWarning>[warning],
      information: <DomainInformation>[information],
    );

    expect(result.value, 20);
    expect(result.isSuccess, isTrue);
    expect(result.isFailure, isFalse);
    expect(result.errors, isEmpty);
    expect(result.warnings, <DomainWarning>[warning]);
    expect(result.information, <DomainInformation>[information]);
    expect(result.hasValue, isTrue);
    expect(result.hasErrors, isFalse);
    expect(result.hasWarnings, isTrue);
    expect(result.hasInformation, isTrue);
    expect(result.messageCount, 2);
  });

  test('successWithoutValue has no value or errors', () {
    final result = DomainResult.successWithoutValue();

    expect(result.isSuccess, isTrue);
    expect(result.hasValue, isFalse);
    expect(result.errors, isEmpty);
  });

  test('failure has no value and requires at least one error', () {
    final result = DomainResult<int>.failure(
      <DomainError>[error],
      warnings: <DomainWarning>[warning],
      information: <DomainInformation>[information],
    );

    expect(result.isFailure, isTrue);
    expect(result.isSuccess, isFalse);
    expect(result.value, isNull);
    expect(result.errors, <DomainError>[error]);
    expect(result.messageCount, 3);
    expect(
      () => DomainResult<int>.failure(const <DomainError>[]),
      throwsArgumentError,
    );
  });

  test('fromError creates failure with exactly one error', () {
    final result = DomainResult<int>.fromError(error);

    expect(result.isFailure, isTrue);
    expect(result.errors, <DomainError>[error]);
  });

  test('fromWarning creates success with value and one warning', () {
    final result = DomainResult<int>.fromWarning(20, warning);

    expect(result.isSuccess, isTrue);
    expect(result.value, 20);
    expect(result.errors, isEmpty);
    expect(result.warnings, <DomainWarning>[warning]);
  });

  test('informationOnly creates valueless success with one information', () {
    final result = DomainResult.informationOnly(information);

    expect(result.isSuccess, isTrue);
    expect(result.hasValue, isFalse);
    expect(result.errors, isEmpty);
    expect(result.information, <DomainInformation>[information]);
  });

  test('message lists are defensive copies and immutable', () {
    final warnings = <DomainWarning>[warning];
    final result = DomainResult<int>.success(20, warnings: warnings);
    warnings.clear();

    expect(result.warnings, <DomainWarning>[warning]);
    expect(() => result.warnings.clear(), throwsUnsupportedError);
    expect(() => result.errors.add(error), throwsUnsupportedError);
    expect(() => result.information.add(information), throwsUnsupportedError);
  });

  test('status invariants always agree with errors', () {
    final success = DomainResult<int>.success(20);
    final failure = DomainResult<int>.fromError(error);

    for (final result in <DomainResult<int>>[success, failure]) {
      expect(result.isSuccess, isNot(result.isFailure));
      expect(result.isFailure, result.errors.isNotEmpty);
    }
  });
}
