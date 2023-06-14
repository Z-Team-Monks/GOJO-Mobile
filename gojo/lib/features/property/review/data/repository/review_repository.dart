import '../models/review.dart';
import 'review_client_api.dart';

abstract class ReviewRepositoryAPI {
  Future<Review> createReview(
      {required Review review, required int propertyId});
}

class ReviewRepositoryImpl implements ReviewRepositoryAPI {
  final ReviewClientAPI reviewClient;

  ReviewRepositoryImpl(this.reviewClient);

  @override
  Future<Review> createReview({
    required Review review,
    required int propertyId,
  }) async {
    final newReview =
        await reviewClient.createReview(review: review, propertyId: propertyId);
    return newReview;
  }
}

/// A Fake implementation of the [ReviewRepositoryAPI] contract.
class ReviewRepositoryFake implements ReviewRepositoryAPI {
  @override
  Future<Review> createReview({
    required Review review,
    required int propertyId,
  }) {
    const review = Review(
      rating: 4.5,
      comment: "This is a comment",
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () => review,
    );
  }
}
