class Facility {
  final String name;
  final int id;
  final int? amount;

  Facility({
    required this.name,
    required this.id,
    this.amount,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(name: json['name'], id: json['id'], amount: json['amount']);
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
    int? amount,
  }) {
    return Facility(
      name: name ?? this.name,
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }
}
