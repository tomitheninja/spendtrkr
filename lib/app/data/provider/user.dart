import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spendtrkr/app/data/models/user_model.dart';
import 'package:spendtrkr/core/values/keys.dart';

class UserProvider {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  /* ---------------------------------- auth ---------------------------------- */
  User? getAuth() => auth.currentUser;
  Stream<User?> subscribeAuth() => auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
          {required String email, required String password}) =>
      auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> signUpAnonymously() async {
    final result = await auth.signInAnonymously();
    await _addFirebaseUser(UserModel(uid: result.user!.uid));
  }

  Future<void> signOut() => auth.signOut();

  // Create user with email and password
  // img defaults to gravatar
  Future<void> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required Uint8List img,
  }) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var user = result.user!;
    await user.sendEmailVerification();

    String? photoUrl =
        img.isNotEmpty ? await uploadAvatar(user.uid, img) : null;

    await _addFirebaseUser(UserModel(
        uid: result.user!.uid, email: email, name: name, photoUrl: photoUrl));
  }

  Future<void> _addFirebaseUser(UserModel user) async {
    await db.doc('/$userStorageKey/${user.uid}').set(user.toJson());
  }

  /* --------------------------------- storage -------------------------------- */
  Future<void> deleteFileFromUrl(String url) async {
    return await storage.refFromURL(url).delete();
  }

  /* ---------------------------------- user ---------------------------------- */
  Future<UserModel> byId(String uid) {
    return db.doc('/$userStorageKey/$uid').get().then(
        (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  Stream<UserModel> streamById(String uid) => db
      .doc('/$userStorageKey/$uid')
      .snapshots()
      .map((snapshot) => UserModel.fromMap(snapshot.data()!));

  /* --------------------------------- avatar --------------------------------- */
  /// Uploads the avatar to the storage and updates the user's avatar url.
  Future<String> uploadAvatar(String uid, Uint8List imageData) async {
    UploadTask uploadTask = storage
        .ref('$avatarStorageKey/$uid')
        .child(DateTime.now().hashCode.toString())
        .putData(imageData);
    final photoUrl = await (await uploadTask).ref.getDownloadURL();
    await db.doc('/$userStorageKey/$uid').update({'photoUrl': photoUrl});
    return photoUrl;
  }
}
