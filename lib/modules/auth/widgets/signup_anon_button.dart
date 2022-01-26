import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/data/services/auth.dart';

class SignupAnonButton extends GetView<AuthController> {
  const SignupAnonButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: controller.signupAnonymously,
      child: Text(
        'auth.continue-anonymous'.tr,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
