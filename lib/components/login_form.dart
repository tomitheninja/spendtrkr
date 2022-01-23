import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

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
            // validator: Validator().email,
            // controller: authController.emailController,

            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'auth.email'.tr,
                contentPadding: const EdgeInsets.all(11.25),
                icon: const Icon(Icons.email)),
          ),
          TextFormField(
            //   validator: Validator().password,
            //   controller: authController.passwordController,
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
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      //         await authController
                      //               .signInWithEmailAndPassword(context);
                    }
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case 'invalid-email':
                        Get.snackbar("Error", "Invalid email address");
                        break;
                      case 'user-disabled':
                        Get.snackbar("Error", "User is disabled");
                        break;
                      case 'user-not-found':
                      case 'wrong-password':
                        Get.snackbar("Error", "Invalid email or password");
                        break;
                      default:
                        Get.snackbar("Error", "An error occurred");
                        break;
                    }
                  } catch (e) {
                    Get.snackbar("Error", e.toString());
                  }
                },
                child: Text('login.button-text'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
