import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/features/wallet/data_layer.dart/repository/wallet_repository.dart';
import 'package:gojo_landlord/features/wallet/presentation/bloc/withdraw/model/account_number_input.dart';
import 'package:meta/meta.dart';

import '../../../data_layer.dart/model/bank.dart';
import '../../../data_layer.dart/model/withdraw.dart';
import 'model/amount_input.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  final WalletRepositoryAPI walletRepository;

  WithdrawBloc(this.walletRepository) : super(WithdrawState.initial()) {
    on<AmountChanged>((event, emit) {
      emit(state.copyWith(
        amountInput: AmountInput.dirty(value: event.amount),
        withDrawRequestStatus: WithDrawRequestStatus.initial,
      ));
    });

    on<BankChanged>((event, emit) {
      emit(state.copyWith(
        selectedBank: event.bank,
        withDrawRequestStatus: WithDrawRequestStatus.initial,
      ));
    });

    on<AccountNumberChanged>((event, emit) {
      emit(state.copyWith(
        accountNumberInput: AccountNumberInput.dirty(
          value: event.accountNumber,
        ),
        withDrawRequestStatus: WithDrawRequestStatus.initial,
      ));
    });

    on<WithdrawConfirmed>((event, emit) async {
      emit(
          state.copyWith(withDrawRequestStatus: WithDrawRequestStatus.loading));

      try {
        final amountToWithdraw = double.parse(state.amountInput.value);
        final selectedBank =
            Bank.banks.where((bank) => bank.name == state.selectedBank).first;
        await walletRepository.withDraw(WithDraw(
          amount: amountToWithdraw,
          bank: selectedBank,
          accountNumber: state.accountNumberInput.value,
        ));
        emit(state.copyWith(
            withDrawRequestStatus: WithDrawRequestStatus.success));
      } catch (e) {
        emit(state.copyWith(
          withDrawRequestStatus: WithDrawRequestStatus.error,
        ));
      }
    });
  }
}
