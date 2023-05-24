import 'package:json_annotation/json_annotation.dart';

part 'property_item.g.dart';

@JsonSerializable()
class Facility {
  final String name;
  final int count;

  Facility({required this.name, required this.count});

  factory Facility.fromJson(Map<String, dynamic> json) =>
      _$FacilityFromJson(json);
}

@JsonSerializable()
class PropertyItem {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String category;
  final List<Facility> facilities;
  final int rent;
  final double rating;

  const PropertyItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.category,
    required this.facilities,
    required this.rent,
    required this.rating,
  });

  factory PropertyItem.fromJson(Map<String, dynamic> json) =>
      _$PropertyItemFromJson(json);
}

@JsonSerializable()
class PropertyItemList {
  final List<PropertyItem> items;

  PropertyItemList(this.items);

  factory PropertyItemList.fromJson(Map<String, dynamic> json) =>
      _$PropertyItemListFromJson(json);
}
