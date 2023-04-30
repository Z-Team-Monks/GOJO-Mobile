import 'package:gojo/features/home/data_layer/model/property_item.dart';

class ProfileMediaItem {
  final String id;
  final String title;
  final String thumbnailUrl;

  ProfileMediaItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory ProfileMediaItem.fromPropertyItem(PropertyItem propertyItem) {
    return ProfileMediaItem(
      id: propertyItem.id,
      title: propertyItem.title,
      thumbnailUrl: propertyItem.thumbnailUrl,
    );
  }
}
