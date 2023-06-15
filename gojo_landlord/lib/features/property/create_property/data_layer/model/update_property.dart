import 'address.dart';
import 'category.dart';
import 'facility.dart';

class UpdateProperty {
  final String title;
  final Address address;
  final String description;
  final String rent;
  final Category category;
  final int id;
  final List<Facility> facilities;

  UpdateProperty({
    required this.title,
    required this.address,
    required this.description,
    required this.rent,
    required this.category,
    required this.id,
    required this.facilities,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "address": address.toJson(),
      "description": description,
      "amount": rent,
      'facilities': facilities.map((f) => f.toJson()).toList(),
      "category": category.toJson(),
      "id": id,
    };
  }
}
