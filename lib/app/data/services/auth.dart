import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/data/models/user_model.dart';
import 'package:spendtrkr/app/data/provider/fire_auth.dart';
import 'package:spendtrkr/app/data/provider/fire_storage.dart';
import 'package:spendtrkr/app/data/provider/fire_store.dart';
import 'package:spendtrkr/routes/routes.dart';

class AuthController extends GetxController {
  final auth = FireAuth();
  final store = FireStore();
  final storage = FireStorage();

  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  @override
  void onReady() async {
    // run every time auth state changes
    ever(firebaseUser, (User? _firebaseUser) async {
      // get user data from firestore
      if (_firebaseUser?.uid != null) {
        firestoreUser.bindStream(store.getUserStream(firebaseUser.value!.uid));
      }

      if (_firebaseUser == null) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.home);
      }
    });

    firebaseUser.bindStream(user);

    super.onReady();
  }

  Future<User> get getUser async => auth.getUser()!;
  Stream<User?> get user => auth.subscribe();

  // Send forgot password email
  Future<void> sendPasswordResetEmail(String email) async {
    return auth.db.sendPasswordResetEmail(email: email);
  }

  // Create user without credentials
  Future<void> signupAnonymously() async {
    final result = await auth.db.signInAnonymously();
    final user = result.user!;
    await store.addUser(user.uid, UserModel(uid: user.uid));
  }

  // Create user with email and password
  // img defaults to gravatar
  Future<void> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required Uint8List img,
  }) async {
    UserCredential result = await auth.db.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var user = result.user!;

    await user.sendEmailVerification();

    String? photoUrl = img.isEmpty
        ? 'https://www.gravatar.com/avatar/${md5.convert(utf8.encode(email)).toString()}?d=mp'
        : await storage.uploadAvatar(user.uid, img);

    await store.addUser(
        result.user!.uid,
        UserModel(
            uid: result.user!.uid,
            email: email,
            name: name,
            photoUrl: photoUrl));
  }

  // Sign out
  Future<void> signOut() {
    return auth.db.signOut();
  }
}
