import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/models/user_model.dart';
import 'package:spendtrkr/utils/storage.dart';

class SignupAnonController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //create the firestore user in users collection
  Future<void> _createUserFirestore(UserModel user, User _firebaseUser) async {
    await _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  Future<void> signupAnon() async {
    await showLoader();
    try {
      UserCredential result = await _auth.signInAnonymously();
      var user = result.user;

      if (user == null) {
        throw Exception('Error signing up');
      }
      String photoUrl = await StorageMethods()
          .uploadImage("avatars/${user.uid}", Uint8List(0));
      UserModel _newUser = UserModel(
          uid: result.user!.uid,
          name: 'firebase.auth.anon'.tr,
          photoUrl: photoUrl);
      await _createUserFirestore(_newUser, result.user!);
    } finally {
      await hideLoader();
    }
  }
}
