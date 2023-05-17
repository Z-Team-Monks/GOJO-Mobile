import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import 'package:gojo/features/transactions/data_layer/model/finished_transaction.dart';
import 'package:gojo/features/transactions/data_layer/model/pending_tranasction.dart';

abstract class TransactionClientAPI {
  Future<List<FinishedTransaction>> getFinishedTransactions();

  Future<List<PendingTrasaction>> getPendingTransactions();
}

class TransactionImpl extends BaseApiClient implements TransactionClientAPI {
  @override
  Future<List<FinishedTransaction>> getFinishedTransactions() async {
    final finishedTranasctionsResponse =
        await get("transactions?status=finished");

    return (finishedTranasctionsResponse.data as List)
        .map((e) => FinishedTransaction.fromJson(e))
        .toList();
  }

  @override
  Future<List<PendingTrasaction>> getPendingTransactions() async {
    final pendingTranasctionsResponse =
        await get("transactions?status=pending");
    return (pendingTranasctionsResponse.data as List)
        .map((e) => PendingTrasaction.fromJson(e))
        .toList();
  }
}
