class Facility {
  final String name;
  final int? amount;
  final int id;

  Facility({required this.name, required this.id, this.amount});

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'] as int,
      name: json['name'] as String,
      amount: (json['amount'] as double?)?.toInt(),
    );
  }
}

class Category {
  final String name;
  final int id;

  Category({required this.name, required this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String,
      id: json['id'] as int,
    );
  }
}

class PropertyItem {
  final int id;
  final String title;
  final String? description;
  final String thumbnailUrl;
  final String category;
  final List<Facility> facilities;
  final String rent;
  final double rating;

  const PropertyItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.category,
    required this.facilities,
    required this.rent,
    required this.rating,
    this.description,
  });

  factory PropertyItem.fromJson(Map<String, dynamic> json) {
    return PropertyItem(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      category: json['category'] as String,
      facilities: (json['facilities'] as List<dynamic>)
          .map((item) => Facility.fromJson(item as Map<String, dynamic>))
          .toList(),
      rent: json['amount'] as String,
      rating: json['rating'] as double,
      description: json['description'] as String?,
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
