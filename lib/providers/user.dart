import 'package:flutter/material.dart';
import 'package:kfupm_community_app/firebase_backend/auth_methods.dart';
import 'package:kfupm_community_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  final AuthMethods authMethods = AuthMethods();

  Future<void> refreshUser() async {
    UserModel currentUser = await authMethods.getCurrentUserDetails();
    user = currentUser;
    print('Notified userprovider refreshuser listeners!');
    notifyListeners();
  }
}
