import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendtrkr/app/data/models/transaction_model.dart';
import 'package:spendtrkr/core/values/keys.dart';

class TransactionProvider {
  final _db = FirebaseFirestore.instance;

  /// Uploads the transaction to the database and assign the id field
  Future<TransactionModel> add(TransactionModel data) async {
    final result = await _db
        .collection('/$userStorageKey/${data.ownerId}/$transactionKey')
        .add(data.toJson());
    data.id = result.id;
    return data;
  }

  Future<void> update(TransactionModel data) async {
    await _db
        .collection('/$userStorageKey/${data.ownerId}/$transactionKey')
        .doc(data.id!)
        .update(data.toJson());
  }

  Future<List<TransactionModel>> listOwned({required String ownerId}) async {
    final data = await _db
        .collection('/$userStorageKey/$ownerId/$transactionKey')
        .orderBy('date')
        .get();
    return data.docs
        .map((e) => TransactionModel.fromMap(
            ownerId: ownerId, id: e.id, data: e.data()))
        .toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllOwned(
          {required String ownerId}) =>
      _db.collection('/$userStorageKey/$ownerId/$transactionKey').snapshots();

  Future<void> delete(TransactionModel data) async {
    await _db
        .collection('/$userStorageKey/${data.ownerId}/$transactionKey')
        .doc(data.id!)
        .delete();
  }
}
