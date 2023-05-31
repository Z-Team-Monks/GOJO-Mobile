import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo_landlord/features/wallet/data_layer.dart/repository/wallet_repository.dart';
import 'package:gojo_landlord/features/wallet/presentation/bloc/withdraw/withdraw_bloc.dart';

import '../bloc/wallet/wallet_bloc.dart';
import 'widgets/transaction_item.dart';
import 'widgets/withdraw_form.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Wallet",
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WalletBloc(GetIt.I.get<WalletRepositoryAPI>())
              ..add(LoadWallet()),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: const [
              _Balance(),
              SizedBox(height: 10),
              _WithdrawButton(),
              SizedBox(height: 40),
              TransactionsView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Balance extends StatelessWidget {
  const _Balance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GojoPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Balance",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "2,540.00 ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 32,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                "ETB",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WithdrawButton extends StatelessWidget {
  const _WithdrawButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: GojoBarButton(
              title: "Withdraw",
              onClick: () {
                showDialog<void>(
                  context: context,
                  builder: (_) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => WithdrawBloc(
                            (GetIt.I.get<WalletRepositoryAPI>()),
                          ),
                        ),
                        // BlocProvider.value(value: context.read<WalletBloc>()),
                      ],
                      child: const WithDrawForm(),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          "Transactions",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 12),
        TransactionItem(
          type: TransactionType.withdrawal,
          title: "Withdrawal",
          date: "08 June, 2021",
          time: "09:00",
          amount: "20.50",
        ),
        TransactionItem(
          type: TransactionType.pending,
          title: "Pending",
          date: "08 June, 2021",
          time: "09:00",
          amount: "20.50",
        ),
        TransactionItem(
          type: TransactionType.deposit,
          title: "Andrew Robertson",
          date: "08 June, 2021",
          time: "09:00",
          amount: "20.50",
        ),
      ],
    );
  }
}
