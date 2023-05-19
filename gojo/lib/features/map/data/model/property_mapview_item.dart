class PropertyMapViewItem {
  final String id;
  final String title;
  final String price;
  final String address;
  final String image;
  final double rating;
  final Location location;

  const PropertyMapViewItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.address,
      required this.image,
      required this.rating,
      required this.location});

  factory PropertyMapViewItem.fromJson(Map<String, dynamic> json) {
    return PropertyMapViewItem(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      address: json['address'],
      image: json['image'],
      rating: json['rating'],
      location: Location(
        lat: json['location']['lat'],
        lng: json['location']['lng'],
      ),
    );
  }
}

class Location {
  final double lat;
  final double lng;

  const Location({required this.lat, required this.lng});
}
