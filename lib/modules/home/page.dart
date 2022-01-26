import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/data/models/transaction_model.dart';
import 'package:spendtrkr/data/services/auth.dart';
import 'package:spendtrkr/modules/settings/page.dart';
import 'package:spendtrkr/modules/transaction/page.dart';

import 'controller.dart';
import 'widgets/home_body.dart';

class HomeUI extends StatelessWidget {
  HomeUI({Key? key}) : super(key: key);
  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    if (_auth.firebaseUser.value == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(color: Colors.pink)));
    }
    final controller = Get.put(TransactionController());

    return Scaffold(
      appBar: AppBar(
        title: Text('app.title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(() => SettingsUI(), transition: Transition.rightToLeft);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[400],
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () async {
          final result = await Get.to(TransactionUI(
            transaction: TransactionModel(
              ownerId: _auth.user!.uid,
              amount: 0,
              title: '',
              isCompleted: false,
              date: DateTime.now(),
            ),
            onDelete: (tr) async {
              await controller.delete(tr);
            },
          ));
          if (result != null && result is TransactionModel) {
            if (result.id == null) {
              await controller.add(result);
            } else {
              await controller.set(result);
            }
          }
        },
      ),
      body: SafeArea(child: Center(child: HomeBodyUI())),
    );
  }
}
