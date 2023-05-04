import '../../../../core/model/user.dart';
import '../models/review.dart';
import 'review_client_api.dart';

/// An abstract class defining the interface for a review repository API.
abstract class ReviewRepositoryAPI {
  /// Returns a `Future` that resolves to a list of review property items.
  Future<Review> createReview(Review review);
}

class ReviewRepositoryImpl implements ReviewRepositoryAPI {
  final ReviewClientAPI reviewClient;

  ReviewRepositoryImpl(this.reviewClient);

  @override
  Future<Review> createReview(Review review) async {
    final newReview = await reviewClient.createReview(review);
    return newReview;
  }
}

/// A Fake implementation of the [ReviewRepositoryAPI] contract.
class ReviewRepositoryFake implements ReviewRepositoryAPI {
  @override
  Future<Review> createReview(Review review) {
    const user = User(
      id: "id",
      firstName: "Kebede",
      lastName: "Alemayehu",
      phoneNumber: "0949024607",
      profilePicture: "",
    );
    const review = Review(
      user: user,
      rating: 4.5,
      comment: "This is a comment",
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () => review,
    );
  }
}
