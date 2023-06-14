import 'package:dashed_rect/dashed_rect.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/pick_file_button.dart';
import 'package:gojo_landlord/features/profile/presentation/screens/profile_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/core/repository/application/application_repository.dart';
import '../bloc/applications_bloc.dart';
import 'widgets/application_request_item.dart';

class ApplicationRequestsView extends StatelessWidget {
  final int propertyId;
  const ApplicationRequestsView({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplicationsBloc(
        applicationRepository: GetIt.I<ApplicationsRepositoryAPI>(),
        propertyId: propertyId,
      )..add(LoadApplications()),
      child: const _ApplicationRequestsView(),
    );
  }
}

class _ApplicationRequestsView extends StatelessWidget {
  const _ApplicationRequestsView();

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: AppLocalizations.of(context)!.applicationRequests,
      child: BlocConsumer<ApplicationsBloc, ApplicationsState>(
        listener: (context, state) {
          switch (state.rejectApplicationStatus) {
            case RejectApplicationStatus.loading:
              GojoSnackBars.showLoading(context, "Rejecting application...");
              break;
            case RejectApplicationStatus.success:
              GojoSnackBars.showSuccess(context, "Application Rejected!");
              break;
            case RejectApplicationStatus.error:
              GojoSnackBars.showError(
                context,
                "Couldn't reject application. Try again later!",
              );
              break;
            default:
          }

          switch (state.approveApplicationStatus) {
            case ApproveApplicationStatus.loading:
              GojoSnackBars.showLoading(context, "Approving an application...");
              break;
            case ApproveApplicationStatus.success:
              GojoSnackBars.showSuccess(context, "Application Approved!");
              Navigator.pop(context);
              break;
            case ApproveApplicationStatus.error:
              GojoSnackBars.showError(
                context,
                "Couldn't approve application. Try again later!",
              );
              break;
            default:
          }
        },
        builder: (context, state) {
          switch (state.fetchApplicationsFetchStatus) {
            case FetchApplicationsStatus.loading:
              return const LoadingView();
            case FetchApplicationsStatus.loaded:
              if (state.pendingApplications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "No applications yet",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "You will see applications here when tenants apply for your property",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (var request in state.pendingApplications)
                      ApplicationRequestItem(
                        leadingImageUrl: request.thumbnailUrl,
                        title: request.title,
                        topRightDate: request.applicationDate,
                        startDate: request.startDate,
                        endDate: request.endDate,
                        description: request.description,
                        onApprove: () async {
                          final contractFilePath =
                              await showUploadContractDialogue(context);
                          if (context.mounted && contractFilePath != null) {
                            context
                                .read<ApplicationsBloc>()
                                .add(ApprovePendingApplication(
                                  applicationId: request.id,
                                  contractFilePath: contractFilePath,
                                ));
                          }
                        },
                        onReject: () {
                          context
                              .read<ApplicationsBloc>()
                              .add(RejectPendingApplication(request.id));
                        },
                      ),
                  ],
                ),
              );
            case FetchApplicationsStatus.error:
              return const ErrorView();
          }
        },
      ),
    );
  }

  Future<String?> showUploadContractDialogue(
    BuildContext context,
  ) async {
    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: UploadContractView(),
          ),
        );
      },
    );
  }
}

class UploadContractView extends StatefulWidget {
  const UploadContractView({
    super.key,
  });

  @override
  State<UploadContractView> createState() => _UploadContractViewState();
}

class _UploadContractViewState extends State<UploadContractView> {
  String? contractFilePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: GojoPadding.extraSmall),
          child: Text(
            "Upload Your Contract",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 20),
        DashedRect(
          gap: 10,
          strokeWidth: 3,
          color: const Color.fromARGB(150, 27, 181, 92),
          child: Container(
            padding: const EdgeInsets.all(60),
            width: double.infinity,
            child: const Icon(
              Icons.cloud_upload,
              size: 50,
              color: Color.fromARGB(150, 27, 181, 92),
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () async {
            final path = await _getFile();
            if (mounted && path != null) {
              setState(() {
                contractFilePath = path;
              });
            }
          },
          child: (contractFilePath != null)
              ? PickAFileButton(path: contractFilePath)
              : const PickAFileButton(),
        ),
        const SizedBox(height: 20),
        GojoBarButton(
          title: "Submit",
          isActive: contractFilePath != null,
          onClick: () {
            Navigator.pop(context, contractFilePath);
          },
        ),
      ],
    );
  }

  Future<String?> _getFile() async {
    debugPrint("pick file called");
    try {
      var paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        onFileLoading: (FilePickerStatus status) =>
            debugPrint(status.toString()),
        dialogTitle: "Pick Your Contract",
        lockParentWindow: true,
      ));
      return paths?.files.single.path;
    } catch (e) {
      return null;
    }
  }
}
