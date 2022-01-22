import 'package:get/get.dart';
import 'package:spendtrkr/ui/ui.dart';
import 'package:spendtrkr/ui/auth/auth.dart';

class Routes {
  static const home = '/home';
  static const signin = '/signin';
  static const signup = '/signup';
  static const settings = '/settings';
  static const resetPassword = '/reset-password';
}

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashUI()),
    GetPage(name: Routes.signin, page: () => SignInUI()),
    GetPage(name: Routes.signup, page: () => SignUpUI()),
    GetPage(name: Routes.home, page: () => const HomeUI()),
    GetPage(name: Routes.settings, page: () => const SettingsUI()),
    GetPage(name: Routes.resetPassword, page: () => ResetPasswordUI()),
  ];
}
