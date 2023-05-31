import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_layer.dart/model/balance.dart';
import '../../../data_layer.dart/repository/wallet_repository.dart';
import '../../../data_layer.dart/wallet.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepositoryAPI walletRepository;
  WalletBloc(this.walletRepository) : super(WalletState.initial()) {
    on<LoadWallet>((event, emit) {
      emit(state.copyWith(fetchWalletStatus: FetchWalletStatus.loading));
      walletRepository.getWallet().then((wallet) {
        emit(state.copyWith(
          wallet: wallet,
          fetchWalletStatus: FetchWalletStatus.loaded,
        ));
      }).catchError((error) {
        emit(state.copyWith(fetchWalletStatus: FetchWalletStatus.error));
      });
    });
  }
}
