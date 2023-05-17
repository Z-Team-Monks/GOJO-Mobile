import 'package:gojo/features/applications/data_layer/model/application.dart';
import 'package:gojo/features/applications/data_layer/repository/application_cilent.dart';

abstract class ApplicationsRepositoryAPI {
  Future<List<Application>> getPendingApplications();

  Future<List<Application>> getAcceptedApplications();

  Future<List<Application>> getRequestedAppilcations();
}

class ApplicationRepositoryImpl implements ApplicationsRepositoryAPI {
  final ApplicationsClientAPI applicationsClient;

  ApplicationRepositoryImpl(this.applicationsClient);

  @override
  Future<List<Application>> getPendingApplications() async {
    return await applicationsClient.getPendingApplications();
  }

  @override
  Future<List<Application>> getAcceptedApplications() async {
    return await applicationsClient.getAcceptedApplications();
  }

  @override
  Future<List<Application>> getRequestedAppilcations() async {
    return await applicationsClient.getRequestedAppilcations();
  }
}

class ApplicationRepositoryFake implements ApplicationsRepositoryAPI {
  @override
  Future<List<Application>> getPendingApplications() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => List.filled(
        4,
        Application(
            id: "1",
            title: "Kanda Nok",
            applicationDate: "March 2, 2023",
            startDate: "Jan 4,2023",
            endDate: "Jan 4, 2024",
            description: "Application description",
            thumbnailUrl: "https://picsum.photos/250?image=4"),
      ),
    );
  }

  @override
  Future<List<Application>> getAcceptedApplications() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => List.filled(
        4,
        Application(
            id: "1",
            title: "Kanda Nok",
            applicationDate: "March 2, 2023",
            startDate: "Jan 4,2023",
            endDate: "Jan 4, 2024",
            description: "Application description",
            thumbnailUrl: "https://picsum.photos/250?image=8"),
      ),
    );
  }

  @override
  Future<List<Application>> getRequestedAppilcations() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => List.filled(
        4,
        Application(
            id: "1",
            title: "Kanda Nok",
            applicationDate: "March 2, 2023",
            startDate: "Jan 4,2023",
            endDate: "Jan 4, 2024",
            description: "Application description",
            thumbnailUrl: "https://picsum.photos/250?image=12"),
      ),
    );
  }
}
