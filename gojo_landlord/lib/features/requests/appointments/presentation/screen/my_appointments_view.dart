import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../data_layer/model/appointment.dart';
import '../../data_layer/repository/my_appointments_repository.dart';
import '../bloc/my_appointments_bloc.dart';
import 'widgets/my_appointment_item.dart';

class MyAppointmentsView extends StatelessWidget {
  final int propertyId;
  const MyAppointmentsView({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "My Appointments",
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              const [_Header()],
              addRepaintBoundaries: false,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.all(GojoPadding.large),
              child: SingleChildScrollView(
                child: BlocProvider(
                  create: (context) => MyAppointmentsBloc(
                    propertyId: propertyId,
                    myAppointmentsRepositoryAPI:
                        GetIt.I<MyAppointmentsRepositoryAPI>(),
                  )..add(LoadMyAppointments()),
                  child: const _MyAppointmentsContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyAppointmentsContent extends StatelessWidget {
  const _MyAppointmentsContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyAppointmentsBloc, MyAppointmentsState>(
        listener: (context, state) {
      switch (state.approveAppointmentStatus) {
        case ApproveAppointmentStatus.loading:
          GojoSnackBars.showLoading(context, "Approving appointment...");
          break;
        case ApproveAppointmentStatus.error:
          GojoSnackBars.showError(context, "Error approving appointment");
          break;
        case ApproveAppointmentStatus.success:
          GojoSnackBars.showSuccess(
              context, "Appointment Approved successfully");
          break;
        case ApproveAppointmentStatus.initial:
          break;
      }

      switch (state.cancelAppointmentStatus) {
        case CancelAppointmentStatus.loading:
          GojoSnackBars.showLoading(context, "Canceling appointment...");
          break;
        case CancelAppointmentStatus.error:
          GojoSnackBars.showError(context, "Error cancelling appointment");
          break;
        case CancelAppointmentStatus.success:
          GojoSnackBars.showSuccess(
              context, "Appointment cancelled successfully");
          break;
        case CancelAppointmentStatus.initial:
          break;
      }
    }, builder: (context, state) {
      switch (state.fetchAppointmentstatus) {
        case FetchAppointmentStatus.success:
          return _MyAppointmentsListView(appointments: state.appointments);
        case FetchAppointmentStatus.loading:
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(child: CircularProgressIndicator()),
          );
        case FetchAppointmentStatus.error:
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(
              child: Text("Error"),
            ),
          );
      }
    });
  }
}

class _MyAppointmentsListView extends StatelessWidget {
  final List<Appointment> appointments;
  const _MyAppointmentsListView({
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return MyAppointementsItem(
            fullName: appointments[index].fullName,
            phoneNumber: appointments[index].phoneNumber,
            status: appointments[index].status == "pending"
                ? AppointmentStatusType.pending
                : AppointmentStatusType.approved,
            date: appointments[index].date,
            onApprove: () {
              context.read<MyAppointmentsBloc>().add(
                    ApproveAppointment(
                      appointments[index].id,
                    ),
                  );
            },
            onCancel: () {
              context.read<MyAppointmentsBloc>().add(
                    CancelAppointment(
                      appointments[index].id,
                    ),
                  );
            },
          );
        });
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Full Name",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 16)),
            Text("Date",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 16)),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
