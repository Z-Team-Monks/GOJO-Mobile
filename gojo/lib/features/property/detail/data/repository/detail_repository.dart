import '../../../../../Gojo-Mobile-Shared/core/model/user.dart';
import '../../../../home/data_layer/model/property_item.dart';
import '../../../../review/data/models/review.dart';
import '../model/apply_for_rent_model.dart';
import '../model/appointment.dart';
import '../model/property.dart';
import '../model/visiting_hours.dart';
import 'detail_client_api.dart';

abstract class PropertyDetailRepository {
  Future<Property> fetchProperty(int propertyId);
  Future<void> scheduleAppointment(AppointmentModel appointment);
  Future<void> applyForRent(ApplyForRentModel applyForRentModel);
  Future<void> favorProperty(int propertyId);
}

class PropertyDetailRepositoryImpl implements PropertyDetailRepository {
  final PropertyDetailClientAPI propertyDetailClient;

  PropertyDetailRepositoryImpl(this.propertyDetailClient);

  @override
  Future<Property> fetchProperty(int propertyId) async {
    return await propertyDetailClient.fetchProperty(propertyId);
  }

  @override
  Future<void> scheduleAppointment(AppointmentModel appointment) async {
    await propertyDetailClient.scheduleAppointment(appointment);
  }

  @override
  Future<void> applyForRent(ApplyForRentModel applyForRentModel) async {
    await propertyDetailClient.applyForRent(applyForRentModel);
  }

  @override
  Future<void> favorProperty(int propertyId) async {
    await propertyDetailClient.favorProperty(propertyId);
  }
}

class PropertyDetailRepositoryFake implements PropertyDetailRepository {
  @override
  Future<Property> fetchProperty(int propertyId) {
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
        Facility(name: "Kitchen", amount: 1),
        Facility(name: "Bedroom", amount: 2),
      ],
      images: const [
        "https://media.istockphoto.com/id/1272128530/photo/home-with-blue-siding-and-stone-fa%C3%A7ade-on-base-of-home.jpg?s=612x612&w=0&k=20&c=2nv-93cqakGCvVQ1CMavx_o14HSBruCDwKdv3Llh5Ek=",
        "https://www.home-designing.com/wp-content/uploads/2019/10/Mini-Sofa-Bed-Grey-Velvet-Tufted-Cushions-With-White-Trim-Foldaway-Bed-600x600.jpg",
        "https://images.unsplash.com/photo-1540518614846-7eded433c457?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmVkcm9vbXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
      ],
      price: "10000",
      rating: 4.5,
      virtualTourId: "skjdflkj",
      reviews: const [
        Review(
          user: user,
          date: "Mar 2, 2023",
          rating: 2.5,
          comment:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
        Review(
          date: "Mar 2, 2023",
          user: user,
          rating: 3.9,
          comment:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
        Review(
          user: user,
          date: "Mar 2, 2023",
          rating: 4.0,
          comment:
              "The property exceeded my expectations with modern amenities, cozy atmosphere, and perfect location.",
        ),
      ],
      visitingHours: VisitingHours(visitingHours: [
        VisitingHourModel(
          from: "2:00 PM",
          to: "6:00 PM",
          day: "Monday",
        ),
        VisitingHourModel(
          from: "3:00 PM",
          to: "5:00 PM",
          day: "Tuesday",
        ),
        VisitingHourModel(
          from: "2:00 AM",
          to: "6:00 AM",
          day: "Wednesday",
        ),
      ]),
      isFavorite: false,
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () => property,
    );
  }

  @override
  Future<void> applyForRent(ApplyForRentModel applyForRentModel) async {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> scheduleAppointment(AppointmentModel appointment) async {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> favorProperty(int propertyId) async {
    return Future.delayed(const Duration(seconds: 1));
  }
}
