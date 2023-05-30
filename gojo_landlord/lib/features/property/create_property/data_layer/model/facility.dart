import '../../../../../Gojo-Mobile-Shared/constants/facilities.dart';

class Facility {
  final String name;
  final int id;
  final double? amount;

  Facility({
    required this.name,
    required this.id,
    this.amount,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      name: json['name'] as String,
      id: json['id'] as int,
      amount: json['amount'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
    };
  }

  Facility copyWith({
    String? name,
    int? id,
    double? amount,
  }) {
    return Facility(
      name: name ?? this.name,
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }
}
