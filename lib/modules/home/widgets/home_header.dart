import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Text(
                "home.title".tr,
                style: const TextStyle(fontSize: 30, color: Colors.white),
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
                      Text(
                          "home.spent-this-month"
                              .trParams({'amount': spendThisMonth}),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                      Text("home.not-yet-paid".trParams({'amount': notYetPaid}),
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
