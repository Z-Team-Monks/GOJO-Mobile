import 'package:gojo/features/home/data_layer/model/property_item.dart';

// Represents data to be displayed in the media item widget of profile page.
class ProfileMediaItem {
  final int id;
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
