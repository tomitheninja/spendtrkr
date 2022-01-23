import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/models/user_model.dart';
import 'package:spendtrkr/utils/pick_image.dart';
import 'package:spendtrkr/utils/storage.dart';

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
    emailController.clear();
    passwordController.clear();
    passwordAgainController.clear();
    super.onClose();
  }

  //create the firestore user in users collection
  Future<void> _createUserFirestore(UserModel user, User _firebaseUser) async {
    await _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  Future<void> signUpWithEmailAndPassword() async {
    await showLoader();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      var user = result.user;
      if (user == null) {
        throw Exception('Error signing up');
      }
      await user.sendEmailVerification();
      String photoUrl = await StorageMethods().uploadImage("avatar", photo);
      UserModel _newUser = UserModel(
          uid: result.user!.uid,
          email: result.user!.email!,
          name: nameController.text,
          photoUrl: photoUrl);
      _createUserFirestore(_newUser, result.user!);
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      passwordAgainController.clear();
    } finally {
      await hideLoader();
    }
  }
}
