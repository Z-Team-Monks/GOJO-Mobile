import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/features/appointment/my_appointments/data_layer/repository/my_appointments_repository.dart';
import 'package:gojo/features/appointment/my_appointments/presentation/bloc/my_appointments_bloc.dart';

class MyAppointmentsView extends StatelessWidget {
  const MyAppointmentsView({super.key});

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
  const _MyAppointmentsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsBloc, MyAppointmentsState>(
        builder: (context, state) {
      switch (state.status) {
        case FetchMyAppointmentsStatus.loaded:
          return ListView(
            shrinkWrap: true,
            children: state.appointments,
          );
        case FetchMyAppointmentsStatus.loading:
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        case FetchMyAppointmentsStatus.error:
          return const Center(child: Text("Error"));
      }
    });
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Full Name",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 16,
                  ),
            ),
            Text(
              "Date",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
