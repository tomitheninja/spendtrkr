import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_strength/password_strength.dart';
import 'package:email_validator/email_validator.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    // TODO: Load from local storage
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? emailValidator(String? value) {
    if (!EmailValidator.validate(value ?? '')) {
      return 'Invalid email';
    }
  }

  String? passwordValidator(String? value) {
    if (estimatePasswordStrength(value ?? '') < 0.5) {
      return 'Password is too weak';
    }
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      Get.snackbar("Success", "Signed in successfully");
    }
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
