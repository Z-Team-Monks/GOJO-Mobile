import 'package:gojo/core/model/user.dart';
import 'package:gojo/features/review/data/models/review.dart';

import '../../../home/data_layer/model/property_item.dart';
import '../model/property.dart';
import 'detail_client_api.dart';

/// An abstract class defining the interface for a property detail repository API.
abstract class PropertyDetailRepositoryAPI {
  /// Returns a `Future` that resolves to a property item.
  Future<Property> fetchProperty(String propertyId);
}

class PropertyDetailRepositoryImpl implements PropertyDetailRepositoryAPI {
  final PropertyDetailClientAPI propertyDetailClient;

  PropertyDetailRepositoryImpl(this.propertyDetailClient);

  @override
  Future<Property> fetchProperty(String propertyId) async {
    return await propertyDetailClient.fetchProperty(propertyId);
  }
}

/// A Fake implementation of the [PropertyDetailRepositoryAPI] contract.
class PropertyDetailRepositoryFake implements PropertyDetailRepositoryAPI {
  @override
  Future<Property> fetchProperty(String propertyId) {
    final property = Property(
      id: "fjkldsaj2",
      owner: const User(
        id: "askdfj",
        firstName: "Konda",
        lastName: "Nok",
        phoneNumber: "0949024607",
        profilePicture: "",
      ),
      address: "Jl. Kemang Raya No. 12",
      title: "Villa, Kemah Tinggi",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, diam id aliquam ultrices, nisl nunc aliquet enim, vitae aliquam nisl nunc eget nunc. Sed euismod, diam id aliquam ultrices, nisl nunc aliquet enim, vitae aliquam nisl nunc eget nunc.",
      category: "Villa",
      facilities: [
        Facility(name: "Kitchen", count: 1),
        Facility(name: "Bedroom", count: 2),
      ],
      images: const [
        "https://images.unsplash.com/photo-1611095787870-4b7b7b7b7b7b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhY2glMjBwcm9wZXJ0eXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "https://images.unsplash.com/photo-1611095787870-4b7b7b7b7b7b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhY2glMjBwcm9wZXJ0eXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "https://images.unsplash.com/photo-1611095787870-4b7b7b7b7b7b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhY2glMjBwcm9wZXJ0eXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
      ],
      price: 1000000,
      rating: 4.5,
      area: 100,
      virtualTourId: "skjdflkj",
      reviews: const [
        Review(
          message:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
        Review(
          message:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
        Review(
          message:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
      ],
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () => property,
    );
  }
}
