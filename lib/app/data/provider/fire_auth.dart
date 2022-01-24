import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  final db = FirebaseAuth.instance;

  User? getUser() => db.currentUser;

  Stream<User?> subscribe() => db.authStateChanges();
}
