import 'package:equatable/equatable.dart';

import '../../../../core/model/user.dart';

class Review extends Equatable {
  final User user;
  final String comment;
  final num rating;

  const Review({
    required this.user,
    required this.comment,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json["comment"],
      rating: json["rating"],
      user: User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user,
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
