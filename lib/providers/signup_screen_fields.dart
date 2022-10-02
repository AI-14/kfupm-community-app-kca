import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kfupm_community_app/utils/constants.dart';

class SignupScreenFieldsProvider extends ChangeNotifier {
  String photoUrl;
  bool obscureTextPassword, obscureTextConfirmPassword, isLoading;
  Uint8List? photoFile;

  SignupScreenFieldsProvider(
      {this.photoUrl = defaultProfilePicUrl,
      this.obscureTextPassword = true,
      this.obscureTextConfirmPassword = true,
      this.isLoading = false,
      this.photoFile});

  void setPhotoUrl(String url) {
    photoUrl = url;
    notifyListeners();
  }

  void changeObscureTextPassword() {
    obscureTextPassword = !obscureTextPassword;
    notifyListeners();
  }

  void changeObscureTextConfirmPassword() {
    obscureTextConfirmPassword = !obscureTextConfirmPassword;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
  
  void setPhotoFile(Uint8List? file) {
    photoFile = file;
    notifyListeners();
  }
}
