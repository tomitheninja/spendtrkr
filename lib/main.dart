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

const firebaseWebOptions = FirebaseOptions(
  apiKey: 'AIzaSyDuyY763bk4-OxjdhUUYW2HAQdYcP5xoCI',
  authDomain: 'spendtrkr-e40ce.firebaseapp.com',
  projectId: 'spendtrkr-e40ce',
  storageBucket: 'spendtrkr-e40ce.appspot.com',
  messagingSenderId: '541450653193',
  appId: '1:541450653193:web:cb2d8b42412bc5f69272d8',
  measurementId: 'G-N1DF094QV0',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: GetPlatform.isWeb ? firebaseWebOptions : null,
  );
  await Get.putAsync(() => ThemeService().init());
  await Get.putAsync(() => LocaleService().init());
  Get.put(AuthController());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
