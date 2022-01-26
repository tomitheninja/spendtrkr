import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/data/models/transaction_model.dart';
import 'package:spendtrkr/data/services/auth.dart';
import 'package:spendtrkr/modules/transaction/page.dart';
import 'package:spendtrkr/widgets/tranaction_card.dart';

import '../controller.dart';
import 'home_header.dart';

class HomeBodyUI extends GetView<TransactionController> {
  HomeBodyUI({Key? key}) : super(key: key);
  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.getStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return HomeHeaderUI(
            key: const Key('home_header'),
            spendThisMonth: '0\$',
            notYetPaid: '0\$',
            refreshAction: () {},
          );
        }
        return ListView.builder(
          itemCount: max(snapshot.data!.docs.length, 1),
          itemBuilder: (context, index) {
            if (snapshot.data!.docs.isEmpty) {
              return HomeHeaderUI(
                key: const Key('home_header'),
                spendThisMonth: '0',
                notYetPaid: '0',
                refreshAction: () {
                  controller;
                },
              );
            }
            DocumentSnapshot ds = snapshot.data!.docs[index];
            TransactionModel t = TransactionModel.fromMap(
              ownerId: _auth.firebaseUser.value!.uid,
              id: ds.id,
              data: ds.data() as dynamic,
            );

            final ts = snapshot.data!.docs.map((x) => TransactionModel.fromMap(
                  data: x.data() as dynamic,
                  ownerId: '',
                ));

            controller.spentThisMonth.value = ts
                .where((t) => t.isCompleted)
                .where((t) => t.date
                    .add(const Duration(days: 30))
                    .isAfter(DateTime.now()))
                .map((e) => e.amount)
                .fold(0.0, (double a, b) => a + b);

            controller.notYetPaid.value = ts
                .where((t) => !t.isCompleted)
                .map((e) => e.amount)
                .fold(0.0, (double a, b) => a + b);

            return Column(
              children: [
                if (index == 0)
                  Obx(() => HomeHeaderUI(
                        key: const Key('home_header'),
                        spendThisMonth: '${controller.spentThisMonth}\$'
                            .replaceFirst('.0\$', '\$'),
                        notYetPaid: '${controller.notYetPaid}\$'
                            .replaceFirst('.0\$', '\$'),
                        refreshAction: () {},
                      )),
                GestureDetector(
                  onTap: () async {
                    final result = await Get.to(() => TransactionUI(
                          transaction: t,
                          onDelete: (tr) async {
                            await controller.delete(tr);
                          },
                        ));
                    if (result != null && result is TransactionModel) {
                      await controller.set(result);
                    }
                  },
                  child: TransactionCard(
                    key: Key(ds.id),
                    transaction: t,
                    onDelete: controller.delete,
                    onCheckClicked: (transaction, value) async {
                      transaction.isCompleted = value;
                      controller.set(transaction);
                      controller.update();
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}