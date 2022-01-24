import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final db = FirebaseStorage.instance;

  Future<String> uploadAvatar(String uid, Uint8List imageData) async {
    UploadTask uploadTask = db
        .ref('avatar/$uid')
        .child(DateTime.now().hashCode.toString())
        .putData(imageData);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  Future<void> deleteAvatar(String uid, String url) async {
    return await db.refFromURL(url).delete();
  }
}
