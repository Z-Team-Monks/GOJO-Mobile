import '../model/finished_transaction.dart';
import '../model/pending_tranasction.dart';
import 'transactions_client.dart';

abstract class TransactionsRepositoryAPI {
  Future<List<FinishedTransaction>> getFinishedTransactions();

  Future<List<PendingTrasaction>> getPendingTransactions();

  Future<String> getCheckOutUrl(int transactionId);
}

class TransactionsRepositoryImpl implements TransactionsRepositoryAPI {
  final TransactionsClientAPI transactionsClient;

  TransactionsRepositoryImpl(this.transactionsClient);

  @override
  Future<List<FinishedTransaction>> getFinishedTransactions() async {
    return await transactionsClient.getFinishedTransactions();
  }

  @override
  Future<List<PendingTrasaction>> getPendingTransactions() async {
    return await transactionsClient.getPendingTransactions();
  }

  @override
  Future<String> getCheckOutUrl(int transactionId) async {
    return await transactionsClient.getCheckOutUrl(transactionId);
  }
}

class TransactionsRepositoryFake implements TransactionsRepositoryAPI {
  @override
  Future<List<FinishedTransaction>> getFinishedTransactions() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        FinishedTransaction(
          id: 1,
          title: "Villa, Kemah Tinggi",
          payedAmount: "14000",
          paymentDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=10",
        ),
        FinishedTransaction(
          id: 2,
          title: "Studio in 4kilo",
          payedAmount: "24000",
          paymentDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=10",
        ),
        FinishedTransaction(
          id: 3,
          title: "Condominium",
          payedAmount: "34000",
          paymentDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=10",
        ),
      ],
    );
  }

  @override
  Future<List<PendingTrasaction>> getPendingTransactions() {
    return Future.delayed(
      const Duration(seconds: 3),
      () => [
        PendingTrasaction(
          id: 2,
          title: "Studio in 4kilo",
          amount: "24000",
          dueDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=10",
        ),
        PendingTrasaction(
          id: 3,
          title: "Condominium",
          amount: "34000",
          dueDate: "12/12/2020",
          thumbnailUrl: "https://picsum.photos/250?image=10",
        ),
      ],
    );
  }

  @override
  Future<String> getCheckOutUrl(int transactionId) async {
    return Future.delayed(
        const Duration(seconds: 1),
        () =>
            "https://checkout.chapa.co/checkout/payment/xCACcOKJueYJ5IPKcve7aHNSnBTH4PadY3cFKwYLPWlb4");
  }
}
