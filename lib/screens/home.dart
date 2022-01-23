import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/settings.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final settings = Get.find<SettingsService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  settings.theme = settings.theme == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
                child: Text('home.change-theme'.tr.capitalizeFirst!),
              ),
              ElevatedButton(
                onPressed: () {
                  settings.locale = settings.locale == 'en' ? 'hu' : 'en';
                },
                child: Text('home.change-locale'.tr),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('logout'),
              ),
              const SizedBox(height: 16),
              Text('home.welcome'.tr, style: const TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
