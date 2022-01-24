import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/data/services/theme.dart';
import 'package:spendtrkr/app/data/services/auth.dart';
import 'package:spendtrkr/app/modules/settings/page.dart';

class HomeUI extends StatelessWidget {
  HomeUI({Key? key}) : super(key: key);
  final _auth = Get.find<AuthController>();
  final themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return _auth.firebaseUser.value == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text('app.title'.tr),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Get.to(() => SettingsUI(),
                        transition: Transition.rightToLeft);
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Get.locale.toString()),
                    Obx(() => ElevatedButton(
                          onPressed: () {
                            themeService.theme =
                                themeService.theme == ThemeMode.dark
                                    ? ThemeMode.light
                                    : ThemeMode.dark;
                          },
                          child: Text(themeService.theme.toString()),
                        )),
                    ElevatedButton(
                      onPressed: _auth.signOut,
                      child: const Text('logout'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'home.welcome'.tr,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
