import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String uid, Uint8List imageData) async {
    UploadTask uploadTask =
        _storage.ref().child("avatars/$uid").putData(imageData);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }
}
