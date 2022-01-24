import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendtrkr/app/data/models/user_model.dart';

class FireStore {
  final db = FirebaseFirestore.instance;

  Future<UserModel> getUser(String uid) {
    return db.doc('/users/$uid').get().then(
        (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  Stream<UserModel> getUserStream(String uid) => db
      .doc('/users/$uid')
      .snapshots()
      .map((snapshot) => UserModel.fromMap(snapshot.data()!));

  Future<void> addUser(String uid, UserModel user) async {
    await db.doc('/users/$uid').set(user.toJson());
  }

  Future<void> updatePhoto(String uid, String photoUrl) async {
    await db.doc('/users/$uid').update({'photoUrl': photoUrl});
  }
}
