import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import 'package:gojo/features/applications/data_layer/model/application.dart';

abstract class ApplicationsClientAPI {
  Future<List<Application>> getPendingApplications();

  Future<List<Application>> getApprovedApplications();

  Future<List<Application>> getRejectedApplications();
}

class ApplicationsClientImpl extends BaseApiClient
    implements ApplicationsClientAPI {
  @override
  Future<List<Application>> getPendingApplications() {
    return get("applications?status=pending").then((value) =>
        (value.data as List)
            .map((item) => Application.fromJson(item))
            .toList());
  }

  @override
  Future<List<Application>> getApprovedApplications() {
    return get("applications?status=approved").then((value) =>
        (value.data as List)
            .map((item) => Application.fromJson(item))
            .toList());
  }

  @override
  Future<List<Application>> getRejectedApplications() {
    return get("applications?status=requested").then((value) =>
        (value.data as List)
            .map((item) => Application.fromJson(item))
            .toList());
  }
}
