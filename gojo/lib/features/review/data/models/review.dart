import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String? userId;
  // final User? user;
  final String message;
  final num? rating;

  const ReviewModel({
    this.userId,
    required this.message,
    this.rating,
    // this.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      message: json["message"],
      rating: json["rating"],
      // user: User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "id": this.userId,
      "message": message,
      "rating": rating,
    };
  }

  @override
  List<Object?> get props => [userId, message, rating];
}
