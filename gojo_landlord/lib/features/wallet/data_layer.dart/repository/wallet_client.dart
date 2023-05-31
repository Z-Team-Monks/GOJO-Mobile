import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/network/base_api_client.dart';
import 'package:gojo_landlord/features/wallet/data_layer.dart/model/withdraw.dart';

import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';

abstract class WalletClientAPI {
  Future<dynamic> getWallet();
  Future<void> withdraw(dynamic withdrawData);
}

class WalletClientImpl extends BaseApiClient implements WalletClientAPI {
  WalletClientImpl() : super();

  @override
  Future<dynamic> getWallet() async {
    final user = await GetIt.I.get<UserRepositoryAPI>().getUser();
    final response = await get('/wallet', token: user?.token);
    return response;
  }

  @override
  Future<void> withdraw(dynamic withdrawData) async {
    final user = await GetIt.I.get<UserRepositoryAPI>().getUser();
    final response = await post(
      '/wallet/withdraw',
      withdrawData,
      token: user?.token,
    );
  }
}
