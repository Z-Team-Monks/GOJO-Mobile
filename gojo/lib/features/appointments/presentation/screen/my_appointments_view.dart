import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../data_layer/model/appointment.dart';
import '../../data_layer/repository/my_appointments_repository.dart';
import '../bloc/my_appointments_bloc.dart';
import 'widgets/my_appointment_item.dart';

class MyAppointmentsView extends StatelessWidget {
  const MyAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: AppLocalizations.of(context)!.myAppointments,
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
                  create: (context) =>
                      MyAppointmentsBloc(GetIt.I<MyAppointmentsRepositoryAPI>())
                        ..add(LoadMyAppointments()),
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
      switch (state.cancelAppointmentStatus) {
        case CancelAppointmentStatus.loading:
          GojoSnackBars.showLoading(
            context,
            AppLocalizations.of(context)!.cancelingAppointment,
          );
          break;
        case CancelAppointmentStatus.error:
          GojoSnackBars.showError(
            context,
            AppLocalizations.of(context)!.errorCancelingAppointment,
          );
          break;
        case CancelAppointmentStatus.success:
          GojoSnackBars.showSuccess(
            context,
            AppLocalizations.of(context)!.appointmentCanceledSuccesfully,
          );
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
            child: Center(
              child: Text(AppLocalizations.of(context)!.errorLoadingContent),
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
    if (appointments.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Center(
          child: Text(AppLocalizations.of(context)!.noAppointments),
        ),
      );
    }
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
            Text(AppLocalizations.of(context)!.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 16)),
            Text(AppLocalizations.of(context)!.date,
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
