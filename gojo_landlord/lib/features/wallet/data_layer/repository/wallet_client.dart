import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

abstract class WalletClientAPI {
  Future<dynamic> getWallet();
  Future<void> withdraw(dynamic withdrawData);
}

class WalletClientImpl extends BaseApiClient implements WalletClientAPI {
  WalletClientImpl() : super();

  @override
  Future<dynamic> getWallet() async {
    final user = await GetIt.I.get<UserRepositoryAPI>().getUser();
    final response = await get('transactions/', token: user?.token);
    return response.data;
  }

  @override
  Future<void> withdraw(dynamic withdrawData) async {
    final user = await GetIt.I.get<UserRepositoryAPI>().getUser();
    final response = await post(
      'transactions/',
      withdrawData,
      token: user?.token,
    );
  }
}
