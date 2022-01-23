import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/screens/signup.dart';

class LoginBottomNav extends StatelessWidget {
  const LoginBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 5) {
          // swiping in right direction
          Get.to(() => const SignupPage(), transition: Transition.leftToRight);
        } else if (details.delta.dx < -5) {
          // swiping in left direction
          Get.to(() => const SignupPage(), transition: Transition.rightToLeft);
        } else if (details.delta.dy.abs() > 5) {
          Get.to(() => const SignupPage(), transition: Transition.downToUp);
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RawMaterialButton(
          onPressed: () => Get.to(
            const SignupPage(),
            transition: Transition.downToUp,
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 800),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 32, top: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.keyboard_arrow_up),
                    const SizedBox(height: 8),
                    Text(
                      "login.signup".tr,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
