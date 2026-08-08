import '../../core/errors/domain_result.dart';

final class DefaultProfileFlag {
  const DefaultProfileFlag._(this.isDefault);

  final bool isDefault;

  static DomainResult<DefaultProfileFlag> createEnabled() =>
      DomainResult<DefaultProfileFlag>.success(
        const DefaultProfileFlag._(true),
      );

  static DomainResult<DefaultProfileFlag> createDisabled() =>
      DomainResult<DefaultProfileFlag>.success(
        const DefaultProfileFlag._(false),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefaultProfileFlag && isDefault == other.isDefault;

  @override
  int get hashCode => isDefault.hashCode;

  @override
  String toString() => isDefault ? 'default' : 'notDefault';
}
