import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/core/utils/validator.dart';
import 'package:spendtrkr/core/values/keys.dart';
import 'package:spendtrkr/modules/auth/controller.dart';

import 'widgets/forgot_password_dialog.dart';

class LoginForm extends GetView<AuthFormController> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "login.welcome".tr,
            style: const TextStyle(
                fontSize: 17,
                color: Color.fromRGBO(147, 148, 184, 1),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          TextFormField(
            validator: Validator.email,
            controller: controller.emailController,
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'auth.email'.tr,
                contentPadding: const EdgeInsets.all(11.25),
                icon: const Icon(Icons.email)),
          ),
          TextFormField(
            validator: Validator.password,
            controller: controller.passwordController,
            autofillHints: const [AutofillHints.password],
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'auth.password'.tr,
                contentPadding: const EdgeInsets.all(11.25),
                icon: const Icon(Icons.lock)),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () async {
                    final result = await Get.dialog(ForgotPasswordDialog());
                    if (result != null && result is String) {
                      if (forgotPasswordFormKey.currentState!.validate()) {
                        try {
                          await controller.auth
                              .sendPasswordResetEmail(result);
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
                    }
                  },
                  child: Text(
                    'auth.forgot-password'.tr,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await showLoader(isModal: true);
                      if (loginFormKey.currentState!.validate()) {
                        await controller.auth.signInWithEmailAndPassword(
                          email: controller.emailController.text.trim(),
                          password: controller.passwordController.text.trim(),
                        );
                        controller.passwordController.text = '';
                      }
                    } on FirebaseAuthException catch (e) {
                      switch (e.code) {
                        case 'invalid-email':
                          showNotification(
                            title: 'error'.tr,
                            message: "firebase.auth.invalid-email".tr,
                            backgroundColor: Colors.red,
                            autoDismissible: true,
                            notificationDuration: 2000,
                          );
                          break;
                        case 'user-disabled':
                          showNotification(
                            title: 'error'.tr,
                            message: "firebase.auth.user-disabled".tr,
                            backgroundColor: Colors.red,
                            autoDismissible: true,
                            notificationDuration: 2000,
                          );
                          break;
                        case 'user-not-found':
                        case 'wrong-password':
                          showNotification(
                            title: 'error'.tr,
                            message: "firebase.auth.wrong-password".tr,
                            backgroundColor: Colors.red,
                            autoDismissible: true,
                            notificationDuration: 2000,
                          );
                          break;
                        default:
                          showNotification(
                            title: 'error'.tr,
                            message: "firebase.auth.unknown-error".tr,
                            backgroundColor: Colors.red,
                            autoDismissible: true,
                            notificationDuration: 2000,
                          );
                          break;
                      }
                    } catch (e) {
                      Get.snackbar("Error", e.toString());
                    } finally {
                      await hideLoader();
                    }
                  },
                  child: Text(
                    'login.button-text'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
