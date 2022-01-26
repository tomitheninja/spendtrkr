import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/data/models/user_model.dart';
import 'package:spendtrkr/data/provider/user.dart';
import 'package:spendtrkr/routes/routes.dart';

class AuthController extends GetxController {
  final _user = UserProvider();

  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  @override
  void onReady() async {
    // await _user.signOut();

    // run every time auth state changes
    ever(firebaseUser, (User? _firebaseUser) async {
      if (_firebaseUser == null) {
        Get.offAllNamed(Routes.login);
        return;
      }
      firestoreUser.bindStream(_user.streamById(firebaseUser.value!.uid));
      Get.offAllNamed(Routes.home);
    });

    // subscribe to firebase auth changes
    firebaseUser.bindStream(_user.subscribeAuth());
    super.onReady();
  }

  User? get user => _user.getAuth();

  Future<void> changePhoto(Uint8List image) async {
    await showLoader(isModal: true);
    try {
      final prevUrl = firestoreUser.value!.photoUrl;
      await _user.uploadAvatar(firebaseUser.value!.uid, image);
      if (prevUrl != null) {
        await _user.deleteFileFromUrl(prevUrl);
      }
    } finally {
      await hideLoader();
      update();
    }
  }

  // Send forgot password email
  Future<void> sendPasswordResetEmail(String email) async {
    return _user.auth.sendPasswordResetEmail(email: email);
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(
          {required String email, required String password}) =>
      _user.signInWithEmailAndPassword(email: email, password: password);

  // Create user without credentials
  Future<void> signupAnonymously() async {
    await _user.signUpAnonymously();
    await Get.offNamed(Routes.home);
  }

  Future<void> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required Uint8List img,
  }) async {
    await _user.signupWithEmailAndPassword(
        email: email, password: password, name: name, img: img);
    await Get.offNamed(Routes.home);
  }

  // Sign out
  Future<void> signOut() => _user.auth.signOut();
}
