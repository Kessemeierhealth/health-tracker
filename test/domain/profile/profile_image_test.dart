import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/domain/profile/checksum_algorithm.dart';
import 'package:healthtracker/domain/profile/image_checksum.dart';
import 'package:healthtracker/domain/profile/image_dimensions.dart';
import 'package:healthtracker/domain/profile/image_reference.dart';
import 'package:healthtracker/domain/profile/media_type.dart';
import 'package:healthtracker/domain/profile/profile_image.dart';

void main() {
  const referenceValue = 'img_0123456789abcdefghijklmnop';
  const checksumValue =
      'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';

  ProfileImage createImage({ImageChecksum? checksum}) => ProfileImage.create(
        ImageReference.create(referenceValue).value!,
        MediaType.jpeg,
        ImageDimensions.create(1024, 768).value!,
        checksum,
      ).value!;

  group('ProfileImage', () {
    test('creates a complete immutable image without a checksum', () {
      final result = ProfileImage.create(
        ImageReference.create(referenceValue).value!,
        MediaType.png,
        ImageDimensions.create(800, 600).value!,
        null,
      );

      expect(result.isSuccess, isTrue);
      expect(result.errors, isEmpty);
      expect(result.value!.reference.value, referenceValue);
      expect(result.value!.mediaType, MediaType.png);
      expect(result.value!.dimensions.width, 800);
      expect(result.value!.checksum, isNull);
    });

    test('creates a complete immutable image with a checksum', () {
      final checksum = ImageChecksum.create(
        ChecksumAlgorithm.sha256,
        checksumValue,
      ).value!;
      final image = createImage(checksum: checksum);

      expect(image.checksum, checksum);
    });

    test('uses complete value equality and a consistent hashCode', () {
      final checksum = ImageChecksum.create(
        ChecksumAlgorithm.sha256,
        checksumValue,
      ).value!;
      final first = createImage(checksum: checksum);
      final same = createImage(
        checksum: ImageChecksum.create(
          ChecksumAlgorithm.sha256,
          ' $checksumValue ',
        ).value!,
      );
      final withoutChecksum = createImage();

      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first, isNot(withoutChecksum));
    });
  });
}
