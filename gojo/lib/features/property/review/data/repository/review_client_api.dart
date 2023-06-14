import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../models/review.dart';

/// An abstract class defining the API contract for reviewing property
abstract class ReviewClientAPI {
  Future<Review> createReview({
    required Review review,
    required int propertyId,
  });
}

class ReviewClientImpl extends BaseApiClient implements ReviewClientAPI {
  @override
  Future<Review> createReview({
    required Review review,
    required int propertyId,
  }) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final createReviewResponse = await post(
      'properties/$propertyId/review/',
      review.toJson(),
      token: user.token,
    );
    return Review.fromJson(createReviewResponse.data);
  }
}
