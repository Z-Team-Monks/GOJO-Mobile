class Address {
  final double latitude;
  final double longitude;
  final String street;

  const Address({
    required this.latitude,
    required this.longitude,
    required this.street,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'street': street,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      street: json['street'],
    );
  }
}
