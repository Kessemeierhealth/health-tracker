import '../../core/errors/constraint_type.dart';
import '../../core/errors/domain_message.dart';
import '../../core/errors/domain_result.dart';
import '../../core/errors/error_code.dart';
import '../../core/errors/field_reference.dart';
import '../../core/errors/message_category.dart';
import '../../core/errors/message_key.dart';
import '../../core/errors/message_severity.dart';
import 'text_scale_preference.dart';
import 'theme_preference.dart';

final class AppearanceSettings {
  const AppearanceSettings._({
    required this.themePreference,
    required this.textScalePreference,
  });

  final ThemePreference themePreference;
  final TextScalePreference? textScalePreference;

  static DomainResult<AppearanceSettings> create(
    ThemePreference? themePreference,
    TextScalePreference? textScalePreference,
  ) {
    if (themePreference == null) {
      return DomainResult<AppearanceSettings>.fromError(
        DomainError(
          code: ErrorCode.create('PRO-VAL-APP-001')!,
          messageKey: MessageKey.create(
            'validation.appearanceSettings.themePreference.required',
          )!,
          severity: MessageSeverity.error,
          category: MessageCategory.validation,
          parameters: const {},
          field: FieldReference.create('themePreference'),
          constraint: ConstraintType.required,
        ),
      );
    }

    return DomainResult<AppearanceSettings>.success(
      AppearanceSettings._(
        themePreference: themePreference,
        textScalePreference: textScalePreference,
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppearanceSettings &&
          themePreference == other.themePreference &&
          textScalePreference == other.textScalePreference;

  @override
  int get hashCode => Object.hash(themePreference, textScalePreference);

  @override
  String toString() => 'AppearanceSettings('
      'themePreference: $themePreference, '
      'textScalePreference: $textScalePreference)';
}
