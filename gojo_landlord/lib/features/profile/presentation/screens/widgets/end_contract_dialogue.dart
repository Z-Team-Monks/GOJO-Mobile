import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import 'package:gojo_landlord/features/profile/presentation/bloc/end_contract/end_contract_bloc.dart';

class EndContractDialogue extends StatelessWidget {
  final String propertyTitle;
  final int propertyId;

  const EndContractDialogue({
    super.key,
    required this.propertyTitle,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<EndContractBloc, EndContractState>(
      listener: (context, state) {
        switch (state) {
          case EndContractState.success:
            GojoSnackBars.showSuccess(context, "Contract ended successfully");
            Navigator.of(context).pop();
            break;
          case EndContractState.error:
            GojoSnackBars.showError(
              context,
              "Failed to end contract. Please try again!",
            );
            break;
          case EndContractState.loading:
            GojoSnackBars.showLoading(context, "Ending contract...");
            break;
          case EndContractState.initial:
            break;
        }
      },
      child: AlertDialog(
        title: RichText(
            text: TextSpan(
          children: [
            TextSpan(
              text: "Are you sure you want to end the contract for",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            TextSpan(
              text: " $propertyTitle",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: " ?",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        )),
        actions: [
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              context.read<EndContractBloc>().add(EndContract(propertyId));
            },
          ),
          TextButton(
            child: const Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
