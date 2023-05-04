import 'package:equatable/equatable.dart';

import '../../../../core/model/user.dart';
import '../../../home/data_layer/model/property_item.dart';
import '../../../review/data/models/review.dart';

class Property extends Equatable {
  final String id;
  final String title;
  final User owner;
  final List<String> images;
  final String virtualTourId;
  final String address;
  final num rating;
  final num price;
  final String description;
  final num area;
  final List<Facility> facilities;
  final List<Review> reviews;
  final String category;

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
    required this.area,
    required this.facilities,
    required this.description,
    required this.category,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      owner: User.fromJson(json['owner']),
      virtualTourId: json['virtualTourId'],
      title: json['title'],
      images: json['images'],
      price: json['price'],
      address: json['address'],
      reviews: json['reviews'],
      rating: json['rating'],
      area: json['area'],
      facilities: ((json['facilities'] as List))
          .map((li) => Facility.fromJson(li))
          .toList(),
      description: json['description'],
      category: json['category'],
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
      "area": area,
      "facilities": facilities,
      "description": description,
      "category": category,
    };
  }

  @override
  List<Object> get props => [
        id,
        owner,
        virtualTourId,
        title,
        images,
        price,
        address,
        reviews,
        rating,
        area,
        facilities,
        description,
        category,
      ];
}
