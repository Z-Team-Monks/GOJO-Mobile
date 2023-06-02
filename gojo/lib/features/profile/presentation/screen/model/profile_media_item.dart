import '../../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';
import '../../../../home/data_layer/model/property_item.dart';

extension PropertyMediaItemExtension on PropertyMediaItem {
  static PropertyMediaItem fromPropertyItem(PropertyItem propertyItem) {
    return PropertyMediaItem(
      title: propertyItem.title,
      thumbnailUrl: propertyItem.thumbnailUrl,
      subtitle: propertyItem.category,
      content: propertyItem.description ?? "",
      onPressed: () {},
    );
  }
}
