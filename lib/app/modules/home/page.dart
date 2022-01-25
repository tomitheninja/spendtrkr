import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/data/models/transaction_model.dart';
import 'package:spendtrkr/app/data/services/auth.dart';
import 'package:spendtrkr/app/modules/settings/page.dart';
import 'package:spendtrkr/app/modules/transaction/page.dart';
import 'package:spendtrkr/controller/tranaction_card.dart';

import 'controller.dart';

class HomeUI extends StatelessWidget {
  HomeUI({Key? key}) : super(key: key);
  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    if (_auth.firebaseUser.value == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
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

class HomeHeaderUI extends StatelessWidget {
  final String spendThisMonth;
  final String notYetPaid;
  final Function refreshAction;
  const HomeHeaderUI({
    Key? key,
    required this.spendThisMonth,
    required this.notYetPaid,
    required this.refreshAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.only(
            left: 30,
            right: 10,
            top: 15,
            bottom: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "My wallet history",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Spent this month: $spendThisMonth",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                      Text("Not yet paid: $notYetPaid",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  /* TextButton(
                    style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      elevation: 8,
                      shadowColor: Colors.blueGrey,
                      backgroundColor: Colors.blue[700],
                    ),
                    onPressed: () async {},
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ) */
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.blue,
          child: Container(
              height: 15,
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              )),
        ),
      ],
    );
  }
}
