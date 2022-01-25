import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/data/models/transaction_model.dart';
import 'package:spendtrkr/app/data/provider/transaction.dart';
import 'package:spendtrkr/app/data/services/auth.dart';

class TransactionController extends GetxController {
  final _auth = Get.find<AuthController>();
  final _db = TransactionProvider();

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
    return FirebaseFirestore.instance
        .collection('/users/${_auth.user!.uid}/transactions')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> delete(TransactionModel model) async {
    await _db.delete(model);
  }

  Future<void> add(TransactionModel model) async {
    await _db.add(model);
    //update();
  }

  Future<void> set(TransactionModel model) async {
    await _db.update(model);
  }

  final spentThisMonth = 0.0.obs;
  final notYetPaid = 0.0.obs;
}
