// User model in firebase_storage
class UserModel {
  final String uid;
  final String? email;
  final String? name;
  final String? photoUrl;

  // constructor
  UserModel(
      {required this.uid,
      this.name,
      this.email,
      this.photoUrl});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      name: data['name'],
      photoUrl: data['photoUrl'],
    );
  }

  Map<String, String?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
    };
  }
}
