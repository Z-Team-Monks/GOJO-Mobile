import '../model/balance.dart';
import '../model/wallet.dart';
import '../model/withdraw.dart';
import 'wallet_client.dart';

abstract class WalletRepositoryAPI {
  Future<Wallet> getWallet();
  Future<void> withDraw(WithDraw withDraw);
}

class WalletRepositoryImpl implements WalletRepositoryAPI {
  final WalletClientAPI walletClient;

  WalletRepositoryImpl(this.walletClient);

  @override
  Future<Wallet> getWallet() async {
    final walletResponse = await walletClient.getWallet();
    return Wallet.fromJson(walletResponse);
  }

  @override
  Future<void> withDraw(WithDraw withDraw) async {
    await walletClient.withdraw(withDraw.toJson());
  }
}

class WalletRepositoryFake implements WalletRepositoryAPI {
  @override
  Future<Wallet> getWallet() async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () => const Wallet(balance: Balance(amount: 0), transactions: []),
    );
  }

  @override
  Future<void> withDraw(WithDraw withDraw) async {
    return Future.delayed(const Duration(seconds: 1));
  }
}
