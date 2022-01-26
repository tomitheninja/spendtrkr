import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/data/models/transaction_model.dart';
import 'package:spendtrkr/data/provider/transaction.dart';
import 'package:spendtrkr/data/services/auth.dart';

class TransactionController extends GetxController {
  final _auth = Get.find<AuthController>();
  final _db = TransactionProvider();

  final Rx<List<TransactionModel>> _transactions =
      Rx<List<TransactionModel>>([]);
  List<TransactionModel> get transactions => _transactions.value;

  @override
  void onInit() {
    super.onInit();
    _transactions.bindStream(FirebaseFirestore.instance
        .collection('/users/${_auth.user!.uid}/transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((QuerySnapshot query) => query.docs
            .map((qry) => TransactionModel.fromMap(
                data: qry.data() as dynamic,
                ownerId: _auth.user!.uid,
                id: qry.id))
            .toList()));
  }

  Future<void> delete(TransactionModel model) async {
    await _db.delete(model);
    update();
  }

  Future<void> add(TransactionModel model) async {
    await _db.add(model);
    update();
  }

  Future<void> set(TransactionModel model) async {
    await _db.update(model);
    update();
  }

  final spentThisMonth = 0.0.obs;
  final notYetPaid = 0.0.obs;
}
