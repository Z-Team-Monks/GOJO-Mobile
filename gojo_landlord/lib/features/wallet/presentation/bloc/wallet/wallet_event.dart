part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class LoadWallet extends WalletEvent {
  LoadWallet();
}
