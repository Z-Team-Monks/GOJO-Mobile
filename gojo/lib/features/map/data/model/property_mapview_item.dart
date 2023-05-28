class PropertyMapViewItem {
  final int id;
  final String title;
  final String price;
  final String image;
  final double rating;
  final Location location;

  const PropertyMapViewItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.image,
      required this.rating,
      required this.location});

  factory PropertyMapViewItem.fromJson(Map<String, dynamic> json) {
    return PropertyMapViewItem(
      id: json['id'],
      title: json['title'],
      price: json['amount'],
      image: json['thumbnail_url'],
      rating: json['rating'],
      location: Location(
        lat: json['location']['latitude'],
        lng: json['location']['longitude'],
      ),
    );
  }
}

class Location {
  final double lat;
  final double lng;

  const Location({required this.lat, required this.lng});
}
