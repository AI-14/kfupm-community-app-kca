import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String password;
  final String profilePhotoUrl;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.profilePhotoUrl,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> userMap = {};

    userMap['username'] = username;
    userMap['email'] = email;
    userMap['password'] = password;
    userMap['profilePhotoUrl'] = profilePhotoUrl;
    return userMap;
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        username: snapshot['username'],
        email: snapshot['email'],
        password: snapshot['password'],
        profilePhotoUrl: snapshot['profilePhotoUrl']);
  }
}
