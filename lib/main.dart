import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/app/data/services/theme.dart';
import 'package:spendtrkr/app/data/services/auth.dart';
import 'app/data/services/locale.dart';
import 'core/languages/translations.dart';
import 'core/theme/app.dart';
import 'routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await Get.putAsync(() => ThemeService().init());
  await Get.putAsync(() => LocaleService().init());

  Get.put(AuthController());
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return OTS(
      showNetworkUpdates: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: MyTranslations(),
        fallbackLocale: const Locale('en', 'UK'),
        title: 'Spendtrkt',
        theme: Themes.light,
        darkTheme: Themes.dark,
        initialRoute: AppRoutes.initial,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
