import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ots/ots.dart';
import 'package:spendtrkr/app/data/models/user_model.dart';
import 'package:spendtrkr/app/data/provider/user.dart';
import 'package:spendtrkr/routes/routes.dart';

class AuthController extends GetxController {
  final _user = UserProvider();
  String? _redictedUrl;

  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  @override
  void onReady() async {
    // run every time auth state changes
    ever(firebaseUser, (User? _firebaseUser) async {
      // get user data from firestore
      if (_firebaseUser?.uid != null) {
        firestoreUser.bindStream(_user.streamById(firebaseUser.value!.uid));
      }

      if (_firebaseUser == null) {
        _redictedUrl = Get.routing.current;
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(_redictedUrl ?? Routes.home);
      }
    });

    firebaseUser.bindStream(userStream);

    super.onReady();
  }

  User? get user => _user.getAuth();
  Stream<User?> get userStream => _user.subscribeAuth();

  Future<void> changePhoto(Uint8List image) async {
    showLoader(isModal: true);
    try {
      final prevUrl = firestoreUser.value!.photoUrl;
      await _user.uploadAvatar(firebaseUser.value!.uid, image);
      if (prevUrl != null) {
        await _user.deleteFileFromUrl(prevUrl);
      }
    } finally {
      hideLoader();
      update();
    }
  }

  // Send forgot password email
  Future<void> sendPasswordResetEmail(String email) async {
    return _user.auth.sendPasswordResetEmail(email: email);
  }

  // Create user without credentials
  Future<void> Function() get signupAnonymously => _user.signUpAnonymously;

  Future<void> Function({
    required String email,
    required String password,
    required String name,
    required Uint8List img,
  }) get signupWithEmailAndPassword => _user.signupWithEmailAndPassword;

  Future<void> Function({required String email, required String password})
      get signInWithEmailAndPassword => _user.signInWithEmailAndPassword;

  // Sign out
  Future<void> signOut() => _user.auth.signOut();
}
