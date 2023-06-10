import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import 'package:gojo_landlord/features/wallet/data_layer/model/bank.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../bloc/withdraw/withdraw_bloc.dart';

class WithDrawForm extends StatelessWidget {
  const WithDrawForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WithdrawBloc, WithdrawState>(
      listener: (context, state) {
        switch (state.withDrawRequestStatus) {
          case WithDrawRequestStatus.success:
            GojoSnackBars.showSuccess(
              context,
              "Withdraw Request sent successfully!",
            );
            Navigator.pop(context);
            break;
          case WithDrawRequestStatus.error:
            GojoSnackBars.showError(
              context,
              "Something went wrong!",
            );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 18.0,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Please fill the following information.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const AmountInput(),
                const SizedBox(height: 20),
                const BankInput(),
                const SizedBox(height: 20),
                const AccountInput(),
                const SizedBox(height: 30),
                const _ConfirmButton()
              ],
            ),
          ),
        );
      },
    );
  }
}

class AmountInput extends StatelessWidget {
  const AmountInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        return GojoTextField(
          labelText: "Amount",
          textInputType: TextInputType.number,
          onChanged: (value) {
            context.read<WithdrawBloc>().add(AmountChanged(amount: value));
          },
          errorText: !state.amountInput.isPure && state.amountInput.isNotValid
              ? state.amountInput.getErrorMessage()
              : null,
        );
      },
    );
  }
}

class AccountInput extends StatelessWidget {
  const AccountInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        return GojoTextField(
          labelText: "Bank Account",
          textInputType: TextInputType.number,
          onChanged: (value) {
            context
                .read<WithdrawBloc>()
                .add(AccountNumberChanged(accountNumber: value));
          },
          errorText: !state.accountNumberInput.isPure &&
                  state.accountNumberInput.isNotValid
              ? state.accountNumberInput.getErrorMessage()
              : null,
        );
      },
    );
  }
}

class BankInput extends StatelessWidget {
  const BankInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: state.selectedBank,
              underline: Container(),
              isExpanded: true,
              hint: Text(
                "Pick a bank",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
              onChanged: (String? value) {
                if (value != null) {
                  context.read<WithdrawBloc>().add(BankChanged(bank: value));
                }
              },
              items: Bank.banks.map<DropdownMenuItem<String>>((Bank value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawBloc, WithdrawState>(
      builder: (context, state) {
        return GojoBarButton(
          title: "Confirm",
          isActive: _isButtonActive(state),
          loadingState: _isButtonLoading(state),
          onClick: () => _onClick(context, state),
        );
      },
    );
  }

  bool _isButtonActive(WithdrawState state) {
    return state.amountInput.isValid &&
        state.withDrawRequestStatus != WithDrawRequestStatus.loading;
  }

  bool _isButtonLoading(WithdrawState state) {
    return state.withDrawRequestStatus == WithDrawRequestStatus.loading;
  }

  void _onClick(BuildContext context, WithdrawState state) {
    context.read<WithdrawBloc>().add(WithdrawConfirmed());
  }
}
