part of 'wallet_bloc.dart';

enum FetchWalletStatus {
  initial,
  loading,
  loaded,
  error,
}

@immutable
class WalletState {
  final Wallet wallet;
  final FetchWalletStatus fetchWalletStatus;

  const WalletState({required this.wallet, required this.fetchWalletStatus});

  factory WalletState.initial() {
    return const WalletState(
      wallet: Wallet(
        balance: Balance(amount: 0),
        transactions: [],
      ),
      fetchWalletStatus: FetchWalletStatus.initial,
    );
  }

  WalletState copyWith({
    Wallet? wallet,
    FetchWalletStatus? fetchWalletStatus,
  }) {
    return WalletState(
      wallet: wallet ?? this.wallet,
      fetchWalletStatus: fetchWalletStatus ?? this.fetchWalletStatus,
    );
  }
}
