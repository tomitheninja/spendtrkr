import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final db = FirebaseStorage.instance;

  Future<String> uploadAvatar(String uid, Uint8List imageData) async {
    UploadTask uploadTask = db.ref().child('avatars/$uid').putData(imageData);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }
}
