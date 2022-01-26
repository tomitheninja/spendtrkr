import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/data/models/transaction_model.dart';
import 'package:spendtrkr/widgets/transaction_editor.dart';
import 'package:spendtrkr/widgets/tranaction_card.dart';

import '../controller.dart';
import 'home_header.dart';

class HomeBodyUI extends GetView<TransactionController> {
  const HomeBodyUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<TransactionController>(
          builder: (controller) => HomeHeaderUI(
            key: const Key('home_header'),
            spendThisMonth: controller.transactions
                .where((t) => t.isCompleted)
                .where((t) => t.date
                    .add(const Duration(days: 30))
                    .isAfter(DateTime.now()))
                .map((e) => e.amount)
                .fold(0.0, (double a, b) => a + b)
                .toString(),
            notYetPaid: controller.transactions
                .where((t) => !t.isCompleted)
                .map((e) => e.amount)
                .fold(0.0, (double a, b) => a + b)
                .toString(),
            refreshAction: () {},
          ),
        ),
        Expanded(
          child: GetX<TransactionController>(
            builder: (controller) => ListView(
              children: controller.transactions
                  .map((transaction) => GestureDetector(
                      child: TransactionCard(
                        key: Key(transaction.id!),
                        transaction: transaction,
                        onDelete: controller.delete,
                        onCheckClicked: (tr, value) async {
                          tr.isCompleted = value;
                          controller.set(tr);
                          controller.update();
                        },
                      ),
                      onTap: () => Get.to(
                            () => TransactionEditorUI(
                                transaction: transaction,
                                onDelete: (tr) async {
                                  await controller.delete(tr);
                                }),
                          )?.then((result) {
                            if (result != null && result is TransactionModel) {
                              controller.set(result);
                            }
                          })))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
