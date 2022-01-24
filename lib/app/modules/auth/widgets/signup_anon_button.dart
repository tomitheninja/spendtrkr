import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../anon_controller.dart';

class SignupAnonButton extends StatelessWidget {
  SignupAnonButton({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(SignupAnonController());

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: controller.signupAnon,
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
