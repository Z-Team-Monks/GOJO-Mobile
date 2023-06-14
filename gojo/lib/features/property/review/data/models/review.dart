import 'package:equatable/equatable.dart';

import '../../../../../Gojo-Mobile-Shared/core/model/user.dart';

class Review extends Equatable {
  final User? user;
  final String comment;
  final String? date;
  final num rating;

  const Review({
    this.user,
    required this.comment,
    required this.rating,
    this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json["comment"],
      rating: json["rating"],
      user: User.fromJson(json["user"]),
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "comment": comment,
      "rating": rating,
    };
  }

  @override
  List<Object?> get props => [
        user,
        comment,
        rating,
      ];
}
