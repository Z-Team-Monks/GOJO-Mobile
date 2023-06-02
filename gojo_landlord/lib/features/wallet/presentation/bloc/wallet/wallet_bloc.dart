import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_layer/model/balance.dart';
import '../../../data_layer/repository/wallet_repository.dart';
import '../../../data_layer/model/wallet.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepositoryAPI walletRepository;
  WalletBloc(this.walletRepository) : super(WalletState.initial()) {
    on<LoadWallet>((event, emit) async {
      emit(state.copyWith(fetchWalletStatus: FetchWalletStatus.loading));
      try {
        final wallet = await walletRepository.getWallet();
        emit(state.copyWith(
          wallet: wallet,
          fetchWalletStatus: FetchWalletStatus.loaded,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(fetchWalletStatus: FetchWalletStatus.error));
      }
    });
  }
}
