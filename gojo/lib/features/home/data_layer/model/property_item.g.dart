// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Facility _$FacilityFromJson(Map<String, dynamic> json) => Facility(
      name: json['name'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$FacilityToJson(Facility instance) => <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
    };

PropertyItem _$PropertyItemFromJson(Map<String, dynamic> json) => PropertyItem(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      category: json['category'] as String,
      facilities: (json['facilities'] as List<dynamic>)
          .map((e) => Facility.fromJson(e as Map<String, dynamic>))
          .toList(),
      rent: json['rent'] as int,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$PropertyItemToJson(PropertyItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'category': instance.category,
      'facilities': instance.facilities,
      'rent': instance.rent,
      'rating': instance.rating,
    };

PropertyItemList _$PropertyItemListFromJson(Map<String, dynamic> json) =>
    PropertyItemList(
      (json['items'] as List<dynamic>)
          .map((e) => PropertyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropertyItemListToJson(PropertyItemList instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
