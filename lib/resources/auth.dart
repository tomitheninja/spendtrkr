import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spendtrkr/resources/storage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> signupUsingLocalStrategy(
      {required String email,
      required String password,
      required String username,
      Uint8List? avatar}) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    var user = result.user;
    if (user == null) {
      throw Exception('Error signing up');
    } else {
      String avatarUrl =
          await StorageMethods().uploadImage("avatar", avatar ?? Uint8List(0));

      await _firestore.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
        'avatar': avatarUrl,
        'createdAt': DateTime.now(),
        'userId': user.uid,
        'followers': [],
        'following': [],
      });
      await user.sendEmailVerification();
    }
  }

  Future<void> signInUsingLocalStrategy({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
