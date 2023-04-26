import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import '../models/review.dart';

/// An abstract class defining the API contract for reviewing property
abstract class ReviewClientAPI {
  Future<ReviewModel> createReview(ReviewModel review);
}

class ReviewClientImpl extends BaseApiClient implements ReviewClientAPI {
  @override
  Future<ReviewModel> createReview(ReviewModel review) async {
    final createReviewResponse =
        await post('/properties/review', review.toJson());
    return ReviewModel.fromJson(createReviewResponse.data);
  }
}
