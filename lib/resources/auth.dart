import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> signupUsinglocalStrategy(
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
      await _firestore.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
        'avatar': avatar,
        'createdAt': DateTime.now(),
        'userId': user.uid,
        'followers': [],
        'following': [],
      });
      await user.sendEmailVerification();
    }
  }
}
