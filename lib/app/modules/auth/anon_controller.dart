import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/app/data/models/user_model.dart';

class SignupAnonController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //create the firestore user in users collection
  Future<void> _createUserFirestore(User _firebaseUser, UserModel user) async {
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
      await _createUserFirestore(
          result.user!,
          UserModel(
            uid: result.user!.uid,
          ));
    } finally {
      await hideLoader();
    }
  }
}
