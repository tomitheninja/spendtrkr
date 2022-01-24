import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/core/utils/validator.dart';

import '../login_controller.dart';
import '../signup_controller.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginFormController());
  final registerController = Get.put(SignupFormController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                  onPressed: () {},
                  child: Text(
                    'auth.forgot-password'.tr,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      if (_formKey.currentState!.validate()) {
                        await controller.signInWithEmailAndPassword();
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
