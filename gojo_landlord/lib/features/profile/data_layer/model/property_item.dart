import 'package:gojo_landlord/features/property/create_property/data_layer/model/address.dart';
import '../../../property/create_property/data_layer/model/facility.dart';

class PropertyItem {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String category;
  final String? contractUrl;
  final List<Facility>? facilities;
  final Address? address;
  final String? rent;

  const PropertyItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.category,
    this.contractUrl,
    this.facilities,
    this.address,
    this.rent,
  });

  factory PropertyItem.fromJson(Map<String, dynamic> json) {
    return PropertyItem(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      category: json['category'] as String,
      contractUrl: json['contract_url'] as String?,
      facilities: (json['facilities'] as List<dynamic>)
          .map((item) => Facility.fromJson(item as Map<String, dynamic>))
          .toList(),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      rent: json['amount'] as String?,
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
