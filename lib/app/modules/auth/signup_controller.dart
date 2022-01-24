import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/app/data/models/user_model.dart';
import 'package:spendtrkr/app/data/storage.dart';
import 'package:spendtrkr/core/utils/pick_image.dart';

class SignupFormController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  //create the firestore user in users collection
  Future<void> _createUserFirestore(User _firebaseUser, UserModel user) async {
    await _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  Future<void> signUpWithEmailAndPassword() async {
    debugPrint(photo.isEmpty.toString());
    await showLoader(isModal: true);
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name = nameController.text.trim();
      final img = photo;
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = result.user;

      if (user == null) {
        throw Exception('Error signing up');
      }

      await user.sendEmailVerification();

      String? photoUrl = img.isEmpty
          ? null
          : await StorageMethods().uploadImage("avatars/${user.uid}", img);
      await _createUserFirestore(
          result.user!,
          UserModel(
              uid: result.user!.uid,
              email: email,
              name: name,
              photoUrl: photoUrl));
    } finally {
      await hideLoader();
    }
  }
}
