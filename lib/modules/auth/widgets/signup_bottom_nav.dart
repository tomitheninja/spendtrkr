import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupBottomNav extends StatelessWidget {
  const SignupBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) => Get.back(),
      onHorizontalDragStart: (_) => Get.back(),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RawMaterialButton(
          onPressed: () => Get.back(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 32, top: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "signup.login".tr,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Icon(Icons.keyboard_arrow_down),
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