import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import '../models/review.dart';

/// An abstract class defining the API contract for reviewing property
abstract class ReviewClientAPI {
  Future<Review> createReview(Review review);
}

class ReviewClientImpl extends BaseApiClient implements ReviewClientAPI {
  @override
  Future<Review> createReview(Review review) async {
    final createReviewResponse =
        await post('/properties/review', review.toJson());
    return Review.fromJson(createReviewResponse.data);
  }
}
