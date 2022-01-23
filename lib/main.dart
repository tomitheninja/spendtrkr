import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spendtrkr/controllers/settings.dart';
import 'package:spendtrkr/utils/routes.dart';

import 'translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  Get.lazyPut(() => SettingsService());
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final settings = Get.find<SettingsService>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslations(),
      locale: Locale(settings.locale),
      fallbackLocale: const Locale('en'),
      title: 'Spendtrkt',
      themeMode: settings.theme,
      darkTheme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
