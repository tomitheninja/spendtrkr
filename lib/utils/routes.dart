// AppRoutes class
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:spendtrkr/screens/home.dart';
import 'package:spendtrkr/screens/login.dart';

class Routes {
  Routes._();
  static const String home = '/';
  static const String login = '/login';
}

class AppRoutes {
  AppRoutes._();
  static const initial = Routes.home;
  static final routes = [
    GetPage(name: Routes.home, page: () => HomePage()),
    GetPage(name: Routes.login, page: () => LoginPage()),
  ];
}
