import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'controllers/controllers.dart';
import 'constants/constants.dart';
import 'ui/components/components.dart';
import 'helpers/helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) => Loading(
        child: GetMaterialApp(
          translations: Localization(),
          locale: languageController.getLocale, // <- Current locale
          // navigatorObservers: [
          // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
          // ],
          debugShowCheckedModeBanner: false,
          //defaultTransition: Transition.fade,
          // theme: AppThemes.lightTheme,
          darkTheme:
              ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
          themeMode: ThemeMode.system,
          initialRoute: "/",
          getPages: AppRoutes.routes,
        ),
      ),
    );
  }
}
