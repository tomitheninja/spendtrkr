import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/core/utils/pick_image.dart';
import 'package:spendtrkr/core/utils/validator.dart';
import 'package:spendtrkr/core/values/keys.dart';
import 'package:spendtrkr/widgets/avatar.dart';

import 'controller.dart';

class SignupForm extends GetView<AuthFormController> {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar
          Stack(
            children: [
              Obx(() => Avatar(
                  overrideImage: controller.photo.value.isNotEmpty
                      ? MemoryImage(controller.photo.value)
                      : null,
                  image: const AssetImage('assets/images/birds.png'))),
              Positioned(
                child: IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.add_photo_alternate),
                    onPressed: () async {
                      controller.photo.value = Uint8List(0);
                      var img = await pickImage(ImageSource.gallery);
                      if (img != null) {
                        controller.photo.value = img;
                      }
                    }),
                bottom: -10,
                left: 80,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Name
          TextFormField(
            validator: Validator.required,
            controller: controller.nameController,
            autofillHints: const [AutofillHints.name],
            decoration: InputDecoration(
              labelText: 'signup.username'.tr,
              icon: const Icon(Icons.person),
            ),
          ),
          // Email
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
          // Password
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
          // Password again
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
          // Signup button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (signupFormKey.currentState!.validate()) {
                    try {
                      await showLoader(isModal: true);
                      await controller.auth.signupWithEmailAndPassword(
                        email: controller.emailController.text.trim(),
                        password: controller.passwordController.text.trim(),
                        name: controller.nameController.text.trim(),
                        img: controller.photo.value,
                      );
                      controller.passwordController.text = '';
                      controller.passwordAgainController.text = '';
                      controller.photo.value.clear();
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
                    } finally {
                      await hideLoader();
                    }
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
