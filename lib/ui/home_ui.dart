import 'package:flutter/material.dart';
import 'package:spendtrkr/constants/app_routes.dart';
import 'package:spendtrkr/controllers/controllers.dart';
import 'package:spendtrkr/ui/components/components.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('home.title'.tr),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Get.toNamed(Routes.settings);
                      }),
                ],
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 120),
                    Avatar(user: controller.firestoreUser.value!),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const FormVerticalSpace(),
                        Text(
                            'home.uidLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.uid,
                            style: const TextStyle(fontSize: 16)),
                        const FormVerticalSpace(),
                        Text(
                            'home.nameLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.name,
                            style: const TextStyle(fontSize: 16)),
                        const FormVerticalSpace(),
                        Text(
                            'home.emailLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.email,
                            style: const TextStyle(fontSize: 16)),
                        const FormVerticalSpace(),
                        Text(
                            'home.adminUserLabel'.tr +
                                ': ' +
                                controller.admin.value.toString(),
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
