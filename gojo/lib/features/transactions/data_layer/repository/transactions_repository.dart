import 'package:gojo/features/transactions/data_layer/model/finished_transaction.dart';
import 'package:gojo/features/transactions/data_layer/model/pending_tranasction.dart';
import 'package:gojo/features/transactions/data_layer/repository/transactions_client.dart';

abstract class TransactionsRepositoryAPI {
  Future<List<FinishedTransaction>> getFinishedTransactions();

  Future<List<PendingTrasaction>> getPendingTransactions();
}

class TransactionsRepositoryImpl implements TransactionsRepositoryAPI {
  final TransactionsClientAPI TransactionsClient;

  TransactionsRepositoryImpl(this.TransactionsClient);

  @override
  Future<List<FinishedTransaction>> getFinishedTransactions() async {
    return await TransactionsClient.getFinishedTransactions();
  }

  @override
  Future<List<PendingTrasaction>> getPendingTransactions() async {
    return await TransactionsClient.getPendingTransactions();
  }
}

class TransactionsRepositoryFake implements TransactionsRepositoryAPI {
  @override
  Future<List<FinishedTransaction>> getFinishedTransactions() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        FinishedTransaction(
          id: "1",
          title: "Villa, Kemah Tinggi",
          payedAmount: 14000,
          paymentDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=9",
        ),
        FinishedTransaction(
          id: "2",
          title: "Studio in 4kilo",
          payedAmount: 24000,
          paymentDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=9",
        ),
        FinishedTransaction(
          id: "3",
          title: "Condominium",
          payedAmount: 34000,
          paymentDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=9",
        ),
      ],
    );
  }

  @override
  Future<List<PendingTrasaction>> getPendingTransactions() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        PendingTrasaction(
          id: "2",
          title: "Studio in 4kilo",
          amount: 24000,
          dueDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=9",
        ),
        PendingTrasaction(
          id: "3",
          title: "Condominium",
          amount: 34000,
          dueDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=9",
        ),
      ],
    );
  }
}
