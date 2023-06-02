import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/finished_transaction.dart';
import '../model/pending_tranasction.dart';

abstract class TransactionsClientAPI {
  Future<List<FinishedTransaction>> getFinishedTransactions();

  Future<List<PendingTrasaction>> getPendingTransactions();

  Future<String> getCheckOutUrl(int transactionId);
}

class TransactionsClientImpl extends BaseApiClient
    implements TransactionsClientAPI {
  @override
  Future<List<FinishedTransaction>> getFinishedTransactions() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final finishedTranasctionsResponse = await get(
      "transactions/?status=paid",
      token: user.token,
    );

    return (finishedTranasctionsResponse.data['results'] as List)
        .map((e) => FinishedTransaction.fromJson(e))
        .toList();
  }

  @override
  Future<List<PendingTrasaction>> getPendingTransactions() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final pendingTranasctionsResponse = await get(
      "transactions/?status=pending",
      token: user.token,
    );

    return (pendingTranasctionsResponse.data['results'] as List)
        .map((e) => PendingTrasaction.fromJson(e))
        .toList();
  }

  @override
  Future<String> getCheckOutUrl(int transactionId) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final response = await get(
      "transactions/$transactionId/chapa_checkout_url/",
      token: user.token,
    );
    debugPrint(response.data.toString());
    return response.data['data']['checkout_url'];
  }
}
