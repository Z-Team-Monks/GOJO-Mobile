import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo/features/home/presentation/bloc/property_filter/property_filter_bloc.dart';
import 'package:gojo/features/home/presentation/screen/widgets/filter_form_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GojoHomeFilterFormView extends StatelessWidget {
  const GojoHomeFilterFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyFilterBloc, PropertyFilterState>(
        builder: (context, state) {
      switch (state.status) {
        case FetchPropertyFilterStatus.success:
          return FilterFormContent();
        case FetchPropertyFilterStatus.loading:
          return const LoadingView();
        case FetchPropertyFilterStatus.error:
          return const ErrorView();
      }
    });
  }
}

// TODO: Use generic LoadingView
class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      alignment: Alignment.center,
      child: const SizedBox(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// TODO: Use generic ErrorView
class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.errorLoadingContent);
  }
}
