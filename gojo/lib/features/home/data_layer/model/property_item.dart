class Facility {
  final String name;
  final double count;

  Facility({required this.name, required this.count});

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      name: json['name'],
      count: json['count'],
    );
  }
}

class PropertyItem {
  final int id;
  final String title;
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
  });

  factory PropertyItem.fromJson(Map<String, dynamic> json) {
    return PropertyItem(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnail_url'],
      category: json['category'],
      facilities: (json['facilities'] as List<dynamic>)
          .map((f) => Facility.fromJson(f))
          .toList(),
      rent: json['amount'],
      rating: json['rating'],
    );
  }
}

class PropertyItemList {
  final List<PropertyItem> items;

  PropertyItemList(this.items);

  factory PropertyItemList.fromJson(Map<String, dynamic> json) =>
      PropertyItemList((json['results'] as List<dynamic>)
          .map((f) => PropertyItem.fromJson(f))
          .toList());
}
