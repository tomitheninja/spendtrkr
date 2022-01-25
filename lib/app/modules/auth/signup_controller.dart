import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/app/data/services/auth.dart';
import 'package:spendtrkr/core/utils/pick_image.dart';
import 'package:spendtrkr/routes/routes.dart';

class SignupFormController extends GetxController {
  final _auth = Get.find<AuthController>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
  final _photo = Uint8List(0).obs;
  Uint8List get photo => _photo.value;
  Future<void> selectImage() async {
    _photo.value = Uint8List(0);
    var img = await pickImage(ImageSource.gallery);
    if (img != null) {
      _photo.value = img;
    }
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    _photo.value = Uint8List(0);
    super.onClose();
  }

  Future<void> signUpWithEmailAndPassword() async {
    showLoader(isModal: true);
    try {
      await _auth.signupWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        img: photo,
      );
    } finally {
      hideLoader();
      Get.offAllNamed(Routes.home);
    }
  }
}
