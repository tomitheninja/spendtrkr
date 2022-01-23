import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/controllers/signup_form.dart';
import 'package:spendtrkr/utils/gravatar_uri.dart';
import 'package:spendtrkr/utils/validator.dart';

class SignupForm extends GetView<SignupFormController> {
  SignupForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              GetBuilder<SignupFormController>(
                builder: (controller) => controller.photo.isEmpty
                    ? GetUtils.isEmail(controller.emailController.text)
                        ? CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            radius: 64,
                            backgroundImage: NetworkImage(gravatarUrl(
                                controller.emailController.text.trim())))
                        : CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            radius: 64,
                            backgroundImage:
                                const AssetImage('assets/images/birds.png'))
                    : CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        radius: 64,
                        backgroundImage: MemoryImage(controller.photo)),
              ),
              Positioned(
                child: IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.add_photo_alternate),
                  onPressed: controller.selectImage,
                ),
                bottom: -10,
                left: 80,
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: Validator.required,
            controller: controller.nameController,
            autofillHints: const [AutofillHints.name],
            decoration: InputDecoration(
              labelText: 'signup.username'.tr,
              icon: const Icon(Icons.person),
            ),
          ),
          TextFormField(
            validator: Validator.email,
            controller: controller.emailController,
            onChanged: (value) => controller.update(),
            autofillHints: const [
              AutofillHints.email,
            ],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'auth.email'.tr,
              icon: const Icon(Icons.email),
            ),
          ),
          TextFormField(
            validator: Validator.password,
            controller: controller.passwordController,
            autofillHints: const [AutofillHints.newPassword],
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'auth.password'.tr,
              icon: const Icon(Icons.lock),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value != controller.passwordController.text) {
                return 'signup.password_mismatch'.tr;
              }
            },
            controller: controller.passwordAgainController,
            autofillHints: const [AutofillHints.password],
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'signup.password-again'.tr,
              icon: const Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      await controller.signUpWithEmailAndPassword();
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
                      case 'weak-password':
                        showNotification(
                          title: 'error'.tr,
                          message: "firebase.auth.weak-password".tr,
                          backgroundColor: Colors.red,
                          autoDismissible: true,
                          notificationDuration: 2000,
                        );
                        break;
                      case 'email-already-in-use':
                        showNotification(
                          title: 'error'.tr,
                          message: "firebase.auth.already-in-use".tr,
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
                child: Text('signup.button-text'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
