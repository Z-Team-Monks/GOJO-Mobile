import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo_landlord/features/wallet/data_layer/repository/wallet_repository.dart';
import 'package:gojo_landlord/features/wallet/presentation/bloc/withdraw/withdraw_bloc.dart';
import 'package:intl/intl.dart';

import '../../data_layer/model/transaction.dart';
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
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              switch (state.fetchWalletStatus) {
                case FetchWalletStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case FetchWalletStatus.error:
                  return const SizedBox(
                    height: 40,
                    child: Center(child: Text("Can't load balance!")),
                  );
                default:
                  break;
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: GojoPadding.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          NumberFormat('#,##0.00')
                              .format(state.wallet.balance.amount),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 32,
                                    letterSpacing: 0.3,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          " ETB",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
            },
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transactions",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor.withOpacity(0.7),
              ),
        ),
        BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            switch (state.fetchWalletStatus) {
              case FetchWalletStatus.loading:
                return const Center(child: CircularProgressIndicator());

              case FetchWalletStatus.error:
                return const Padding(
                  padding: EdgeInsets.only(top: 38.0),
                  child: Center(
                    child: Text("Can't load transactions right now!"),
                  ),
                );
              case FetchWalletStatus.loaded:
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.wallet.transactions.length,
                    itemBuilder: (context, index) {
                      final transactionItem = state.wallet.transactions[index];
                      return TransactionItem(
                        type: transactionItem.type,
                        title: transactionItem.title,
                        date: transactionItem.date,
                        time: transactionItem.time,
                        amount: transactionItem.amount,
                      );
                    });
            }
          },
        ),
      ],
    );
  }
}
