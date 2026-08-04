import 'domain_message.dart';

final class DomainResult<T> {
  DomainResult._({
    required this.value,
    required List<DomainError> errors,
    required List<DomainWarning> warnings,
    required List<DomainInformation> information,
  })  : errors = List<DomainError>.unmodifiable(errors),
        warnings = List<DomainWarning>.unmodifiable(warnings),
        information = List<DomainInformation>.unmodifiable(information);

  factory DomainResult.success(
    T value, {
    List<DomainWarning> warnings = const [],
    List<DomainInformation> information = const [],
  }) =>
      DomainResult._(
        value: value,
        errors: const [],
        warnings: warnings,
        information: information,
      );

  factory DomainResult.failure(
    List<DomainError> errors, {
    List<DomainWarning> warnings = const [],
    List<DomainInformation> information = const [],
  }) {
    if (errors.isEmpty) {
      throw ArgumentError.value(errors, 'errors');
    }
    return DomainResult._(
      value: null,
      errors: errors,
      warnings: warnings,
      information: information,
    );
  }

  factory DomainResult.fromError(DomainError error) =>
      DomainResult.failure(<DomainError>[error]);

  factory DomainResult.fromWarning(T value, DomainWarning warning) =>
      DomainResult.success(value, warnings: <DomainWarning>[warning]);

  final T? value;
  final List<DomainError> errors;
  final List<DomainWarning> warnings;
  final List<DomainInformation> information;

  bool get isSuccess => errors.isEmpty;
  bool get isFailure => !isSuccess;
  bool get hasValue => value != null;
  bool get hasErrors => errors.isNotEmpty;
  bool get hasWarnings => warnings.isNotEmpty;
  bool get hasInformation => information.isNotEmpty;
  int get messageCount => errors.length + warnings.length + information.length;

  static DomainResult<void> successWithoutValue({
    List<DomainWarning> warnings = const [],
    List<DomainInformation> information = const [],
  }) =>
      DomainResult<void>._(
        value: null,
        errors: const [],
        warnings: warnings,
        information: information,
      );

  static DomainResult<void> informationOnly(
    DomainInformation information,
  ) =>
      DomainResult.successWithoutValue(
        information: <DomainInformation>[information],
      );
}
