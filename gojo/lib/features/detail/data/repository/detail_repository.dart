import 'package:gojo/features/appointment/schedule_appointment/data/model/availablity.dart';

import '../../../../core/model/user.dart';
import '../../../home/data_layer/model/property_item.dart';
import '../../../review/data/models/review.dart';
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
    const user = User(
      id: 1,
      firstName: "Kebede",
      lastName: "Alemayehu",
      phoneNumber: "0949024607",
      profilePicture: "",
    );
    final property = Property(
      id: propertyId,
      owner: user,
      address: "Jl. Kemang Raya No. 12",
      title: "Kemah Tinggi",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, diam id aliquam ultrices, nisl nunc aliquet enim, vitae aliquam nisl nunc eget nunc. Sed euismod, diam id aliquam ultrices, nisl nunc aliquet enim, vitae aliquam nisl nunc eget nunc.",
      category: "Villa",
      facilities: [
        Facility(name: "Kitchen", count: 1),
        Facility(name: "Bedroom", count: 2),
      ],
      images: const [
        "",
      ],
      price: 10000,
      rating: 4.5,
      area: 100,
      virtualTourId: "skjdflkj",
      reviews: const [
        Review(
          user: user,
          rating: 2.5,
          comment:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
        Review(
          user: user,
          rating: 3.9,
          comment:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
        Review(
          user: user,
          rating: 4.0,
          comment:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
      ],
      availability: AvailabilityModel(
        days: [1, 2, 3, 4, 5],
        timeSlots: {
          "1": ["10:00 AM", "11:00 AM", "12:00 AM"],
          "2": ["10:00 AM", "11:00 AM", "12:00 AM"],
          "3": ["9:00 AM", "11:00 AM", "12:00 AM"],
        },
      ),
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () => property,
    );
  }
}
