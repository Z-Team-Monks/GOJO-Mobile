import 'package:json_annotation/json_annotation.dart';

class PropertyItem {
  final int id;
  final String title;
  final String desciption;
  final String thumbnailUrl;
  final String category;

  const PropertyItem({
    required this.id,
    required this.title,
    required this.desciption,
    required this.thumbnailUrl,
    required this.category,
  });

  factory PropertyItem.fromJson(Map<String, dynamic> json) {
    return PropertyItem(
      id: json['id'] as int,
      title: json['title'] as String,
      desciption: json['description'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      category: json['category'] as String,
    );
  }
}

class PropertyItemList {
  final List<PropertyItem> items;

  PropertyItemList(this.items);

  factory PropertyItemList.fromJson(Map<String, dynamic> json) {
    return PropertyItemList(
      (json['results'] as List<dynamic>)
          .map((item) => PropertyItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
