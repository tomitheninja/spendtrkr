// AppRoutes class
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:spendtrkr/screens/home.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = '/';
  static final routes = [
    GetPage(name: '/', page: () => HomePage()),
  ];
}
