import '../../../../../Gojo-Mobile-Shared/core/model/user.dart';
import '../../../../home/data_layer/model/property_item.dart';
import '../../../../review/data/models/review.dart';
import 'visiting_hours.dart';

class Property {
  final int id;
  final String title;
  final User owner;
  final List<String> images;
  final String virtualTourId;
  final String address;
  final double rating;
  final String price;
  final String description;
  final List<Facility> facilities;
  final List<Review> reviews;
  final String category;
  final VisitingHours? visitingHours;
  final bool isFavorite;

  const Property({
    required this.id,
    required this.owner,
    required this.virtualTourId,
    required this.title,
    required this.images,
    required this.price,
    required this.address,
    required this.reviews,
    required this.rating,
    required this.facilities,
    required this.description,
    required this.category,
    this.visitingHours,
    required this.isFavorite,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      owner: User.fromJson(json['owner']),
      virtualTourId: json['virtualTourId'] ?? "",
      title: json['title'],
      images: List<String>.from(json['images']),
      price: json['amount'],
      address: json['location']['street'] ?? "",
      reviews: ((json['reviews'] as List))
          .map(
            (li) => Review.fromJson(li),
          )
          .toList(),
      rating: json['rating'],
      facilities: ((json['facilities'] as List))
          .map((li) => Facility.fromJson(li))
          .toList(),
      description: json['description'],
      category: json['category'],
      visitingHours: VisitingHours.fromJson(json['visiting_hours']),
      isFavorite: json['favorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "owner": owner,
      "virtualTourId": virtualTourId,
      "title": title,
      "images": images,
      "price": price,
      "address": address,
      "reviews": reviews,
      "rating": rating,
      "facilities": facilities,
      "description": description,
      "category": category,
    };
  }
}
