import 'package:get_it/get_it.dart';
import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import 'package:gojo/features/applications/data_layer/model/application.dart';

import '../../../../core/repository/user_repository.dart';

abstract class ApplicationsClientAPI {
  Future<List<Application>> getPendingApplications();

  Future<List<Application>> getApprovedApplications();

  Future<List<Application>> getRejectedApplications();

  Future<void> withdrawPendingApplication(int pendingApplicationId);
}

class ApplicationsClientImpl extends BaseApiClient
    implements ApplicationsClientAPI {
  @override
  Future<List<Application>> getPendingApplications() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    return get("applications/?status=pending", token: user.token).then(
        (value) => (value.data['results'] as List)
            .map((item) => Application.fromJson(item))
            .toList());
  }

  @override
  Future<List<Application>> getApprovedApplications() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    return get("applications/?status=approved", token: user.token).then(
        (value) => (value.data['results'] as List)
            .map((item) => Application.fromJson(item))
            .toList());
  }

  @override
  Future<List<Application>> getRejectedApplications() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    return get("applications/?status=rejected", token: user.token)
        .then((value) {
      return (value.data['results'] as List)
          .map((item) => Application.fromJson(item))
          .toList();
    });
  }

  @override
  Future<void> withdrawPendingApplication(int pendingApplicationId) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    return delete("applications/$pendingApplicationId/withdraw/", token: user.token)
        .then((value) => value);
  }
}
