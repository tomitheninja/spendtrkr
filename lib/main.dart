import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/signup.dart';
import 'package:spendtrkr/screens/login.dart';
import 'controllers/login.dart';
import 'screens/signup.dart';
import 'utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spendtrkr',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignupScreen(),
          binding: SignupBinding(),
        ),
      ],
    );
  }
}
