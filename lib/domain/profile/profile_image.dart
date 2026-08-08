import '../../core/errors/domain_result.dart';
import 'image_checksum.dart';
import 'image_dimensions.dart';
import 'image_reference.dart';
import 'media_type.dart';

final class ProfileImage {
  const ProfileImage._({
    required this.reference,
    required this.mediaType,
    required this.dimensions,
    required this.checksum,
  });

  final ImageReference reference;
  final MediaType mediaType;
  final ImageDimensions dimensions;
  final ImageChecksum? checksum;

  static DomainResult<ProfileImage> create(
    ImageReference reference,
    MediaType mediaType,
    ImageDimensions dimensions,
    ImageChecksum? checksum,
  ) =>
      DomainResult<ProfileImage>.success(
        ProfileImage._(
          reference: reference,
          mediaType: mediaType,
          dimensions: dimensions,
          checksum: checksum,
        ),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileImage &&
          reference == other.reference &&
          mediaType == other.mediaType &&
          dimensions == other.dimensions &&
          checksum == other.checksum;

  @override
  int get hashCode => Object.hash(reference, mediaType, dimensions, checksum);
}
