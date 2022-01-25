import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/app/data/services/auth.dart';

class LoginFormController extends GetxController {
  final _auth = Get.find<AuthController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Method to handle user sign in using email and password
  Future<void> signInWithEmailAndPassword() async {
    await showLoader();
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } finally {
      await hideLoader();
    }
  }
}
