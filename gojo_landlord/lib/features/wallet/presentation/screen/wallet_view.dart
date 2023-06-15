import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo_landlord/features/wallet/data_layer/repository/wallet_repository.dart';
import 'package:gojo_landlord/features/wallet/presentation/bloc/withdraw/withdraw_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/wallet/wallet_bloc.dart';
import 'widgets/transaction_item.dart';
import 'widgets/withdraw_form.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: AppLocalizations.of(context)!.wallet,
      child: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  WalletBloc(GetIt.I.get<WalletRepositoryAPI>())
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
                _TransactionsView(),
              ],
            ),
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
            AppLocalizations.of(context)!.balance,
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                case FetchWalletStatus.error:
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.errorLoadingContent,
                      ),
                    ),
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
              title: AppLocalizations.of(context)!.withdraw,
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

class _TransactionsView extends StatelessWidget {
  const _TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.transactions,
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
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: const Center(child: CircularProgressIndicator()),
                );

              case FetchWalletStatus.error:
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.errorLoadingContent,
                    ),
                  ),
                );
              case FetchWalletStatus.loaded:
                if (state.wallet.transactions.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                      child:
                          Text(AppLocalizations.of(context)!.noTransactionsYet),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                  },
                );
            }
          },
        ),
      ],
    );
  }
}
