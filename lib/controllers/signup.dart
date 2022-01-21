import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:password_strength/password_strength.dart';
import 'package:email_validator/email_validator.dart';
import 'package:spendtrkr/resources/auth.dart';
import 'package:spendtrkr/utils/image_picker.dart';

class SignupController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
  final usernameController = TextEditingController();

  final _avatar = Uint8List(0).obs;
  Uint8List get avatar => _avatar.value;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    super.onClose();
  }

  String? emailValidator(String? value) {
    if (!EmailValidator.validate(value ?? '')) {
      return 'Invalid email';
    }
  }

  String? passwordValidator(String? value) {
    if (estimatePasswordStrength(value ?? '') < 0.5) {
      return 'Password is too weak';
    }
  }

  String? passwordAgainValidator(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
  }

  String? usernameValidator(String? value) {
    if ((value ?? '').length < 3) {
      return 'Username is too short';
    }
  }

  Future<void> selectImage() async {
    _avatar.value = Uint8List(0);
    var img = await pickImage(ImageSource.gallery);
    if (img != null) {
      _avatar.value = img;
    }
  }

  Future<void> signup() async {
    if (signupFormKey.currentState!.validate()) {
      return AuthMethods().signupUsingLocalStrategy(
          email: emailController.text,
          password: passwordController.text,
          username: usernameController.text);
    }
  }
}

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}
