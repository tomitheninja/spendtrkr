import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/core/utils/validator.dart';
import 'package:spendtrkr/core/values/keys.dart';
import 'package:spendtrkr/data/services/auth.dart';

class ForgotPasswordDialog extends GetView<AuthController> {
  final TextEditingController emailController;
  const ForgotPasswordDialog({Key? key, required this.emailController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          0.5),
      title: Text("auth.forgot-password".tr),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: forgotPasswordFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text("auth.forgot-password.desc".tr),
              const SizedBox(height: 4),
              TextFormField(
                controller: emailController,
                validator: Validator.email,
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'auth.email'.tr,
                    contentPadding: const EdgeInsets.all(11.25),
                    icon: const Icon(Icons.email)),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text("auth.forgot-password.submit".tr),
          onPressed: () async {
            if (forgotPasswordFormKey.currentState!.validate()) {
              try {
                await controller.sendPasswordResetEmail(emailController.text);
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case 'user-not-found':
                    break;
                  case 'invalid-email':
                    showNotification(
                      title: 'error'.tr,
                      message: "firebase.auth.invalid-email".tr,
                      backgroundColor: Colors.red,
                      autoDismissible: true,
                      notificationDuration: 2000,
                    );
                    return;
                  default:
                    debugPrint(e.code);
                    showNotification(
                      title: 'error'.tr,
                      message: "firebase.auth.unknown-error".tr,
                      backgroundColor: Colors.red,
                      autoDismissible: true,
                      notificationDuration: 2000,
                    );
                    return;
                }
              }
              showNotification(
                title: 'auth.forgot-password.success.title'.tr,
                message: 'auth.forgot-password.success.desc'.tr,
                autoDismissible: true,
                notificationDuration: 5000,
                backgroundColor: Colors.green,
              );
              Get.back();
            }
          },
        ),
      ],
    );
  }
}
