import 'package:flutter/material.dart';

@immutable
class PropertyItem {
  final String id;
  final String title;
  final String thumbnailUrl;

  const PropertyItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory PropertyItem.fromJson(Map<String, dynamic> json) {
    return PropertyItem(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class PropertyItemList {
  final List<PropertyItem> items;

  PropertyItemList(this.items);

  factory PropertyItemList.fromJson(List<dynamic> json) {
    return PropertyItemList(
      json.map((e) => PropertyItem.fromJson(e)).toList(),
    );
  }
}
