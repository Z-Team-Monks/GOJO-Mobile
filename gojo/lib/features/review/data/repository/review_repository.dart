import 'dart:math';

import 'package:gojo/features/review/data/models/review.dart';

import 'review_client_api.dart';

/// An abstract class defining the interface for a review repository API.
abstract class ReviewRepositoryAPI {
  /// Returns a `Future` that resolves to a list of review property items.
  Future<ReviewModel> createReview(ReviewModel review);
}

class ReviewRepositoryImpl implements ReviewRepositoryAPI {
  final ReviewClientAPI reviewClient;

  ReviewRepositoryImpl(this.reviewClient);

  @override
  Future<ReviewModel> createReview(ReviewModel review) async {
    final newReview = await reviewClient.createReview(review);
    return newReview;
  }
}

/// A Fake implementation of the [ReviewRepositoryAPI] contract.
class ReviewRepositoryFake implements ReviewRepositoryAPI {
  @override
  Future<ReviewModel> createReview(ReviewModel review) {
    final random = Random();
    var list = [201, 409, 404, 500];
    switch (list[random.nextInt(list.length)]) {
      case 409:
        throw ("Review already exists");
      case 404:
        throw ("User doesn't exist");
      case 500:
        throw ("Server Error Try Again Later");
      default:
        return Future.value(review);
    }
  }
}
