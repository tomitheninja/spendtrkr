import 'package:get/get.dart';
import 'package:spendtrkr/routes/routes.dart';
import 'package:spendtrkr/modules/home/page.dart';
import 'package:spendtrkr/modules/settings/page.dart';
import 'package:spendtrkr/modules/auth/login_page.dart';
import 'package:spendtrkr/modules/auth/signup_page.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = Routes.home;
  static final routes = [
    GetPage(name: Routes.home, page: () => HomeUI()),
    GetPage(name: Routes.login, page: () => const LoginUI()),
    GetPage(name: Routes.signup, page: () => const SignupUI()),
    GetPage(name: Routes.settings, page: () => SettingsUI()),
  ];
}