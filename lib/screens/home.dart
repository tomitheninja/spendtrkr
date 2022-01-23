import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/auth.dart';
import 'package:spendtrkr/controllers/settings.dart';
import 'package:spendtrkr/screens/settings.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final settings = Get.find<SettingsService>();
  final _auth = Get.find<AuthController>();
  final _settings = Get.find<SettingsService>();

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
                    Get.to(() => SettingsPage(),
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
                    ElevatedButton(
                      onPressed: () {
                        _settings.theme = _settings.theme == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark;
                      },
                      child: Text(_settings.theme.toString()),
                    ),
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
